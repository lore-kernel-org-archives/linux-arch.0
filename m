Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:43542 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfAITGk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jan 2019 14:06:40 -0500
Date: Wed, 9 Jan 2019 20:06:38 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 14/16] io_uring: support kernel side submission
Message-ID: <20190109190638.GB22645@lst.de>
References: <20190108165645.19311-1-axboe@kernel.dk> <20190108165645.19311-15-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108165645.19311-15-axboe@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com

> +struct iocb_submit {
> +	const struct io_uring_iocb *iocb;
> +	unsigned int index;
> +};
> +
> +struct io_work {
> +	struct work_struct work;
> +	struct io_ring_ctx *ctx;
> +	struct io_uring_iocb iocb;
> +	unsigned iocb_index;
> +};

I think we should use struct iocb_submit everywhere where we pass
an iocb + index, including in the io_work structure.  Here is how
I did that to my old tree:

http://git.infradead.org/users/hch/misc.git/commitdiff/65929ed6f143a1c996305a10a15fd7f64d32595f

Btw, I think we can also remove the separate io_work allocation,
just do the io_get_req in the submission context, and overlay
the io_work onto the iocb in a union of some sort.  This avoids
a whole memory allocation.
