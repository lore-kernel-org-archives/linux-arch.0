Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268092AbUHKQNw@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:27292 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268085AbUHKQNw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 12:13:52 -0400
Date: Wed, 11 Aug 2004 09:13:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: copy_page_range()
In-Reply-To: <20040811000708.6e31969d.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0408110856080.1839@ppc970.osdl.org>
References: <20040807000529.5ca6e8fe.davem@redhat.com> <20040807080751.GX17188@holomorphy.com>
 <20040811000708.6e31969d.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "David S. Miller" <davem@redhat.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Wed, 11 Aug 2004, David S. Miller wrote:
> 
> I hacked up something slightly different today.  I only
> have it being used by clear_page_range() but it is extremely
> effective.

Hmm.. I don't see any of this being arch-dependent, so I wonder why you 
did it that way. 

Also, one comment: the page directory "index" is never zeroed, as far as I
can tell.

> Things like fork+exit latencies on my 750Mhz sparc64 box went
> from ~490 microseconds to ~367 microseconds.  fork+execve
> latency went down from ~1595 microseconds to ~1351 microseconds.

That's definitely fascinating, and implies either a bug (hey, who knows?) 
or that page tables are a lot sparser than I'd have expected them to be.

Ahh.. I see. The "clear_page_tables()" interface was really designed for a 
two-level page table. And even there I was lazy in exit_mmap(). 

Yeah, I think clear_page_tables() is broken, and it's increasingly broken 
on three or four-level setups. Your patch really works around the fact 
that we're extremely lazy about tearing down page tables.

Ho humm. Maybe it's the right way to go, but I have to say that I would
_really_ prefer to make this generic. There's absolutely nothing
architecture-specific anywhere there except for the place where you hide
the bitmap ("page->index" depends on a pgd/pmd being one page).

I hate "asm-generic" if it's just hiding the fact that it really _is_ 
generic, but people wanted macros.

David, could you look at instead of doing this <asm/page-walk.c> thing, 
just do a few _trivial_ macros in the asm page table headers:

	/* We use a bitmap in the pmd page to mark things busy,
	 * where we reduce the pmd index into 64 bits
	 */
	#define PMD_BITMAP_SHIFT (PAGE_SHIFT-6)
	#define pmd_usage_bitmap(pmd)	(virt_to_page(pmd)->index)

	#define PGD_BITMAP_SHIFT (PAGE_SHIFT-6)
	#define pgd_usage_bitmap(pgd)	(virt_to_page(pgd)->index)

and then the two-level folding can be done in the generic code by not 
defining the PGD_BITMAP_SHIFT at all or something like that, ie the 
generic code would have exactly _one_ #ifdef:

	clear_pgd_tables(...)
	{
		do {
	#ifdef PGD_BITMAP_SHIFT
		if (!(pgd_usage_bitmap(pgd) & mask))
			continue;
	#endif
		...
		} while (pgd < end)
	}

(you get the idea).

What do you think? Actually - make the same #ifdef in the pmd case too,
since that allows architectures that don't fold things but don't have any
good _room_ to hide the bitmap to also just not do this.

Hmm?

		Linus
