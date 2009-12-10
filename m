From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 11:59:16 -0600
Message-ID: <1260467956.2457.109.camel@mulgrave.site>
References: <1260398346.14369.45.camel@mulgrave.site>
	 <20091210020309.36742c7f.isloginov@gmail.com>
	 <1260400273.14369.52.camel@mulgrave.site>
	 <20091210023609.b8c9bd34.isloginov@gmail.com>
	 <1260402471.14369.60.camel@mulgrave.site>
	 <20091210030638.db4cfd8a.isloginov@gmail.com>
	 <1260404395.14369.68.camel@mulgrave.site>
	 <20091210074020.a7c36c32.isloginov@gmail.com>
	 <1260464851.2457.98.camel@mulgrave.site>
	 <20091210174823.GA20884@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46932 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760972AbZLJR7M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Dec 2009 12:59:12 -0500
In-Reply-To: <20091210174823.GA20884@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Ilya Loginov <isloginov@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, 2009-12-10 at 17:48 +0000, Russell King wrote:
> On Thu, Dec 10, 2009 at 11:07:31AM -0600, James Bottomley wrote:
> > For PIO we have this kmap/operate/flush_kernel_dcache_page()/kunmap
> > complexity (see for example drivers/mmc/mmc_spi.c).  However, it could
> > all be taken care of in a similar way to the DMA API via an
> > abstraction ... although I suspect the best abstraction is to pull the
> > flush into kunmap.
> 
> I assume you actually mean kmap_atomic() / kunmap_atomic(), since that
> would be used in interrupt driven PIO drivers rather than kmap()/kunmap().

Yes, just using shorthand.

> Well, it would mean every kunmap_atomic() gains an expensive cache flush
> no matter what it's doing.  That would be very bad for things like
> copy_user_highpage(), where we kmap the source and destination pages,
> and then kunmap both.
> 
> However, there are cases where we do want to flush on kunmap_atomic() -
> again, taking the copy_user_highpage() example, we want to ensure that
> data written to the page is going to be visible in some way.  IOW, we
> already have this:
> 
>         kfrom = kmap_atomic(from, KM_USER0);
>         kto = kmap_atomic(to, KM_USER1);
>         copy_page(kto, kfrom);
> #ifdef CONFIG_HIGHMEM
>         /*
>          * kmap_atomic() doesn't set the page virtual address, and
>          * kunmap_atomic() takes care of cache flushing already.
>          */
>         if (page_address(to) != NULL)
> #endif
>                 __cpuc_flush_dcache_page(kto);
>         kunmap_atomic(kto, KM_USER1);
>         kunmap_atomic(kfrom, KM_USER0);
> 
> would become something like:
> 
> 	...
> 	kunmap_atomic_flush(kto, KM_USER1);
> 	kunmap_atomic(kfrom, KM_USER0);
> 
> So I think what we want to add is kunmap_atomic_flush() for the cases
> where we need the additional coherency, or maybe a kunmap_atomic_noflush()
> for those which we don't.

So if you think about it on a VI architecture, assuming we modified some
data in the kmap page at the returned address, why would we ever want to
unmap without flushing?  The only case I can think of is when we *know*
the kmap address and the other addresses are all congruent (so we have
no aliases).

So I really think in kunmap(_atomic) we need to check to see if the page
was modified (using the pte flags), and if it was, and it's not
congruent, we flush ... otherwise we've left a dirty cache line above an
unmapped area (which is an illegal condition, at least on parisc).

The problems, as you rightly point out, come because most of our uses of
kmap/kunmap already have a flush built into them if they modify the
mapped page.  However, doesn't it make sense semantically to pull all of
these flushes into the unmap (as in modify a lot of code to remove the
explicit flush)?

What this does is have kmap/kunmap automatically do the architecturally
right thing, and the user never needs to worry about flushing.

James
