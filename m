From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 12:20:55 -0600
Message-ID: <1260469255.2457.113.camel@mulgrave.site>
References: <20091210020309.36742c7f.isloginov@gmail.com>
	 <1260400273.14369.52.camel@mulgrave.site>
	 <20091210023609.b8c9bd34.isloginov@gmail.com>
	 <1260402471.14369.60.camel@mulgrave.site>
	 <20091210030638.db4cfd8a.isloginov@gmail.com>
	 <1260404395.14369.68.camel@mulgrave.site>
	 <20091210074020.a7c36c32.isloginov@gmail.com>
	 <1260464851.2457.98.camel@mulgrave.site>
	 <20091210174823.GA20884@flint.arm.linux.org.uk>
	 <1260467956.2457.109.camel@mulgrave.site>
	 <20091210180635.GB20884@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54708 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761143AbZLJSUx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Dec 2009 13:20:53 -0500
In-Reply-To: <20091210180635.GB20884@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Ilya Loginov <isloginov@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, 2009-12-10 at 18:06 +0000, Russell King wrote:
> On Thu, Dec 10, 2009 at 11:59:16AM -0600, James Bottomley wrote:
> > On Thu, 2009-12-10 at 17:48 +0000, Russell King wrote:
> > > Well, it would mean every kunmap_atomic() gains an expensive cache flush
> > > no matter what it's doing.  That would be very bad for things like
> > > copy_user_highpage(), where we kmap the source and destination pages,
> > > and then kunmap both.
> > > 
> > > However, there are cases where we do want to flush on kunmap_atomic() -
> > > again, taking the copy_user_highpage() example, we want to ensure that
> > > data written to the page is going to be visible in some way.  IOW, we
> > > already have this:
> > > 
> > >         kfrom = kmap_atomic(from, KM_USER0);
> > >         kto = kmap_atomic(to, KM_USER1);
> > >         copy_page(kto, kfrom);
> > > #ifdef CONFIG_HIGHMEM
> > >         /*
> > >          * kmap_atomic() doesn't set the page virtual address, and
> > >          * kunmap_atomic() takes care of cache flushing already.
> > >          */
> > >         if (page_address(to) != NULL)
> > > #endif
> > >                 __cpuc_flush_dcache_page(kto);
> > >         kunmap_atomic(kto, KM_USER1);
> > >         kunmap_atomic(kfrom, KM_USER0);
> > > 
> > > would become something like:
> > > 
> > > 	...
> > > 	kunmap_atomic_flush(kto, KM_USER1);
> > > 	kunmap_atomic(kfrom, KM_USER0);
> > > 
> > > So I think what we want to add is kunmap_atomic_flush() for the cases
> > > where we need the additional coherency, or maybe a kunmap_atomic_noflush()
> > > for those which we don't.
> > 
> > So if you think about it on a VI architecture, assuming we modified some
> > data in the kmap page at the returned address, why would we ever want to
> > unmap without flushing?  The only case I can think of is when we *know*
> > the kmap address and the other addresses are all congruent (so we have
> > no aliases).
> 
> The above example code comes from non-aliasing VIPT - where for the
> vast majority of cases, unmapping without flush is fine provided we
> haven't written data.  However, unmapping with flush is required to
> ensure coherency with the instruction cache.

right, but you can check those two cases in the unmap, can't you?

> > So I really think in kunmap(_atomic) we need to check to see if the page
> > was modified (using the pte flags),
> 
> That's fine _if_ you have such flags.  Not everything has - in which
> case, going down the route you're proposing means that every single
> kunmap_atomic() ends up having to flush the whole page whether it's
> actually needed on an architecture "just because" - with no technical
> reason to actually do so.
> 
> We need the two cases separated for hardware which is not PARISC.

So having such a flag is a requirement of the linux mm code, isn't it?

I thought what you did on arm was mark the page read only (even if it's
supposed to be read/write) and then trap on the write request and update
the dirty bit and set the page to read/write ... don't you do that
anymore?

I'm not religiously opposed to the separation into a flush and a non
flush case ... although I think if we have to do this, it's equivalent
to just forcing users to add the flush_kernel_dcache_page() ... but if
we can do it so that the users don't need to know the details, I think
the API is much better.

James
