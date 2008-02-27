Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail164.messagelabs.com ([216.82.253.131]:3493 "HELO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754872AbYB0MpE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Feb 2008 07:45:04 -0500
Date: Wed, 27 Feb 2008 13:44:59 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: regression: 2f569af (CONFIG_HIGHPTE vs. sub-page page tables.)
Message-ID: <20080227124459.GA32147@digi.com>
References: <20080225132648.GA13791@digi.com> <1203958582.3247.3.camel@localhost> <20080226143858.GA11590@digi.com> <1204048666.21725.6.camel@localhost> <20080226194903.GB31527@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20080226194903.GB31527@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

Hello Russell,

(I didn't add you to the recipients of that mail, because your mail had
a Reply-To: header.  So I assume that's what you want.)

> > > Removing the calls to dec_zone_page_state() and pte_lock_deinit() in
> > > free_pgd_slow() fixed it for me.
> > 
> > That is imho the best way to fix it.
> 
> ... but at what cost?
I don't see any costs.  Can you please enlighten me?

> > > For a complete fix we might want to change the type of pte?
> > 
> > You mean instead of a "struct page *" use a pgtable_t ? Yes, that would
> > be cleaner even if it is the same type.
> 
> Would someone mind investigating how the code ended up in this mess in
> the first place, so we can avoid this kind of thing in the future?
> 
> It looks like the pte_lock_deinit() appeared in
> 4c21e2f2441dc5fbb957b030333f5a3f2d02dea7.
> 
> The dec_zone_page_state() used to be dec_page_state(nr_page_table_pages);
> which then became a dec_zone_page_state() in
> df849a1529c106f7460e51479ca78fe07b07dc8c.
> 
> Both changes of those changes on their own look correct.
> 
> Ah, is it that someone skipped over ARM when they changed the page table
> freeing code?  Yes - 2f569afd9ced9ebec9a6eb3dbf6f83429be0a7b4 has:
If you look at the subject line or the earlier mails in that thread,
that is the exact commit I blamed, too.

So below comes a patch.  In  my eyes this has to go in before 2.6.25.

Best regards
Uwe

---->8----
Fix freeing of page tables for ARM in free_pgd_slow

Since 2f569af (CONFIG_HIGHPTE vs. sub-page page tables.) pte_free() calls
pte_lock_deinit() and dec_zone_page_state().  So free_pgd_slow must not call
the latter two when calling the first.

Signed-off-by: Uwe Kleine-König <Uwe.Kleine-Koenig@digi.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/arm/mm/pgd.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index 500c961..e0f19ab 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -75,7 +75,7 @@ no_pgd:
 void free_pgd_slow(struct mm_struct *mm, pgd_t *pgd)
 {
 	pmd_t *pmd;
-	struct page *pte;
+	pgtable_t pte;
 
 	if (!pgd)
 		return;
@@ -90,10 +90,8 @@ void free_pgd_slow(struct mm_struct *mm, pgd_t *pgd)
 		goto free;
 	}
 
-	pte = pmd_page(*pmd);
+	pte = pmd_pgtable(*pmd);
 	pmd_clear(pmd);
-	dec_zone_page_state(virt_to_page((unsigned long *)pgd), NR_PAGETABLE);
-	pte_lock_deinit(pte);
 	pte_free(mm, pte);
 	pmd_free(mm, pmd);
 free:
-- 
1.5.4.3


-- 
Uwe Kleine-König, Software Engineer
Digi International GmbH Branch Breisach, Küferstrasse 8, 79206 Breisach, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 13962
