From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/15] io_uring: use fget/fput_many() for file references
Date: Wed,  9 Jan 2019 19:43:58 -0700
Message-ID: <20190110024404.25372-10-axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
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
 fs/io_uring.c | 105 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 92 insertions(+), 13 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f7938156552f..cd2dfc153338 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -126,6 +126,15 @@ struct io_submit_state {
 	 */
 	struct list_head req_list;
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
 
 static struct kmem_cache *kiocb_cachep;
@@ -234,7 +243,8 @@ static void io_iopoll_reap(struct io_ring_ctx *ctx, unsigned int *nr_events)
 {
 	void *iocbs[IO_IOPOLL_BATCH];
 	struct io_kiocb *iocb, *n;
-	int to_free = 0;
+	int file_count, to_free = 0;
+	struct file *file = NULL;
 
 	list_for_each_entry_safe(iocb, n, &ctx->poll_completing, ki_list) {
 		if (!test_bit(KIOCB_F_IOPOLL_COMPLETED, &iocb->ki_flags))
@@ -245,10 +255,27 @@ static void io_iopoll_reap(struct io_ring_ctx *ctx, unsigned int *nr_events)
 		list_del(&iocb->ki_list);
 		iocbs[to_free++] = iocb;
 
-		fput(iocb->rw.ki_filp);
+		/*
+		 * Batched puts of the same file, to avoid dirtying the
+		 * file usage count multiple times, if avoidable.
+		 */
+		if (!file) {
+			file = iocb->rw.ki_filp;
+			file_count = 1;
+		} else if (file == iocb->rw.ki_filp) {
+			file_count++;
+		} else {
+			fput_many(file, file_count);
+			file = iocb->rw.ki_filp;
+			file_count = 1;
+		}
+
 		(*nr_events)++;
 	}
 
+	if (file)
+		fput_many(file, file_count);
+
 	if (to_free)
 		io_free_kiocb_many(ctx, iocbs, &to_free);
 }
@@ -428,13 +455,60 @@ static void io_complete_scqring_iopoll(struct kiocb *kiocb, long res, long res2)
 	}
 }
 
-static int io_prep_rw(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe)
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
+	if (!state->file) {
+get_file:
+		state->file = fget_many(fd, state->ios_left);
+		if (!state->file)
+			return NULL;
+
+		state->fd = fd;
+		state->has_refs = state->ios_left;
+		state->used_refs = 1;
+		state->ios_left--;
+		return state->file;
+	}
+
+	if (state->fd == fd) {
+		state->used_refs++;
+		state->ios_left--;
+		return state->file;
+	}
+
+	io_file_put(state, NULL);
+	goto get_file;
+}
+
+static int io_prep_rw(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
+		      struct io_submit_state *state)
 {
 	struct io_ring_ctx *ctx = kiocb->ki_ctx;
 	struct kiocb *req = &kiocb->rw;
 	int ret;
 
-	req->ki_filp = fget(sqe->fd);
+	req->ki_filp = io_file_get(state, sqe->fd);
 	if (unlikely(!req->ki_filp))
 		return -EBADF;
 	req->ki_pos = sqe->off;
@@ -470,7 +544,7 @@ static int io_prep_rw(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe)
 	}
 	return 0;
 out_fput:
-	fput(req->ki_filp);
+	io_file_put(state, req->ki_filp);
 	return ret;
 }
 
@@ -553,7 +627,8 @@ static void io_iopoll_kiocb_issued(struct io_submit_state *state,
 		io_iopoll_iocb_add_state(state, kiocb);
 }
 
-static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe)
+static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
+		       struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	void __user *buf = (void __user *) (uintptr_t) sqe->addr;
@@ -562,7 +637,7 @@ static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe)
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(kiocb, sqe);
+	ret = io_prep_rw(kiocb, sqe, state);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -588,7 +663,8 @@ static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe)
 	return ret;
 }
 
-static ssize_t io_write(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe)
+static ssize_t io_write(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
+			struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	void __user *buf = (void __user *) (uintptr_t) sqe->addr;
@@ -597,7 +673,7 @@ static ssize_t io_write(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe)
 	struct file *file;
 	ssize_t ret;
 
-	ret = io_prep_rw(kiocb, sqe);
+	ret = io_prep_rw(kiocb, sqe, state);
 	if (ret)
 		return ret;
 	file = req->ki_filp;
@@ -697,10 +773,10 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	ret = -EINVAL;
 	switch (sqe->opcode) {
 	case IORING_OP_READV:
-		ret = io_read(req, sqe);
+		ret = io_read(req, sqe, state);
 		break;
 	case IORING_OP_WRITEV:
-		ret = io_write(req, sqe);
+		ret = io_write(req, sqe, state);
 		break;
 	case IORING_OP_FSYNC:
 		ret = io_fsync(req, sqe, false);
@@ -751,17 +827,20 @@ static void io_submit_state_end(struct io_submit_state *state)
 	blk_finish_plug(&state->plug);
 	if (!list_empty(&state->req_list))
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
 	INIT_LIST_HEAD(&state->req_list);
 	state->req_count = 0;
+	state->file = NULL;
+	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
 	state->plug_cb.callback = io_state_unplug;
 	blk_start_plug(&state->plug);
@@ -807,7 +886,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
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
