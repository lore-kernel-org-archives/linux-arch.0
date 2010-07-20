From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4/5] ARM: Use lazy cache flushing on ARMv7 SMP systems
Date: Tue, 20 Jul 2010 18:12:24 +0100
Message-ID: <20100720171224.19582.22364.stgit@e102109-lin.cambridge.arm.com>
References: <20100720171201.19582.85920.stgit@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:38947 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751046Ab0GTRMg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Jul 2010 13:12:36 -0400
In-Reply-To: <20100720171201.19582.85920.stgit@e102109-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Rabin Vincent <rabin.vincent@stericsson.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>

ARMv7 processors like Cortex-A9 broadcast the cache maintenance
operations in hardware. This patch allows the
flush_dcache_page/update_mmu_cache pair to work in lazy flushing mode
similar to the UP case.

Note that cache flushing on SMP systems now takes place via the
set_pte_at() call (__sync_icache_dcache) and there is no race with other
CPUs executing code from the new PTE before the cache flushing took
place.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/smp_plat.h |    4 ++++
 arch/arm/mm/flush.c             |   13 ++++---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index e621530..963a338 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -13,9 +13,13 @@ static inline int tlb_ops_need_broadcast(void)
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 2;
 }
 
+#if !defined(CONFIG_SMP) || __LINUX_ARM_ARCH__ >= 7
+#define cache_ops_need_broadcast()	0
+#else
 static inline int cache_ops_need_broadcast(void)
 {
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
 }
+#endif
 
 #endif
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index dd5b012..2332b77 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -17,6 +17,7 @@
 #include <asm/smp_plat.h>
 #include <asm/system.h>
 #include <asm/tlbflush.h>
+#include <asm/smp_plat.h>
 
 #include "mm.h"
 
@@ -93,12 +94,10 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 #define flush_pfn_alias(pfn,vaddr)	do { } while (0)
 #endif
 
-#ifdef CONFIG_SMP
 static void flush_ptrace_access_other(void *args)
 {
 	__flush_icache_all();
 }
-#endif
 
 static
 void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
@@ -122,11 +121,9 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 	if (vma->vm_flags & VM_EXEC) {
 		unsigned long addr = (unsigned long)kaddr;
 		__cpuc_coherent_kern_range(addr, addr + len);
-#ifdef CONFIG_SMP
 		if (cache_ops_need_broadcast())
 			smp_call_function(flush_ptrace_access_other,
 					  NULL, 1);
-#endif
 	}
 }
 
@@ -276,12 +273,10 @@ void flush_dcache_page(struct page *page)
 
 	mapping = page_mapping(page);
 
-#ifndef CONFIG_SMP
-	if (mapping && !mapping_mapped(mapping))
+	if (!cache_ops_need_broadcast() &&
+	    mapping && !mapping_mapped(mapping))
 		clear_bit(PG_dcache_clean, &page->flags);
-	else
-#endif
-	{
+	else {
 		__flush_dcache_page(mapping, page);
 		if (mapping && cache_is_vivt())
 			__flush_dcache_aliases(mapping, page);
