Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404595AbfBMRq4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2019 12:46:56 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 7/8] initramfs: proide a generic free_initrd_mem implementation
Date: Wed, 13 Feb 2019 18:46:20 +0100
Message-ID: <20190213174621.29297-8-hch@lst.de>
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190213174620.MMxcEIDiVTXR__dt9sQq7hB1cV0jPN38u9e5gP4j3no@z>

For most architectures free_initrd_mem just expands to the same
free_reserved_area call.  Provide that as a generic implementation
marked __weak.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/mm/init.c      | 8 --------
 arch/arc/mm/init.c        | 7 -------
 arch/c6x/mm/init.c        | 7 -------
 arch/h8300/mm/init.c      | 8 --------
 arch/m68k/mm/init.c       | 7 -------
 arch/microblaze/mm/init.c | 7 -------
 arch/nds32/mm/init.c      | 7 -------
 arch/nios2/mm/init.c      | 7 -------
 arch/openrisc/mm/init.c   | 7 -------
 arch/parisc/mm/init.c     | 7 -------
 arch/powerpc/mm/mem.c     | 7 -------
 arch/sh/mm/init.c         | 7 -------
 arch/um/kernel/mem.c      | 7 -------
 arch/unicore32/mm/init.c  | 7 -------
 init/initramfs.c          | 5 +++++
 15 files changed, 5 insertions(+), 100 deletions(-)

diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index a42fc5c4db89..97f4940f11e3 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -291,11 +291,3 @@ free_initmem(void)
 {
 	free_initmem_default(-1);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void
-free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index e1ab2d7f1d64..c357a3bd1532 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -214,10 +214,3 @@ void __ref free_initmem(void)
 {
 	free_initmem_default(-1);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
index af5ada0520be..5504b71254f6 100644
--- a/arch/c6x/mm/init.c
+++ b/arch/c6x/mm/init.c
@@ -67,13 +67,6 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void __init free_initmem(void)
 {
 	free_initmem_default(-1);
diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
index 6519252ac4db..2eff00de2b78 100644
--- a/arch/h8300/mm/init.c
+++ b/arch/h8300/mm/init.c
@@ -101,14 +101,6 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 }
 
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void
 free_initmem(void)
 {
diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index 933c33e76a48..c62e41563bb9 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -144,10 +144,3 @@ void __init mem_init(void)
 	init_pointer_tables();
 	mem_init_print_info(NULL);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index b17fd8aafd64..3bd32de46abb 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -186,13 +186,6 @@ void __init setup_memory(void)
 	paging_init();
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void free_initmem(void)
 {
 	free_initmem_default(-1);
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index 253f79fc7196..c02e10ac5e76 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -249,13 +249,6 @@ void free_initmem(void)
 	free_initmem_default(-1);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void __set_fixmap(enum fixed_addresses idx,
 			       phys_addr_t phys, pgprot_t flags)
 {
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index 16cea5776b87..60736a725883 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -82,13 +82,6 @@ void __init mmu_init(void)
 	flush_tlb_all();
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void __ref free_initmem(void)
 {
 	free_initmem_default(-1);
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index d157310eb377..d0d94a4391d4 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -221,13 +221,6 @@ void __init mem_init(void)
 	return;
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void free_initmem(void)
 {
 	free_initmem_default(-1);
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 059187a3ded7..1b445e206ca8 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -935,10 +935,3 @@ void flush_tlb_all(void)
 	spin_unlock(&sid_lock);
 }
 #endif
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 33cc6f676fa6..976c706a64e2 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -388,13 +388,6 @@ void free_initmem(void)
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 /*
  * This is called when a page has been modified by the kernel.
  * It just marks the page as not i-cache clean.  We do the i-cache
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index a8e5c0e00fca..2fa824336ec2 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -410,13 +410,6 @@ void free_initmem(void)
 	free_initmem_default(-1);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 #ifdef CONFIG_MEMORY_HOTPLUG
 int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 		bool want_memblock)
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 799b571a8f88..48b24b63b10d 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -172,13 +172,6 @@ void free_initmem(void)
 {
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 /* Allocate and free page tables. */
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index e3f4f791e10a..01271ce52ef9 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -316,10 +316,3 @@ void free_initmem(void)
 {
 	free_initmem_default(-1);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
diff --git a/init/initramfs.c b/init/initramfs.c
index cf8bf014873f..f3aaa58ac63d 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -527,6 +527,11 @@ extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+void __weak free_initrd_mem(unsigned long start, unsigned long end)
+{
+	free_reserved_area((void *)start, (void *)end, -1, "initrd");
+}
+
 #ifdef CONFIG_KEXEC_CORE
 static bool kexec_free_initrd(void)
 {
-- 
2.20.1
