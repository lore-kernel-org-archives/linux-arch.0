From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 25/31] x86, lmb: Use lmb_memory_size()/lmb_free_memory_size() to get correct dma_reserve
Date: Sun, 28 Mar 2010 19:43:18 -0700
Message-ID: <1269830604-26214-26-git-send-email-yinghai@kernel.org>
References: <1269830604-26214-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1269830604-26214-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

lmb_memory_size() will return memory size in lmb.memory.region.
lmb_free_memory_size() will return free memory size in lmb.memory.region.

So We can get exact reseved size.

Set the size right after initmem_init(), because later bootmem API will
get area from 16M. (except some fallback).

Later after we remove the bootmem, We could call that just before paging_init().

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/include/asm/e820.h |    2 ++
 arch/x86/kernel/e820.c      |   17 +++++++++++++++++
 arch/x86/kernel/setup.c     |    1 +
 arch/x86/mm/init_64.c       |    7 -------
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/e820.h b/arch/x86/include/asm/e820.h
index de6cd06..334281f 100644
--- a/arch/x86/include/asm/e820.h
+++ b/arch/x86/include/asm/e820.h
@@ -117,6 +117,8 @@ extern u64 early_reserve_e820(u64 startt, u64 sizet, u64 align);
 
 void init_lmb_memory(void);
 void fill_lmb_memory(void);
+void find_lmb_dma_reserve(void);
+
 extern void finish_e820_parsing(void);
 extern void e820_reserve_resources(void);
 extern void e820_reserve_resources_late(void);
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 47eb188..9c4b9da 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1100,3 +1100,20 @@ void __init fill_lmb_memory(void)
 	lmb_analyze();
 	lmb_dump_all();
 }
+
+void __init find_lmb_dma_reserve(void)
+{
+#ifdef CONFIG_X86_64
+	u64 free_size_pfn;
+	u64 mem_size_pfn;
+	/*
+	 * need to find out used area below MAX_DMA_PFN
+	 * need to use lmb to get free size in [0, MAX_DMA_PFN]
+	 * at first, and assume boot_mem will not take below MAX_DMA_PFN
+	 */
+	mem_size_pfn = lmb_memory_size(0, MAX_DMA_PFN << PAGE_SHIFT) >> PAGE_SHIFT;
+	free_size_pfn = lmb_free_memory_size(0, MAX_DMA_PFN << PAGE_SHIFT) >> PAGE_SHIFT;
+	set_dma_reserve(mem_size_pfn - free_size_pfn);
+#endif
+}
+
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d43f12..b00ccc4 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -979,6 +979,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	initmem_init(0, max_pfn, acpi, k8);
+	find_lmb_dma_reserve();
 #ifndef CONFIG_NO_BOOTMEM
 	lmb_to_bootmem(0, max_low_pfn<<PAGE_SHIFT);
 #endif
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b86492e..f1af41c 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -52,8 +52,6 @@
 #include <asm/init.h>
 #include <linux/bootmem.h>
 
-static unsigned long dma_reserve __initdata;
-
 static int __init parse_direct_gbpages_off(char *arg)
 {
 	direct_gbpages = 0;
@@ -820,11 +818,6 @@ int __init reserve_bootmem_generic(unsigned long phys, unsigned long len,
 
 	reserve_bootmem(phys, len, flags);
 
-	if (phys+len <= MAX_DMA_PFN*PAGE_SIZE) {
-		dma_reserve += len / PAGE_SIZE;
-		set_dma_reserve(dma_reserve);
-	}
-
 	return 0;
 }
 #endif
-- 
1.6.4.2
