From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 10/12] ia64: move exports to definitions
Date: Fri, 29 Jan 2016 19:18:32 +0000
Message-ID: <1454095114-4128-10-git-send-email-viro@ZenIV.linux.org.uk>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160129191744.GB17997@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/include/asm/Kbuild      |  1 +
 arch/ia64/kernel/entry.S          |  3 ++
 arch/ia64/kernel/esi_stub.S       |  2 +
 arch/ia64/kernel/head.S           |  3 ++
 arch/ia64/kernel/ia64_ksyms.c     | 94 +--------------------------------------
 arch/ia64/kernel/ivt.S            |  2 +
 arch/ia64/kernel/pal.S            |  7 +++
 arch/ia64/kernel/setup.c          |  4 ++
 arch/ia64/lib/clear_page.S        |  2 +
 arch/ia64/lib/clear_user.S        |  2 +
 arch/ia64/lib/copy_page.S         |  2 +
 arch/ia64/lib/copy_page_mck.S     |  2 +
 arch/ia64/lib/copy_user.S         |  2 +
 arch/ia64/lib/flush.S             |  2 +
 arch/ia64/lib/idiv32.S            |  2 +
 arch/ia64/lib/idiv64.S            |  2 +
 arch/ia64/lib/ip_fast_csum.S      |  3 ++
 arch/ia64/lib/memcpy.S            |  2 +
 arch/ia64/lib/memcpy_mck.S        |  3 ++
 arch/ia64/lib/memset.S            |  2 +
 arch/ia64/lib/strlen.S            |  2 +
 arch/ia64/lib/strlen_user.S       |  2 +
 arch/ia64/lib/strncpy_from_user.S |  2 +
 arch/ia64/lib/strnlen_user.S      |  2 +
 arch/ia64/lib/xor.S               |  5 +++
 25 files changed, 63 insertions(+), 92 deletions(-)

diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 502a91d..691efe7 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -1,6 +1,7 @@
 
 generic-y += clkdev.h
 generic-y += exec.h
+generic-y += export.h
 generic-y += irq_work.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
diff --git a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
index 477c55e..46a3165f 100644
--- a/arch/ia64/kernel/entry.S
+++ b/arch/ia64/kernel/entry.S
@@ -48,6 +48,7 @@
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
 #include <asm/ftrace.h>
+#include <asm/export.h>
 
 #include "minstate.h"
 
@@ -1345,12 +1346,14 @@ GLOBAL_ENTRY(unw_init_running)
 	mov rp=loc0
 	br.ret.sptk.many rp
 END(unw_init_running)
+EXPORT_SYMBOL(unw_init_running)
 
 #ifdef CONFIG_FUNCTION_TRACER
 #ifdef CONFIG_DYNAMIC_FTRACE
 GLOBAL_ENTRY(_mcount)
 	br ftrace_stub
 END(_mcount)
+EXPORT_SYMBOL(_mcount)
 
 .here:
 	br.ret.sptk.many b0
diff --git a/arch/ia64/kernel/esi_stub.S b/arch/ia64/kernel/esi_stub.S
index 6b3d6c1f..2c369bf 100644
--- a/arch/ia64/kernel/esi_stub.S
+++ b/arch/ia64/kernel/esi_stub.S
@@ -35,6 +35,7 @@
 
 #include <asm/processor.h>
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 
 /*
  * Inputs:
@@ -94,3 +95,4 @@ GLOBAL_ENTRY(esi_call_phys)
 	mov gp=loc2
 	br.ret.sptk.many rp
 END(esi_call_phys)
+EXPORT_SYMBOL_GPL(esi_call_phys)
diff --git a/arch/ia64/kernel/head.S b/arch/ia64/kernel/head.S
index bb748c5..aabbc0a 100644
--- a/arch/ia64/kernel/head.S
+++ b/arch/ia64/kernel/head.S
@@ -32,6 +32,7 @@
 #include <asm/mca_asm.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <asm/export.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define SAL_PSR_BITS_TO_SET				\
@@ -168,6 +169,7 @@ RestRR:											\
 	__PAGE_ALIGNED_DATA
 
 	.global empty_zero_page
+EXPORT_SYMBOL_GPL(empty_zero_page)
 empty_zero_page:
 	.skip PAGE_SIZE
 
@@ -991,6 +993,7 @@ GLOBAL_ENTRY(ia64_delay_loop)
 	mov ar.lc=r2
 	br.ret.sptk.many rp
 END(ia64_delay_loop)
+EXPORT_SYMBOL(ia64_delay_loop)
 
 /*
  * Return a CPU-local timestamp in nano-seconds.  This timestamp is
diff --git a/arch/ia64/kernel/ia64_ksyms.c b/arch/ia64/kernel/ia64_ksyms.c
index 0967310..d111248 100644
--- a/arch/ia64/kernel/ia64_ksyms.c
+++ b/arch/ia64/kernel/ia64_ksyms.c
@@ -1,101 +1,11 @@
 /*
  * Architecture-specific kernel symbols
- *
- * Don't put any exports here unless it's defined in an assembler file.
- * All other exports should be put directly after the definition.
  */
 
-#include <linux/module.h>
-
-#include <linux/string.h>
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(strlen);
-
-#include <asm/pgtable.h>
-EXPORT_SYMBOL_GPL(empty_zero_page);
-
-#include <asm/checksum.h>
-EXPORT_SYMBOL(ip_fast_csum);		/* hand-coded assembly */
-EXPORT_SYMBOL(csum_ipv6_magic);
-
-#include <asm/page.h>
-EXPORT_SYMBOL(clear_page);
-EXPORT_SYMBOL(copy_page);
-
 #ifdef CONFIG_VIRTUAL_MEM_MAP
+#include <linux/compiler.h>
+#include <linux/export.h>
 #include <linux/bootmem.h>
 EXPORT_SYMBOL(min_low_pfn);	/* defined by bootmem.c, but not exported by generic code */
 EXPORT_SYMBOL(max_low_pfn);	/* defined by bootmem.c, but not exported by generic code */
 #endif
-
-#include <asm/processor.h>
-EXPORT_SYMBOL(ia64_cpu_info);
-#ifdef CONFIG_SMP
-EXPORT_SYMBOL(local_per_cpu_offset);
-#endif
-
-#include <asm/uaccess.h>
-EXPORT_SYMBOL(__copy_user);
-EXPORT_SYMBOL(__do_clear_user);
-EXPORT_SYMBOL(__strlen_user);
-EXPORT_SYMBOL(__strncpy_from_user);
-EXPORT_SYMBOL(__strnlen_user);
-
-/* from arch/ia64/lib */
-extern void __divsi3(void);
-extern void __udivsi3(void);
-extern void __modsi3(void);
-extern void __umodsi3(void);
-extern void __divdi3(void);
-extern void __udivdi3(void);
-extern void __moddi3(void);
-extern void __umoddi3(void);
-
-EXPORT_SYMBOL(__divsi3);
-EXPORT_SYMBOL(__udivsi3);
-EXPORT_SYMBOL(__modsi3);
-EXPORT_SYMBOL(__umodsi3);
-EXPORT_SYMBOL(__divdi3);
-EXPORT_SYMBOL(__udivdi3);
-EXPORT_SYMBOL(__moddi3);
-EXPORT_SYMBOL(__umoddi3);
-
-#if defined(CONFIG_MD_RAID456) || defined(CONFIG_MD_RAID456_MODULE)
-extern void xor_ia64_2(void);
-extern void xor_ia64_3(void);
-extern void xor_ia64_4(void);
-extern void xor_ia64_5(void);
-
-EXPORT_SYMBOL(xor_ia64_2);
-EXPORT_SYMBOL(xor_ia64_3);
-EXPORT_SYMBOL(xor_ia64_4);
-EXPORT_SYMBOL(xor_ia64_5);
-#endif
-
-#include <asm/pal.h>
-EXPORT_SYMBOL(ia64_pal_call_phys_stacked);
-EXPORT_SYMBOL(ia64_pal_call_phys_static);
-EXPORT_SYMBOL(ia64_pal_call_stacked);
-EXPORT_SYMBOL(ia64_pal_call_static);
-EXPORT_SYMBOL(ia64_load_scratch_fpregs);
-EXPORT_SYMBOL(ia64_save_scratch_fpregs);
-
-#include <asm/unwind.h>
-EXPORT_SYMBOL(unw_init_running);
-
-#if defined(CONFIG_IA64_ESI) || defined(CONFIG_IA64_ESI_MODULE)
-extern void esi_call_phys (void);
-EXPORT_SYMBOL_GPL(esi_call_phys);
-#endif
-extern char ia64_ivt[];
-EXPORT_SYMBOL(ia64_ivt);
-
-#include <asm/ftrace.h>
-#ifdef CONFIG_FUNCTION_TRACER
-/* mcount is defined in assembly */
-EXPORT_SYMBOL(_mcount);
-#endif
-
-#include <asm/cacheflush.h>
-EXPORT_SYMBOL_GPL(flush_icache_range);
diff --git a/arch/ia64/kernel/ivt.S b/arch/ia64/kernel/ivt.S
index b1c3cfc..9b00d0d 100644
--- a/arch/ia64/kernel/ivt.S
+++ b/arch/ia64/kernel/ivt.S
@@ -57,6 +57,7 @@
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
 #include <asm/errno.h>
+#include <asm/export.h>
 
 #if 0
 # define PSR_DEFAULT_BITS	psr.ac
@@ -85,6 +86,7 @@
 
 	.align 32768	// align on 32KB boundary
 	.global ia64_ivt
+	EXPORT_SYMBOL(ia64_ivt)
 ia64_ivt:
 /////////////////////////////////////////////////////////////////////////////////////////
 // 0x0000 Entry 0 (size 64 bundles) VHPT Translation (8,20,47)
diff --git a/arch/ia64/kernel/pal.S b/arch/ia64/kernel/pal.S
index 0b53344..94fb2e3 100644
--- a/arch/ia64/kernel/pal.S
+++ b/arch/ia64/kernel/pal.S
@@ -14,6 +14,7 @@
 
 #include <asm/asmmacro.h>
 #include <asm/processor.h>
+#include <asm/export.h>
 
 	.data
 pal_entry_point:
@@ -87,6 +88,7 @@ GLOBAL_ENTRY(ia64_pal_call_static)
 	srlz.d				// seralize restoration of psr.l
 	br.ret.sptk.many b0
 END(ia64_pal_call_static)
+EXPORT_SYMBOL(ia64_pal_call_static)
 
 /*
  * Make a PAL call using the stacked registers calling convention.
@@ -122,6 +124,7 @@ GLOBAL_ENTRY(ia64_pal_call_stacked)
 	srlz.d				// serialize restoration of psr.l
 	br.ret.sptk.many b0
 END(ia64_pal_call_stacked)
+EXPORT_SYMBOL(ia64_pal_call_stacked)
 
 /*
  * Make a physical mode PAL call using the static registers calling convention.
@@ -193,6 +196,7 @@ GLOBAL_ENTRY(ia64_pal_call_phys_static)
 	srlz.d				// seralize restoration of psr.l
 	br.ret.sptk.many b0
 END(ia64_pal_call_phys_static)
+EXPORT_SYMBOL(ia64_pal_call_phys_static)
 
 /*
  * Make a PAL call using the stacked registers in physical mode.
@@ -250,6 +254,7 @@ GLOBAL_ENTRY(ia64_pal_call_phys_stacked)
 	srlz.d				// seralize restoration of psr.l
 	br.ret.sptk.many b0
 END(ia64_pal_call_phys_stacked)
+EXPORT_SYMBOL(ia64_pal_call_phys_stacked)
 
 /*
  * Save scratch fp scratch regs which aren't saved in pt_regs already
@@ -275,6 +280,7 @@ GLOBAL_ENTRY(ia64_save_scratch_fpregs)
 	stf.spill [r2]  = f15,32
 	br.ret.sptk.many rp
 END(ia64_save_scratch_fpregs)
+EXPORT_SYMBOL(ia64_save_scratch_fpregs)
 
 /*
  * Load scratch fp scratch regs (fp10-fp15)
@@ -296,3 +302,4 @@ GLOBAL_ENTRY(ia64_load_scratch_fpregs)
 	ldf.fill  f15 = [r2],32
 	br.ret.sptk.many rp
 END(ia64_load_scratch_fpregs)
+EXPORT_SYMBOL(ia64_load_scratch_fpregs)
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 4f118b0..d81a89c 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -71,7 +71,11 @@ EXPORT_SYMBOL(__per_cpu_offset);
 #endif
 
 DEFINE_PER_CPU(struct cpuinfo_ia64, ia64_cpu_info);
+EXPORT_SYMBOL(ia64_cpu_info);
 DEFINE_PER_CPU(unsigned long, local_per_cpu_offset);
+#ifdef CONFIG_SMP
+EXPORT_SYMBOL(local_per_cpu_offset);
+#endif
 unsigned long ia64_cycles_per_usec;
 struct ia64_boot_param *ia64_boot_param;
 struct screen_info screen_info;
diff --git a/arch/ia64/lib/clear_page.S b/arch/ia64/lib/clear_page.S
index 2d814e7..3cf5b76 100644
--- a/arch/ia64/lib/clear_page.S
+++ b/arch/ia64/lib/clear_page.S
@@ -11,6 +11,7 @@
 
 #include <asm/asmmacro.h>
 #include <asm/page.h>
+#include <asm/export.h>
 
 #ifdef CONFIG_ITANIUM
 # define L3_LINE_SIZE	64	// Itanium L3 line size
@@ -74,3 +75,4 @@ GLOBAL_ENTRY(clear_page)
 	mov ar.lc = saved_lc		// restore lc
 	br.ret.sptk.many rp
 END(clear_page)
+EXPORT_SYMBOL(clear_page)
diff --git a/arch/ia64/lib/clear_user.S b/arch/ia64/lib/clear_user.S
index eecd857..7b40731 100644
--- a/arch/ia64/lib/clear_user.S
+++ b/arch/ia64/lib/clear_user.S
@@ -12,6 +12,7 @@
  */
 
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 
 //
 // arguments
@@ -207,3 +208,4 @@ GLOBAL_ENTRY(__do_clear_user)
 	mov ar.lc=saved_lc
 	br.ret.sptk.many rp
 END(__do_clear_user)
+EXPORT_SYMBOL(__do_clear_user)
diff --git a/arch/ia64/lib/copy_page.S b/arch/ia64/lib/copy_page.S
index 127d1d0..cbdb9e3 100644
--- a/arch/ia64/lib/copy_page.S
+++ b/arch/ia64/lib/copy_page.S
@@ -16,6 +16,7 @@
  */
 #include <asm/asmmacro.h>
 #include <asm/page.h>
+#include <asm/export.h>
 
 #define PIPE_DEPTH	3
 #define EPI		p[PIPE_DEPTH-1]
@@ -96,3 +97,4 @@ GLOBAL_ENTRY(copy_page)
 	mov ar.lc=saved_lc
 	br.ret.sptk.many rp
 END(copy_page)
+EXPORT_SYMBOL(copy_page)
diff --git a/arch/ia64/lib/copy_page_mck.S b/arch/ia64/lib/copy_page_mck.S
index 3c45d60a..c13f690 100644
--- a/arch/ia64/lib/copy_page_mck.S
+++ b/arch/ia64/lib/copy_page_mck.S
@@ -61,6 +61,7 @@
  */
 #include <asm/asmmacro.h>
 #include <asm/page.h>
+#include <asm/export.h>
 
 #define PREFETCH_DIST	8		// McKinley sustains 16 outstanding L2 misses (8 ld, 8 st)
 
@@ -183,3 +184,4 @@ GLOBAL_ENTRY(copy_page)
 	mov pr = saved_pr, -1
 	br.ret.sptk.many rp
 END(copy_page)
+EXPORT_SYMBOL(copy_page)
diff --git a/arch/ia64/lib/copy_user.S b/arch/ia64/lib/copy_user.S
index c952bdc..66facd5 100644
--- a/arch/ia64/lib/copy_user.S
+++ b/arch/ia64/lib/copy_user.S
@@ -30,6 +30,7 @@
  */
 
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 
 //
 // Tuneable parameters
@@ -608,3 +609,4 @@ GLOBAL_ENTRY(__copy_user)
 	mov ar.pfs=saved_pfs
 	br.ret.sptk.many rp
 END(__copy_user)
+EXPORT_SYMBOL(__copy_user)
diff --git a/arch/ia64/lib/flush.S b/arch/ia64/lib/flush.S
index 1d8c888..9a5a2f9 100644
--- a/arch/ia64/lib/flush.S
+++ b/arch/ia64/lib/flush.S
@@ -8,6 +8,7 @@
  */
 
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 
 
 	/*
@@ -60,6 +61,7 @@ GLOBAL_ENTRY(flush_icache_range)
 	mov	ar.lc=r3		// restore ar.lc
 	br.ret.sptk.many rp
 END(flush_icache_range)
+EXPORT_SYMBOL_GPL(flush_icache_range)
 
 	/*
 	 * clflush_cache_range(start,size)
diff --git a/arch/ia64/lib/idiv32.S b/arch/ia64/lib/idiv32.S
index 2ac28bf..3cc78bcb 100644
--- a/arch/ia64/lib/idiv32.S
+++ b/arch/ia64/lib/idiv32.S
@@ -15,6 +15,7 @@
  */
 
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 
 #ifdef MODULO
 # define OP	mod
@@ -81,3 +82,4 @@ GLOBAL_ENTRY(NAME)
 	getf.sig r8 = f6		// transfer result to result register
 	br.ret.sptk.many rp
 END(NAME)
+EXPORT_SYMBOL(NAME)
diff --git a/arch/ia64/lib/idiv64.S b/arch/ia64/lib/idiv64.S
index f69bd2b..b59b191 100644
--- a/arch/ia64/lib/idiv64.S
+++ b/arch/ia64/lib/idiv64.S
@@ -15,6 +15,7 @@
  */
 
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 
 #ifdef MODULO
 # define OP	mod
@@ -78,3 +79,4 @@ GLOBAL_ENTRY(NAME)
 	getf.sig r8 = f11		// transfer result to result register
 	br.ret.sptk.many rp
 END(NAME)
+EXPORT_SYMBOL(NAME)
diff --git a/arch/ia64/lib/ip_fast_csum.S b/arch/ia64/lib/ip_fast_csum.S
index 620d9dc..648e0d4 100644
--- a/arch/ia64/lib/ip_fast_csum.S
+++ b/arch/ia64/lib/ip_fast_csum.S
@@ -13,6 +13,7 @@
  */
 
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 
 /*
  * Since we know that most likely this function is called with buf aligned
@@ -92,6 +93,7 @@ GLOBAL_ENTRY(ip_fast_csum)
 	mov	b0=r34
 	br.ret.sptk.many b0
 END(ip_fast_csum)
+EXPORT_SYMBOL(ip_fast_csum)
 
 GLOBAL_ENTRY(csum_ipv6_magic)
 	ld4	r20=[in0],4
@@ -142,3 +144,4 @@ GLOBAL_ENTRY(csum_ipv6_magic)
 	andcm	r8=r9,r8
 	br.ret.sptk.many b0
 END(csum_ipv6_magic)
+EXPORT_SYMBOL(csum_ipv6_magic)
diff --git a/arch/ia64/lib/memcpy.S b/arch/ia64/lib/memcpy.S
index 448908d..ba172fd 100644
--- a/arch/ia64/lib/memcpy.S
+++ b/arch/ia64/lib/memcpy.S
@@ -14,6 +14,7 @@
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 
 GLOBAL_ENTRY(memcpy)
 
@@ -299,3 +300,4 @@ GLOBAL_ENTRY(memcpy)
 	COPY(56, 0)
 
 END(memcpy)
+EXPORT_SYMBOL(memcpy)
diff --git a/arch/ia64/lib/memcpy_mck.S b/arch/ia64/lib/memcpy_mck.S
index ab0f876..b264b6a 100644
--- a/arch/ia64/lib/memcpy_mck.S
+++ b/arch/ia64/lib/memcpy_mck.S
@@ -15,6 +15,7 @@
  */
 #include <asm/asmmacro.h>
 #include <asm/page.h>
+#include <asm/export.h>
 
 #define EK(y...) EX(y)
 
@@ -78,6 +79,7 @@ GLOBAL_ENTRY(memcpy)
 	br.cond.sptk .common_code
 	;;
 END(memcpy)
+EXPORT_SYMBOL(memcpy)
 GLOBAL_ENTRY(__copy_user)
 	.prologue
 // check dest alignment
@@ -664,3 +666,4 @@ EK(.ex_handler,  (p17)	st8	[dst1]=r39,8);						\
 
 /* end of McKinley specific optimization */
 END(__copy_user)
+EXPORT_SYMBOL(__copy_user)
diff --git a/arch/ia64/lib/memset.S b/arch/ia64/lib/memset.S
index f26c16a..87b9747 100644
--- a/arch/ia64/lib/memset.S
+++ b/arch/ia64/lib/memset.S
@@ -18,6 +18,7 @@
    to get peak speed when value = 0.  */
 
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 #undef ret
 
 #define dest		in0
@@ -360,3 +361,4 @@ GLOBAL_ENTRY(memset)
 	br.ret.sptk.many rp
 }
 END(memset)
+EXPORT_SYMBOL(memset)
diff --git a/arch/ia64/lib/strlen.S b/arch/ia64/lib/strlen.S
index e0cdac0..1a6e17c 100644
--- a/arch/ia64/lib/strlen.S
+++ b/arch/ia64/lib/strlen.S
@@ -17,6 +17,7 @@
  */
 
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 
 //
 //
@@ -190,3 +191,4 @@ GLOBAL_ENTRY(strlen)
 	mov ar.pfs=saved_pfs	// because of ar.ec, restore no matter what
 	br.ret.sptk.many rp	// end of successful recovery code
 END(strlen)
+EXPORT_SYMBOL(strlen)
diff --git a/arch/ia64/lib/strlen_user.S b/arch/ia64/lib/strlen_user.S
index c71eded..9d25768 100644
--- a/arch/ia64/lib/strlen_user.S
+++ b/arch/ia64/lib/strlen_user.S
@@ -16,6 +16,7 @@
  */
 
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 
 //
 // int strlen_user(char *)
@@ -196,3 +197,4 @@ GLOBAL_ENTRY(__strlen_user)
 	mov ar.pfs=saved_pfs	// because of ar.ec, restore no matter what
 	br.ret.sptk.many rp
 END(__strlen_user)
+EXPORT_SYMBOL(__strlen_user)
diff --git a/arch/ia64/lib/strncpy_from_user.S b/arch/ia64/lib/strncpy_from_user.S
index a504381..ca9ccf2 100644
--- a/arch/ia64/lib/strncpy_from_user.S
+++ b/arch/ia64/lib/strncpy_from_user.S
@@ -17,6 +17,7 @@
  */
 
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 
 GLOBAL_ENTRY(__strncpy_from_user)
 	alloc r2=ar.pfs,3,0,0,0
@@ -42,3 +43,4 @@ GLOBAL_ENTRY(__strncpy_from_user)
 [.Lexit:]
 	br.ret.sptk.many rp
 END(__strncpy_from_user)
+EXPORT_SYMBOL(__strncpy_from_user)
diff --git a/arch/ia64/lib/strnlen_user.S b/arch/ia64/lib/strnlen_user.S
index d09066b1..80a5dfd 100644
--- a/arch/ia64/lib/strnlen_user.S
+++ b/arch/ia64/lib/strnlen_user.S
@@ -13,6 +13,7 @@
  */
 
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 
 GLOBAL_ENTRY(__strnlen_user)
 	.prologue
@@ -43,3 +44,4 @@ GLOBAL_ENTRY(__strnlen_user)
 	mov ar.lc=r16			// restore ar.lc
 	br.ret.sptk.many rp
 END(__strnlen_user)
+EXPORT_SYMBOL(__strnlen_user)
diff --git a/arch/ia64/lib/xor.S b/arch/ia64/lib/xor.S
index 54e3f7e..c83f1c4 100644
--- a/arch/ia64/lib/xor.S
+++ b/arch/ia64/lib/xor.S
@@ -14,6 +14,7 @@
  */
 
 #include <asm/asmmacro.h>
+#include <asm/export.h>
 
 GLOBAL_ENTRY(xor_ia64_2)
 	.prologue
@@ -51,6 +52,7 @@ GLOBAL_ENTRY(xor_ia64_2)
 	mov pr = r29, -1
 	br.ret.sptk.few rp
 END(xor_ia64_2)
+EXPORT_SYMBOL(xor_ia64_2)
 
 GLOBAL_ENTRY(xor_ia64_3)
 	.prologue
@@ -91,6 +93,7 @@ GLOBAL_ENTRY(xor_ia64_3)
 	mov pr = r29, -1
 	br.ret.sptk.few rp
 END(xor_ia64_3)
+EXPORT_SYMBOL(xor_ia64_3)
 
 GLOBAL_ENTRY(xor_ia64_4)
 	.prologue
@@ -134,6 +137,7 @@ GLOBAL_ENTRY(xor_ia64_4)
 	mov pr = r29, -1
 	br.ret.sptk.few rp
 END(xor_ia64_4)
+EXPORT_SYMBOL(xor_ia64_4)
 
 GLOBAL_ENTRY(xor_ia64_5)
 	.prologue
@@ -182,3 +186,4 @@ GLOBAL_ENTRY(xor_ia64_5)
 	mov pr = r29, -1
 	br.ret.sptk.few rp
 END(xor_ia64_5)
+EXPORT_SYMBOL(xor_ia64_5)
-- 
2.1.4
