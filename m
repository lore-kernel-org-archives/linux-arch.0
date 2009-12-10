From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
	flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 17:48:23 +0000
Message-ID: <20091210174823.GA20884@flint.arm.linux.org.uk>
References: <1260398346.14369.45.camel@mulgrave.site> <20091210020309.36742c7f.isloginov@gmail.com> <1260400273.14369.52.camel@mulgrave.site> <20091210023609.b8c9bd34.isloginov@gmail.com> <1260402471.14369.60.camel@mulgrave.site> <20091210030638.db4cfd8a.isloginov@gmail.com> <1260404395.14369.68.camel@mulgrave.site> <20091210074020.a7c36c32.isloginov@gmail.com> <1260464851.2457.98.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46976 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760884AbZLJRsk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 12:48:40 -0500
Content-Disposition: inline
In-Reply-To: <1260464851.2457.98.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Ilya Loginov <isloginov@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, Dec 10, 2009 at 11:07:31AM -0600, James Bottomley wrote:
> For PIO we have this kmap/operate/flush_kernel_dcache_page()/kunmap
> complexity (see for example drivers/mmc/mmc_spi.c).  However, it could
> all be taken care of in a similar way to the DMA API via an
> abstraction ... although I suspect the best abstraction is to pull the
> flush into kunmap.

I assume you actually mean kmap_atomic() / kunmap_atomic(), since that
would be used in interrupt driven PIO drivers rather than kmap()/kunmap().

Well, it would mean every kunmap_atomic() gains an expensive cache flush
no matter what it's doing.  That would be very bad for things like
copy_user_highpage(), where we kmap the source and destination pages,
and then kunmap both.

However, there are cases where we do want to flush on kunmap_atomic() -
again, taking the copy_user_highpage() example, we want to ensure that
data written to the page is going to be visible in some way.  IOW, we
already have this:

        kfrom = kmap_atomic(from, KM_USER0);
        kto = kmap_atomic(to, KM_USER1);
        copy_page(kto, kfrom);
#ifdef CONFIG_HIGHMEM
        /*
         * kmap_atomic() doesn't set the page virtual address, and
         * kunmap_atomic() takes care of cache flushing already.
         */
        if (page_address(to) != NULL)
#endif
                __cpuc_flush_dcache_page(kto);
        kunmap_atomic(kto, KM_USER1);
        kunmap_atomic(kfrom, KM_USER0);

would become something like:

	...
	kunmap_atomic_flush(kto, KM_USER1);
	kunmap_atomic(kfrom, KM_USER0);

So I think what we want to add is kunmap_atomic_flush() for the cases
where we need the additional coherency, or maybe a kunmap_atomic_noflush()
for those which we don't.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
