From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 2/2] lockless get_user_pages
Date: Wed, 28 May 2008 16:32:45 +0200
Message-ID: <20080528143245.GA12718@wotan.suse.de>
References: <20080525144847.GB25747@wotan.suse.de> <20080525145227.GC25747@wotan.suse.de> <20080528113906.GA699@shadowen.org> <20080528122827.GH2630@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:54544 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbYE1Ocr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 28 May 2008 10:32:47 -0400
Content-Disposition: inline
In-Reply-To: <20080528122827.GH2630@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, shaggy@austin.ibm.com, jens.axboe@oracle.com, torvalds@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org

FWIW, this is what I've got to support gigabyte hugepages...
---

Index: linux-2.6/arch/x86/mm/gup.c
===================================================================
--- linux-2.6.orig/arch/x86/mm/gup.c
+++ linux-2.6/arch/x86/mm/gup.c
@@ -122,7 +122,7 @@ static noinline int gup_huge_pmd(pmd_t p
 
 	refs = 0;
 	head = pte_page(pte);
-	page = head + ((addr & ~HPAGE_MASK) >> PAGE_SHIFT);
+	page = head + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
 	do {
 		VM_BUG_ON(compound_head(page) != head);
 		pages[*nr] = page;
@@ -160,6 +160,38 @@ static int gup_pmd_range(pud_t pud, unsi
 	return 1;
 }
 
+static noinline int gup_huge_pud(pud_t pud, unsigned long addr,
+		unsigned long end, int write, struct page **pages, int *nr)
+{
+	unsigned long mask;
+	pte_t pte = *(pte_t *)&pud;
+	struct page *head, *page;
+	int refs;
+
+	mask = _PAGE_PRESENT|_PAGE_USER;
+	if (write)
+		mask |= _PAGE_RW;
+	if ((pte_val(pte) & mask) != mask)
+		return 0;
+	/* hugepages are never "special" */
+	VM_BUG_ON(pte_val(pte) & _PAGE_SPECIAL);
+	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
+
+	refs = 0;
+	head = pte_page(pte);
+	page = head + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+	do {
+		VM_BUG_ON(compound_head(page) != head);
+		pages[*nr] = page;
+		(*nr)++;
+		page++;
+		refs++;
+	} while (addr += PAGE_SIZE, addr != end);
+	get_head_page_multiple(head, refs);
+
+	return 1;
+}
+
 static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end, int write, struct page **pages, int *nr)
 {
 	unsigned long next;
@@ -172,8 +204,13 @@ static int gup_pud_range(pgd_t pgd, unsi
 		next = pud_addr_end(addr, end);
 		if (pud_none(pud))
 			return 0;
-		if (!gup_pmd_range(pud, addr, next, write, pages, nr))
-			return 0;
+		if (unlikely(pud_large(pud))) {
+			if (!gup_huge_pud(pud, addr, next, write, pages, nr))
+				return 0;
+		} else {
+			if (!gup_pmd_range(pud, addr, next, write, pages, nr))
+				return 0;
+		}
 	} while (pudp++, addr = next, addr != end);
 
 	return 1;
