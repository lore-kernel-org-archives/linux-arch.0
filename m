From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/16] io_uring: use fget/fput_many() for file references
Date: Sat, 12 Jan 2019 14:30:05 -0700
Message-ID: <20190112213011.1439-11-axboe@kernel.dk>
References: <20190112213011.1439-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190112213011.1439-1-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
List-Id: linux-arch.vger.kernel.org

On the submission side, add file reference batching to the
io_submit_state. We get as many references as the number of iocbs we
are submitting, and drop unused ones if we end up switching files. The
assumption here is that we're usually only dealing with one fd, and if
there are multiple, hopefuly they are at least somewhat ordered. Could
trivially be extended to cover multiple fds, if needed.

On the completion side we do the same thing, except this is trivially
done just locally in io_iopoll_reap().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 98 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 13 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 93905ce360bb..443988474b83 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -139,6 +139,15 @@ struct io_submit_state {
 	 */
 	struct list_multi req_list;
 	unsigned int req_count;
+
+	/*
+	 * File reference cache
+	 */
+	struct file *file;
+	unsigned int fd;
+	unsigned int has_refs;
+	unsigned int used_refs;
+	unsigned int ios_left;
 };
 
 static struct kmem_cache *req_cachep;
@@ -282,8 +291,10 @@ static void io_iopoll_reap(struct io_ring_ctx *ctx, unsigned int *nr_events)
 {
 	void *reqs[IO_IOPOLL_BATCH];
 	struct io_kiocb *req, *n;
-	int to_free = 0;
+	int file_count, to_free;
+	struct file *file = NULL;
 
+	file_count = to_free = 0;
 	list_for_each_entry_safe(req, n, &ctx->poll_completing.list, ki_list) {
 		if (!(req->ki_flags & REQ_F_IOPOLL_COMPLETED))
 			continue;
@@ -293,10 +304,26 @@ static void io_iopoll_reap(struct io_ring_ctx *ctx, unsigned int *nr_events)
 		list_del(&req->ki_list);
 		reqs[to_free++] = req;
 
-		fput(req->rw.ki_filp);
+		/*
+		 * Batched puts of the same file, to avoid dirtying the
+		 * file usage count multiple times, if avoidable.
+		 */
+		if (!file) {
+			file = req->rw.ki_filp;
+			file_count = 1;
+		} else if (file == req->rw.ki_filp) {
+			file_count++;
+		} else {
+			fput_many(file, file_count);
+			file = req->rw.ki_filp;
+			file_count = 1;
+		}
+
 		(*nr_events)++;
 	}
 
+	if (file)
+		fput_many(file, file_count);
 	if (to_free)
 		io_free_req_many(ctx, reqs, &to_free);
 }
@@ -557,14 +584,56 @@ static void io_iopoll_req_issued(struct io_submit_state *state,
 		io_iopoll_req_add_state(state, req);
 }
 
+static void io_file_put(struct io_submit_state *state, struct file *file)
+{
+	if (!state) {
+		fput(file);
+	} else if (state->file) {
+		int diff = state->has_refs - state->used_refs;
+
+		if (diff)
+			fput_many(state->file, diff);
+		state->file = NULL;
+	}
+}
+
+/*
+ * Get as many references to a file as we have IOs left in this submission,
+ * assuming most submissions are for one file, or at least that each file
+ * has more than one submission.
+ */
+static struct file *io_file_get(struct io_submit_state *state, int fd)
+{
+	if (!state)
+		return fget(fd);
+
+	if (state->file) {
+		if (state->fd == fd) {
+			state->used_refs++;
+			state->ios_left--;
+			return state->file;
+		}
+		io_file_put(state, NULL);
+	}
+	state->file = fget_many(fd, state->ios_left);
+	if (!state->file)
+		return NULL;
+
+	state->fd = fd;
+	state->has_refs = state->ios_left;
+	state->used_refs = 1;
+	state->ios_left--;
+	return state->file;
+}
+
 static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		      bool force_nonblock)
+		      bool force_nonblock, struct io_submit_state *state)
 {
 	struct io_ring_ctx *ctx = req->ki_ctx;
 	struct kiocb *kiocb = &req->rw;
 	int ret;
 
-	kiocb->ki_filp = fget(sqe->fd);
+	kiocb->ki_filp = io_file_get(state, sqe->fd);
 	if (unlikely(!kiocb->ki_filp))
 		return -EBADF;
 	kiocb->ki_pos = sqe->off;
@@ -603,7 +672,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	return 0;
 out_fput:
-	fput(kiocb->ki_filp);
+	io_file_put(state, kiocb->ki_filp);
 	return ret;
 }
 
@@ -628,7 +697,7 @@ static inline void io_rw_done(struct kiocb *req, ssize_t ret)
 }
 
 static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		       bool force_nonblock)
+		       bool force_nonblock, struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	void __user *buf = (void __user *) (uintptr_t) sqe->addr;
@@ -637,7 +706,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, sqe, force_nonblock);
+	ret = io_prep_rw(req, sqe, force_nonblock, state);
 	if (ret)
 		return ret;
 	file = kiocb->ki_filp;
@@ -672,7 +741,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 }
 
 static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-			bool force_nonblock)
+			bool force_nonblock, struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	void __user *buf = (void __user *) (uintptr_t) sqe->addr;
@@ -681,7 +750,7 @@ static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(req, sqe, force_nonblock);
+	ret = io_prep_rw(req, sqe, force_nonblock, state);
 	if (ret)
 		return ret;
 	file = kiocb->ki_filp;
@@ -776,10 +845,10 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	ret = -EINVAL;
 	switch (sqe->opcode) {
 	case IORING_OP_READV:
-		ret = io_read(req, sqe, force_nonblock);
+		ret = io_read(req, sqe, force_nonblock, state);
 		break;
 	case IORING_OP_WRITEV:
-		ret = io_write(req, sqe, force_nonblock);
+		ret = io_write(req, sqe, force_nonblock, state);
 		break;
 	case IORING_OP_FSYNC:
 		ret = io_fsync(req, sqe, force_nonblock);
@@ -882,17 +951,20 @@ static void io_submit_state_end(struct io_submit_state *state)
 	blk_finish_plug(&state->plug);
 	if (!list_empty(&state->req_list.list))
 		io_flush_state_reqs(state->ctx, state);
+	io_file_put(state, NULL);
 }
 
 /*
  * Start submission side cache.
  */
 static void io_submit_state_start(struct io_submit_state *state,
-				  struct io_ring_ctx *ctx)
+				  struct io_ring_ctx *ctx, unsigned max_ios)
 {
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list.list);
 	state->req_count = 0;
+	state->file = NULL;
+	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
 	state->plug_cb.callback = io_state_unplug;
 	blk_start_plug(&state->plug);
@@ -938,7 +1010,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 	int i, ret = 0, submit = 0;
 
 	if (to_submit > IO_PLUG_THRESHOLD) {
-		io_submit_state_start(&state, ctx);
+		io_submit_state_start(&state, ctx, to_submit);
 		statep = &state;
 	}
 
-- 
2.17.1

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
