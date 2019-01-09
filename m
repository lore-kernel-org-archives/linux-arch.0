Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41151 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730239AbfAIML7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jan 2019 07:11:59 -0500
Date: Wed, 9 Jan 2019 13:11:57 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/16] io_uring: support for IO polling
Message-ID: <20190109121157.GB13779@lst.de>
References: <20190108165645.19311-1-axboe@kernel.dk> <20190108165645.19311-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108165645.19311-7-axboe@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com

On Tue, Jan 08, 2019 at 09:56:35AM -0700, Jens Axboe wrote:
> Add polled variants of the read and write commands. These act like their
> non-polled counterparts, except we expect to poll for completion of
> them.

These aren't really need command variants, but a different type of context.

>  	case IORING_OP_FSYNC:
> +		if (ctx->flags & IORING_SETUP_IOPOLL)
> +			break;
>  		ret = io_fsync(&req->fsync, iocb, false);
>  		break;
>  	case IORING_OP_FDSYNC:
> +		if (ctx->flags & IORING_SETUP_IOPOLL)
> +			break;
>  		ret = io_fsync(&req->fsync, iocb, true);

I'd move this check into io_fsync to avoid a little duplication.
