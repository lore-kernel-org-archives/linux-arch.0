Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41166 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbfAIMNm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jan 2019 07:13:42 -0500
Date: Wed, 9 Jan 2019 13:13:40 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/16] io_uring: batch io_kiocb allocation
Message-ID: <20190109121340.GD13779@lst.de>
References: <20190108165645.19311-1-axboe@kernel.dk> <20190108165645.19311-12-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108165645.19311-12-axboe@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com

> +	if (!state)
> +		req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);

Just return an error here if kmem_cache_alloc fails.

> +	if (req)
> +		io_req_init(ctx, req);

Because all the other ones can't reached this with a NULL req.
