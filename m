Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41159 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbfAIMMw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jan 2019 07:12:52 -0500
Date: Wed, 9 Jan 2019 13:12:50 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/16] io_uring: split kiocb init from allocation
Message-ID: <20190109121250.GC13779@lst.de>
References: <20190108165645.19311-1-axboe@kernel.dk> <20190108165645.19311-11-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108165645.19311-11-axboe@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Message-ID: <20190109121250.CqZtAVn0n_lyqIY8D-tHjTN1R8s7aIbvphPdPFJB3_8@z>

On Tue, Jan 08, 2019 at 09:56:39AM -0700, Jens Axboe wrote:
> In preparation from having pre-allocated requests, that we then just
> need to initialize before use.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/io_uring.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index afbaebb63012..11d045f0f799 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -202,6 +202,14 @@ static struct io_uring_event *io_peek_cqring(struct io_ring_ctx *ctx)
>  	return &ring->events[tail & ctx->cq_ring.ring_mask];
>  }
>  
> +static void io_req_init(struct io_ring_ctx *ctx, struct io_kiocb *req)
> +{
> +	percpu_ref_get(&ctx->refs);
> +	req->ki_ctx = ctx;
> +	INIT_LIST_HEAD(&req->ki_list);
> +	req->ki_flags = 0;

We still only have a single caller of this in the final tree, and
I don't think this function helps.  So I'd just drop the patch.
