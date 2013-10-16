From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 15/17] xtensa: add SMP support
Date: Thu, 17 Oct 2013 02:42:26 +0400
Message-ID: <1381963348-29448-16-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:56897 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762107Ab3JPWnJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:43:09 -0400
Received: by mail-lb0-f179.google.com with SMTP id p9so1195524lbv.38
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:43:07 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

This is largely based on SMP code from the xtensa-2.6.29-smp tree by
Piet Delaney, Marc Gauthier, Joe Taylor, Christian Zankel (and possibly
other Tensilica folks).

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig                                |  37 +-
 arch/xtensa/include/asm/barrier.h                  |   4 +-
 arch/xtensa/include/asm/bitops.h                   |   8 +-
 arch/xtensa/include/asm/cacheflush.h               |  40 +-
 arch/xtensa/include/asm/mmu.h                      |  10 +-
 arch/xtensa/include/asm/mmu_context.h              | 100 +++--
 arch/xtensa/include/asm/ptrace.h                   |   8 +
 arch/xtensa/include/asm/smp.h                      |  29 +-
 arch/xtensa/include/asm/timex.h                    |  14 +-
 arch/xtensa/include/asm/tlbflush.h                 |  42 +-
 arch/xtensa/include/asm/traps.h                    |   1 +
 arch/xtensa/kernel/Makefile                        |   1 +
 arch/xtensa/kernel/head.S                          | 130 ++++--
 arch/xtensa/kernel/irq.c                           |  15 +-
 arch/xtensa/kernel/mxhead.S                        |  85 ++++
 arch/xtensa/kernel/setup.c                         |  66 ++-
 arch/xtensa/kernel/smp.c                           | 465 +++++++++++++++++++++
 arch/xtensa/kernel/traps.c                         |  33 +-
 arch/xtensa/kernel/vmlinux.lds.S                   |  26 ++
 arch/xtensa/mm/cache.c                             |   7 +-
 arch/xtensa/mm/fault.c                             |   2 +-
 arch/xtensa/mm/mmu.c                               |   4 +-
 arch/xtensa/mm/tlb.c                               |  37 +-
 .../platforms/xtfpga/include/platform/hardware.h   |   2 +-
 24 files changed, 967 insertions(+), 199 deletions(-)
 create mode 100644 arch/xtensa/kernel/mxhead.S
 create mode 100644 arch/xtensa/kernel/smp.c

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index fb140ae..4b09c60 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -9,7 +9,6 @@ config XTENSA
 	select GENERIC_CLOCKEVENTS
 	select VIRT_TO_BUS
 	select GENERIC_IRQ_SHOW
-	select GENERIC_CPU_DEVICES
 	select GENERIC_SCHED_CLOCK
 	select MODULES_USE_ELF_RELA
 	select GENERIC_PCI_IOMAP
@@ -65,6 +64,9 @@ config MMU
 config VARIANT_IRQ_SWITCH
 	def_bool n
 
+config MAY_HAVE_SMP
+	def_bool n
+
 menu "Processor type and features"
 
 choice
@@ -105,6 +107,39 @@ config XTENSA_UNALIGNED_USER
 
 source "kernel/Kconfig.preempt"
 
+config HAVE_SMP
+	bool "System Supports SMP (MX)"
+	depends on MAY_HAVE_SMP
+	select XTENSA_MX
+	help
+	  This option is use to indicate that the system-on-a-chip (SOC)
+	  supports Multiprocessing. Multiprocessor support implemented above
+	  the CPU core definition and currently needs to be selected manually.
+
+	  Multiprocessor support in implemented with external cache and
+	  interrupt controlers.
+
+	  The MX interrupt distributer adds Interprocessor Interrupts
+	  and causes the IRQ numbers to be increased by 4 for devices
+	  like the open cores ethernet driver and the serial interface.
+
+	  You still have to select "Enable SMP" to enable SMP on this SOC.
+
+config SMP
+	bool "Enable Symmetric multi-processing support"
+	depends on HAVE_SMP
+	select USE_GENERIC_SMP_HELPERS
+	select GENERIC_SMP_IDLE_THREAD
+	help
+	  Enabled SMP Software; allows more than one CPU/CORE
+	  to be activated during startup.
+
+config NR_CPUS
+	depends on SMP
+	int "Maximum number of CPUs (2-32)"
+	range 2 32
+	default "4"
+
 config MATH_EMULATION
 	bool "Math emulation"
 	help
diff --git a/arch/xtensa/include/asm/barrier.h b/arch/xtensa/include/asm/barrier.h
index ef02167..8e5e5c9 100644
--- a/arch/xtensa/include/asm/barrier.h
+++ b/arch/xtensa/include/asm/barrier.h
@@ -17,7 +17,9 @@
 #define wmb() mb()
 
 #ifdef CONFIG_SMP
-#error smp_* not defined
+#define smp_mb()	mb()
+#define smp_rmb()	rmb()
+#define smp_wmb()	wmb()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
diff --git a/arch/xtensa/include/asm/bitops.h b/arch/xtensa/include/asm/bitops.h
index 84afe58..7b6873a 100644
--- a/arch/xtensa/include/asm/bitops.h
+++ b/arch/xtensa/include/asm/bitops.h
@@ -22,12 +22,8 @@
 #include <asm/processor.h>
 #include <asm/byteorder.h>
 
-#ifdef CONFIG_SMP
-# error SMP not supported on this architecture
-#endif
-
-#define smp_mb__before_clear_bit()	barrier()
-#define smp_mb__after_clear_bit()	barrier()
+#define smp_mb__before_clear_bit()	smp_mb()
+#define smp_mb__after_clear_bit()	smp_mb()
 
 #include <asm-generic/bitops/non-atomic.h>
 
diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/asm/cacheflush.h
index 127cd48..555a98a 100644
--- a/arch/xtensa/include/asm/cacheflush.h
+++ b/arch/xtensa/include/asm/cacheflush.h
@@ -1,18 +1,14 @@
 /*
- * include/asm-xtensa/cacheflush.h
- *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * (C) 2001 - 2007 Tensilica Inc.
+ * (C) 2001 - 2013 Tensilica Inc.
  */
 
 #ifndef _XTENSA_CACHEFLUSH_H
 #define _XTENSA_CACHEFLUSH_H
 
-#ifdef __KERNEL__
-
 #include <linux/mm.h>
 #include <asm/processor.h>
 #include <asm/page.h>
@@ -51,7 +47,6 @@ extern void __invalidate_icache_page(unsigned long);
 extern void __invalidate_icache_range(unsigned long, unsigned long);
 extern void __invalidate_dcache_range(unsigned long, unsigned long);
 
-
 #if XCHAL_DCACHE_IS_WRITEBACK
 extern void __flush_invalidate_dcache_all(void);
 extern void __flush_dcache_page(unsigned long);
@@ -87,9 +82,22 @@ static inline void __invalidate_icache_page_alias(unsigned long virt,
  * (see also Documentation/cachetlb.txt)
  */
 
-#if (DCACHE_WAY_SIZE > PAGE_SIZE)
+#if (DCACHE_WAY_SIZE > PAGE_SIZE) || defined(CONFIG_SMP)
+
+#ifdef CONFIG_SMP
+void flush_cache_all(void);
+void flush_cache_range(struct vm_area_struct*, ulong, ulong);
+void flush_icache_range(unsigned long start, unsigned long end);
+void flush_cache_page(struct vm_area_struct*,
+			     unsigned long, unsigned long);
+#else
+#define flush_cache_all local_flush_cache_all
+#define flush_cache_range local_flush_cache_range
+#define flush_icache_range local_flush_icache_range
+#define flush_cache_page  local_flush_cache_page
+#endif
 
-#define flush_cache_all()						\
+#define local_flush_cache_all()						\
 	do {								\
 		__flush_invalidate_dcache_all();			\
 		__invalidate_icache_all();				\
@@ -103,9 +111,11 @@ static inline void __invalidate_icache_page_alias(unsigned long virt,
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page*);
-extern void flush_cache_range(struct vm_area_struct*, ulong, ulong);
-extern void flush_cache_page(struct vm_area_struct*,
-			     unsigned long, unsigned long);
+
+void local_flush_cache_range(struct vm_area_struct *vma,
+		unsigned long start, unsigned long end);
+void local_flush_cache_page(struct vm_area_struct *vma,
+		unsigned long address, unsigned long pfn);
 
 #else
 
@@ -119,13 +129,14 @@ extern void flush_cache_page(struct vm_area_struct*,
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
 #define flush_dcache_page(page)				do { } while (0)
 
-#define flush_cache_page(vma,addr,pfn)			do { } while (0)
-#define flush_cache_range(vma,start,end)		do { } while (0)
+#define flush_icache_range local_flush_icache_range
+#define flush_cache_page(vma, addr, pfn)		do { } while (0)
+#define flush_cache_range(vma, start, end)		do { } while (0)
 
 #endif
 
 /* Ensure consistency between data and instruction cache. */
-#define flush_icache_range(start,end) 					\
+#define local_flush_icache_range(start, end)				\
 	do {								\
 		__flush_dcache_range(start, (end) - (start));		\
 		__invalidate_icache_range(start,(end) - (start));	\
@@ -253,5 +264,4 @@ static inline void flush_invalidate_dcache_unaligned(u32 addr, u32 size)
 	}
 }
 
-#endif /* __KERNEL__ */
 #endif /* _XTENSA_CACHEFLUSH_H */
diff --git a/arch/xtensa/include/asm/mmu.h b/arch/xtensa/include/asm/mmu.h
index 8554b2c..71afe41 100644
--- a/arch/xtensa/include/asm/mmu.h
+++ b/arch/xtensa/include/asm/mmu.h
@@ -1,11 +1,9 @@
 /*
- * include/asm-xtensa/mmu.h
- *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
+ * Copyright (C) 2001 - 2013 Tensilica Inc.
  */
 
 #ifndef _XTENSA_MMU_H
@@ -15,8 +13,10 @@
 #include <asm-generic/mmu.h>
 #else
 
-/* Default "unsigned long" context */
-typedef unsigned long mm_context_t;
+typedef struct {
+	unsigned long asid[NR_CPUS];
+	unsigned int cpu;
+} mm_context_t;
 
 #endif /* CONFIG_MMU */
 #endif	/* _XTENSA_MMU_H */
diff --git a/arch/xtensa/include/asm/mmu_context.h b/arch/xtensa/include/asm/mmu_context.h
index 86292c2..d33c71a 100644
--- a/arch/xtensa/include/asm/mmu_context.h
+++ b/arch/xtensa/include/asm/mmu_context.h
@@ -1,13 +1,11 @@
 /*
- * include/asm-xtensa/mmu_context.h
- *
  * Switch an MMU context.
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
+ * Copyright (C) 2001 - 2013 Tensilica Inc.
  */
 
 #ifndef _XTENSA_MMU_CONTEXT_H
@@ -20,22 +18,25 @@
 #include <linux/stringify.h>
 #include <linux/sched.h>
 
-#include <variant/core.h>
+#include <asm/vectors.h>
 
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm-generic/mm_hooks.h>
+#include <asm-generic/percpu.h>
 
 #if (XCHAL_HAVE_TLBS != 1)
 # error "Linux must have an MMU!"
 #endif
 
-extern unsigned long asid_cache;
+DECLARE_PER_CPU(unsigned long, asid_cache);
+#define cpu_asid_cache(cpu) per_cpu(asid_cache, cpu)
 
 /*
  * NO_CONTEXT is the invalid ASID value that we don't ever assign to
- * any user or kernel context.
+ * any user or kernel context.  We use the reserved values in the
+ * ASID_INSERT macro below.
  *
  * 0 invalid
  * 1 kernel
@@ -68,64 +69,77 @@ static inline unsigned long get_rasid_register (void)
 	return tmp;
 }
 
-static inline void
-__get_new_mmu_context(struct mm_struct *mm)
+static inline void get_new_mmu_context(struct mm_struct *mm, unsigned int cpu)
+{
+	unsigned long asid = cpu_asid_cache(cpu);
+	if ((++asid & ASID_MASK) == 0) {
+		/*
+		 * Start new asid cycle; continue counting with next
+		 * incarnation bits; skipping over 0, 1, 2, 3.
+		 */
+		local_flush_tlb_all();
+		asid += ASID_USER_FIRST;
+	}
+	cpu_asid_cache(cpu) = asid;
+	mm->context.asid[cpu] = asid;
+	mm->context.cpu = cpu;
+}
+
+static inline void get_mmu_context(struct mm_struct *mm, unsigned int cpu)
 {
-	extern void flush_tlb_all(void);
-	if (! (++asid_cache & ASID_MASK) ) {
-		flush_tlb_all(); /* start new asid cycle */
-		asid_cache += ASID_USER_FIRST;
+	/*
+	 * Check if our ASID is of an older version and thus invalid.
+	 */
+
+	if (mm) {
+		unsigned long asid = mm->context.asid[cpu];
+
+		if (asid == NO_CONTEXT ||
+				((asid ^ cpu_asid_cache(cpu)) & ~ASID_MASK))
+			get_new_mmu_context(mm, cpu);
 	}
-	mm->context = asid_cache;
 }
 
-static inline void
-__load_mmu_context(struct mm_struct *mm)
+static inline void activate_context(struct mm_struct *mm, unsigned int cpu)
 {
-	set_rasid_register(ASID_INSERT(mm->context));
+	get_mmu_context(mm, cpu);
+	set_rasid_register(ASID_INSERT(mm->context.asid[cpu]));
 	invalidate_page_directory();
 }
 
 /*
  * Initialize the context related info for a new mm_struct
- * instance.
+ * instance.  Valid cpu values are 0..(NR_CPUS-1), so initializing
+ * to -1 says the process has never run on any core.
  */
 
-static inline int
-init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+static inline int init_new_context(struct task_struct *tsk,
+		struct mm_struct *mm)
 {
-	mm->context = NO_CONTEXT;
+	int cpu;
+	for_each_possible_cpu(cpu) {
+		mm->context.asid[cpu] = NO_CONTEXT;
+	}
+	mm->context.cpu = -1;
 	return 0;
 }
 
-/*
- * After we have set current->mm to a new value, this activates
- * the context for the new mm so we see the new mappings.
- */
-static inline void
-activate_mm(struct mm_struct *prev, struct mm_struct *next)
-{
-	/* Unconditionally get a new ASID.  */
-
-	__get_new_mmu_context(next);
-	__load_mmu_context(next);
-}
-
-
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 			     struct task_struct *tsk)
 {
-	unsigned long asid = asid_cache;
-
-	/* Check if our ASID is of an older version and thus invalid */
-
-	if (next->context == NO_CONTEXT || ((next->context^asid) & ~ASID_MASK))
-		__get_new_mmu_context(next);
-
-	__load_mmu_context(next);
+	unsigned int cpu = smp_processor_id();
+	int migrated = next->context.cpu != cpu;
+	/* Flush the icache if we migrated to a new core. */
+	if (migrated) {
+		__invalidate_icache_all();
+		next->context.cpu = cpu;
+	}
+	if (migrated || prev != next)
+		activate_context(next, cpu);
 }
 
-#define deactivate_mm(tsk, mm)	do { } while(0)
+#define activate_mm(prev, next)	switch_mm((prev), (next), NULL)
+#define deactivate_mm(tsk, mm)	do { } while (0)
 
 /*
  * Destroy context related info for an mm_struct that is about
diff --git a/arch/xtensa/include/asm/ptrace.h b/arch/xtensa/include/asm/ptrace.h
index 81f31bc..598e752 100644
--- a/arch/xtensa/include/asm/ptrace.h
+++ b/arch/xtensa/include/asm/ptrace.h
@@ -59,9 +59,17 @@ struct pt_regs {
 	(task_stack_page(tsk) + KERNEL_STACK_SIZE - (XCHAL_NUM_AREGS-16)*4) - 1)
 # define user_mode(regs) (((regs)->ps & 0x00000020)!=0)
 # define instruction_pointer(regs) ((regs)->pc)
+# define return_pointer(regs) (MAKE_PC_FROM_RA((regs)->areg[0], \
+					       (regs)->areg[1]))
 
 # ifndef CONFIG_SMP
 #  define profile_pc(regs) instruction_pointer(regs)
+# else
+#  define profile_pc(regs)						\
+	({								\
+		in_lock_functions(instruction_pointer(regs)) ?		\
+		return_pointer(regs) : instruction_pointer(regs);	\
+	})
 # endif
 
 #define user_stack_pointer(regs) ((regs)->areg[1])
diff --git a/arch/xtensa/include/asm/smp.h b/arch/xtensa/include/asm/smp.h
index 83c569e..30ac58c 100644
--- a/arch/xtensa/include/asm/smp.h
+++ b/arch/xtensa/include/asm/smp.h
@@ -1,27 +1,34 @@
 /*
- * include/asm-xtensa/smp.h
- *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
+ * Copyright (C) 2001 - 2013 Tensilica Inc.
  */
 
 #ifndef _XTENSA_SMP_H
 #define _XTENSA_SMP_H
 
-extern struct xtensa_cpuinfo boot_cpu_data;
+#ifdef CONFIG_SMP
 
-#define cpu_data (&boot_cpu_data)
-#define current_cpu_data boot_cpu_data
+#define raw_smp_processor_id()	(current_thread_info()->cpu)
+#define cpu_logical_map(cpu)	(cpu)
 
-struct xtensa_cpuinfo {
-	unsigned long	*pgd_cache;
-	unsigned long	*pte_cache;
-	unsigned long	pgtable_cache_sz;
+struct start_info {
+	unsigned long stack;
 };
+extern struct start_info start_info;
 
-#define cpu_logical_map(cpu)	(cpu)
+struct cpumask;
+void arch_send_call_function_ipi_mask(const struct cpumask *mask);
+void arch_send_call_function_single_ipi(int cpu);
+
+void smp_init_cpus(void);
+void secondary_init_irq(void);
+void ipi_init(void);
+struct seq_file;
+void show_ipi_list(struct seq_file *p, int prec);
+
+#endif /* CONFIG_SMP */
 
 #endif	/* _XTENSA_SMP_H */
diff --git a/arch/xtensa/include/asm/timex.h b/arch/xtensa/include/asm/timex.h
index 27fa3c1..ca929e6 100644
--- a/arch/xtensa/include/asm/timex.h
+++ b/arch/xtensa/include/asm/timex.h
@@ -1,18 +1,14 @@
 /*
- * include/asm-xtensa/timex.h
- *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2001 - 2008 Tensilica Inc.
+ * Copyright (C) 2001 - 2013 Tensilica Inc.
  */
 
 #ifndef _XTENSA_TIMEX_H
 #define _XTENSA_TIMEX_H
 
-#ifdef __KERNEL__
-
 #include <asm/processor.h>
 #include <linux/stringify.h>
 
@@ -39,14 +35,9 @@ extern unsigned long ccount_freq;
 
 typedef unsigned long long cycles_t;
 
-/*
- * Only used for SMP.
- */
-
-extern cycles_t cacheflush_time;
-
 #define get_cycles()	(0)
 
+void local_timer_setup(unsigned cpu);
 
 /*
  * Register access.
@@ -81,5 +72,4 @@ static inline void set_linux_timer (unsigned long ccompare)
 	WSR_CCOMPARE(LINUX_TIMER, ccompare);
 }
 
-#endif	/* __KERNEL__ */
 #endif	/* _XTENSA_TIMEX_H */
diff --git a/arch/xtensa/include/asm/tlbflush.h b/arch/xtensa/include/asm/tlbflush.h
index 43dd348..fc34274 100644
--- a/arch/xtensa/include/asm/tlbflush.h
+++ b/arch/xtensa/include/asm/tlbflush.h
@@ -1,18 +1,14 @@
 /*
- * include/asm-xtensa/tlbflush.h
- *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
+ * Copyright (C) 2001 - 2013 Tensilica Inc.
  */
 
 #ifndef _XTENSA_TLBFLUSH_H
 #define _XTENSA_TLBFLUSH_H
 
-#ifdef __KERNEL__
-
 #include <linux/stringify.h>
 #include <asm/processor.h>
 
@@ -34,12 +30,37 @@
  *  - flush_tlb_range(mm, start, end) flushes a range of pages
  */
 
-extern void flush_tlb_all(void);
-extern void flush_tlb_mm(struct mm_struct*);
-extern void flush_tlb_page(struct vm_area_struct*,unsigned long);
-extern void flush_tlb_range(struct vm_area_struct*,unsigned long,unsigned long);
+void local_flush_tlb_all(void);
+void local_flush_tlb_mm(struct mm_struct *mm);
+void local_flush_tlb_page(struct vm_area_struct *vma,
+		unsigned long page);
+void local_flush_tlb_range(struct vm_area_struct *vma,
+		unsigned long start, unsigned long end);
+
+#ifdef CONFIG_SMP
+
+void flush_tlb_all(void);
+void flush_tlb_mm(struct mm_struct *);
+void flush_tlb_page(struct vm_area_struct *, unsigned long);
+void flush_tlb_range(struct vm_area_struct *, unsigned long,
+		unsigned long);
+
+static inline void flush_tlb_kernel_range(unsigned long start,
+		unsigned long end)
+{
+	flush_tlb_all();
+}
+
+#else /* !CONFIG_SMP */
+
+#define flush_tlb_all()			   local_flush_tlb_all()
+#define flush_tlb_mm(mm)		   local_flush_tlb_mm(mm)
+#define flush_tlb_page(vma, page)	   local_flush_tlb_page(vma, page)
+#define flush_tlb_range(vma, vmaddr, end)  local_flush_tlb_range(vma, vmaddr, \
+								 end)
+#define flush_tlb_kernel_range(start, end) local_flush_tlb_all()
 
-#define flush_tlb_kernel_range(start,end) flush_tlb_all()
+#endif /* CONFIG_SMP */
 
 /* TLB operations. */
 
@@ -187,5 +208,4 @@ static inline unsigned long read_itlb_translation (int way)
 }
 
 #endif	/* __ASSEMBLY__ */
-#endif	/* __KERNEL__ */
 #endif	/* _XTENSA_TLBFLUSH_H */
diff --git a/arch/xtensa/include/asm/traps.h b/arch/xtensa/include/asm/traps.h
index 917488a..8c194f6 100644
--- a/arch/xtensa/include/asm/traps.h
+++ b/arch/xtensa/include/asm/traps.h
@@ -19,6 +19,7 @@
  */
 extern void * __init trap_set_handler(int cause, void *handler);
 extern void do_unhandled(struct pt_regs *regs, unsigned long exccause);
+void secondary_trap_init(void);
 
 static inline void spill_registers(void)
 {
diff --git a/arch/xtensa/kernel/Makefile b/arch/xtensa/kernel/Makefile
index f90265e..18d962a 100644
--- a/arch/xtensa/kernel/Makefile
+++ b/arch/xtensa/kernel/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_KGDB) += xtensa-stub.o
 obj-$(CONFIG_PCI) += pci.o
 obj-$(CONFIG_MODULES) += xtensa_ksyms.o module.o
 obj-$(CONFIG_FUNCTION_TRACER) += mcount.o
+obj-$(CONFIG_SMP) += smp.o mxhead.o
 
 AFLAGS_head.o += -mtext-section-literals
 
diff --git a/arch/xtensa/kernel/head.S b/arch/xtensa/kernel/head.S
index 7d740eb..74ec62c 100644
--- a/arch/xtensa/kernel/head.S
+++ b/arch/xtensa/kernel/head.S
@@ -19,6 +19,7 @@
 #include <asm/page.h>
 #include <asm/cacheasm.h>
 #include <asm/initialize_mmu.h>
+#include <asm/mxregs.h>
 
 #include <linux/init.h>
 #include <linux/linkage.h>
@@ -54,7 +55,7 @@ ENTRY(_start)
 
 	/* Preserve the pointer to the boot parameter list in EXCSAVE_1 */
 	wsr     a2, excsave1
-	_j	_SetupMMU
+	_j	_SetupOCD
 
 	.align	4
 	.literal_position
@@ -62,6 +63,23 @@ ENTRY(_start)
 	.word	_startup
 
 	.align	4
+_SetupOCD:
+	/*
+	 * Initialize WB, WS, and clear PS.EXCM (to allow loop instructions).
+	 * Set Interrupt Level just below XCHAL_DEBUGLEVEL to allow
+	 * xt-gdb to single step via DEBUG exceptions received directly
+	 * by ocd.
+	 */
+	movi	a1, 1
+	movi	a0, 0
+	wsr	a1, windowstart
+	wsr	a0, windowbase
+	rsync
+
+	movi	a1, LOCKLEVEL
+	wsr	a1, ps
+	rsync
+
 	.global _SetupMMU
 _SetupMMU:
 	Offset = _SetupMMU - _start
@@ -90,19 +108,6 @@ ENDPROC(_start)
 
 ENTRY(_startup)
 
-	/* Disable interrupts and exceptions. */
-
-	movi	a0, LOCKLEVEL
-	wsr	a0, ps
-
-	/* Start with a fresh windowbase and windowstart.  */
-
-	movi	a1, 1
-	movi	a0, 0
-	wsr	a1, windowstart
-	wsr	a0, windowbase
-	rsync
-
 	/* Set a0 to 0 for the remaining initialization. */
 
 	movi	a0, 0
@@ -154,17 +159,6 @@ ENTRY(_startup)
 	wsr	a0, cpenable
 #endif
 
-	/* Set PS.INTLEVEL=LOCKLEVEL, PS.WOE=0, kernel stack, PS.EXCM=0
-	 *
-	 * Note: PS.EXCM must be cleared before using any loop
-	 *	 instructions; otherwise, they are silently disabled, and
-	 * 	 at most one iteration of the loop is executed.
-	 */
-
-	movi	a1, LOCKLEVEL
-	wsr	a1, ps
-	rsync
-
 	/*  Initialize the caches.
 	 *  a2, a3 are just working registers (clobbered).
 	 */
@@ -182,6 +176,37 @@ ENTRY(_startup)
 
 	isync
 
+#ifdef CONFIG_HAVE_SMP
+	movi	a2, CCON	# MX External Register to Configure Cache
+	movi	a3, 1
+	wer	a3, a2
+#endif
+
+	/* Setup stack and enable window exceptions (keep irqs disabled) */
+
+	movi	a1, start_info
+	l32i	a1, a1, 0
+
+	movi	a2, (1 << PS_WOE_BIT) | LOCKLEVEL
+					# WOE=1, INTLEVEL=LOCKLEVEL, UM=0
+	wsr	a2, ps			# (enable reg-windows; progmode stack)
+	rsync
+
+	/* Set up EXCSAVE[DEBUGLEVEL] to point to the Debug Exception Handler.*/
+
+	movi	a2, debug_exception
+	wsr	a2, SREG_EXCSAVE + XCHAL_DEBUGLEVEL
+
+#ifdef CONFIG_SMP
+	/*
+	 * Notice that we assume with SMP that cores have PRID
+	 * supported by the cores.
+	 */
+	rsr	a2, prid
+	bnez	a2, .Lboot_secondary
+
+#endif  /* CONFIG_SMP */
+
 	/* Unpack data sections
 	 *
 	 * The linker script used to build the Linux kernel image
@@ -234,24 +259,7 @@ ENTRY(_startup)
 	___invalidate_icache_all a2 a3
 	isync
 
-	/* Setup stack and enable window exceptions (keep irqs disabled) */
-
-	movi	a1, init_thread_union
-	addi	a1, a1, KERNEL_STACK_SIZE
-
-	movi	a2, (1 << PS_WOE_BIT) | LOCKLEVEL
-					# WOE=1, INTLEVEL=LOCKLEVEL, UM=0
-	wsr	a2, ps			# (enable reg-windows; progmode stack)
-	rsync
-
-	/* Set up EXCSAVE[DEBUGLEVEL] to point to the Debug Exception Handler.*/
-
-	movi	a2, debug_exception
-	wsr	a2, SREG_EXCSAVE + XCHAL_DEBUGLEVEL
-
-	/* Set up EXCSAVE[1] to point to the exc_table. */
-
-	movi	a6, exc_table
+	movi	a6, 0
 	xsr	a6, excsave1
 
 	/* init_arch kick-starts the linux kernel */
@@ -265,9 +273,45 @@ ENTRY(_startup)
 should_never_return:
 	j	should_never_return
 
+#ifdef CONFIG_SMP
+.Lboot_secondary:
+
+	movi	a2, cpu_start_ccount
+1:
+	l32i	a3, a2, 0
+	beqi	a3, 0, 1b
+	movi	a3, 0
+	s32i	a3, a2, 0
+	memw
+1:
+	l32i	a3, a2, 0
+	beqi	a3, 0, 1b
+	wsr	a3, ccount
+	movi	a3, 0
+	s32i	a3, a2, 0
+	memw
+
+	movi	a6, 0
+	wsr	a6, excsave1
+
+	movi	a4, secondary_start_kernel
+	callx4	a4
+	j	should_never_return
+
+#endif  /* CONFIG_SMP */
+
 ENDPROC(_startup)
 
 /*
+ * DATA section
+ */
+
+        .section ".data.init.refok"
+        .align  4
+ENTRY(start_info)
+        .long   init_thread_union + KERNEL_STACK_SIZE
+
+/*
  * BSS section
  */
 	
diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index 7d49730..fad9e00 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -4,7 +4,7 @@
  * Xtensa built-in interrupt controller and some generic functions copied
  * from i386.
  *
- * Copyright (C) 2002 - 2006 Tensilica, Inc.
+ * Copyright (C) 2002 - 2013 Tensilica, Inc.
  * Copyright (C) 1992, 1998 Linus Torvalds, Ingo Molnar
  *
  *
@@ -19,10 +19,12 @@
 #include <linux/irq.h>
 #include <linux/kernel_stat.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/xtensa-mx.h>
 #include <linux/irqchip/xtensa-pic.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 
+#include <asm/mxregs.h>
 #include <asm/uaccess.h>
 #include <asm/platform.h>
 
@@ -55,6 +57,9 @@ asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
 
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
+#ifdef CONFIG_SMP
+	show_ipi_list(p, prec);
+#endif
 	seq_printf(p, "%*s: ", prec, "ERR");
 	seq_printf(p, "%10u\n", atomic_read(&irq_err_count));
 	return 0;
@@ -136,7 +141,15 @@ void __init init_IRQ(void)
 #ifdef CONFIG_OF
 	irqchip_init();
 #else
+#ifdef CONFIG_HAVE_SMP
+	xtensa_mx_init_legacy(NULL);
+#else
 	xtensa_pic_init_legacy(NULL);
 #endif
+#endif
+
+#ifdef CONFIG_SMP
+	ipi_init();
+#endif
 	variant_init_irq();
 }
diff --git a/arch/xtensa/kernel/mxhead.S b/arch/xtensa/kernel/mxhead.S
new file mode 100644
index 0000000..77a161a
--- /dev/null
+++ b/arch/xtensa/kernel/mxhead.S
@@ -0,0 +1,85 @@
+/*
+ * Xtensa Secondary Processors startup code.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2001 - 2013 Tensilica Inc.
+ *
+ * Joe Taylor <joe@tensilica.com>
+ * Chris Zankel <chris@zankel.net>
+ * Marc Gauthier <marc@tensilica.com, marc@alumni.uwaterloo.ca>
+ * Pete Delaney <piet@tensilica.com>
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/cacheasm.h>
+#include <asm/initialize_mmu.h>
+#include <asm/mxregs.h>
+#include <asm/regs.h>
+
+
+	.section .SecondaryResetVector.text, "ax"
+
+
+ENTRY(_SecondaryResetVector)
+	_j _SetupOCD
+
+	.begin  no-absolute-literals
+	.literal_position
+
+_SetupOCD:
+	/*
+	 * Initialize WB, WS, and clear PS.EXCM (to allow loop instructions).
+	 * Set Interrupt Level just below XCHAL_DEBUGLEVEL to allow
+	 * xt-gdb to single step via DEBUG exceptions received directly
+	 * by ocd.
+	 */
+	movi	a1, 1
+	movi	a0, 0
+	wsr	a1, windowstart
+	wsr	a0, windowbase
+	rsync
+
+	movi	a1, LOCKLEVEL
+	wsr	a1, ps
+	rsync
+
+_SetupMMU:
+	Offset = _SetupMMU - _SecondaryResetVector
+
+#ifdef CONFIG_INITIALIZE_XTENSA_MMU_INSIDE_VMLINUX
+	initialize_mmu
+#endif
+
+	/*
+	 * Start Secondary Processors with NULL pointer to boot params.
+	 */
+	movi	a2, 0				#  a2 == NULL
+	movi	a3, _startup
+	jx	a3
+
+	.end    no-absolute-literals
+
+
+	.section 	.SecondaryResetVector.remapped_text, "ax"
+	.global         _RemappedSecondaryResetVector
+
+	.org 0                                  # Need to do org before literals
+
+_RemappedSecondaryResetVector:
+	.begin  no-absolute-literals
+	.literal_position
+
+	_j      _RemappedSetupMMU
+	. = _RemappedSecondaryResetVector + Offset
+
+_RemappedSetupMMU:
+
+#ifdef CONFIG_INITIALIZE_XTENSA_MMU_INSIDE_VMLINUX
+	initialize_mmu
+#endif
+
+	.end    no-absolute-literals
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 84b26ee..1f6e377 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -21,6 +21,8 @@
 #include <linux/screen_info.h>
 #include <linux/bootmem.h>
 #include <linux/kernel.h>
+#include <linux/percpu.h>
+#include <linux/cpu.h>
 
 #ifdef CONFIG_OF
 #include <linux/of_fdt.h>
@@ -49,6 +51,7 @@
 #include <asm/setup.h>
 #include <asm/param.h>
 #include <asm/traps.h>
+#include <asm/smp.h>
 
 #include <platform/hardware.h>
 
@@ -523,6 +526,10 @@ void __init setup_arch(char **cmdline_p)
 
 	platform_setup(cmdline_p);
 
+#ifdef CONFIG_SMP
+	smp_init_cpus();
+#endif
+
 	paging_init();
 	zones_init();
 
@@ -539,6 +546,21 @@ void __init setup_arch(char **cmdline_p)
 #endif
 }
 
+static DEFINE_PER_CPU(struct cpu, cpu_data);
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		struct cpu *cpu = &per_cpu(cpu_data, i);
+		register_cpu(cpu, i);
+	}
+
+	return 0;
+}
+subsys_initcall(topology_init);
+
 void machine_restart(char * cmd)
 {
 	platform_restart();
@@ -564,21 +586,27 @@ void machine_power_off(void)
 static int
 c_show(struct seq_file *f, void *slot)
 {
+	char buf[NR_CPUS * 5];
+
+	cpulist_scnprintf(buf, sizeof(buf), cpu_online_mask);
 	/* high-level stuff */
-	seq_printf(f,"processor\t: 0\n"
-		     "vendor_id\t: Tensilica\n"
-		     "model\t\t: Xtensa " XCHAL_HW_VERSION_NAME "\n"
-		     "core ID\t\t: " XCHAL_CORE_ID "\n"
-		     "build ID\t: 0x%x\n"
-		     "byte order\t: %s\n"
-		     "cpu MHz\t\t: %lu.%02lu\n"
-		     "bogomips\t: %lu.%02lu\n",
-		     XCHAL_BUILD_UNIQUE_ID,
-		     XCHAL_HAVE_BE ?  "big" : "little",
-		     ccount_freq/1000000,
-		     (ccount_freq/10000) % 100,
-		     loops_per_jiffy/(500000/HZ),
-		     (loops_per_jiffy/(5000/HZ)) % 100);
+	seq_printf(f, "CPU count\t: %u\n"
+		      "CPU list\t: %s\n"
+		      "vendor_id\t: Tensilica\n"
+		      "model\t\t: Xtensa " XCHAL_HW_VERSION_NAME "\n"
+		      "core ID\t\t: " XCHAL_CORE_ID "\n"
+		      "build ID\t: 0x%x\n"
+		      "byte order\t: %s\n"
+		      "cpu MHz\t\t: %lu.%02lu\n"
+		      "bogomips\t: %lu.%02lu\n",
+		      num_online_cpus(),
+		      buf,
+		      XCHAL_BUILD_UNIQUE_ID,
+		      XCHAL_HAVE_BE ?  "big" : "little",
+		      ccount_freq/1000000,
+		      (ccount_freq/10000) % 100,
+		      loops_per_jiffy/(500000/HZ),
+		      (loops_per_jiffy/(5000/HZ)) % 100);
 
 	seq_printf(f,"flags\t\t: "
 #if XCHAL_HAVE_NMI
@@ -690,7 +718,7 @@ c_show(struct seq_file *f, void *slot)
 static void *
 c_start(struct seq_file *f, loff_t *pos)
 {
-	return (void *) ((*pos == 0) ? (void *)1 : NULL);
+	return (*pos == 0) ? (void *)1 : NULL;
 }
 
 static void *
@@ -706,10 +734,10 @@ c_stop(struct seq_file *f, void *v)
 
 const struct seq_operations cpuinfo_op =
 {
-	start:  c_start,
-	next:   c_next,
-	stop:   c_stop,
-	show:   c_show
+	.start	= c_start,
+	.next	= c_next,
+	.stop	= c_stop,
+	.show	= c_show,
 };
 
 #endif /* CONFIG_PROC_FS */
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
new file mode 100644
index 0000000..46bdd14
--- /dev/null
+++ b/arch/xtensa/kernel/smp.c
@@ -0,0 +1,465 @@
+/*
+ * Xtensa SMP support functions.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 - 2013 Tensilica Inc.
+ *
+ * Chris Zankel <chris@zankel.net>
+ * Joe Taylor <joe@tensilica.com>
+ * Pete Delaney <piet@tensilica.com
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <linux/kdebug.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/seq_file.h>
+#include <linux/smp.h>
+#include <linux/thread_info.h>
+
+#include <asm/cacheflush.h>
+#include <asm/kdebug.h>
+#include <asm/mmu_context.h>
+#include <asm/mxregs.h>
+#include <asm/platform.h>
+#include <asm/tlbflush.h>
+#include <asm/traps.h>
+
+#ifdef CONFIG_SMP
+# if XCHAL_HAVE_S32C1I == 0
+#  error "The S32C1I option is required for SMP."
+# endif
+#endif
+
+/* IPI (Inter Process Interrupt) */
+
+#define IPI_IRQ	0
+
+static irqreturn_t ipi_interrupt(int irq, void *dev_id);
+static struct irqaction ipi_irqaction = {
+	.handler =	ipi_interrupt,
+	.flags =	IRQF_PERCPU,
+	.name =		"ipi",
+};
+
+void ipi_init(void)
+{
+	unsigned irq = irq_create_mapping(NULL, IPI_IRQ);
+	setup_irq(irq, &ipi_irqaction);
+}
+
+static inline unsigned int get_core_count(void)
+{
+	/* Bits 18..21 of SYSCFGID contain the core count minus 1. */
+	unsigned int syscfgid = get_er(SYSCFGID);
+	return ((syscfgid >> 18) & 0xf) + 1;
+}
+
+static inline int get_core_id(void)
+{
+	/* Bits 0...18 of SYSCFGID contain the core id  */
+	unsigned int core_id = get_er(SYSCFGID);
+	return core_id & 0x3fff;
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	unsigned i;
+
+	for (i = 0; i < max_cpus; ++i)
+		set_cpu_present(i, true);
+}
+
+void __init smp_init_cpus(void)
+{
+	unsigned i;
+	unsigned int ncpus = get_core_count();
+	unsigned int core_id = get_core_id();
+
+	pr_info("%s: Core Count = %d\n", __func__, ncpus);
+	pr_info("%s: Core Id = %d\n", __func__, core_id);
+
+	for (i = 0; i < ncpus; ++i)
+		set_cpu_possible(i, true);
+}
+
+void __init smp_prepare_boot_cpu(void)
+{
+	unsigned int cpu = smp_processor_id();
+	BUG_ON(cpu != 0);
+	cpu_asid_cache(cpu) = ASID_USER_FIRST;
+}
+
+void __init smp_cpus_done(unsigned int max_cpus)
+{
+}
+
+static int boot_secondary_processors = 1; /* Set with xt-gdb via .xt-gdb */
+static DECLARE_COMPLETION(cpu_running);
+
+void __init secondary_start_kernel(void)
+{
+	struct mm_struct *mm = &init_mm;
+	unsigned int cpu = smp_processor_id();
+
+	init_mmu();
+
+#ifdef CONFIG_DEBUG_KERNEL
+	if (boot_secondary_processors == 0) {
+		pr_debug("%s: boot_secondary_processors:%d; Hanging cpu:%d\n",
+			__func__, boot_secondary_processors, cpu);
+		for (;;)
+			__asm__ __volatile__ ("waiti " __stringify(LOCKLEVEL));
+	}
+
+	pr_debug("%s: boot_secondary_processors:%d; Booting cpu:%d\n",
+		__func__, boot_secondary_processors, cpu);
+#endif
+	/* Init EXCSAVE1 */
+
+	secondary_trap_init();
+
+	/* All kernel threads share the same mm context. */
+
+	atomic_inc(&mm->mm_users);
+	atomic_inc(&mm->mm_count);
+	current->active_mm = mm;
+	cpumask_set_cpu(cpu, mm_cpumask(mm));
+	enter_lazy_tlb(mm, current);
+
+	preempt_disable();
+	trace_hardirqs_off();
+
+	calibrate_delay();
+
+	notify_cpu_starting(cpu);
+
+	secondary_init_irq();
+	local_timer_setup(cpu);
+
+	local_irq_enable();
+
+	set_cpu_online(cpu, true);
+	complete(&cpu_running);
+
+	cpu_startup_entry(CPUHP_ONLINE);
+}
+
+static void mx_cpu_start(void *p)
+{
+	unsigned cpu = (unsigned)p;
+	unsigned long run_stall_mask = get_er(MPSCORE);
+
+	set_er(run_stall_mask & ~(1u << cpu), MPSCORE);
+	pr_debug("%s: cpu: %d, run_stall_mask: %lx ---> %lx\n",
+			__func__, cpu, run_stall_mask, get_er(MPSCORE));
+}
+
+static void mx_cpu_stop(void *p)
+{
+	unsigned cpu = (unsigned)p;
+	unsigned long run_stall_mask = get_er(MPSCORE);
+
+	set_er(run_stall_mask | (1u << cpu), MPSCORE);
+	pr_debug("%s: cpu: %d, run_stall_mask: %lx ---> %lx\n",
+			__func__, cpu, run_stall_mask, get_er(MPSCORE));
+}
+
+unsigned long cpu_start_ccount;
+
+static int boot_secondary(unsigned int cpu, struct task_struct *ts)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+	unsigned long ccount;
+	int i;
+
+	smp_call_function_single(0, mx_cpu_start, (void *)cpu, 1);
+
+	for (i = 0; i < 2; ++i) {
+		do
+			ccount = get_ccount();
+		while (!ccount);
+
+		cpu_start_ccount = ccount;
+
+		while (time_before(jiffies, timeout)) {
+			mb();
+			if (!cpu_start_ccount)
+				break;
+		}
+
+		if (cpu_start_ccount) {
+			smp_call_function_single(0, mx_cpu_stop,
+					(void *)cpu, 1);
+			cpu_start_ccount = 0;
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+int __cpu_up(unsigned int cpu, struct task_struct *idle)
+{
+	int ret = 0;
+
+	if (cpu_asid_cache(cpu) == 0)
+		cpu_asid_cache(cpu) = ASID_USER_FIRST;
+
+	start_info.stack = (unsigned long)task_pt_regs(idle);
+	wmb();
+
+	pr_debug("%s: Calling wakeup_secondary(cpu:%d, idle:%p, sp: %08lx)\n",
+			__func__, cpu, idle, start_info.stack);
+
+	ret = boot_secondary(cpu, idle);
+	if (ret == 0) {
+		wait_for_completion_timeout(&cpu_running,
+				msecs_to_jiffies(1000));
+		if (!cpu_online(cpu))
+			ret = -EIO;
+	}
+
+	if (ret)
+		pr_err("CPU %u failed to boot\n", cpu);
+
+	return ret;
+}
+
+enum ipi_msg_type {
+	IPI_RESCHEDULE = 0,
+	IPI_CALL_FUNC,
+	IPI_CPU_STOP,
+	IPI_MAX
+};
+
+static const struct {
+	const char *short_text;
+	const char *long_text;
+} ipi_text[] = {
+	{ .short_text = "RES", .long_text = "Rescheduling interrupts" },
+	{ .short_text = "CAL", .long_text = "Function call interrupts" },
+	{ .short_text = "DIE", .long_text = "CPU shutdown interrupts" },
+};
+
+struct ipi_data {
+	unsigned long ipi_count[IPI_MAX];
+};
+
+static DEFINE_PER_CPU(struct ipi_data, ipi_data);
+
+static void send_ipi_message(const struct cpumask *callmask,
+		enum ipi_msg_type msg_id)
+{
+	int index;
+	unsigned long mask = 0;
+
+	for_each_cpu(index, callmask)
+		if (index != smp_processor_id())
+			mask |= 1 << index;
+
+	set_er(mask, MIPISET(msg_id));
+}
+
+void arch_send_call_function_ipi_mask(const struct cpumask *mask)
+{
+	send_ipi_message(mask, IPI_CALL_FUNC);
+}
+
+void arch_send_call_function_single_ipi(int cpu)
+{
+	send_ipi_message(cpumask_of(cpu), IPI_CALL_FUNC);
+}
+
+void smp_send_reschedule(int cpu)
+{
+	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
+}
+
+void smp_send_stop(void)
+{
+	struct cpumask targets;
+
+	cpumask_copy(&targets, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), &targets);
+	send_ipi_message(&targets, IPI_CPU_STOP);
+}
+
+static void ipi_cpu_stop(unsigned int cpu)
+{
+	set_cpu_online(cpu, false);
+	machine_halt();
+}
+
+irqreturn_t ipi_interrupt(int irq, void *dev_id)
+{
+	unsigned int cpu = smp_processor_id();
+	struct ipi_data *ipi = &per_cpu(ipi_data, cpu);
+	unsigned int msg;
+	unsigned i;
+
+	msg = get_er(MIPICAUSE(cpu));
+	for (i = 0; i < IPI_MAX; i++)
+		if (msg & (1 << i)) {
+			set_er(1 << i, MIPICAUSE(cpu));
+			++ipi->ipi_count[i];
+		}
+
+	if (msg & (1 << IPI_RESCHEDULE))
+		scheduler_ipi();
+	if (msg & (1 << IPI_CALL_FUNC))
+		generic_smp_call_function_interrupt();
+	if (msg & (1 << IPI_CPU_STOP))
+		ipi_cpu_stop(cpu);
+
+	return IRQ_HANDLED;
+}
+
+void show_ipi_list(struct seq_file *p, int prec)
+{
+	unsigned int cpu;
+	unsigned i;
+
+	for (i = 0; i < IPI_MAX; ++i) {
+		seq_printf(p, "%*s:", prec, ipi_text[i].short_text);
+		for_each_online_cpu(cpu)
+			seq_printf(p, " %10lu",
+					per_cpu(ipi_data, cpu).ipi_count[i]);
+		seq_printf(p, "   %s\n", ipi_text[i].long_text);
+	}
+}
+
+int setup_profiling_timer(unsigned int multiplier)
+{
+	pr_debug("setup_profiling_timer %d\n", multiplier);
+	return 0;
+}
+
+/* TLB flush functions */
+
+struct flush_data {
+	struct vm_area_struct *vma;
+	unsigned long addr1;
+	unsigned long addr2;
+};
+
+static void ipi_flush_tlb_all(void *arg)
+{
+	local_flush_tlb_all();
+}
+
+void flush_tlb_all(void)
+{
+	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+}
+
+static void ipi_flush_tlb_mm(void *arg)
+{
+	local_flush_tlb_mm(arg);
+}
+
+void flush_tlb_mm(struct mm_struct *mm)
+{
+	on_each_cpu(ipi_flush_tlb_mm, mm, 1);
+}
+
+static void ipi_flush_tlb_page(void *arg)
+{
+	struct flush_data *fd = arg;
+	local_flush_tlb_page(fd->vma, fd->addr1);
+}
+
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct flush_data fd = {
+		.vma = vma,
+		.addr1 = addr,
+	};
+	on_each_cpu(ipi_flush_tlb_page, &fd, 1);
+}
+
+static void ipi_flush_tlb_range(void *arg)
+{
+	struct flush_data *fd = arg;
+	local_flush_tlb_range(fd->vma, fd->addr1, fd->addr2);
+}
+
+void flush_tlb_range(struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end)
+{
+	struct flush_data fd = {
+		.vma = vma,
+		.addr1 = start,
+		.addr2 = end,
+	};
+	on_each_cpu(ipi_flush_tlb_range, &fd, 1);
+}
+
+/* Cache flush functions */
+
+static void ipi_flush_cache_all(void *arg)
+{
+	local_flush_cache_all();
+}
+
+void flush_cache_all(void)
+{
+	on_each_cpu(ipi_flush_cache_all, NULL, 1);
+}
+
+static void ipi_flush_cache_page(void *arg)
+{
+	struct flush_data *fd = arg;
+	local_flush_cache_page(fd->vma, fd->addr1, fd->addr2);
+}
+
+void flush_cache_page(struct vm_area_struct *vma,
+		     unsigned long address, unsigned long pfn)
+{
+	struct flush_data fd = {
+		.vma = vma,
+		.addr1 = address,
+		.addr2 = pfn,
+	};
+	on_each_cpu(ipi_flush_cache_page, &fd, 1);
+}
+
+static void ipi_flush_cache_range(void *arg)
+{
+	struct flush_data *fd = arg;
+	local_flush_cache_range(fd->vma, fd->addr1, fd->addr2);
+}
+
+void flush_cache_range(struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end)
+{
+	struct flush_data fd = {
+		.vma = vma,
+		.addr1 = start,
+		.addr2 = end,
+	};
+	on_each_cpu(ipi_flush_cache_range, &fd, 1);
+}
+
+static void ipi_flush_icache_range(void *arg)
+{
+	struct flush_data *fd = arg;
+	local_flush_icache_range(fd->addr1, fd->addr2);
+}
+
+void flush_icache_range(unsigned long start, unsigned long end)
+{
+	struct flush_data fd = {
+		.addr1 = start,
+		.addr2 = end,
+	};
+	on_each_cpu(ipi_flush_icache_range, &fd, 1);
+}
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 3dbe864..3c0ff57 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -157,7 +157,7 @@ COPROCESSOR(7),
  * 2. it is a temporary memory buffer for the exception handlers.
  */
 
-unsigned long exc_table[EXC_TABLE_SIZE/4];
+DEFINE_PER_CPU(unsigned long, exc_table[EXC_TABLE_SIZE/4]);
 
 void die(const char*, struct pt_regs*, long);
 
@@ -313,17 +313,31 @@ do_debug(struct pt_regs *regs)
 }
 
 
+static void set_handler(int idx, void *handler)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(exc_table, cpu)[idx] = (unsigned long)handler;
+}
+
 /* Set exception C handler - for temporary use when probing exceptions */
 
 void * __init trap_set_handler(int cause, void *handler)
 {
-	unsigned long *entry = &exc_table[EXC_TABLE_DEFAULT / 4 + cause];
-	void *previous = (void *)*entry;
-	*entry = (unsigned long)handler;
+	void *previous = (void *)per_cpu(exc_table, 0)[
+		EXC_TABLE_DEFAULT / 4 + cause];
+	set_handler(EXC_TABLE_DEFAULT / 4 + cause, handler);
 	return previous;
 }
 
 
+static void __init trap_init_excsave(void)
+{
+	unsigned long excsave1 = (unsigned long)this_cpu_ptr(exc_table);
+	__asm__ __volatile__("wsr  %0, excsave1\n" : : "a" (excsave1));
+}
+
 /*
  * Initialize dispatch tables.
  *
@@ -337,8 +351,6 @@ void * __init trap_set_handler(int cause, void *handler)
  * See vectors.S for more details.
  */
 
-#define set_handler(idx,handler) (exc_table[idx] = (unsigned long) (handler))
-
 void __init trap_init(void)
 {
 	int i;
@@ -368,10 +380,15 @@ void __init trap_init(void)
 	}
 
 	/* Initialize EXCSAVE_1 to hold the address of the exception table. */
+	trap_init_excsave();
+}
 
-	i = (unsigned long)exc_table;
-	__asm__ __volatile__("wsr  %0, excsave1\n" : : "a" (i));
+#ifdef CONFIG_SMP
+void __init secondary_trap_init(void)
+{
+	trap_init_excsave();
 }
+#endif
 
 /*
  * This function dumps the current valid window frame and other base registers.
diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
index 21acd11..ee32c00 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -165,6 +165,13 @@ SECTIONS
 		   .DoubleExceptionVector.text);
     RELOCATE_ENTRY(_DebugInterruptVector_text,
 		   .DebugInterruptVector.text);
+#if defined(CONFIG_SMP)
+    RELOCATE_ENTRY(_SecondaryResetVector_literal,
+		   .SecondaryResetVector.literal);
+    RELOCATE_ENTRY(_SecondaryResetVector_text,
+		   .SecondaryResetVector.text);
+#endif
+
   
     __boot_reloc_table_end = ABSOLUTE(.) ;
 
@@ -272,6 +279,25 @@ SECTIONS
 		  .DoubleExceptionVector.literal)
 
   . = (LOADADDR( .DoubleExceptionVector.text ) + SIZEOF( .DoubleExceptionVector.text ) + 3) & ~ 3;
+
+#if defined(CONFIG_SMP)
+
+  SECTION_VECTOR (_SecondaryResetVector_literal,
+		  .SecondaryResetVector.literal,
+		  RESET_VECTOR1_VADDR - 4,
+		  SIZEOF(.DoubleExceptionVector.text),
+		  .DoubleExceptionVector.text)
+
+  SECTION_VECTOR (_SecondaryResetVector_text,
+		  .SecondaryResetVector.text,
+		  RESET_VECTOR1_VADDR,
+		  4,
+		  .SecondaryResetVector.literal)
+
+  . = LOADADDR(.SecondaryResetVector.text)+SIZEOF(.SecondaryResetVector.text);
+
+#endif
+
   . = ALIGN(PAGE_SIZE);
 
   __init_end = .;
diff --git a/arch/xtensa/mm/cache.c b/arch/xtensa/mm/cache.c
index 81edeab..ba4c47f 100644
--- a/arch/xtensa/mm/cache.c
+++ b/arch/xtensa/mm/cache.c
@@ -118,7 +118,7 @@ void flush_dcache_page(struct page *page)
  * For now, flush the whole cache. FIXME??
  */
 
-void flush_cache_range(struct vm_area_struct* vma,
+void local_flush_cache_range(struct vm_area_struct *vma,
 		       unsigned long start, unsigned long end)
 {
 	__flush_invalidate_dcache_all();
@@ -132,7 +132,7 @@ void flush_cache_range(struct vm_area_struct* vma,
  * alias versions of the cache flush functions.
  */
 
-void flush_cache_page(struct vm_area_struct* vma, unsigned long address,
+void local_flush_cache_page(struct vm_area_struct *vma, unsigned long address,
 		      unsigned long pfn)
 {
 	/* Note that we have to use the 'alias' address to avoid multi-hit */
@@ -159,8 +159,7 @@ update_mmu_cache(struct vm_area_struct * vma, unsigned long addr, pte_t *ptep)
 
 	/* Invalidate old entry in TLBs */
 
-	invalidate_itlb_mapping(addr);
-	invalidate_dtlb_mapping(addr);
+	flush_tlb_page(vma, addr);
 
 #if (DCACHE_WAY_SIZE > PAGE_SIZE) && XCHAL_DCACHE_IS_WRITEBACK
 
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 70fa7bc..b57c4f9 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -21,7 +21,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 
-unsigned long asid_cache = ASID_USER_FIRST;
+DEFINE_PER_CPU(unsigned long, asid_cache) = ASID_USER_FIRST;
 void bad_page_fault(struct pt_regs*, unsigned long, int);
 
 #undef DEBUG_PAGE_FAULT
diff --git a/arch/xtensa/mm/mmu.c b/arch/xtensa/mm/mmu.c
index a107757..3fdd69a 100644
--- a/arch/xtensa/mm/mmu.c
+++ b/arch/xtensa/mm/mmu.c
@@ -22,7 +22,7 @@ void __init paging_init(void)
 /*
  * Flush the mmu and reset associated register to default values.
  */
-void __init init_mmu(void)
+void init_mmu(void)
 {
 #if !(XCHAL_HAVE_PTP_MMU && XCHAL_HAVE_SPANNING_WAY)
 	/*
@@ -37,7 +37,7 @@ void __init init_mmu(void)
 	set_itlbcfg_register(0);
 	set_dtlbcfg_register(0);
 #endif
-	flush_tlb_all();
+	local_flush_tlb_all();
 
 	/* Set rasid register to a known value. */
 
diff --git a/arch/xtensa/mm/tlb.c b/arch/xtensa/mm/tlb.c
index ca9d236..ade62382 100644
--- a/arch/xtensa/mm/tlb.c
+++ b/arch/xtensa/mm/tlb.c
@@ -48,7 +48,7 @@ static inline void __flush_dtlb_all (void)
 }
 
 
-void flush_tlb_all (void)
+void local_flush_tlb_all(void)
 {
 	__flush_itlb_all();
 	__flush_dtlb_all();
@@ -60,19 +60,23 @@ void flush_tlb_all (void)
  * a new context will be assigned to it.
  */
 
-void flush_tlb_mm(struct mm_struct *mm)
+void local_flush_tlb_mm(struct mm_struct *mm)
 {
+	int cpu = smp_processor_id();
+
 	if (mm == current->active_mm) {
 		unsigned long flags;
 		local_irq_save(flags);
-		__get_new_mmu_context(mm);
-		__load_mmu_context(mm);
+		mm->context.asid[cpu] = NO_CONTEXT;
+		activate_context(mm, cpu);
 		local_irq_restore(flags);
+	} else {
+		mm->context.asid[cpu] = NO_CONTEXT;
+		mm->context.cpu = -1;
 	}
-	else
-		mm->context = 0;
 }
 
+
 #define _ITLB_ENTRIES (ITLB_ARF_WAYS << XCHAL_ITLB_ARF_ENTRIES_LOG2)
 #define _DTLB_ENTRIES (DTLB_ARF_WAYS << XCHAL_DTLB_ARF_ENTRIES_LOG2)
 #if _ITLB_ENTRIES > _DTLB_ENTRIES
@@ -81,24 +85,26 @@ void flush_tlb_mm(struct mm_struct *mm)
 # define _TLB_ENTRIES _DTLB_ENTRIES
 #endif
 
-void flush_tlb_range (struct vm_area_struct *vma,
-		      unsigned long start, unsigned long end)
+void local_flush_tlb_range(struct vm_area_struct *vma,
+		unsigned long start, unsigned long end)
 {
+	int cpu = smp_processor_id();
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long flags;
 
-	if (mm->context == NO_CONTEXT)
+	if (mm->context.asid[cpu] == NO_CONTEXT)
 		return;
 
 #if 0
 	printk("[tlbrange<%02lx,%08lx,%08lx>]\n",
-			(unsigned long)mm->context, start, end);
+			(unsigned long)mm->context.asid[cpu], start, end);
 #endif
 	local_irq_save(flags);
 
 	if (end-start + (PAGE_SIZE-1) <= _TLB_ENTRIES << PAGE_SHIFT) {
 		int oldpid = get_rasid_register();
-		set_rasid_register (ASID_INSERT(mm->context));
+
+		set_rasid_register(ASID_INSERT(mm->context.asid[cpu]));
 		start &= PAGE_MASK;
 		if (vma->vm_flags & VM_EXEC)
 			while(start < end) {
@@ -114,24 +120,25 @@ void flush_tlb_range (struct vm_area_struct *vma,
 
 		set_rasid_register(oldpid);
 	} else {
-		flush_tlb_mm(mm);
+		local_flush_tlb_mm(mm);
 	}
 	local_irq_restore(flags);
 }
 
-void flush_tlb_page (struct vm_area_struct *vma, unsigned long page)
+void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 {
+	int cpu = smp_processor_id();
 	struct mm_struct* mm = vma->vm_mm;
 	unsigned long flags;
 	int oldpid;
 
-	if(mm->context == NO_CONTEXT)
+	if (mm->context.asid[cpu] == NO_CONTEXT)
 		return;
 
 	local_irq_save(flags);
 
 	oldpid = get_rasid_register();
-	set_rasid_register(ASID_INSERT(mm->context));
+	set_rasid_register(ASID_INSERT(mm->context.asid[cpu]));
 
 	if (vma->vm_flags & VM_EXEC)
 		invalidate_itlb_mapping(page);
diff --git a/arch/xtensa/platforms/xtfpga/include/platform/hardware.h b/arch/xtensa/platforms/xtfpga/include/platform/hardware.h
index 4b43ff1..aeb316b 100644
--- a/arch/xtensa/platforms/xtfpga/include/platform/hardware.h
+++ b/arch/xtensa/platforms/xtfpga/include/platform/hardware.h
@@ -26,7 +26,7 @@
 
 /* Default assignment of LX60 devices to external interrupts. */
 
-#ifdef CONFIG_ARCH_HAS_SMP
+#ifdef CONFIG_XTENSA_MX
 #define DUART16552_INTNUM	XCHAL_EXTINT3_NUM
 #define OETH_IRQ		XCHAL_EXTINT4_NUM
 #else
-- 
1.8.1.4
