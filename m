Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfG3MP4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Jul 2019 08:15:56 -0400
From: guoren@kernel.org
Subject: [PATCH 2/4] csky: Fixup dma_alloc_coherent with PAGE_SO attribute
Date: Tue, 30 Jul 2019 20:15:43 +0800
Message-ID: <1564488945-20149-2-git-send-email-guoren@kernel.org>
In-Reply-To: <1564488945-20149-1-git-send-email-guoren@kernel.org>
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190730121543.EHqwp3jCRViNPBba48NdeIw_sK7zXzQmhvoEc70Flks@z>

From: Guo Ren <ren_guo@c-sky.com>

This bug is from commit: 2b070ccdf8c0 (fixup abiv2 mmap(... O_SYNC)
failed). In that patch we remove the _PAGE_SO for memory noncache
mapping and this will cause problem when drivers use dma descriptors
to control the transcations without dma_w/rmb().

After referencing other archs' implementation, pgprot_writecombine is
introduced for mmap(... O_SYNC).

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/pgtable.h | 10 ++++++++++
 arch/csky/mm/ioremap.c          |  6 ++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index c429a6f..fc19ba4 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -258,6 +258,16 @@ static inline pgprot_t pgprot_noncached(pgprot_t _prot)
 {
 	unsigned long prot = pgprot_val(_prot);
 
+	prot = (prot & ~_CACHE_MASK) | _CACHE_UNCACHED | _PAGE_SO;
+
+	return __pgprot(prot);
+}
+
+#define pgprot_writecombine pgprot_writecombine
+static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
+{
+	unsigned long prot = pgprot_val(_prot);
+
 	prot = (prot & ~_CACHE_MASK) | _CACHE_UNCACHED;
 
 	return __pgprot(prot);
diff --git a/arch/csky/mm/ioremap.c b/arch/csky/mm/ioremap.c
index 8473b6b..4853111 100644
--- a/arch/csky/mm/ioremap.c
+++ b/arch/csky/mm/ioremap.c
@@ -29,8 +29,7 @@ void __iomem *ioremap(phys_addr_t addr, size_t size)
 
 	vaddr = (unsigned long)area->addr;
 
-	prot = __pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE |
-			_PAGE_GLOBAL | _CACHE_UNCACHED | _PAGE_SO);
+	prot = pgprot_noncached(PAGE_KERNEL);
 
 	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
 		free_vm_area(area);
@@ -51,10 +50,9 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
 	if (!pfn_valid(pfn)) {
-		vma_prot.pgprot |= _PAGE_SO;
 		return pgprot_noncached(vma_prot);
 	} else if (file->f_flags & O_SYNC) {
-		return pgprot_noncached(vma_prot);
+		return pgprot_writecombine(vma_prot);
 	}
 
 	return vma_prot;
-- 
2.7.4
