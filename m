Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 26 Feb 2005 21:19:10 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] set_pte() part 2 arch usage
Message-Id: <20050226211910.79dbfa45.davem@davemloft.net>
In-Reply-To: <20050226190943.7aa031e2.davem@davemloft.net>
References: <20050223200719.2d4e8918.davem@davemloft.net>
	<1109222328.15027.12.camel@gaston>
	<20050224143601.12c340ca.davem@davemloft.net>
	<1109309524.14993.56.camel@gaston>
	<1109316055.14992.60.camel@gaston>
	<20050225103730.75adf2f0.davem@davemloft.net>
	<1109379369.15027.99.camel@gaston>
	<20050226190943.7aa031e2.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: benh@kernel.crashing.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 26 Feb 2005 19:09:43 -0800
"David S. Miller" <davem@davemloft.net> wrote:

> I know of at least three such cases so far, vmalloc.c:unmap_area_pte(),
> vmalloc.c:map_area_pte(), and mprotect.c:change_pte_range()
> 
> The latter could definitely explain the behavior you are seeing on
> ppc64.

Ok, here's a fix, let me know if it makes the PPC64 problems
go away Ben.

Thanks.

===== mm/memory.c 1.224 vs edited =====
--- 1.224/mm/memory.c	2005-02-23 15:40:53 -08:00
+++ edited/mm/memory.c	2005-02-26 20:12:21 -08:00
@@ -992,16 +992,17 @@
 			      unsigned long address,
 			      unsigned long size, pgprot_t prot)
 {
-	unsigned long end;
+	unsigned long base, end;
 
+	base = address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
 		end = PMD_SIZE;
 	do {
-		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(address), prot));
+		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(base+address), prot));
 		BUG_ON(!pte_none(*pte));
-		set_pte_at(mm, address, pte, zero_pte);
+		set_pte_at(mm, base+address, pte, zero_pte);
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
@@ -1106,8 +1107,9 @@
 		unsigned long address, unsigned long size,
 		unsigned long pfn, pgprot_t prot)
 {
-	unsigned long end;
+	unsigned long base, end;
 
+	base = address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -1115,7 +1117,7 @@
 	do {
 		BUG_ON(!pte_none(*pte));
 		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
-			set_pte_at(mm, address, pte, pfn_pte(pfn, prot));
+			set_pte_at(mm, base+address, pte, pfn_pte(pfn, prot));
 		address += PAGE_SIZE;
 		pfn++;
 		pte++;
===== mm/mprotect.c 1.41 vs edited =====
--- 1.41/mm/mprotect.c	2005-02-23 15:40:53 -08:00
+++ edited/mm/mprotect.c	2005-02-26 20:40:27 -08:00
@@ -30,7 +30,7 @@
 		unsigned long size, pgprot_t newprot)
 {
 	pte_t * pte;
-	unsigned long end;
+	unsigned long base, end;
 
 	if (pmd_none(*pmd))
 		return;
@@ -40,6 +40,7 @@
 		return;
 	}
 	pte = pte_offset_map(pmd, address);
+	base = address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -52,8 +53,8 @@
 			 * bits by wiping the pte and then setting the new pte
 			 * into place.
 			 */
-			entry = ptep_get_and_clear(mm, address, pte);
-			set_pte_at(mm, address, pte, pte_modify(entry, newprot));
+			entry = ptep_get_and_clear(mm, base + address, pte);
+			set_pte_at(mm, base + address, pte, pte_modify(entry, newprot));
 		}
 		address += PAGE_SIZE;
 		pte++;
@@ -66,7 +67,7 @@
 		 unsigned long size, pgprot_t newprot)
 {
 	pmd_t * pmd;
-	unsigned long end;
+	unsigned long base, end;
 
 	if (pud_none(*pud))
 		return;
@@ -76,12 +77,13 @@
 		return;
 	}
 	pmd = pmd_offset(pud, address);
+	base = address & PUD_MASK;
 	address &= ~PUD_MASK;
 	end = address + size;
 	if (end > PUD_SIZE)
 		end = PUD_SIZE;
 	do {
-		change_pte_range(mm, pmd, address, end - address, newprot);
+		change_pte_range(mm, pmd, base + address, end - address, newprot);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
@@ -92,7 +94,7 @@
 		 unsigned long size, pgprot_t newprot)
 {
 	pud_t * pud;
-	unsigned long end;
+	unsigned long base, end;
 
 	if (pgd_none(*pgd))
 		return;
@@ -102,12 +104,13 @@
 		return;
 	}
 	pud = pud_offset(pgd, address);
+	base = address & PGDIR_MASK;
 	address &= ~PGDIR_MASK;
 	end = address + size;
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
-		change_pmd_range(mm, pud, address, end - address, newprot);
+		change_pmd_range(mm, pud, base + address, end - address, newprot);
 		address = (address + PUD_SIZE) & PUD_MASK;
 		pud++;
 	} while (address && (address < end));
===== mm/vmalloc.c 1.41 vs edited =====
--- 1.41/mm/vmalloc.c	2005-02-23 15:40:53 -08:00
+++ edited/mm/vmalloc.c	2005-02-26 20:18:44 -08:00
@@ -26,7 +26,7 @@
 static void unmap_area_pte(pmd_t *pmd, unsigned long address,
 				  unsigned long size)
 {
-	unsigned long end;
+	unsigned long base, end;
 	pte_t *pte;
 
 	if (pmd_none(*pmd))
@@ -38,6 +38,7 @@
 	}
 
 	pte = pte_offset_kernel(pmd, address);
+	base = address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -45,7 +46,7 @@
 
 	do {
 		pte_t page;
-		page = ptep_get_and_clear(&init_mm, address, pte);
+		page = ptep_get_and_clear(&init_mm, base + address, pte);
 		address += PAGE_SIZE;
 		pte++;
 		if (pte_none(page))
@@ -59,7 +60,7 @@
 static void unmap_area_pmd(pud_t *pud, unsigned long address,
 				  unsigned long size)
 {
-	unsigned long end;
+	unsigned long base, end;
 	pmd_t *pmd;
 
 	if (pud_none(*pud))
@@ -71,13 +72,14 @@
 	}
 
 	pmd = pmd_offset(pud, address);
+	base = address & PUD_MASK;
 	address &= ~PUD_MASK;
 	end = address + size;
 	if (end > PUD_SIZE)
 		end = PUD_SIZE;
 
 	do {
-		unmap_area_pte(pmd, address, end - address);
+		unmap_area_pte(pmd, base + address, end - address);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address < end);
@@ -87,7 +89,7 @@
 			   unsigned long size)
 {
 	pud_t *pud;
-	unsigned long end;
+	unsigned long base, end;
 
 	if (pgd_none(*pgd))
 		return;
@@ -98,13 +100,14 @@
 	}
 
 	pud = pud_offset(pgd, address);
+	base = address & PGDIR_MASK;
 	address &= ~PGDIR_MASK;
 	end = address + size;
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 
 	do {
-		unmap_area_pmd(pud, address, end - address);
+		unmap_area_pmd(pud, base + address, end - address);
 		address = (address + PUD_SIZE) & PUD_MASK;
 		pud++;
 	} while (address && (address < end));
@@ -114,8 +117,9 @@
 			       unsigned long size, pgprot_t prot,
 			       struct page ***pages)
 {
-	unsigned long end;
+	unsigned long base, end;
 
+	base = address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -127,7 +131,7 @@
 		if (!page)
 			return -ENOMEM;
 
-		set_pte_at(&init_mm, address, pte, mk_pte(page, prot));
+		set_pte_at(&init_mm, base + address, pte, mk_pte(page, prot));
 		address += PAGE_SIZE;
 		pte++;
 		(*pages)++;
@@ -151,7 +155,7 @@
 		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, base + address);
 		if (!pte)
 			return -ENOMEM;
-		if (map_area_pte(pte, address, end - address, prot, pages))
+		if (map_area_pte(pte, base + address, end - address, prot, pages))
 			return -ENOMEM;
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
