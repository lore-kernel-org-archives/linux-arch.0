Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:30415 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932587AbWHHMXW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2006 08:23:22 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 9/13] Generic ioremap_page_range: parisc conversion
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 08 Aug 2006 14:23:11 +0200
Message-Id: <11550397961615-git-send-email-hskinnemoen@atmel.com>
In-Reply-To: <11550397963281-git-send-email-hskinnemoen@atmel.com>
References: <11550397951750-git-send-email-hskinnemoen@atmel.com> <11550397954098-git-send-email-hskinnemoen@atmel.com> <11550397954093-git-send-email-hskinnemoen@atmel.com> <11550397963310-git-send-email-hskinnemoen@atmel.com> <11550397962723-git-send-email-hskinnemoen@atmel.com> <1155039796165-git-send-email-hskinnemoen@atmel.com> <11550397964177-git-send-email-hskinnemoen@atmel.com> <1155039796529-git-send-email-hskinnemoen@atmel.com> <11550397963281-git-send-email-hskinnemoen@atmel.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
List-ID: <linux-arch.vger.kernel.org>

Convert parisc to use generic ioremap_page_range()

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/parisc/mm/ioremap.c |  111 +++-------------------------------------------
 1 files changed, 7 insertions(+), 104 deletions(-)

diff --git a/arch/parisc/mm/ioremap.c b/arch/parisc/mm/ioremap.c
index 2738456..a31da6c 100644
--- a/arch/parisc/mm/ioremap.c
+++ b/arch/parisc/mm/ioremap.c
@@ -9,110 +9,8 @@
 #include <linux/vmalloc.h>
 #include <linux/errno.h>
 #include <linux/module.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/pgalloc.h>
-#include <asm/tlbflush.h>
-#include <asm/cacheflush.h>
-
-static inline void 
-remap_area_pte(pte_t *pte, unsigned long address, unsigned long size,
-	       unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end, pfn;
-	pgprot_t pgprot = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY |
-				   _PAGE_ACCESSED | flags);
-
-	address &= ~PMD_MASK;
-
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-
-	BUG_ON(address >= end);
-
-	pfn = phys_addr >> PAGE_SHIFT;
-	do {
-		BUG_ON(!pte_none(*pte));
-
-		set_pte(pte, pfn_pte(pfn, pgprot));
-
-		address += PAGE_SIZE;
-		pfn++;
-		pte++;
-	} while (address && (address < end));
-}
-
-static inline int 
-remap_area_pmd(pmd_t *pmd, unsigned long address, unsigned long size,
-	       unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-
-	address &= ~PGDIR_MASK;
-
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-
-	BUG_ON(address >= end);
-
-	phys_addr -= address;
-	do {
-		pte_t *pte = pte_alloc_kernel(pmd, address);
-		if (!pte)
-			return -ENOMEM;
-
-		remap_area_pte(pte, address, end - address, 
-			       address + phys_addr, flags);
-
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
-
-	return 0;
-}
-
-static int 
-remap_area_pages(unsigned long address, unsigned long phys_addr,
-		 unsigned long size, unsigned long flags)
-{
-	pgd_t *dir;
-	int error = 0;
-	unsigned long end = address + size;
-
-	BUG_ON(address >= end);
-
-	phys_addr -= address;
-	dir = pgd_offset_k(address);
-
-	flush_cache_all();
-
-	do {
-		pud_t *pud;
-		pmd_t *pmd;
-
-		error = -ENOMEM;
-		pud = pud_alloc(&init_mm, dir, address);
-		if (!pud)
-			break;
-
-		pmd = pmd_alloc(&init_mm, pud, address);
-		if (!pmd)
-			break;
-
-		if (remap_area_pmd(pmd, address, end - address,
-				   phys_addr + address, flags))
-			break;
-
-		error = 0;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
-
-	flush_tlb_all();
-
-	return error;
-}
 
 /*
  * Generic mapping function (not visible outside):
@@ -131,6 +29,7 @@ void __iomem * __ioremap(unsigned long p
 	void *addr;
 	struct vm_struct *area;
 	unsigned long offset, last_addr;
+	pgprot_t pgprot;
 
 #ifdef CONFIG_EISA
 	unsigned long end = phys_addr + size - 1;
@@ -164,6 +63,9 @@ #endif
 		}
 	}
 
+	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY |
+			  _PAGE_ACCESSED | flags);
+
 	/*
 	 * Mappings have to be page-aligned
 	 */
@@ -179,7 +81,8 @@ #endif
 		return NULL;
 
 	addr = area->addr;
-	if (remap_area_pages((unsigned long) addr, phys_addr, size, flags)) {
+	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size,
+			       phys_addr, pgprot)) {
 		vfree(addr);
 		return NULL;
 	}
-- 
1.4.0

