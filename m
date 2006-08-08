Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:59342 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932586AbWHHMXV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2006 08:23:21 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 10/13] Generic ioremap_page_range: s390 conversion
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 08 Aug 2006 14:23:12 +0200
Message-Id: <11550397961711-git-send-email-hskinnemoen@atmel.com>
In-Reply-To: <11550397961615-git-send-email-hskinnemoen@atmel.com>
References: <11550397951750-git-send-email-hskinnemoen@atmel.com> <11550397954098-git-send-email-hskinnemoen@atmel.com> <11550397954093-git-send-email-hskinnemoen@atmel.com> <11550397963310-git-send-email-hskinnemoen@atmel.com> <11550397962723-git-send-email-hskinnemoen@atmel.com> <1155039796165-git-send-email-hskinnemoen@atmel.com> <11550397964177-git-send-email-hskinnemoen@atmel.com> <1155039796529-git-send-email-hskinnemoen@atmel.com> <11550397963281-git-send-email-hskinnemoen@atmel.com> <11550397961615-git-send-email-hskinnemoen@atmel.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
List-ID: <linux-arch.vger.kernel.org>

Convert S390 to use generic ioremap_page_range()

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/s390/mm/ioremap.c |   84 ++----------------------------------------------
 1 files changed, 3 insertions(+), 81 deletions(-)

diff --git a/arch/s390/mm/ioremap.c b/arch/s390/mm/ioremap.c
index 0f6e9ec..3d2100a 100644
--- a/arch/s390/mm/ioremap.c
+++ b/arch/s390/mm/ioremap.c
@@ -15,87 +15,8 @@
 
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/pgalloc.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-
-static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
-        unsigned long phys_addr, unsigned long flags)
-{
-        unsigned long end;
-        unsigned long pfn;
-
-        address &= ~PMD_MASK;
-        end = address + size;
-        if (end > PMD_SIZE)
-                end = PMD_SIZE;
-	if (address >= end)
-		BUG();
-        pfn = phys_addr >> PAGE_SHIFT;
-        do {
-                if (!pte_none(*pte)) {
-                        printk("remap_area_pte: page already exists\n");
-			BUG();
-		}
-                set_pte(pte, pfn_pte(pfn, __pgprot(flags)));
-                address += PAGE_SIZE;
-                pfn++;
-                pte++;
-        } while (address && (address < end));
-}
-
-static inline int remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size,
-        unsigned long phys_addr, unsigned long flags)
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
-static int remap_area_pages(unsigned long address, unsigned long phys_addr,
-				 unsigned long size, unsigned long flags)
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
-	return 0;
-}
 
 /*
  * Generic mapping function (not visible outside):
@@ -122,7 +43,8 @@ void * __ioremap(unsigned long phys_addr
 	if (!area)
 		return NULL;
 	addr = area->addr;
-	if (remap_area_pages((unsigned long) addr, phys_addr, size, flags)) {
+	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size,
+			       phys_addr, __pgprot(flags))) {
 		vfree(addr);
 		return NULL;
 	}
-- 
1.4.0

