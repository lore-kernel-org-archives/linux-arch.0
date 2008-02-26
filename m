Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51763 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbYBZTtt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2008 14:49:49 -0500
Date: Tue, 26 Feb 2008 19:49:03 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: regression: 2f569af (CONFIG_HIGHPTE vs. sub-page page tables.)
Message-ID: <20080226194903.GB31527@flint.arm.linux.org.uk>
References: <20080225132648.GA13791@digi.com> <1203958582.3247.3.camel@localhost> <20080226143858.GA11590@digi.com> <1204048666.21725.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1204048666.21725.6.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Tue, Feb 26, 2008 at 06:57:46PM +0100, Martin Schwidefsky wrote:
> Hi Uwe,
> 
> On Tue, 2008-02-26 at 15:38 +0100, Uwe Kleine-König wrote:
> > Moreover a "grep PageTables /proc/meminfo" resulted in 
> > 
> > 	9x __dec_zone_state with item == NR_PAGETABLE
> > 	7x __inc_zone_state with item == NR_PAGETABLE
> > 
> > All those 16 calles where done via __(inc|dec)_zone_page_state.
> > 
> > ... some time later ...
> > 
> > I got it.  This code is currently in free_pgd_slow():
> > 
> >         pte = pmd_page(*pmd);
> >         pmd_clear(pmd);
> >         dec_zone_page_state(virt_to_page((unsigned long *)pgd), NR_PAGETABLE);
> >         pte_lock_deinit(pte);
> >         pte_free(mm, pte);
> >         pmd_free(mm, pmd);
> >
> > So because (since 2f569af) pte_free does dec_zone_page_state and
> > pte_lock_deinit, these two happen twice here.
> 
> Ah, good. I wonder if there are any other pte_lock_deinit hidden in the
> arch code... nope, arm is the only architecture that does it.

That's because we _may_ have a page table to map the vectors page at
address 0 (which needs to exist all the time that the page tables are
in use by the CPU.)

> > Removing the calls to dec_zone_page_state() and pte_lock_deinit() in
> > free_pgd_slow() fixed it for me.
> 
> That is imho the best way to fix it.

... but at what cost?

> > For a complete fix we might want to change the type of pte?
> 
> You mean instead of a "struct page *" use a pgtable_t ? Yes, that would
> be cleaner even if it is the same type.

Would someone mind investigating how the code ended up in this mess in
the first place, so we can avoid this kind of thing in the future?

It looks like the pte_lock_deinit() appeared in
4c21e2f2441dc5fbb957b030333f5a3f2d02dea7.

The dec_zone_page_state() used to be dec_page_state(nr_page_table_pages);
which then became a dec_zone_page_state() in
df849a1529c106f7460e51479ca78fe07b07dc8c.

Both changes of those changes on their own look correct.

Ah, is it that someone skipped over ARM when they changed the page table
freeing code?  Yes - 2f569afd9ced9ebec9a6eb3dbf6f83429be0a7b4 has:

diff --git a/mm/memory.c b/mm/memory.c
index 153a54b..e5628a5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -134,11 +134,9 @@ void pmd_clear_bad(pmd_t *pmd)
  */
 static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd)
 {
-       struct page *page = pmd_page(*pmd);
+       pgtable_t token = pmd_pgtable(*pmd);
        pmd_clear(pmd);
-       pte_lock_deinit(page);
-       pte_free_tlb(tlb, page);
-       dec_zone_page_state(page, NR_PAGETABLE);
+       pte_free_tlb(tlb, token);
        tlb->mm->nr_ptes--;
 }

and no corresponding change to ARM.  So, ARM needs to be fixed with this
change before some other subtle breakage occurs.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
