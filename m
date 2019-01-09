Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:43534 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbfAITDW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jan 2019 14:03:22 -0500
Date: Wed, 9 Jan 2019 20:03:21 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/16] io_uring: batch io_kiocb allocation
Message-ID: <20190109190321.GA22645@lst.de>
References: <20190108165645.19311-1-axboe@kernel.dk> <20190108165645.19311-12-axboe@kernel.dk> <20190109121340.GD13779@lst.de> <0a91dd38-69b8-84ab-f96a-225f09a54ec9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a91dd38-69b8-84ab-f96a-225f09a54ec9@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com

On Wed, Jan 09, 2019 at 09:57:59AM -0700, Jens Axboe wrote:
> On 1/9/19 5:13 AM, Christoph Hellwig wrote:
> >> +	if (!state)
> >> +		req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
> > 
> > Just return an error here if kmem_cache_alloc fails.
> > 
> >> +	if (req)
> >> +		io_req_init(ctx, req);
> > 
> > Because all the other ones can't reached this with a NULL req.
> 
> This is different in the current tree, since I properly fixed the
> ctx ref issue.

Your tree does a percpu_ref_tryget very first, and then leaks that if
kmem_cache_alloc_bulk fails, and also is inconsistent for NULL vs
ERR_PTR returns.  I think you want something like this on top:

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 35d055dcbc22..6c95749e9601 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -250,14 +250,6 @@ static struct io_uring_event *io_peek_cqring(struct io_ring_ctx *ctx)
 	return &ring->events[tail & ctx->cq_ring.ring_mask];
 }
 
-static bool io_req_init(struct io_ring_ctx *ctx, struct io_kiocb *req)
-{
-	req->ki_ctx = ctx;
-	INIT_LIST_HEAD(&req->ki_list);
-	req->ki_flags = 0;
-	return true;
-}
-
 static void io_ring_drop_ctx_ref(struct io_ring_ctx *ctx, unsigned refs)
 {
 	percpu_ref_put_many(&ctx->refs, refs);
@@ -274,9 +266,11 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	if (!percpu_ref_tryget(&ctx->refs))
 		return NULL;
 
-	if (!state)
+	if (!state) {
 		req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
-	else if (!state->free_iocbs) {
+		if (!req)
+			goto out_drop_ref;
+	} else if (!state->free_iocbs) {
 		size_t size;
 		int ret;
 
@@ -284,7 +278,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		ret = kmem_cache_alloc_bulk(kiocb_cachep, GFP_KERNEL, size,
 						state->iocbs);
 		if (ret <= 0)
-			return ERR_PTR(-ENOMEM);
+			goto out_drop_ref;
 		state->free_iocbs = ret - 1;
 		state->cur_iocb = 1;
 		req = state->iocbs[0];
@@ -294,11 +288,11 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		state->cur_iocb++;
 	}
 
-	if (req) {
-		io_req_init(ctx, req);
-		return req;
-	}
+	req->ki_ctx = ctx;
+	req->ki_flags = 0;
+	return req;
 
+out_drop_ref:
 	io_ring_drop_ctx_ref(ctx, 1);
 	return NULL;
 }
