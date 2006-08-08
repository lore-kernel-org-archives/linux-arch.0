Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:22986 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932593AbWHHMXW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2006 08:23:22 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 4/13] Generic ioremap_page_range: avr32 conversion
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 08 Aug 2006 14:23:06 +0200
Message-Id: <11550397962723-git-send-email-hskinnemoen@atmel.com>
In-Reply-To: <11550397963310-git-send-email-hskinnemoen@atmel.com>
References: <11550397951750-git-send-email-hskinnemoen@atmel.com> <11550397954098-git-send-email-hskinnemoen@atmel.com> <11550397954093-git-send-email-hskinnemoen@atmel.com> <11550397963310-git-send-email-hskinnemoen@atmel.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
List-ID: <linux-arch.vger.kernel.org>

Convert AVR32 to use generic ioremap_page_range()

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/mm/ioremap.c |  120 ++---------------------------------------------
 1 files changed, 6 insertions(+), 114 deletions(-)

diff --git a/arch/avr32/mm/ioremap.c b/arch/avr32/mm/ioremap.c
index 5360218..8cfec65 100644
--- a/arch/avr32/mm/ioremap.c
+++ b/arch/avr32/mm/ioremap.c
@@ -7,119 +7,11 @@
  */
 #include <linux/vmalloc.h>
 #include <linux/module.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/pgtable.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
 #include <asm/addrspace.h>
 
-static inline int remap_area_pte(pte_t *pte, unsigned long address,
-				  unsigned long end, unsigned long phys_addr,
-				  pgprot_t prot)
-{
-	unsigned long pfn;
-
-	pfn = phys_addr >> PAGE_SHIFT;
-	do {
-		WARN_ON(!pte_none(*pte));
-
-		set_pte(pte, pfn_pte(pfn, prot));
-		address += PAGE_SIZE;
-		pfn++;
-		pte++;
-	} while (address && (address < end));
-
-	return 0;
-}
-
-static inline int remap_area_pmd(pmd_t *pmd, unsigned long address,
-				 unsigned long end, unsigned long phys_addr,
-				 pgprot_t prot)
-{
-	unsigned long next;
-
-	phys_addr -= address;
-
-	do {
-		pte_t *pte = pte_alloc_kernel(pmd, address);
-		if (!pte)
-			return -ENOMEM;
-
-		next = (address + PMD_SIZE) & PMD_MASK;
-		if (remap_area_pte(pte, address, next,
-				   address + phys_addr, prot))
-			return -ENOMEM;
-
-		address = next;
-		pmd++;
-	} while (address && (address < end));
-	return 0;
-}
-
-static int remap_area_pud(pud_t *pud, unsigned long address,
-			  unsigned long end, unsigned long phys_addr,
-			  pgprot_t prot)
-{
-	unsigned long next;
-
-	phys_addr -= address;
-
-	do {
-		pmd_t *pmd = pmd_alloc(&init_mm, pud, address);
-		if (!pmd)
-			return -ENOMEM;
-		next = (address + PUD_SIZE) & PUD_MASK;
-		if (remap_area_pmd(pmd, address, next,
-				   phys_addr + address, prot))
-			return -ENOMEM;
-
-		address = next;
-		pud++;
-	} while (address && address < end);
-
-	return 0;
-}
-
-static int remap_area_pages(unsigned long address, unsigned long phys_addr,
-			    size_t size, pgprot_t prot)
-{
-	unsigned long end = address + size;
-	unsigned long next;
-	pgd_t *pgd;
-	int err = 0;
-
-	phys_addr -= address;
-
-	pgd = pgd_offset_k(address);
-	flush_cache_all();
-	BUG_ON(address >= end);
-
-	spin_lock(&init_mm.page_table_lock);
-	do {
-		pud_t *pud = pud_alloc(&init_mm, pgd, address);
-
-		err = -ENOMEM;
-		if (!pud)
-			break;
-
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next < address || next > end)
-			next = end;
-		err = remap_area_pud(pud, address, next,
-				     phys_addr + address, prot);
-		if (err)
-			break;
-
-		address = next;
-		pgd++;
-	} while (address && (address < end));
-
-	spin_unlock(&init_mm.page_table_lock);
-	flush_tlb_all();
-	return err;
-}
-
 /*
  * Re-map an arbitrary physical address space into the kernel virtual
  * address space. Needed when the kernel wants to access physical
@@ -128,7 +20,7 @@ static int remap_area_pages(unsigned lon
 void __iomem *__ioremap(unsigned long phys_addr, size_t size,
 			unsigned long flags)
 {
-	void *addr;
+	unsigned long addr;
 	struct vm_struct *area;
 	unsigned long offset, last_addr;
 	pgprot_t prot;
@@ -159,7 +51,7 @@ void __iomem *__ioremap(unsigned long ph
 	phys_addr &= PAGE_MASK;
 	size = PAGE_ALIGN(last_addr + 1) - phys_addr;
 
-	prot = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY
+	prot = __pgprot(_PAGE_PRESENT | _PAGE_GLOBAL | _PAGE_RW | _PAGE_DIRTY
 			| _PAGE_ACCESSED | _PAGE_TYPE_SMALL | flags);
 
 	/*
@@ -169,9 +61,9 @@ void __iomem *__ioremap(unsigned long ph
 	if (!area)
 		return NULL;
 	area->phys_addr = phys_addr;
-	addr = area->addr;
-	if (remap_area_pages((unsigned long)addr, phys_addr, size, prot)) {
-		vunmap(addr);
+	addr = (unsigned long )area->addr;
+	if (ioremap_page_range(addr, addr + size, phys_addr, prot)) {
+		vunmap((void *)addr);
 		return NULL;
 	}
 
-- 
1.4.0

