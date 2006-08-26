Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:36625 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964931AbWHZIU1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 26 Aug 2006 04:20:27 -0400
Date: Sat, 26 Aug 2006 09:20:17 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Cache alias handling in copy_user_page / copy_user_highpage
Message-ID: <20060826082017.GE725@flint.arm.linux.org.uk>
References: <20060819122520.GA18180@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819122520.GA18180@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Sat, Aug 19, 2006 at 01:25:20PM +0100, Ralf Baechle wrote:
> A common implementation of copy_user_page performs a copy_page and a
> cacheflush operation and this implementation is suspect to above problem.
> I know MIPS and PARISC suffer from the problem.  ARM and m68k look suspect
> to me at which point I stopped looking at further architectures.
> 
> The only sane solution I can see is setting up temporary kernel mappings
> for source and destination pages with virtual addresses choosen to be
> congruent to userspace addresses.  cachetlb.txt's wording describes this
> as if it was an optional fancy implementation.

Even this won't work for VIVT caches.  Luckily, VIVT don't feature on ARM
SMP machines that much, so the only case we have to worry about there is
the preempt one.  The immediately obvious solution to that is to disable
preemption over the critical area.  This solves the preemption race, but
I suspect the preempt people will be very unhappy because it'll increase
latency.

For ARM SMP, VIVT isn't that much of an issue - the production ARM SMP
machines are VIPT, and we already map pages in our copy_user_page function.
The kmap interface is entirely wrong for this sort of thing, and if we
ever get ARM SMP+highmem, the kmap interface would need to be changed.

In fact, on such a platform, the kmap step would be entirely redundant
given this implementation, and would only serve to waste CPU cycles.

> 1) Move copy_user_highpage into the arch code.  This will allow the arch code
> to create any sort of crazy mapping it wants.  The old copy_user_page as
> kernel API is only called from copy_user_highpage and would therefore be
> obsoleted.
> 
> 2) Introduce a new kmap_atomic variant to create a congruent mapping.
> copy_user_highpage would change into something like this:
> 
> static inline void copy_user_highpage(struct page *to, struct page *from,
> 	unsigned long vaddr)
> {
>         char *vfrom, *vto;
> 
>         vfrom = kmap_coherent(from, KM_USER0, vaddr);
>         vto = kmap_coherent(to, KM_USER1, vaddr);
>         copy_page(vto, vfrom);
>         kunmap_coherent(vfrom, KM_USER0, vaddr);
>         kunmap_coherent(vto, KM_USER1, vaddr);
>         /* Make sure this page is cleared on other CPU's too before using it */
>         smp_wmb();
> }
> 
> I lean toward 2) since kmap_coherent is a more versatile interface.

This gives me cause for concern - if we move the VIPT remapping of pages
into kmap_coherent(), it's wrong for VIVT caches, and we already build
kernels which run-time configure themselves depending on what they find.

So I'm in favour of (1), where the architecture specific details can be
properly handled by the architecture specific code, perhaps by indirecting
copy_user_highpage() via a function pointer when necessary.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
