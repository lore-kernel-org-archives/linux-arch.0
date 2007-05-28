Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3787 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbXE1PEv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 May 2007 11:04:51 -0400
Date: Mon, 28 May 2007 16:04:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [CFT] read+shared mmap write+read data corruption
Message-ID: <20070528150432.GA5737@flint.arm.linux.org.uk>
References: <20070527104930.GB25023@flint.arm.linux.org.uk> <20070527222408.GA26268@xi.wantstofly.org> <1180310431.3711.27.camel@mulgrave.il.steeleye.com> <20070528100513.GC26046@flint.arm.linux.org.uk> <1180361875.3689.3.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1180361875.3689.3.camel@mulgrave.il.steeleye.com>
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, davej@codemonkey.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Mon, May 28, 2007 at 09:17:55AM -0500, James Bottomley wrote:
> On Mon, 2007-05-28 at 11:05 +0100, Russell King wrote:
> > On Sun, May 27, 2007 at 07:00:31PM -0500, James Bottomley wrote:
> > > Ok, output on parisc is:
> > > 
> > > jejb@ioz:~$ ./a.out
> > > firstfirstfirst
> > > firstfirstfirst
> > > secondsecondsec
> > > 
> > > Which is correct.  It remains correct even if I drop the msync().
> > 
> > With Lennert's new program, I get mostly:
> > 
> > firstfirstfirst
> > firstfirstfirst
> > firstfirstfirst
> > 
> > but occasionally:
> > 
> > firstfirstfirst
> > firstfirstfirst
> > secondsecondsec
> > 
> > However, if I open code the memcpy() in the MAPREAD to copy one word
> > at a time, then I reliably get the "secondsecondsec" line.  But if I
> > convert the memcpy() in MAPWRITE in the same way, I'm back to mostly
> > getting the failure with the occasional success.  Utterly confused.
> > 
> > Unless someone's got a theory, I'm stumped.
> 
> I think you're not flushing correctly in munmap() ... but I'm not sure
> the linux API actually requires this.

We do an unconditional cache flush over the user virtual addresses in
the mapping before we tear down the page table entries.

sys_munmap -> do_munmap -> unmap_region -> unmap_vmas -> unmap_page_range
	-> tlb_start_vma

Although the call to flush_cache_range() in tlb_start_vma() is conditional,
it is conditional on !tlb->fullmm, and the call to tlb_gather_mmu() in
unmap_region() sets this to zero.

Adding additional expensive cache flushing into tlb_start_vma() is going
to be, well, disgusting.  Performance?  What's that?  Oh, something we
used to have in 1995.

Having an additional bit which is set on page cache pages to indicate
that they need flushing would be far more preferable.  PG_arch_1 won't
work because we already use this for delaying flush_dcache_page().  We
need PG_arch_2.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
