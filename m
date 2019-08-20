Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbfHTMep (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 08:34:45 -0400
From: guoren@kernel.org
Subject: [PATCH 1/3] csky: Fixup arch_get_unmapped_area() implementation
Date: Tue, 20 Aug 2019 20:34:27 +0800
Message-ID: <1566304469-5601-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, douzhk@nationalchip.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190820123427.AUTebIOWntHgrpw2P-ENSti_7vZ-5QcD19i3tQa7NuE@z>

From: Guo Ren <ren_guo@c-sky.com>

Current arch_get_unmapped_area() of abiv1 doesn't use standard kernel
api. After referring to the implementation of arch/arm, we implement
it with vm_unmapped_area() from linux/mm.h.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv1/inc/abi/page.h |  5 +--
 arch/csky/abiv1/mmap.c         | 75 ++++++++++++++++++++++--------------------
 2 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/page.h b/arch/csky/abiv1/inc/abi/page.h
index 6336e92..c864519 100644
--- a/arch/csky/abiv1/inc/abi/page.h
+++ b/arch/csky/abiv1/inc/abi/page.h
@@ -1,13 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
-extern unsigned long shm_align_mask;
+#include <asm/shmparam.h>
+
 extern void flush_dcache_page(struct page *page);
 
 static inline unsigned long pages_do_alias(unsigned long addr1,
 					   unsigned long addr2)
 {
-	return (addr1 ^ addr2) & shm_align_mask;
+	return (addr1 ^ addr2) & (SHMLBA-1);
 }
 
 static inline void clear_user_page(void *addr, unsigned long vaddr,
diff --git a/arch/csky/abiv1/mmap.c b/arch/csky/abiv1/mmap.c
index b462fd5..6792aca 100644
--- a/arch/csky/abiv1/mmap.c
+++ b/arch/csky/abiv1/mmap.c
@@ -9,58 +9,63 @@
 #include <linux/random.h>
 #include <linux/io.h>
 
-unsigned long shm_align_mask = (0x4000 >> 1) - 1;   /* Sane caches */
+#define COLOUR_ALIGN(addr,pgoff)		\
+	((((addr)+SHMLBA-1)&~(SHMLBA-1)) +	\
+	 (((pgoff)<<PAGE_SHIFT) & (SHMLBA-1)))
 
-#define COLOUR_ALIGN(addr, pgoff) \
-	((((addr) + shm_align_mask) & ~shm_align_mask) + \
-	 (((pgoff) << PAGE_SHIFT) & shm_align_mask))
-
-unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
+/*
+ * We need to ensure that shared mappings are correctly aligned to
+ * avoid aliasing issues with VIPT caches.  We need to ensure that
+ * a specific page of an object is always mapped at a multiple of
+ * SHMLBA bytes.
+ *
+ * We unconditionally provide this function for all cases.
+ */
+unsigned long
+arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
-	struct vm_area_struct *vmm;
-	int do_color_align;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	int do_align = 0;
+	struct vm_unmapped_area_info info;
+
+	/*
+	 * We only need to do colour alignment if either the I or D
+	 * caches alias.
+	 */
+	do_align = filp || (flags & MAP_SHARED);
 
+	/*
+	 * We enforce the MAP_FIXED case.
+	 */
 	if (flags & MAP_FIXED) {
-		/*
-		 * We do not accept a shared mapping if it would violate
-		 * cache aliasing constraints.
-		 */
-		if ((flags & MAP_SHARED) &&
-			((addr - (pgoff << PAGE_SHIFT)) & shm_align_mask))
+		if (flags & MAP_SHARED &&
+		    (addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1))
 			return -EINVAL;
 		return addr;
 	}
 
 	if (len > TASK_SIZE)
 		return -ENOMEM;
-	do_color_align = 0;
-	if (filp || (flags & MAP_SHARED))
-		do_color_align = 1;
+
 	if (addr) {
-		if (do_color_align)
+		if (do_align)
 			addr = COLOUR_ALIGN(addr, pgoff);
 		else
 			addr = PAGE_ALIGN(addr);
-		vmm = find_vma(current->mm, addr);
+
+		vma = find_vma(mm, addr);
 		if (TASK_SIZE - len >= addr &&
-				(!vmm || addr + len <= vmm->vm_start))
+		    (!vma || addr + len <= vm_start_gap(vma)))
 			return addr;
 	}
-	addr = TASK_UNMAPPED_BASE;
-	if (do_color_align)
-		addr = COLOUR_ALIGN(addr, pgoff);
-	else
-		addr = PAGE_ALIGN(addr);
 
-	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
-		/* At this point: (!vmm || addr < vmm->vm_end). */
-		if (TASK_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vmm || addr + len <= vmm->vm_start)
-			return addr;
-		addr = vmm->vm_end;
-		if (do_color_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-	}
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = mm->mmap_base;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
+	return vm_unmapped_area(&info);
 }
-- 
2.7.4
