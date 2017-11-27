From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 07/35] nds32: Cache and TLB routines
Date: Mon, 27 Nov 2017 20:27:54 +0800
Message-ID: <8e7c0bc03415bade418f626109f1bd0fd83ba354.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch contains cache and TLB maintenance functions.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/cache.h         |   25 ++
 arch/nds32/include/asm/cache_info.h    |   26 ++
 arch/nds32/include/asm/cacheflush.h    |   57 +++
 arch/nds32/include/asm/mmu_context.h   |   81 +++++
 arch/nds32/include/asm/proc-fns.h      |   57 +++
 arch/nds32/include/asm/tlb.h           |   41 +++
 arch/nds32/include/asm/tlbflush.h      |   60 ++++
 arch/nds32/include/uapi/asm/cachectl.h |   19 +
 arch/nds32/kernel/cacheinfo.c          |   62 ++++
 arch/nds32/mm/cacheflush.c             |  331 ++++++++++++++++++
 arch/nds32/mm/proc.c                   |  601 ++++++++++++++++++++++++++++++++
 arch/nds32/mm/tlb.c                    |   63 ++++
 12 files changed, 1423 insertions(+)
 create mode 100644 arch/nds32/include/asm/cache.h
 create mode 100644 arch/nds32/include/asm/cache_info.h
 create mode 100644 arch/nds32/include/asm/cacheflush.h
 create mode 100644 arch/nds32/include/asm/mmu_context.h
 create mode 100644 arch/nds32/include/asm/proc-fns.h
 create mode 100644 arch/nds32/include/asm/tlb.h
 create mode 100644 arch/nds32/include/asm/tlbflush.h
 create mode 100644 arch/nds32/include/uapi/asm/cachectl.h
 create mode 100644 arch/nds32/kernel/cacheinfo.c
 create mode 100644 arch/nds32/mm/cacheflush.c
 create mode 100644 arch/nds32/mm/proc.c
 create mode 100644 arch/nds32/mm/tlb.c

diff --git a/arch/nds32/include/asm/cache.h b/arch/nds32/include/asm/cache.h
new file mode 100644
index 0000000..36ec549
--- /dev/null
+++ b/arch/nds32/include/asm/cache.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __NDS32_CACHE_H__
+#define __NDS32_CACHE_H__
+
+#define L1_CACHE_BYTES	32
+#define L1_CACHE_SHIFT	5
+
+#define ARCH_DMA_MINALIGN   L1_CACHE_BYTES
+
+#endif /* __NDS32_CACHE_H__ */
diff --git a/arch/nds32/include/asm/cache_info.h b/arch/nds32/include/asm/cache_info.h
new file mode 100644
index 0000000..a59d73d
--- /dev/null
+++ b/arch/nds32/include/asm/cache_info.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+struct cache_info {
+	unsigned char ways;
+	unsigned char line_size;
+	unsigned short sets;
+	unsigned short size;
+#if !defined(CONFIG_CPU_CACHE_NONALIASING)
+	unsigned short aliasing_num;
+	unsigned int aliasing_mask;
+#endif
+};
diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
new file mode 100644
index 0000000..0c7c9db
--- /dev/null
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -0,0 +1,57 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __NDS32_CACHEFLUSH_H__
+#define __NDS32_CACHEFLUSH_H__
+
+#include <linux/mm.h>
+
+#define PG_dcache_dirty PG_arch_1
+
+#ifndef CONFIG_CPU_CACHE_NONALIASING
+void flush_cache_mm(struct mm_struct *mm);
+void flush_cache_dup_mm(struct mm_struct *mm);
+void flush_cache_range(struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end);
+void flush_cache_page(struct vm_area_struct *vma,
+		      unsigned long addr, unsigned long pfn);
+void flush_cache_kmaps(void);
+void flush_cache_vmap(unsigned long start, unsigned long end);
+void flush_cache_vunmap(unsigned long start, unsigned long end);
+
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
+void flush_dcache_page(struct page *page);
+void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
+		       unsigned long vaddr, void *dst, void *src, int len);
+void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
+			 unsigned long vaddr, void *dst, void *src, int len);
+
+#define ARCH_HAS_FLUSH_ANON_PAGE
+void flush_anon_page(struct vm_area_struct *vma,
+		     struct page *page, unsigned long vaddr);
+
+#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+void flush_kernel_dcache_page(struct page *page);
+void flush_icache_range(unsigned long start, unsigned long end);
+void flush_icache_page(struct vm_area_struct *vma, struct page *page);
+#define flush_dcache_mmap_lock(mapping)   spin_lock_irq(&(mapping)->tree_lock)
+#define flush_dcache_mmap_unlock(mapping) spin_unlock_irq(&(mapping)->tree_lock)
+
+#else
+#include <asm-generic/cacheflush.h>
+#endif
+
+#endif /* __NDS32_CACHEFLUSH_H__ */
diff --git a/arch/nds32/include/asm/mmu_context.h b/arch/nds32/include/asm/mmu_context.h
new file mode 100644
index 0000000..4a59b5d
--- /dev/null
+++ b/arch/nds32/include/asm/mmu_context.h
@@ -0,0 +1,81 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_NDS32_MMU_CONTEXT_H
+#define __ASM_NDS32_MMU_CONTEXT_H
+
+#include <linux/spinlock.h>
+#include <asm/tlbflush.h>
+#include <asm/proc-fns.h>
+#include <asm-generic/mm_hooks.h>
+
+static inline int
+init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	mm->context.id = 0;
+	return 0;
+}
+
+#define destroy_context(mm)	do { } while(0)
+
+#define CID_BITS	9
+extern spinlock_t cid_lock;
+extern unsigned int cpu_last_cid;
+
+static inline void __new_context(struct mm_struct *mm)
+{
+	unsigned int cid;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cid_lock, flags);
+	cid = cpu_last_cid;
+	cpu_last_cid += 1 << TLB_MISC_offCID;
+	if (cpu_last_cid == 0)
+		cpu_last_cid = 1 << TLB_MISC_offCID << CID_BITS;
+
+	if ((cid & TLB_MISC_mskCID) == 0)
+		flush_tlb_all();
+	spin_unlock_irqrestore(&cid_lock, flags);
+
+	mm->context.id = cid;
+}
+
+static inline void check_context(struct mm_struct *mm)
+{
+	if (unlikely
+	    ((mm->context.id ^ cpu_last_cid) >> TLB_MISC_offCID >> CID_BITS))
+		__new_context(mm);
+}
+
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
+{
+}
+
+static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+			     struct task_struct *tsk)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next) {
+		check_context(next);
+		cpu_switch_mm(next);
+	}
+}
+
+#define deactivate_mm(tsk,mm)	do { } while (0)
+#define activate_mm(prev,next)	switch_mm(prev, next, NULL)
+
+#endif
diff --git a/arch/nds32/include/asm/proc-fns.h b/arch/nds32/include/asm/proc-fns.h
new file mode 100644
index 0000000..b1a56d2
--- /dev/null
+++ b/arch/nds32/include/asm/proc-fns.h
@@ -0,0 +1,57 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __NDS32_PROCFNS_H__
+#define __NDS32_PROCFNS_H__
+
+#ifdef __KERNEL__
+#include <asm/page.h>
+
+struct mm_struct;
+struct vm_area_struct;
+extern void cpu_proc_init(void);
+extern void cpu_proc_fin(void);
+extern void cpu_do_idle(void);
+extern void cpu_reset(unsigned long reset);
+extern void cpu_switch_mm(struct mm_struct *mm);
+
+extern void cpu_dcache_inval_all(void);
+extern void cpu_dcache_wbinval_all(void);
+extern void cpu_dcache_inval_page(unsigned long page);
+extern void cpu_dcache_wb_page(unsigned long page);
+extern void cpu_dcache_wbinval_page(unsigned long page);
+extern void cpu_dcache_inval_range(unsigned long start, unsigned long end);
+extern void cpu_dcache_wb_range(unsigned long start, unsigned long end);
+extern void cpu_dcache_wbinval_range(unsigned long start, unsigned long end);
+
+extern void cpu_icache_inval_all(void);
+extern void cpu_icache_inval_page(unsigned long page);
+extern void cpu_icache_inval_range(unsigned long start, unsigned long end);
+
+extern void cpu_cache_wbinval_page(unsigned long page, int flushi);
+extern void cpu_cache_wbinval_range(unsigned long start,
+				    unsigned long end, int flushi);
+extern void cpu_cache_wbinval_range_check(struct vm_area_struct *vma,
+					  unsigned long start,
+					  unsigned long end, bool flushi,
+					  bool wbd);
+
+extern void cpu_dma_wb_range(unsigned long start, unsigned long end);
+extern void cpu_dma_inval_range(unsigned long start, unsigned long end);
+extern void cpu_dma_wbinval_range(unsigned long start, unsigned long end);
+
+#endif /* __KERNEL__ */
+#endif /* __NDS32_PROCFNS_H__ */
diff --git a/arch/nds32/include/asm/tlb.h b/arch/nds32/include/asm/tlb.h
new file mode 100644
index 0000000..c599827
--- /dev/null
+++ b/arch/nds32/include/asm/tlb.h
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASMNDS32_TLB_H
+#define __ASMNDS32_TLB_H
+
+#define tlb_start_vma(tlb,vma)						\
+	do {								\
+		if (!tlb->fullmm)					\
+			flush_cache_range(vma, vma->vm_start, vma->vm_end); \
+	} while (0)
+
+#define tlb_end_vma(tlb,vma)				\
+	do { 						\
+		if(!tlb->fullmm)			\
+			flush_tlb_range(vma, vma->vm_start, vma->vm_end); \
+	} while (0)
+
+#define __tlb_remove_tlb_entry(tlb, pte, addr) do { } while (0)
+
+#define tlb_flush(tlb)	flush_tlb_mm((tlb)->mm)
+
+#include <asm-generic/tlb.h>
+
+#define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
+#define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tln)->mm, pmd)
+
+#endif
diff --git a/arch/nds32/include/asm/tlbflush.h b/arch/nds32/include/asm/tlbflush.h
new file mode 100644
index 0000000..680aeb3
--- /dev/null
+++ b/arch/nds32/include/asm/tlbflush.h
@@ -0,0 +1,60 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ASMNDS32_TLBFLUSH_H
+#define _ASMNDS32_TLBFLUSH_H
+
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <nds32_intrinsic.h>
+
+static inline void local_flush_tlb_all(void)
+{
+	__nds32__tlbop_flua();
+	__nds32__isb();
+}
+
+static inline void local_flush_tlb_mm(struct mm_struct *mm)
+{
+	__nds32__tlbop_flua();
+	__nds32__isb();
+}
+
+static inline void local_flush_tlb_kernel_range(unsigned long start,
+						unsigned long end)
+{
+	while (start < end) {
+		__nds32__tlbop_inv(start);
+		__nds32__isb();
+		start += PAGE_SIZE;
+	}
+}
+
+void local_flush_tlb_range(struct vm_area_struct *vma,
+			   unsigned long start, unsigned long end);
+void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
+
+#define flush_tlb_all		local_flush_tlb_all
+#define flush_tlb_mm		local_flush_tlb_mm
+#define flush_tlb_range		local_flush_tlb_range
+#define flush_tlb_page		local_flush_tlb_page
+#define flush_tlb_kernel_range	local_flush_tlb_kernel_range
+
+void update_mmu_cache(struct vm_area_struct *vma,
+		      unsigned long address, pte_t * pte);
+void tlb_migrate_finish(struct mm_struct *mm);
+
+#endif
diff --git a/arch/nds32/include/uapi/asm/cachectl.h b/arch/nds32/include/uapi/asm/cachectl.h
new file mode 100644
index 0000000..a56a37d
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/cachectl.h
@@ -0,0 +1,19 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994, 1995, 1996 by Ralf Baechle
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ */
+#ifndef	_ASM_CACHECTL
+#define	_ASM_CACHECTL
+
+/*
+ * Options for cacheflush system call
+ */
+#define	ICACHE	0		/* flush instruction cache        */
+#define	DCACHE	1		/* writeback and flush data cache */
+#define	BCACHE	2		/* flush instruction cache + writeback and flush data cache */
+
+#endif /* _ASM_CACHECTL */
diff --git a/arch/nds32/kernel/cacheinfo.c b/arch/nds32/kernel/cacheinfo.c
new file mode 100644
index 0000000..edc0fda
--- /dev/null
+++ b/arch/nds32/kernel/cacheinfo.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/bitops.h>
+#include <linux/cacheinfo.h>
+#include <linux/cpu.h>
+
+static void ci_leaf_init(struct cacheinfo *this_leaf,
+			 enum cache_type type, unsigned int level)
+{
+	char cache_type = (type & CACHE_TYPE_INST ? ICACHE : DCACHE);
+
+	this_leaf->level = level;
+	this_leaf->type = type;
+	this_leaf->coherency_line_size = CACHE_LINE_SIZE(cache_type);
+	this_leaf->number_of_sets = CACHE_SET(cache_type);;
+	this_leaf->ways_of_associativity = CACHE_WAY(cache_type);
+	this_leaf->size = this_leaf->number_of_sets *
+	    this_leaf->coherency_line_size * this_leaf->ways_of_associativity;
+#if defined(CONFIG_CPU_DCACHE_WRITETHROUGH)
+	this_leaf->attributes = CACHE_WRITE_THROUGH;
+#else
+	this_leaf->attributes = CACHE_WRITE_BACK;
+#endif
+}
+
+int init_cache_level(unsigned int cpu)
+{
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+
+	/* Only 1 level and I/D cache seperate. */
+	this_cpu_ci->num_levels = 1;
+	this_cpu_ci->num_leaves = 2;
+	return 0;
+}
+
+int populate_cache_leaves(unsigned int cpu)
+{
+	unsigned int level, idx;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+
+	for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
+	     idx < this_cpu_ci->num_leaves; idx++, level++) {
+		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
+	}
+	return 0;
+}
diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
new file mode 100644
index 0000000..ef733b2
--- /dev/null
+++ b/arch/nds32/mm/cacheflush.c
@@ -0,0 +1,331 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+#include <linux/module.h>
+#include <asm/cacheflush.h>
+#include <asm/proc-fns.h>
+#include <asm/shmparam.h>
+#include <asm/cache_info.h>
+
+extern struct cache_info L1_cache_info[2];
+
+#ifdef CONFIG_CPU_CACHE_NONALIASING
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
+		      pte_t * pte)
+{
+	struct page *page;
+	unsigned long pfn = pte_pfn(*pte);
+
+	if (!pfn_valid(pfn))
+		return;
+
+	if (vma->vm_mm == current->active_mm) {
+
+		__nds32__mtsr_dsb(addr, NDS32_SR_TLB_VPN);
+		__nds32__tlbop_rwr(*pte);
+		__nds32__isb();
+	}
+	page = pfn_to_page(pfn);
+
+	if ((test_and_clear_bit(PG_dcache_dirty, &page->flags)) ||
+	    (vma->vm_flags & VM_EXEC)) {
+
+		if (!PageHighMem(page)) {
+			cpu_cache_wbinval_page((unsigned long)
+					       page_address(page),
+					       vma->vm_flags & VM_EXEC);
+		} else {
+			unsigned long kaddr = (unsigned long)kmap_atomic(page);
+			cpu_cache_wbinval_page(kaddr, vma->vm_flags & VM_EXEC);
+			kunmap_atomic((void *)kaddr);
+		}
+	}
+}
+#else
+extern pte_t va_present(struct mm_struct *mm, unsigned long addr);
+
+static inline unsigned long aliasing(unsigned long addr, unsigned long page)
+{
+	return ((addr & PAGE_MASK) ^ page) & (SHMLBA - 1);
+}
+
+static inline unsigned long kremap0(unsigned long uaddr, unsigned long pa)
+{
+	unsigned long kaddr, pte;
+
+#define BASE_ADDR0 0xffffc000
+	kaddr = BASE_ADDR0 | (uaddr & L1_cache_info[DCACHE].aliasing_mask);
+	pte = (pa | PAGE_KERNEL);
+	__nds32__mtsr_dsb(kaddr, NDS32_SR_TLB_VPN);
+	__nds32__tlbop_rwlk(pte);
+	__nds32__isb();
+	return kaddr;
+}
+
+static inline void kunmap01(unsigned long kaddr)
+{
+	__nds32__tlbop_unlk(kaddr);
+	__nds32__tlbop_inv(kaddr);
+	__nds32__isb();
+}
+
+static inline unsigned long kremap1(unsigned long uaddr, unsigned long pa)
+{
+	unsigned long kaddr, pte;
+
+#define BASE_ADDR1 0xffff8000
+	kaddr = BASE_ADDR1 | (uaddr & L1_cache_info[DCACHE].aliasing_mask);
+	pte = (pa | PAGE_KERNEL);
+	__nds32__mtsr_dsb(kaddr, NDS32_SR_TLB_VPN);
+	__nds32__tlbop_rwlk(pte);
+	__nds32__isb();
+	return kaddr;
+}
+
+void flush_cache_mm(struct mm_struct *mm)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cpu_dcache_wbinval_all();
+	cpu_icache_inval_all();
+	local_irq_restore(flags);
+}
+
+void flush_cache_dup_mm(struct mm_struct *mm)
+{
+}
+
+void flush_cache_range(struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end)
+{
+	unsigned long flags;
+
+	if ((end - start) > 8 * PAGE_SIZE) {
+		cpu_dcache_wbinval_all();
+		if (vma->vm_flags & VM_EXEC)
+			cpu_icache_inval_all();
+		return;
+	}
+	local_irq_save(flags);
+	while (start < end) {
+		if (va_present(vma->vm_mm, start))
+			cpu_cache_wbinval_page(start, vma->vm_flags & VM_EXEC);
+		start += PAGE_SIZE;
+	}
+	local_irq_restore(flags);
+	return;
+}
+
+void flush_cache_page(struct vm_area_struct *vma,
+		      unsigned long addr, unsigned long pfn)
+{
+	unsigned long vto, flags;
+
+	local_irq_save(flags);
+	vto = kremap0(addr, pfn << PAGE_SHIFT);
+	cpu_cache_wbinval_page(vto, vma->vm_flags & VM_EXEC);
+	kunmap01(vto);
+	local_irq_restore(flags);
+}
+
+void flush_cache_vmap(unsigned long start, unsigned long end)
+{
+	cpu_dcache_wbinval_all();
+	cpu_icache_inval_all();
+}
+
+void flush_cache_vunmap(unsigned long start, unsigned long end)
+{
+	cpu_dcache_wbinval_all();
+	cpu_icache_inval_all();
+}
+
+void copy_user_highpage(struct page *to, struct page *from,
+			unsigned long vaddr, struct vm_area_struct *vma)
+{
+	unsigned long vto, vfrom, flags, kto, kfrom, pfrom, pto;
+	kto = ((unsigned long)page_address(to) & PAGE_MASK);
+	kfrom = ((unsigned long)page_address(from) & PAGE_MASK);
+	pto = page_to_phys(to);
+	pfrom = page_to_phys(from);
+
+	if (aliasing(vaddr, (unsigned long)kfrom))
+		cpu_dcache_wb_page((unsigned long)kfrom);
+	if (aliasing(vaddr, (unsigned long)kto))
+		cpu_dcache_inval_page((unsigned long)kto);
+	local_irq_save(flags);
+	vto = kremap0(vaddr, pto);
+	vfrom = kremap1(vaddr, pfrom);
+	copy_page((void *)vto, (void *)vfrom);
+	kunmap01(vfrom);
+	kunmap01(vto);
+	local_irq_restore(flags);
+}
+
+EXPORT_SYMBOL(copy_user_highpage);
+
+void clear_user_highpage(struct page *page, unsigned long vaddr)
+{
+	unsigned long vto, flags, kto;
+
+	kto = ((unsigned long)page_address(page) & PAGE_MASK);
+
+	local_irq_save(flags);
+	if (aliasing(kto, vaddr) && kto != 0) {
+		cpu_dcache_inval_page(kto);
+		cpu_icache_inval_page(kto);
+	}
+	vto = kremap0(vaddr, page_to_phys(page));
+	clear_page((void *)vto);
+	kunmap01(vto);
+	local_irq_restore(flags);
+}
+
+EXPORT_SYMBOL(clear_user_highpage);
+
+void flush_dcache_page(struct page *page)
+{
+	struct address_space *mapping;
+
+	mapping = page_mapping(page);
+	if (mapping && !mapping_mapped(mapping))
+		set_bit(PG_dcache_dirty, &page->flags);
+	else {
+		int i, pc;
+		unsigned long vto, kaddr, flags;
+		kaddr = (unsigned long)page_address(page);
+		cpu_dcache_wbinval_page(kaddr);
+		pc = CACHE_SET(DCACHE) * CACHE_LINE_SIZE(DCACHE) / PAGE_SIZE;
+		local_irq_save(flags);
+		for (i = 0; i < pc; i++) {
+			vto =
+			    kremap0(kaddr + i * PAGE_SIZE, page_to_phys(page));
+			cpu_dcache_wbinval_page(vto);
+			kunmap01(vto);
+		}
+		local_irq_restore(flags);
+	}
+}
+
+void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
+		       unsigned long vaddr, void *dst, void *src, int len)
+{
+	unsigned long line_size, start, end, vto, flags;
+
+	local_irq_save(flags);
+	vto = kremap0(vaddr, page_to_phys(page));
+	dst = (void *)(vto | (vaddr & (PAGE_SIZE - 1)));
+	memcpy(dst, src, len);
+	if (vma->vm_flags & VM_EXEC) {
+		line_size = L1_cache_info[DCACHE].line_size;
+		start = (unsigned long)dst & ~(line_size - 1);
+		end =
+		    ((unsigned long)dst + len + line_size - 1) & ~(line_size -
+								   1);
+		cpu_cache_wbinval_range(start, end, 1);
+	}
+	kunmap01(vto);
+	local_irq_restore(flags);
+}
+
+void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
+			 unsigned long vaddr, void *dst, void *src, int len)
+{
+	unsigned long vto, flags;
+
+	local_irq_save(flags);
+	vto = kremap0(vaddr, page_to_phys(page));
+	src = (void *)(vto | (vaddr & (PAGE_SIZE - 1)));
+	memcpy(dst, src, len);
+	kunmap01(vto);
+	local_irq_restore(flags);
+}
+
+void flush_anon_page(struct vm_area_struct *vma,
+		     struct page *page, unsigned long vaddr)
+{
+	unsigned long flags;
+	if (!PageAnon(page))
+		return;
+
+	if (vma->vm_mm != current->active_mm)
+		return;
+
+	local_irq_save(flags);
+	if (vma->vm_flags & VM_EXEC)
+		cpu_icache_inval_page(vaddr & PAGE_MASK);
+	cpu_dcache_wbinval_page((unsigned long)page_address(page));
+	local_irq_restore(flags);
+}
+
+void flush_kernel_dcache_page(struct page *page)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	cpu_dcache_wbinval_page((unsigned long)page_address(page));
+	local_irq_restore(flags);
+}
+
+void flush_icache_range(unsigned long start, unsigned long end)
+{
+	unsigned long line_size, flags;
+	line_size = L1_cache_info[DCACHE].line_size;
+	start = start & ~(line_size - 1);
+	end = (end + line_size - 1) & ~(line_size - 1);
+	local_irq_save(flags);
+	cpu_cache_wbinval_range(start, end, 1);
+	local_irq_restore(flags);
+}
+
+void flush_icache_page(struct vm_area_struct *vma, struct page *page)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	cpu_cache_wbinval_page((unsigned long)page_address(page),
+			       vma->vm_flags & VM_EXEC);
+	local_irq_restore(flags);
+}
+
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
+		      pte_t * pte)
+{
+	struct page *page;
+	unsigned long flags;
+	unsigned long pfn = pte_pfn(*pte);
+
+	if (!pfn_valid(pfn))
+		return;
+
+	if (vma->vm_mm == current->active_mm) {
+		__nds32__mtsr_dsb(addr, NDS32_SR_TLB_VPN);
+		__nds32__tlbop_rwr(*pte);
+		__nds32__isb();
+	}
+
+	page = pfn_to_page(pfn);
+	if (test_and_clear_bit(PG_dcache_dirty, &page->flags) ||
+	    (vma->vm_flags & VM_EXEC)) {
+		local_irq_save(flags);
+		cpu_dcache_wbinval_page((unsigned long)page_address(page));
+		local_irq_restore(flags);
+	}
+}
+#endif
diff --git a/arch/nds32/mm/proc.c b/arch/nds32/mm/proc.c
new file mode 100644
index 0000000..58a41b9
--- /dev/null
+++ b/arch/nds32/mm/proc.c
@@ -0,0 +1,601 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <asm/nds32.h>
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
+#ifdef CONFIG_CACHE_L2
+#include <asm/l2_cache.h>
+#endif
+#include <nds32_intrinsic.h>
+
+#include <asm/cache_info.h>
+extern struct cache_info L1_cache_info[2];
+
+int va_kernel_present(unsigned long addr)
+{
+	pmd_t *pmd;
+	pte_t *ptep, pte;
+
+	pmd = pmd_offset(pgd_offset_k(addr), addr);
+	if (!pmd_none(*pmd)) {
+		ptep = pte_offset_map(pmd, addr);
+		pte = *ptep;
+		if (pte_present(pte))
+			return pte;
+	}
+	return 0;
+}
+
+pte_t va_present(struct mm_struct * mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *ptep, pte;
+
+	pgd = pgd_offset(mm, addr);
+	if (!pgd_none(*pgd)) {
+		pud = pud_offset(pgd, addr);
+		if (!pud_none(*pud)) {
+			pmd = pmd_offset(pud, addr);
+			if (!pmd_none(*pmd)) {
+				ptep = pte_offset_map(pmd, addr);
+				pte = *ptep;
+				if (pte_present(pte))
+					return pte;
+			}
+		}
+	}
+	return 0;
+
+}
+
+int va_readable(struct pt_regs *regs, unsigned long addr)
+{
+	struct mm_struct *mm = current->mm;
+	pte_t pte;
+	int ret = 0;
+
+	if (user_mode(regs)) {
+		/* user mode */
+		pte = va_present(mm, addr);
+		if (!pte && pte_read(pte))
+			ret = 1;
+	} else {
+		/* superuser mode is always readable, so we can only
+		 * check it is present or not*/
+		return (! !va_kernel_present(addr));
+	}
+	return ret;
+}
+
+int va_writable(struct pt_regs *regs, unsigned long addr)
+{
+	struct mm_struct *mm = current->mm;
+	pte_t pte;
+	int ret = 0;
+
+	if (user_mode(regs)) {
+		/* user mode */
+		pte = va_present(mm, addr);
+		if (!pte && pte_write(pte))
+			ret = 1;
+	} else {
+		/* superuser mode */
+		pte = va_kernel_present(addr);
+		if (!pte && pte_kernel_write(pte))
+			ret = 1;
+	}
+	return ret;
+}
+
+/*
+ * All
+ */
+void cpu_icache_inval_all(void)
+{
+	unsigned long end, line_size;
+
+	line_size = L1_cache_info[ICACHE].line_size;
+	end =
+	    line_size * L1_cache_info[ICACHE].ways * L1_cache_info[ICACHE].sets;
+
+	do {
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1I_IX_INVAL"::"r" (end));
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1I_IX_INVAL"::"r" (end));
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1I_IX_INVAL"::"r" (end));
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1I_IX_INVAL"::"r" (end));
+	} while (end > 0);
+}
+
+void cpu_dcache_inval_all(void)
+{
+	__nds32__cctl_l1d_invalall();
+}
+
+void cpu_dcache_wb_all(void)
+{
+	if (IS_ENABLED(CONFIG_CACHE_L2)) {
+		if (atl2c_base)
+			__nds32__cctl_l1d_wball_alvl();
+		else
+			__nds32__cctl_l1d_wball_one_lvl();
+	} else
+		__nds32__cctl_l1d_wball_one_lvl();
+}
+
+void cpu_dcache_wbinval_all(void)
+{
+#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
+	unsigned long flags;
+	local_irq_save(flags);
+#endif
+	if (IS_ENABLED(CONFIG_CACHE_L2)) {
+		if (atl2c_base)
+			__nds32__cctl_l1d_wball_alvl();
+		else
+			__nds32__cctl_l1d_wball_one_lvl();
+	} else
+		__nds32__cctl_l1d_wball_one_lvl();
+	__nds32__cctl_l1d_invalall();
+#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
+	local_irq_restore(flags);
+#endif
+}
+
+/*
+ * Page
+ */
+void cpu_icache_inval_page(unsigned long start)
+{
+	unsigned long line_size, end;
+
+	line_size = L1_cache_info[ICACHE].line_size;
+	end = start + PAGE_SIZE;
+
+	do {
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1I_VA_INVAL"::"r" (end));
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1I_VA_INVAL"::"r" (end));
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1I_VA_INVAL"::"r" (end));
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1I_VA_INVAL"::"r" (end));
+	} while (end != start);
+}
+
+void cpu_dcache_inval_page(unsigned long start)
+{
+	unsigned long line_size, end;
+
+	line_size = L1_cache_info[DCACHE].line_size;
+	end = start + PAGE_SIZE;
+
+	do {
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
+	} while (end != start);
+}
+
+void cpu_dcache_wb_page(unsigned long start)
+{
+#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
+	unsigned long line_size, end;
+
+	line_size = L1_cache_info[DCACHE].line_size;
+	end = start + PAGE_SIZE;
+
+	do {
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
+		end -= line_size;
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
+	} while (end != start);
+#endif
+}
+
+void cpu_dcache_wbinval_page(unsigned long start)
+{
+	unsigned long line_size, end;
+
+	line_size = L1_cache_info[DCACHE].line_size;
+	end = start + PAGE_SIZE;
+
+	do {
+		end -= line_size;
+#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
+#endif
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
+		end -= line_size;
+#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
+#endif
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
+		end -= line_size;
+#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
+#endif
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
+		end -= line_size;
+#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
+#endif
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
+	} while (end != start);
+}
+
+void cpu_cache_wbinval_page(unsigned long page, int flushi)
+{
+	cpu_dcache_wbinval_page(page);
+	if (flushi)
+		cpu_icache_inval_page(page);
+}
+
+/*
+ * Range
+ */
+void cpu_icache_inval_range(unsigned long start, unsigned long end)
+{
+	unsigned long line_size;
+
+	line_size = L1_cache_info[ICACHE].line_size;
+
+	while (end > start) {
+		__asm__ volatile ("\n\tcctl %0, L1I_VA_INVAL"::"r" (start));
+		start += line_size;
+	}
+}
+
+void cpu_dcache_inval_range(unsigned long start, unsigned long end)
+{
+	unsigned long line_size;
+
+	line_size = L1_cache_info[DCACHE].line_size;
+
+	while (end > start) {
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (start));
+		start += line_size;
+	}
+}
+
+void cpu_dcache_wb_range(unsigned long start, unsigned long end)
+{
+#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
+	unsigned long line_size;
+
+	line_size = L1_cache_info[DCACHE].line_size;
+
+	while (end > start) {
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (start));
+		start += line_size;
+	}
+#endif
+}
+
+void cpu_dcache_wbinval_range(unsigned long start, unsigned long end)
+{
+	unsigned long line_size;
+
+	line_size = L1_cache_info[DCACHE].line_size;
+
+	while (end > start) {
+#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (start));
+#endif
+		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (start));
+		start += line_size;
+	}
+}
+
+void cpu_cache_wbinval_range(unsigned long start, unsigned long end, int flushi)
+{
+	unsigned long line_size, align_start, align_end;
+
+	line_size = L1_cache_info[DCACHE].line_size;
+	align_start = start & ~(line_size - 1);
+	align_end = (end + line_size - 1) & ~(line_size - 1);
+	cpu_dcache_wbinval_range(align_start, align_end);
+
+	if (flushi) {
+		line_size = L1_cache_info[ICACHE].line_size;
+		align_start = start & ~(line_size - 1);
+		align_end = (end + line_size - 1) & ~(line_size - 1);
+		cpu_icache_inval_range(align_start, align_end);
+	}
+}
+
+void cpu_cache_wbinval_range_check(struct vm_area_struct *vma,
+				   unsigned long start, unsigned long end,
+				   bool flushi, bool wbd)
+{
+	unsigned long line_size, t_start, t_end;
+
+	if (!flushi && !wbd)
+		return;
+	line_size = L1_cache_info[DCACHE].line_size;
+	start = start & ~(line_size - 1);
+	end = (end + line_size - 1) & ~(line_size - 1);
+
+	if ((end - start) > (8 * PAGE_SIZE)) {
+		if (wbd)
+			cpu_dcache_wbinval_all();
+		if (flushi)
+			cpu_icache_inval_all();
+		return;
+	}
+
+	t_start = (start + PAGE_SIZE) & PAGE_MASK;
+	t_end = ((end - 1) & PAGE_MASK);
+
+	if ((start & PAGE_MASK) == t_end) {
+		if (va_present(vma->vm_mm, start)) {
+			if (wbd)
+				cpu_dcache_wbinval_range(start, end);
+			if (flushi)
+				cpu_icache_inval_range(start, end);
+		}
+		return;
+	}
+
+	if (va_present(vma->vm_mm, start)) {
+		if (wbd)
+			cpu_dcache_wbinval_range(start, end);
+		if (flushi)
+			cpu_icache_inval_range(start, end);
+	}
+
+	if (va_present(vma->vm_mm, end - 1)) {
+		if (wbd)
+			cpu_dcache_wbinval_range(start, end);
+		if (flushi)
+			cpu_icache_inval_range(start, end);
+	}
+
+	while (t_start < t_end) {
+		if (va_present(vma->vm_mm, t_start)) {
+			if (wbd)
+				cpu_dcache_wbinval_page(t_start);
+			if (flushi)
+				cpu_icache_inval_page(t_start);
+		}
+		t_start += PAGE_SIZE;
+	}
+}
+
+/*
+ * DMA
+ */
+void cpu_dma_wb_range(unsigned long start, unsigned long end)
+{
+	unsigned long line_size;
+	unsigned long flags;
+	line_size = L1_cache_info[DCACHE].line_size;
+	start = start & (~(line_size - 1));
+	end = (end + line_size - 1) & (~(line_size - 1));
+	if (unlikely(start == end))
+		return;
+
+	local_irq_save(flags);
+	cpu_dcache_wb_range(start, end);
+
+	if (IS_ENABLED(CONFIG_CACHE_L2)) {
+		if (atl2c_base) {
+			unsigned long p_start = __pa(start);
+			unsigned long p_end = __pa(end);
+			unsigned long cmd;
+			/* TODO Can Use PAGE Mode to optimize if range large than PAGE_SIZE */
+			line_size = L2_CACHE_LINE_SIZE();
+			p_start = p_start & (~(line_size - 1));
+			p_end = (p_end + line_size - 1) & (~(line_size - 1));
+			cmd =
+			    (p_start & ~(line_size - 1)) | CCTL_CMD_L2_PA_WB |
+			    CCTL_SINGLE_CMD;
+			do {
+				L2_CMD_RDY();
+				L2C_W_REG(L2_CCTL_CMD_OFF, cmd);
+				cmd += line_size;
+				p_start += line_size;
+			} while (p_end > p_start);
+			cmd = CCTL_CMD_L2_SYNC;
+			L2_CMD_RDY();
+			L2C_W_REG(L2_CCTL_CMD_OFF, cmd);
+			L2_CMD_RDY();
+		}
+	}
+	local_irq_restore(flags);
+}
+
+#ifdef CONFIG_CACHE_L2
+void cpu_l2dcache_wbinval_range(unsigned long start, unsigned long end)
+{
+	unsigned long p_start;
+	unsigned long p_end;
+	unsigned long cmd;
+	unsigned long line_size;
+
+	p_start = __pa(start);
+	p_end = __pa(end);
+	/* TODO Can Use PAGE Mode to optimize if range large than PAGE_SIZE */
+	line_size = L2_CACHE_LINE_SIZE();
+	p_start = p_start & (~(line_size - 1));
+	p_end = (p_end + line_size - 1) & (~(line_size - 1));
+	cmd =
+	    (p_start & ~(line_size - 1)) | CCTL_CMD_L2_PA_WBINVAL |
+	    CCTL_SINGLE_CMD;
+	do {
+		L2_CMD_RDY();
+		L2C_W_REG(L2_CCTL_CMD_OFF, cmd);
+		cmd += line_size;
+		p_start += line_size;
+	} while (p_end > p_start);
+	cmd = CCTL_CMD_L2_SYNC;
+	L2_CMD_RDY();
+	L2C_W_REG(L2_CCTL_CMD_OFF, cmd);
+	L2_CMD_RDY();
+
+}
+#endif
+
+void cpu_dma_inval_range(unsigned long start, unsigned long end)
+{
+	unsigned long line_size;
+	unsigned long old_start = start;
+	unsigned long old_end = end;
+	unsigned long flags;
+	line_size = L1_cache_info[DCACHE].line_size;
+	start = start & (~(line_size - 1));
+	end = (end + line_size - 1) & (~(line_size - 1));
+	if (unlikely(start == end))
+		return;
+	local_irq_save(flags);
+	if (start != old_start) {
+		cpu_dcache_wbinval_range(start, start + line_size);
+		if (IS_ENABLED(CONFIG_CACHE_L2)) {
+			if (atl2c_base)
+				cpu_l2dcache_wbinval_range(start, start + line_size);
+		}
+	}
+	if (end != old_end) {
+		cpu_dcache_wbinval_range(end - line_size, end);
+		if (IS_ENABLED(CONFIG_CACHE_L2)) {
+			if (atl2c_base)
+				cpu_l2dcache_wbinval_range(end - line_size, end);
+		}
+	}
+	cpu_dcache_inval_range(start, end);
+	if (IS_ENABLED(CONFIG_CACHE_L2)) {
+		if (atl2c_base) {
+			unsigned long p_start = __pa(start);
+			unsigned long p_end = __pa(end);
+			unsigned long cmd;
+			/* TODO Can Use PAGE Mode to optimize if range large than PAGE_SIZE */
+			line_size = L2_CACHE_LINE_SIZE();
+			p_start = p_start & (~(line_size - 1));
+			p_end = (p_end + line_size - 1) & (~(line_size - 1));
+			cmd =
+			    (p_start & ~(line_size - 1)) | CCTL_CMD_L2_PA_INVAL |
+			    CCTL_SINGLE_CMD;
+			do {
+				L2_CMD_RDY();
+				L2C_W_REG(L2_CCTL_CMD_OFF, cmd);
+				cmd += line_size;
+				p_start += line_size;
+			} while (p_end > p_start);
+			cmd = CCTL_CMD_L2_SYNC;
+			L2_CMD_RDY();
+			L2C_W_REG(L2_CCTL_CMD_OFF, cmd);
+			L2_CMD_RDY();
+		}
+	}
+	local_irq_restore(flags);
+
+}
+
+void cpu_dma_wbinval_range(unsigned long start, unsigned long end)
+{
+	unsigned long line_size;
+	unsigned long flags;
+	line_size = L1_cache_info[DCACHE].line_size;
+	start = start & (~(line_size - 1));
+	end = (end + line_size - 1) & (~(line_size - 1));
+	if (unlikely(start == end))
+		return;
+
+	local_irq_save(flags);
+	cpu_dcache_wbinval_range(start, end);
+	if (IS_ENABLED(CONFIG_CACHE_L2)) {
+		if (atl2c_base) {
+			unsigned long p_start = __pa(start);
+			unsigned long p_end = __pa(end);
+			unsigned long cmd;
+
+			/* TODO Can Use PAGE Mode to optimize if range large than PAGE_SIZE */
+			line_size = L2_CACHE_LINE_SIZE();
+			p_start = p_start & (~(line_size - 1));
+			p_end = (p_end + line_size - 1) & (~(line_size - 1));
+			cmd =
+			    (p_start & ~(line_size - 1)) | CCTL_CMD_L2_PA_WBINVAL |
+			    CCTL_SINGLE_CMD;
+			do {
+				L2_CMD_RDY();
+				L2C_W_REG(L2_CCTL_CMD_OFF, cmd);
+				cmd += line_size;
+				p_start += line_size;
+			} while (p_end > p_start);
+			cmd = CCTL_CMD_L2_SYNC;
+			L2_CMD_RDY();
+			L2C_W_REG(L2_CCTL_CMD_OFF, cmd);
+			L2_CMD_RDY();
+		}
+	}
+	local_irq_restore(flags);
+}
+
+void cpu_proc_init(void)
+{
+}
+
+void cpu_proc_fin(void)
+{
+}
+
+void cpu_do_idle(void)
+{
+	__nds32__standby_no_wake_grant();
+}
+
+void cpu_reset(unsigned long reset)
+{
+	u32 tmp;
+	GIE_DISABLE();
+	tmp = __nds32__mfsr(NDS32_SR_CACHE_CTL);
+	tmp &= ~(CACHE_CTL_mskIC_EN | CACHE_CTL_mskDC_EN);
+	__nds32__mtsr_isb(tmp, NDS32_SR_CACHE_CTL);
+	cpu_dcache_wbinval_all();
+	cpu_icache_inval_all();
+
+	__asm__ __volatile__("jr.toff %0\n\t"::"r"(reset));
+}
+
+void cpu_switch_mm(struct mm_struct *mm)
+{
+	unsigned long cid;
+	cid = __nds32__mfsr(NDS32_SR_TLB_MISC);
+	cid = (cid & ~TLB_MISC_mskCID) | mm->context.id;
+	__nds32__mtsr_dsb(cid, NDS32_SR_TLB_MISC);
+	__nds32__mtsr_isb(__pa(mm->pgd), NDS32_SR_L1_PPTB);
+}
diff --git a/arch/nds32/mm/tlb.c b/arch/nds32/mm/tlb.c
new file mode 100644
index 0000000..b397b9f
--- /dev/null
+++ b/arch/nds32/mm/tlb.c
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/spinlock_types.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <asm/nds32.h>
+#include <nds32_intrinsic.h>
+
+unsigned int cpu_last_cid = { TLB_MISC_mskCID + (2 << TLB_MISC_offCID) };
+
+DEFINE_SPINLOCK(cid_lock);
+
+void local_flush_tlb_range(struct vm_area_struct *vma,
+			   unsigned long start, unsigned long end)
+{
+	unsigned long flags, ocid, ncid;
+
+	if ((end - start) > 0x400000) {
+		__nds32__tlbop_flua();
+		__nds32__isb();
+		return;
+	}
+
+	spin_lock_irqsave(&cid_lock, flags);
+	ocid = __nds32__mfsr(NDS32_SR_TLB_MISC);
+	ncid = (ocid & ~TLB_MISC_mskCID) | vma->vm_mm->context.id;
+	__nds32__mtsr_dsb(ncid, NDS32_SR_TLB_MISC);
+	while (start < end) {
+		__nds32__tlbop_inv(start);
+		__nds32__isb();
+		start += PAGE_SIZE;
+	}
+	__nds32__mtsr_dsb(ocid, NDS32_SR_TLB_MISC);
+	spin_unlock_irqrestore(&cid_lock, flags);
+}
+
+void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
+{
+	unsigned long flags, ocid, ncid;
+
+	spin_lock_irqsave(&cid_lock, flags);
+	ocid = __nds32__mfsr(NDS32_SR_TLB_MISC);
+	ncid = (ocid & ~TLB_MISC_mskCID) | vma->vm_mm->context.id;
+	__nds32__mtsr_dsb(ncid, NDS32_SR_TLB_MISC);
+	__nds32__tlbop_inv(addr);
+	__nds32__isb();
+	__nds32__mtsr_dsb(ocid, NDS32_SR_TLB_MISC);
+	spin_unlock_irqrestore(&cid_lock, flags);
+}
-- 
1.7.9.5
