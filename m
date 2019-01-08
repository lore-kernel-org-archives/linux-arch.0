From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/16] io_uring: split kiocb init from allocation
Date: Tue,  8 Jan 2019 09:56:39 -0700
Message-ID: <20190108165645.19311-11-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc: hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, Jens Axboe <axboe@kernel.dk>
List-Id: linux-arch.vger.kernel.org

In preparation from having pre-allocated requests, that we then just
need to initialize before use.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index afbaebb63012..11d045f0f799 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -202,6 +202,14 @@ static struct io_uring_event *io_peek_cqring(struct io_ring_ctx *ctx)
 	return &ring->events[tail & ctx->cq_ring.ring_mask];
 }
 
+static void io_req_init(struct io_ring_ctx *ctx, struct io_kiocb *req)
+{
+	percpu_ref_get(&ctx->refs);
+	req->ki_ctx = ctx;
+	INIT_LIST_HEAD(&req->ki_list);
+	req->ki_flags = 0;
+}
+
 static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
 {
 	struct io_kiocb *req;
@@ -210,10 +218,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
 	if (!req)
 		return NULL;
 
-	percpu_ref_get(&ctx->refs);
-	req->ki_ctx = ctx;
-	INIT_LIST_HEAD(&req->ki_list);
-	req->ki_flags = 0;
+	io_req_init(ctx, req);
 	return req;
 }
 
-- 
2.17.1

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
