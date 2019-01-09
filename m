Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:43299 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbfAISbC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jan 2019 13:31:02 -0500
Date: Wed, 9 Jan 2019 19:30:59 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 05/16] Add io_uring IO interface
Message-ID: <20190109183059.GA21824@lst.de>
References: <20190108165645.19311-1-axboe@kernel.dk> <20190108165645.19311-6-axboe@kernel.dk> <20190109121030.GA13779@lst.de> <1576557b-a65f-86eb-5fcc-00f332ec2dd5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576557b-a65f-86eb-5fcc-00f332ec2dd5@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
Message-ID: <20190109183059.dMNe8bbL4Ki9Q0AMAm9FwNTT125UO_gNNcZikitgsxw@z>

On Wed, Jan 09, 2019 at 08:53:31AM -0700, Jens Axboe wrote:
> >> +static int io_setup_rw(int rw, const struct io_uring_iocb *iocb,
> >> +		       struct iovec **iovec, struct iov_iter *iter)
> >> +{
> >> +	void __user *buf = (void __user *)(uintptr_t)iocb->addr;
> >> +	size_t ret;
> >> +
> >> +	ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
> >> +	*iovec = NULL;
> >> +	return ret;
> >> +}
> > 
> > Is there any point in supporting non-vectored operations here?
> 
> Not sure I follow?

This version only supports non-vectored read and write, that is
the equivalent of pread/pwrite.  Many AIO users really need vectored
operations, that is preadv/pwritev semantics indirecting through
a struct iovec array.  The non-vectored version can be trivially
emulated using a vector of 1, which is what we do in the kernel
I/O stack everywhere.  So I think we should just support the vectored
version here, and not the non-vectored one.  See my io_uring branch
for the sketeched implementation.
