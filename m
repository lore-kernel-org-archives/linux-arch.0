From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/16] io_uring: batch io_kiocb allocation
Date: Tue,  8 Jan 2019 09:56:40 -0700
Message-ID: <20190108165645.19311-12-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
List-Id: linux-arch.vger.kernel.org

Similarly to how we use the state->ios_left to know how many references
to get to a file, we can use it to allocate the io_kiocb's we need in
bulk.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 11d045f0f799..62778d7ffb8d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -135,6 +135,13 @@ struct io_submit_state {
 	struct list_head req_list;
 	unsigned int req_count;
 
+	/*
+	 * io_kiocb alloc cache
+	 */
+	void *iocbs[IO_IOPOLL_BATCH];
+	unsigned int free_iocbs;
+	unsigned int cur_iocb;
+
 	/*
 	 * File reference cache
 	 */
@@ -210,15 +217,33 @@ static void io_req_init(struct io_ring_ctx *ctx, struct io_kiocb *req)
 	req->ki_flags = 0;
 }
 
-static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
+static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
+				   struct io_submit_state *state)
 {
 	struct io_kiocb *req;
 
-	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
-	if (!req)
-		return NULL;
+	if (!state)
+		req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
+	else if (!state->free_iocbs) {
+		size_t size;
+		int ret;
+
+		size = min_t(size_t, state->ios_left, ARRAY_SIZE(state->iocbs));
+		ret = kmem_cache_alloc_bulk(kiocb_cachep, GFP_KERNEL, size,
+						state->iocbs);
+		if (ret <= 0)
+			return ERR_PTR(-ENOMEM);
+		state->free_iocbs = ret - 1;
+		state->cur_iocb = 1;
+		req = state->iocbs[0];
+	} else {
+		req = state->iocbs[state->cur_iocb];
+		state->free_iocbs--;
+		state->cur_iocb++;
+	}
 
-	io_req_init(ctx, req);
+	if (req)
+		io_req_init(ctx, req);
 	return req;
 }
 
@@ -773,7 +798,7 @@ static int __io_submit_one(struct io_ring_ctx *ctx,
 	if (unlikely(iocb->flags))
 		return -EINVAL;
 
-	req = io_get_req(ctx);
+	req = io_get_req(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -844,6 +869,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 	if (!list_empty(&state->req_list))
 		io_flush_state_reqs(state->ctx, state);
 	io_file_put(state, NULL);
+	if (state->free_iocbs)
+		kmem_cache_free_bulk(kiocb_cachep, state->free_iocbs,
+					&state->iocbs[state->cur_iocb]);
 }
 
 /*
@@ -855,6 +883,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list);
 	state->req_count = 0;
+	state->free_iocbs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
-- 
2.17.1

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
