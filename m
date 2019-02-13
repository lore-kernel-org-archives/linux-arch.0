Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404576AbfBMRq4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2019 12:46:56 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 8/8] initramfs: poison freed initrd memory
Date: Wed, 13 Feb 2019 18:46:21 +0100
Message-ID: <20190213174621.29297-9-hch@lst.de>
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190213174621.ExGbDMbxIadNSuJ1RmbMLTWF0dmVyPZc4j2pU4PSR0c@z>

Various architectures including x86 poison the freed initrd memory.
Do the same in the generic free_initrd_mem implementation and switch
a few more architectures that are identical to the generic code over
to it now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/mm/init.c     | 8 --------
 arch/s390/mm/init.c     | 8 --------
 arch/sparc/mm/init_32.c | 8 --------
 arch/sparc/mm/init_64.c | 8 --------
 init/initramfs.c        | 3 ++-
 5 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index b521d8e2d359..a9a977d75838 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -492,14 +492,6 @@ void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
-			   "initrd");
-}
-#endif
-
 void (*free_init_pages_eva)(void *begin, void *end) = NULL;
 
 void __ref free_initmem(void)
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 3e82f66d5c61..25e3113091ea 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -154,14 +154,6 @@ void free_initmem(void)
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
-			   "initrd");
-}
-#endif
-
 unsigned long memory_block_size_bytes(void)
 {
 	/*
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index d900952bfc5f..f0dbc0bde70f 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -299,14 +299,6 @@ void free_initmem (void)
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
-			   "initrd");
-}
-#endif
-
 void sparc_flush_page_to_ram(struct page *page)
 {
 	unsigned long vaddr = (unsigned long)page_address(page);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index b4221d3727d0..4179f0e11fd5 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2602,14 +2602,6 @@ void free_initmem(void)
 	}
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
-			   "initrd");
-}
-#endif
-
 pgprot_t PAGE_KERNEL __read_mostly;
 EXPORT_SYMBOL(PAGE_KERNEL);
 
diff --git a/init/initramfs.c b/init/initramfs.c
index f3aaa58ac63d..4a42ff3a2bd1 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -529,7 +529,8 @@ extern unsigned long __initramfs_size;
 
 void __weak free_initrd_mem(unsigned long start, unsigned long end)
 {
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
+	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
+			"initrd");
 }
 
 #ifdef CONFIG_KEXEC_CORE
-- 
2.20.1
