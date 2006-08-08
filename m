Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:15848 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932594AbWHHMXW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2006 08:23:22 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 7/13] Generic ioremap_page_range: m32r conversion
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 08 Aug 2006 14:23:09 +0200
Message-Id: <1155039796529-git-send-email-hskinnemoen@atmel.com>
In-Reply-To: <11550397964177-git-send-email-hskinnemoen@atmel.com>
References: <11550397951750-git-send-email-hskinnemoen@atmel.com> <11550397954098-git-send-email-hskinnemoen@atmel.com> <11550397954093-git-send-email-hskinnemoen@atmel.com> <11550397963310-git-send-email-hskinnemoen@atmel.com> <11550397962723-git-send-email-hskinnemoen@atmel.com> <1155039796165-git-send-email-hskinnemoen@atmel.com> <11550397964177-git-send-email-hskinnemoen@atmel.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
List-ID: <linux-arch.vger.kernel.org>

Convert m32r to use generic ioremap_page_range()

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/m32r/mm/ioremap.c |   93 ++++--------------------------------------------
 1 files changed, 7 insertions(+), 86 deletions(-)

diff --git a/arch/m32r/mm/ioremap.c b/arch/m32r/mm/ioremap.c
index a151849..5152c4e 100644
--- a/arch/m32r/mm/ioremap.c
+++ b/arch/m32r/mm/ioremap.c
@@ -20,92 +20,8 @@ #include <asm/addrspace.h>
 #include <asm/byteorder.h>
 
 #include <linux/vmalloc.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/pgalloc.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-
-static inline void
-remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
-	       unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-	unsigned long pfn;
-	pgprot_t pgprot = __pgprot(_PAGE_GLOBAL | _PAGE_PRESENT | _PAGE_READ
-	                           | _PAGE_WRITE | flags);
-
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-	if (address >= end)
-		BUG();
-	pfn = phys_addr >> PAGE_SHIFT;
-	do {
-		if (!pte_none(*pte)) {
-			printk("remap_area_pte: page already exists\n");
-			BUG();
-		}
-		set_pte(pte, pfn_pte(pfn, pgprot));
-		address += PAGE_SIZE;
-		pfn++;
-		pte++;
-	} while (address && (address < end));
-}
-
-static inline int
-remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size,
-	       unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	phys_addr -= address;
-	if (address >= end)
-		BUG();
-	do {
-		pte_t * pte = pte_alloc_kernel(pmd, address);
-		if (!pte)
-			return -ENOMEM;
-		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
-	return 0;
-}
-
-static int
-remap_area_pages(unsigned long address, unsigned long phys_addr,
-		 unsigned long size, unsigned long flags)
-{
-	int error;
-	pgd_t * dir;
-	unsigned long end = address + size;
-
-	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
-	flush_cache_all();
-	if (address >= end)
-		BUG();
-	do {
-		pmd_t *pmd;
-		pmd = pmd_alloc(&init_mm, dir, address);
-		error = -ENOMEM;
-		if (!pmd)
-			break;
-		if (remap_area_pmd(pmd, address, end - address,
-					 phys_addr + address, flags))
-			break;
-		error = 0;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
-	flush_tlb_all();
-	return error;
-}
 
 /*
  * Generic mapping function (not visible outside):
@@ -129,6 +45,7 @@ __ioremap(unsigned long phys_addr, unsig
 	void __iomem * addr;
 	struct vm_struct * area;
 	unsigned long offset, last_addr;
+	pgprot_t pgprot;
 
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
@@ -157,6 +74,9 @@ __ioremap(unsigned long phys_addr, unsig
 				return NULL;
 	}
 
+	pgprot = __pgprot(_PAGE_GLOBAL | _PAGE_PRESENT | _PAGE_READ
+			  | _PAGE_WRITE | flags);
+
 	/*
 	 * Mappings have to be page-aligned
 	 */
@@ -172,7 +92,8 @@ __ioremap(unsigned long phys_addr, unsig
 		return NULL;
 	area->phys_addr = phys_addr;
 	addr = (void __iomem *) area->addr;
-	if (remap_area_pages((unsigned long)addr, phys_addr, size, flags)) {
+	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size,
+			       phys_addr, pgprot)) {
 		vunmap((void __force *) addr);
 		return NULL;
 	}
-- 
1.4.0

