From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/15] io_uring: batch io_kiocb allocation
Date: Wed,  9 Jan 2019 19:43:59 -0700
Message-ID: <20190110024404.25372-11-axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
List-Id: linux-arch.vger.kernel.org

Similarly to how we use the state->ios_left to know how many references
to get to a file, we can use it to allocate the io_kiocb's we need in
bulk.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 71 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 19 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index cd2dfc153338..b5233786b5a8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -127,6 +127,13 @@ struct io_submit_state {
 	struct list_head req_list;
 	unsigned int req_count;
 
+	/*
+	 * io_kiocb alloc cache
+	 */
+	void *kiocbs[IO_IOPOLL_BATCH];
+	unsigned int free_kiocbs;
+	unsigned int cur_kiocb;
+
 	/*
 	 * File reference cache
 	 */
@@ -196,36 +203,58 @@ static struct io_uring_cqe *io_peek_cqring(struct io_ring_ctx *ctx)
 	return &ring->cqes[tail & ctx->cq_mask];
 }
 
-static struct io_kiocb *io_get_kiocb(struct io_ring_ctx *ctx)
+static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
+{
+	percpu_ref_put_many(&ctx->refs, refs);
+
+	if (waitqueue_active(&ctx->wait))
+		wake_up(&ctx->wait);
+}
+
+static struct io_kiocb *io_get_kiocb(struct io_ring_ctx *ctx,
+				   struct io_submit_state *state)
 {
 	struct io_kiocb *req;
 
 	if (!percpu_ref_tryget(&ctx->refs))
 		return NULL;
 
-	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
-	if (!req)
-		return NULL;
-
-	req->ki_ctx = ctx;
-	INIT_LIST_HEAD(&req->ki_list);
-	req->ki_flags = 0;
-	return req;
-}
+	if (!state)
+		req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
+	else if (!state->free_kiocbs) {
+		size_t sz;
+		int ret;
+
+		sz = min_t(size_t, state->ios_left, ARRAY_SIZE(state->kiocbs));
+		ret = kmem_cache_alloc_bulk(kiocb_cachep, GFP_KERNEL, sz,
+						state->kiocbs);
+		if (ret <= 0)
+			goto out;
+		state->free_kiocbs = ret - 1;
+		state->cur_kiocb = 1;
+		req = state->kiocbs[0];
+	} else {
+		req = state->kiocbs[state->cur_kiocb];
+		state->free_kiocbs--;
+		state->cur_kiocb++;
+	}
 
-static void io_ring_drop_ctx_ref(struct io_ring_ctx *ctx, unsigned refs)
-{
-	percpu_ref_put_many(&ctx->refs, refs);
+	if (req) {
+		req->ki_ctx = ctx;
+		req->ki_flags = 0;
+		return req;
+	}
 
-	if (waitqueue_active(&ctx->wait))
-		wake_up(&ctx->wait);
+out:
+	io_ring_drop_ctx_refs(ctx, 1);
+	return NULL;
 }
 
 static void io_free_kiocb_many(struct io_ring_ctx *ctx, void **iocbs, int *nr)
 {
 	if (*nr) {
 		kmem_cache_free_bulk(kiocb_cachep, *nr, iocbs);
-		io_ring_drop_ctx_ref(ctx, *nr);
+		io_ring_drop_ctx_refs(ctx, *nr);
 		*nr = 0;
 	}
 }
@@ -233,7 +262,7 @@ static void io_free_kiocb_many(struct io_ring_ctx *ctx, void **iocbs, int *nr)
 static void io_free_kiocb(struct io_kiocb *iocb)
 {
 	kmem_cache_free(kiocb_cachep, iocb);
-	io_ring_drop_ctx_ref(iocb->ki_ctx, 1);
+	io_ring_drop_ctx_refs(iocb->ki_ctx, 1);
 }
 
 /*
@@ -761,7 +790,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	if (unlikely(sqe->flags))
 		return -EINVAL;
 
-	req = io_get_kiocb(ctx);
+	req = io_get_kiocb(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -828,6 +857,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 	if (!list_empty(&state->req_list))
 		io_flush_state_reqs(state->ctx, state);
 	io_file_put(state, NULL);
+	if (state->free_kiocbs)
+		kmem_cache_free_bulk(kiocb_cachep, state->free_kiocbs,
+					&state->kiocbs[state->cur_kiocb]);
 }
 
 /*
@@ -839,6 +871,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list);
 	state->req_count = 0;
+	state->free_kiocbs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
@@ -1071,7 +1104,7 @@ SYSCALL_DEFINE4(io_uring_enter, unsigned int, fd, u32, to_submit,
 		ret = __io_uring_enter(ctx, to_submit, min_complete, flags);
 		mutex_unlock(&ctx->uring_lock);
 	}
-	io_ring_drop_ctx_ref(ctx, 1);
+	io_ring_drop_ctx_refs(ctx, 1);
 out_fput:
 	fdput(f);
 	return ret;
-- 
2.17.1

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
