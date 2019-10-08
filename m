From: guoren@kernel.org
Subject: [PATCH] csky: Add setup_initrd check code
Date: Tue,  8 Oct 2019 14:25:13 +0800
Message-ID: <1570515913-26251-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-csky@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, akpm@linux-foundation.org, mhocko@suse.com, rppt@linux.vnet.ibm.com, arunks@codeaurora.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

We should give some necessary check for initrd just like other
architectures and it seems that setup_initrd() could be a common
code for all architectures.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/kernel/setup.c |  3 ---
 arch/csky/mm/init.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 23ee604..a00f8a0 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -47,9 +47,6 @@ static void __init csky_memblock_init(void)
 	signed long size;
 
 	memblock_reserve(__pa(_stext), _end - _stext);
-#ifdef CONFIG_BLK_DEV_INITRD
-	memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);
-#endif
 
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index d4c2292..48f791d 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -35,6 +35,45 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 						__page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
+#ifdef CONFIG_BLK_DEV_INITRD
+static void __init setup_initrd(void)
+{
+	unsigned long size;
+
+	if (initrd_start >= initrd_end) {
+		pr_err("initrd not found or empty");
+		goto disable;
+	}
+
+	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
+		pr_err("initrd extends beyond end of memory");
+		goto disable;
+	}
+
+	size = initrd_end - initrd_start;
+
+	if (memblock_is_region_reserved(__pa(initrd_start), size)) {
+		pr_err("INITRD: 0x%08lx+0x%08lx overlaps in-use memory region",
+		       __pa(initrd_start), size);
+		goto disable;
+	}
+
+	memblock_reserve(__pa(initrd_start), size);
+
+	pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
+		(void *)(initrd_start), size);
+
+	initrd_below_start_ok = 1;
+
+	return;
+
+disable:
+	initrd_start = initrd_end = 0;
+
+	pr_err(" - disabling initrd\n");
+}
+#endif
+
 void __init mem_init(void)
 {
 #ifdef CONFIG_HIGHMEM
@@ -57,6 +96,11 @@ void __init mem_init(void)
 			free_highmem_page(page);
 	}
 #endif
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	setup_initrd();
+#endif
+
 	mem_init_print_info(NULL);
 }
 
-- 
2.7.4
