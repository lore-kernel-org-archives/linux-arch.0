Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:35063 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S964808AbWHHMXW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2006 08:23:22 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 8/13] Generic ioremap_page_range: mips conversion
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 08 Aug 2006 14:23:10 +0200
Message-Id: <11550397963281-git-send-email-hskinnemoen@atmel.com>
In-Reply-To: <1155039796529-git-send-email-hskinnemoen@atmel.com>
References: <11550397951750-git-send-email-hskinnemoen@atmel.com> <11550397954098-git-send-email-hskinnemoen@atmel.com> <11550397954093-git-send-email-hskinnemoen@atmel.com> <11550397963310-git-send-email-hskinnemoen@atmel.com> <11550397962723-git-send-email-hskinnemoen@atmel.com> <1155039796165-git-send-email-hskinnemoen@atmel.com> <11550397964177-git-send-email-hskinnemoen@atmel.com> <1155039796529-git-send-email-hskinnemoen@atmel.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
List-ID: <linux-arch.vger.kernel.org>

Convert MIPS to use generic ioremap_page_range()

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/mips/mm/ioremap.c |   95 ++++--------------------------------------------
 1 files changed, 7 insertions(+), 88 deletions(-)

diff --git a/arch/mips/mm/ioremap.c b/arch/mips/mm/ioremap.c
index 3101d1d..cac79ae 100644
--- a/arch/mips/mm/ioremap.c
+++ b/arch/mips/mm/ioremap.c
@@ -11,93 +11,7 @@ #include <asm/addrspace.h>
 #include <asm/byteorder.h>
 
 #include <linux/vmalloc.h>
-#include <asm/cacheflush.h>
-#include <asm/io.h>
-#include <asm/tlbflush.h>
-
-static inline void remap_area_pte(pte_t * pte, unsigned long address,
-	phys_t size, phys_t phys_addr, unsigned long flags)
-{
-	phys_t end;
-	unsigned long pfn;
-	pgprot_t pgprot = __pgprot(_PAGE_GLOBAL | _PAGE_PRESENT | __READABLE
-	                           | __WRITEABLE | flags);
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
-static inline int remap_area_pmd(pmd_t * pmd, unsigned long address,
-	phys_t size, phys_t phys_addr, unsigned long flags)
-{
-	phys_t end;
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
-static int remap_area_pages(unsigned long address, phys_t phys_addr,
-	phys_t size, unsigned long flags)
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
-		pud_t *pud;
-		pmd_t *pmd;
-
-		error = -ENOMEM;
-		pud = pud_alloc(&init_mm, dir, address);
-		if (!pud)
-			break;
-		pmd = pmd_alloc(&init_mm, pud, address);
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
+#include <linux/io.h>
 
 /*
  * Generic mapping function (not visible outside):
@@ -121,6 +35,7 @@ void __iomem * __ioremap(phys_t phys_add
 	unsigned long offset;
 	phys_t last_addr;
 	void * addr;
+	pgprot_t pgprot;
 
 	phys_addr = fixup_bigphys_addr(phys_addr, size);
 
@@ -152,6 +67,9 @@ void __iomem * __ioremap(phys_t phys_add
 				return NULL;
 	}
 
+	pgprot = __pgprot(_PAGE_GLOBAL | _PAGE_PRESENT | __READABLE
+			  | __WRITEABLE | flags);
+
 	/*
 	 * Mappings have to be page-aligned
 	 */
@@ -166,7 +84,8 @@ void __iomem * __ioremap(phys_t phys_add
 	if (!area)
 		return NULL;
 	addr = area->addr;
-	if (remap_area_pages((unsigned long) addr, phys_addr, size, flags)) {
+	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size,
+			       phys_addr, pgprot)) {
 		vunmap(addr);
 		return NULL;
 	}
-- 
1.4.0

