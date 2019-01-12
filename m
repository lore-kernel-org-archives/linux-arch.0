From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/16] io_uring: add submission side request cache
Date: Sat, 12 Jan 2019 14:30:03 -0700
Message-ID: <20190112213011.1439-9-axboe@kernel.dk>
References: <20190112213011.1439-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190112213011.1439-1-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
List-Id: linux-arch.vger.kernel.org

We have to add each submitted polled request to the io_ring_ctx
poll_submitted list, which means we have to grab the poll_lock. We
already use the block plug to batch submissions if we're doing a batch
of IO submissions, extend that to cover the poll requests internally as
well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 122 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 105 insertions(+), 17 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index eb6550f135e3..93905ce360bb 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -126,6 +126,21 @@ struct io_kiocb {
 #define IO_PLUG_THRESHOLD		2
 #define IO_IOPOLL_BATCH			8
 
+struct io_submit_state {
+	struct io_ring_ctx *ctx;
+
+	struct blk_plug plug;
+#ifdef CONFIG_BLOCK
+	struct blk_plug_cb plug_cb;
+#endif
+
+	/*
+	 * Polled iocbs that have been submitted, but not added to the ctx yet
+	 */
+	struct list_multi req_list;
+	unsigned int req_count;
+};
+
 static struct kmem_cache *req_cachep;
 
 static const struct file_operations io_scqring_fops;
@@ -495,19 +510,51 @@ static void io_complete_scqring_iopoll(struct kiocb *kiocb, long res, long res2)
 	}
 }
 
+ /*
+ * Called either at the end of IO submission, or through a plug callback
+ * because we're going to schedule. Moves out local batch of requests to
+ * the ctx poll list, so they can be found for polling + reaping.
+  */
+static void io_flush_state_reqs(struct io_ring_ctx *ctx,
+				 struct io_submit_state *state)
+{
+	spin_lock(&ctx->poll_lock);
+	io_multi_list_splice(&state->req_list, &ctx->poll_submitted);
+	spin_unlock(&ctx->poll_lock);
+
+	state->req_count = 0;
+}
+
+static void io_iopoll_req_add_list(struct io_kiocb *req)
+{
+	struct io_ring_ctx *ctx = req->ki_ctx;
+
+	spin_lock(&ctx->poll_lock);
+	io_multi_list_add(req, &ctx->poll_submitted);
+	spin_unlock(&ctx->poll_lock);
+}
+
+static void io_iopoll_req_add_state(struct io_submit_state *state,
+				     struct io_kiocb *req)
+{
+	io_multi_list_add(req, &state->req_list);
+	if (++state->req_count >= IO_IOPOLL_BATCH)
+		io_flush_state_reqs(state->ctx, state);
+}
+
 /*
  * After the iocb has been issued, it's safe to be found on the poll list.
  * Adding the kiocb to the list AFTER submission ensures that we don't
  * find it from a io_getevents() thread before the issuer is done accessing
  * the kiocb cookie.
  */
-static void io_iopoll_req_issued(struct io_kiocb *req)
+static void io_iopoll_req_issued(struct io_submit_state *state,
+				 struct io_kiocb *req)
 {
-	struct io_ring_ctx *ctx = req->ki_ctx;
-
-	spin_lock(&ctx->poll_lock);
-	io_multi_list_add(req, &ctx->poll_submitted);
-	spin_unlock(&ctx->poll_lock);
+	if (!state || !IS_ENABLED(CONFIG_BLOCK))
+		io_iopoll_req_add_list(req);
+	else
+		io_iopoll_req_add_state(state, req);
 }
 
 static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
@@ -712,7 +759,8 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 }
 
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			   struct sqe_submit *s, bool force_nonblock)
+			   struct sqe_submit *s, bool force_nonblock,
+			   struct io_submit_state *state)
 {
 	const struct io_uring_sqe *sqe = s->sqe;
 	ssize_t ret;
@@ -747,7 +795,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	if (ctx->flags & IORING_SETUP_IOPOLL) {
 		if (req->ki_flags & REQ_F_IOPOLL_EAGAIN)
 			return -EAGAIN;
-		io_iopoll_req_issued(req);
+		io_iopoll_req_issued(state, req);
 	}
 
 	return 0;
@@ -779,7 +827,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	use_mm(ctx->sqo_mm);
 	set_fs(USER_DS);
 
-	ret = __io_submit_sqe(ctx, req, &req->work.submit, false);
+	ret = __io_submit_sqe(ctx, req, &req->work.submit, false, NULL);
 
 	set_fs(old_fs);
 	unuse_mm(ctx->sqo_mm);
@@ -792,7 +840,8 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	current->files = old_files;
 }
 
-static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s)
+static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
+			 struct io_submit_state *state)
 {
 	struct io_kiocb *req;
 	ssize_t ret;
@@ -801,7 +850,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	if (unlikely(!req))
 		return -EAGAIN;
 
-	ret = __io_submit_sqe(ctx, req, s, true);
+	ret = __io_submit_sqe(ctx, req, s, true, state);
 	if (ret == -EAGAIN) {
 		memcpy(&req->work.submit, s, sizeof(*s));
 		INIT_WORK(&req->work.work, io_sq_wq_submit_work);
@@ -814,6 +863,43 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	return ret;
 }
 
+#ifdef CONFIG_BLOCK
+static void io_state_unplug(struct blk_plug_cb *cb, bool from_schedule)
+{
+	struct io_submit_state *state;
+
+	state = container_of(cb, struct io_submit_state, plug_cb);
+	if (!list_empty(&state->req_list.list))
+		io_flush_state_reqs(state->ctx, state);
+}
+#endif
+
+/*
+ * Batched submission is done, ensure local IO is flushed out.
+ */
+static void io_submit_state_end(struct io_submit_state *state)
+{
+	blk_finish_plug(&state->plug);
+	if (!list_empty(&state->req_list.list))
+		io_flush_state_reqs(state->ctx, state);
+}
+
+/*
+ * Start submission side cache.
+ */
+static void io_submit_state_start(struct io_submit_state *state,
+				  struct io_ring_ctx *ctx)
+{
+	state->ctx = ctx;
+	INIT_LIST_HEAD(&state->req_list.list);
+	state->req_count = 0;
+#ifdef CONFIG_BLOCK
+	state->plug_cb.callback = io_state_unplug;
+	blk_start_plug(&state->plug);
+	list_add(&state->plug_cb.list, &state->plug.cb_list);
+#endif
+}
+
 static void io_inc_sqring(struct io_ring_ctx *ctx)
 {
 	struct io_sq_ring *ring = ctx->sq_ring;
@@ -848,11 +934,13 @@ static bool io_peek_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 
 static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 {
+	struct io_submit_state state, *statep = NULL;
 	int i, ret = 0, submit = 0;
-	struct blk_plug plug;
 
-	if (to_submit > IO_PLUG_THRESHOLD)
-		blk_start_plug(&plug);
+	if (to_submit > IO_PLUG_THRESHOLD) {
+		io_submit_state_start(&state, ctx);
+		statep = &state;
+	}
 
 	for (i = 0; i < to_submit; i++) {
 		struct sqe_submit s;
@@ -860,7 +948,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		if (!io_peek_sqring(ctx, &s))
 			break;
 
-		ret = io_submit_sqe(ctx, &s);
+		ret = io_submit_sqe(ctx, &s, statep);
 		if (ret)
 			break;
 
@@ -868,8 +956,8 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		io_inc_sqring(ctx);
 	}
 
-	if (to_submit > IO_PLUG_THRESHOLD)
-		blk_finish_plug(&plug);
+	if (statep)
+		io_submit_state_end(statep);
 
 	return submit ? submit : ret;
 }
-- 
2.17.1

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
