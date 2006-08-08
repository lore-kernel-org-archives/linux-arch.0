Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:27103 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932570AbWHHMXV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2006 08:23:21 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 11/13] Generic ioremap_page_range: sh conversion
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 08 Aug 2006 14:23:13 +0200
Message-Id: <11550397961826-git-send-email-hskinnemoen@atmel.com>
In-Reply-To: <11550397961711-git-send-email-hskinnemoen@atmel.com>
References: <11550397951750-git-send-email-hskinnemoen@atmel.com> <11550397954098-git-send-email-hskinnemoen@atmel.com> <11550397954093-git-send-email-hskinnemoen@atmel.com> <11550397963310-git-send-email-hskinnemoen@atmel.com> <11550397962723-git-send-email-hskinnemoen@atmel.com> <1155039796165-git-send-email-hskinnemoen@atmel.com> <11550397964177-git-send-email-hskinnemoen@atmel.com> <1155039796529-git-send-email-hskinnemoen@atmel.com> <11550397963281-git-send-email-hskinnemoen@atmel.com> <11550397961615-git-send-email-hskinnemoen@atmel.com> <11550397961711-git-send-email-hskinnemoen@atmel.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
List-ID: <linux-arch.vger.kernel.org>

Convert SH to use generic ioremap_page_range()

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/sh/mm/ioremap.c |   97 ++++----------------------------------------------
 1 files changed, 7 insertions(+), 90 deletions(-)

diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index 96fa4a9..5ef9245 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -15,98 +15,10 @@
 #include <linux/vmalloc.h>
 #include <linux/module.h>
 #include <linux/mm.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/addrspace.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-
-static inline void remap_area_pte(pte_t * pte, unsigned long address,
-	unsigned long size, unsigned long phys_addr, unsigned long flags)
-{
-	unsigned long end;
-	unsigned long pfn;
-	pgprot_t pgprot = __pgprot(_PAGE_PRESENT | _PAGE_RW |
-				   _PAGE_DIRTY | _PAGE_ACCESSED |
-				   _PAGE_HW_SHARED | _PAGE_FLAGS_HARD | flags);
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
-	unsigned long size, unsigned long phys_addr, unsigned long flags)
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
-int remap_area_pages(unsigned long address, unsigned long phys_addr,
-		     unsigned long size, unsigned long flags)
-{
-	int error;
-	pgd_t * dir;
-	unsigned long end = address + size;
-
-	phys_addr -= address;
-	dir = pgd_offset_k(address);
-	flush_cache_all();
-	if (address >= end)
-		BUG();
-	do {
-		pud_t *pud;
-		pmd_t *pmd;
-
-		error = -ENOMEM;
-
-		pud = pud_alloc(&init_mm, dir, address);
-		if (!pud)
-			break;
-		pmd = pmd_alloc(&init_mm, pud, address);
-		if (!pmd)
-			break;
-		if (remap_area_pmd(pmd, address, end - address,
-					phys_addr + address, flags))
-			break;
-		error = 0;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
-	flush_tlb_all();
-	return error;
-}
 
 /*
  * Remap an arbitrary physical address space into the kernel virtual
@@ -122,6 +34,7 @@ void __iomem *__ioremap(unsigned long ph
 {
 	struct vm_struct * area;
 	unsigned long offset, last_addr, addr, orig_addr;
+	pgprot_t pgprot;
 
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
@@ -177,8 +90,12 @@ #ifdef CONFIG_32BIT
 	}
 #endif
 
+	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_RW |
+			  _PAGE_DIRTY | _PAGE_ACCESSED |
+			  _PAGE_HW_SHARED | _PAGE_FLAGS_HARD | flags);
+
 	if (likely(size))
-		if (remap_area_pages(addr, phys_addr, size, flags)) {
+		if (ioremap_page_range(addr, addr + size, phys_addr, pgprot)) {
 			vunmap((void *)orig_addr);
 			return NULL;
 		}
-- 
1.4.0

