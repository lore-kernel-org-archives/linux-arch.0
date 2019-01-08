From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/16] io_uring: add submission side request cache
Date: Tue,  8 Jan 2019 09:56:36 -0700
Message-ID: <20190108165645.19311-8-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
List-Id: linux-arch.vger.kernel.org

We have to add each submitted polled request to the io_context
poll_submitted list, which means we have to grab the poll_lock. We
already use the block plug to batch submissions if we're doing a batch
of IO submissions, extend that to cover the poll requests internally as
well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 122 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 106 insertions(+), 16 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 02eab2f42c63..9f36eb728208 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -121,6 +121,21 @@ struct io_kiocb {
 
 #define IO_IOPOLL_BATCH	8
 
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
+	struct list_head req_list;
+	unsigned int req_count;
+};
+
 static struct kmem_cache *kiocb_cachep, *ioctx_cachep;
 
 static const struct file_operations io_scqring_fops;
@@ -494,21 +509,29 @@ static inline void io_rw_done(struct kiocb *req, ssize_t ret)
 }
 
 /*
- * After the iocb has been issued, it's safe to be found on the poll list.
- * Adding the kiocb to the list AFTER submission ensures that we don't
- * find it from a io_getevents() thread before the issuer is done accessing
- * the kiocb cookie.
+ * Called either at the end of IO submission, or through a plug callback
+ * because we're going to schedule. Moves out local batch of requests to
+ * the ctx poll list, so they can be found for polling + reaping.
  */
-static void io_iopoll_iocb_issued(struct io_kiocb *kiocb)
+static void io_flush_state_reqs(struct io_ring_ctx *ctx,
+				 struct io_submit_state *state)
 {
+	spin_lock(&ctx->poll_lock);
+	list_splice_tail_init(&state->req_list, &ctx->poll_submitted);
+	spin_unlock(&ctx->poll_lock);
+	state->req_count = 0;
+}
+
+static void io_iopoll_iocb_add_list(struct io_kiocb *kiocb)
+{
+	const int front = test_bit(KIOCB_F_IOPOLL_COMPLETED, &kiocb->ki_flags);
+	struct io_ring_ctx *ctx = kiocb->ki_ctx;
+
 	/*
 	 * For fast devices, IO may have already completed. If it has, add
 	 * it to the front so we find it first. We can't add to the poll_done
 	 * list as that's unlocked from the completion side.
 	 */
-	const int front = test_bit(KIOCB_F_IOPOLL_COMPLETED, &kiocb->ki_flags);
-	struct io_ring_ctx *ctx = kiocb->ki_ctx;
-
 	spin_lock(&ctx->poll_lock);
 	if (front)
 		list_add(&kiocb->ki_list, &ctx->poll_submitted);
@@ -517,6 +540,33 @@ static void io_iopoll_iocb_issued(struct io_kiocb *kiocb)
 	spin_unlock(&ctx->poll_lock);
 }
 
+static void io_iopoll_iocb_add_state(struct io_submit_state *state,
+				     struct io_kiocb *kiocb)
+{
+	if (test_bit(KIOCB_F_IOPOLL_COMPLETED, &kiocb->ki_flags))
+		list_add(&kiocb->ki_list, &state->req_list);
+	else
+		list_add_tail(&kiocb->ki_list, &state->req_list);
+
+	if (++state->req_count >= IO_IOPOLL_BATCH)
+		io_flush_state_reqs(state->ctx, state);
+}
+
+/*
+ * After the iocb has been issued, it's safe to be found on the poll list.
+ * Adding the kiocb to the list AFTER submission ensures that we don't
+ * find it from a io_getevents() thread before the issuer is done accessing
+ * the kiocb cookie.
+ */
+static void io_iopoll_iocb_issued(struct io_submit_state *state,
+				  struct io_kiocb *kiocb)
+{
+	if (!state || !IS_ENABLED(CONFIG_BLOCK))
+		io_iopoll_iocb_add_list(kiocb);
+	else
+		io_iopoll_iocb_add_state(state, kiocb);
+}
+
 static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
@@ -632,7 +682,8 @@ static int io_fsync(struct fsync_iocb *req, const struct io_uring_iocb *iocb,
 
 static int __io_submit_one(struct io_ring_ctx *ctx,
 			   const struct io_uring_iocb *iocb,
-			   unsigned long ki_index)
+			   unsigned long ki_index,
+			   struct io_submit_state *state)
 {
 	struct io_kiocb *req;
 	ssize_t ret;
@@ -684,7 +735,7 @@ static int __io_submit_one(struct io_ring_ctx *ctx,
 			ret = -EAGAIN;
 			goto out_put_req;
 		}
-		io_iopoll_iocb_issued(req);
+		io_iopoll_iocb_issued(state, req);
 	}
 	return 0;
 out_put_req:
@@ -692,6 +743,43 @@ static int __io_submit_one(struct io_ring_ctx *ctx,
 	return ret;
 }
 
+#ifdef CONFIG_BLOCK
+static void io_state_unplug(struct blk_plug_cb *cb, bool from_schedule)
+{
+	struct io_submit_state *state;
+
+	state = container_of(cb, struct io_submit_state, plug_cb);
+	if (!list_empty(&state->req_list))
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
+	if (!list_empty(&state->req_list))
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
+	INIT_LIST_HEAD(&state->req_list);
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
 	struct io_sq_ring *ring = ctx->sq_ring.ring;
@@ -726,11 +814,13 @@ static const struct io_uring_iocb *io_peek_sqring(struct io_ring_ctx *ctx,
 
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
 		const struct io_uring_iocb *iocb;
@@ -740,7 +830,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		if (!iocb)
 			break;
 
-		ret = __io_submit_one(ctx, iocb, iocb_index);
+		ret = __io_submit_one(ctx, iocb, iocb_index, statep);
 		if (ret)
 			break;
 
@@ -748,8 +838,8 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
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
