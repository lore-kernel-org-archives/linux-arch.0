From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Wed, 09 Dec 2009 16:39:06 -0600
Message-ID: <1260398346.14369.45.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37062 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757458AbZLIWjD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2009 17:39:03 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ilya Loginov <isloginov@gmail.com>, Jens Axboe <jens.axboe@oracle.com>
Cc: linux-arch@vger.kernel.org

Sorry about being late to the party.  The original patch didn't get cc'd
to linux-arch (in spite of touching header files in every arch).

The problem mtd appears to have (from reading the code) is that it wants
to do pio to and from a device from the kernel view of the address.
What's happening in mtd looks to be wrong on several levels.

Firstly, the pio code in mtd_blkdevs.c starts with req->buffer.  This is
really unsafe, because if the page wasn't mappable (like you're on a
highmem architecture) then req->buffer will be NULL.

Then this extra helpers added to block: rq_flush_dcache_pages() loops
over every segment of the request calling flush_dcache_page() for the
page.  If you read the mtd code, it acts on a bio at a time so a request
with N bios flushes every page in the request N times (i'e N^2 flushes).
I'm assuming there's something somewhere I'm missing that restricts mtd
to single bio requests, which makes this all OK?

Finally, if you look at the actual use, this is using a sledgehammer to
crack a nut.  For writes via the kernel address, all you need to assure
is that the user aliases of the page were flushed as the bio was
constructed ... this is actually done in get_user pages, so this chunk
of code:

> 	case WRITE:
> 		if (!tr->writesect)
> 			return -EIO;
> 
>+		rq_flush_dcache_pages(req);
> 		for (; nsect > 0; nsect--, block++, buf += tr->blksize)
> 			if (tr->writesect(dev, block, buf))
> 				return -EIO;

Should be completely unnecessary.  (well except that mtd might need to
kmap somewhere).

The pio read case is the problematic one, because you dirty the kernel
alias by writing the read data to it and have to flush that before it's
made visible to the user alias view.  The API for doing this is
flush_kernel_dcache_page() ... it *only* flushes the kernel view, not
the user view.  The reason for this is that if the arch has to protect
the user aliases against speculative movein, that's done in the DMA API
before the request is completed.

So for this:

>	case READ:
>		for (; nsect > 0; nsect--, block++, buf += tr->blksize)
>			if (tr->readsect(dev, block, buf))
>				return -EIO;
>+		rq_flush_dcache_pages(req);
>		return 0;

Actually all you need to do is loop over the pages and call
flush_kernel_dcache_page().

Realistically, if I were thinking about the API properly, I'd probably
have kunmap flush the kernel view if the dirty bit were set, thus
relieving the user of the need to know anything at all about any of
this.  We should also have an adaption of the DMA API that tells the
arch that the mapping (and flushing) is only being done for pio not mmio
(so no need to program iommus or set up shared bus coherency registers).

That way we'd have a completely consistent and uniform API for all
drivers (whether PIO, MMIO or a mixture).

James
