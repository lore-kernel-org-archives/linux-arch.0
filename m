Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:63436 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S964795AbWHHMXW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2006 08:23:22 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 5/13] Generic ioremap_page_range: cris conversion
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 08 Aug 2006 14:23:07 +0200
Message-Id: <1155039796165-git-send-email-hskinnemoen@atmel.com>
In-Reply-To: <11550397962723-git-send-email-hskinnemoen@atmel.com>
References: <11550397951750-git-send-email-hskinnemoen@atmel.com> <11550397954098-git-send-email-hskinnemoen@atmel.com> <11550397954093-git-send-email-hskinnemoen@atmel.com> <11550397963310-git-send-email-hskinnemoen@atmel.com> <11550397962723-git-send-email-hskinnemoen@atmel.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
List-ID: <linux-arch.vger.kernel.org>

Convert CRIS to use generic ioremap_page_range()

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/cris/mm/ioremap.c |   88 ++----------------------------------------------
 1 files changed, 3 insertions(+), 85 deletions(-)

diff --git a/arch/cris/mm/ioremap.c b/arch/cris/mm/ioremap.c
index 1780df3..8b0b934 100644
--- a/arch/cris/mm/ioremap.c
+++ b/arch/cris/mm/ioremap.c
@@ -10,93 +10,10 @@
  */
 
 #include <linux/vmalloc.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/pgalloc.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
 #include <asm/arch/memmap.h>
 
-static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long phys_addr, pgprot_t prot)
-{
-	unsigned long end;
-
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-	if (address >= end)
-		BUG();
-	do {
-		if (!pte_none(*pte)) {
-			printk("remap_area_pte: page already exists\n");
-			BUG();
-		}
-		set_pte(pte, mk_pte_phys(phys_addr, prot));
-		address += PAGE_SIZE;
-		phys_addr += PAGE_SIZE;
-		pte++;
-	} while (address && (address < end));
-}
-
-static inline int remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size,
-	unsigned long phys_addr, pgprot_t prot)
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
-		remap_area_pte(pte, address, end - address, address + phys_addr, prot);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
-	return 0;
-}
-
-static int remap_area_pages(unsigned long address, unsigned long phys_addr,
-				 unsigned long size, pgprot_t prot)
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
-
-		if (!pmd)
-			break;
-		if (remap_area_pmd(pmd, address, end - address,
-				   phys_addr + address, prot))
-			break;
-		error = 0;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
-	flush_tlb_all();
-	return error;
-}
-
 /*
  * Generic mapping function (not visible outside):
  */
@@ -135,7 +52,8 @@ void __iomem * __ioremap_prot(unsigned l
 	if (!area)
 		return NULL;
 	addr = (void __iomem *)area->addr;
-	if (remap_area_pages((unsigned long) addr, phys_addr, size, prot)) {
+	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size,
+			       phys_addr, prot)) {
 		vfree((void __force *)addr);
 		return NULL;
 	}
-- 
1.4.0

