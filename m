From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 15/17] RISC-V: Add mm subdirectory
Date: Tue,  6 Jun 2017 16:00:05 -0700
Message-ID: <20170606230007.19101-16-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33572 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbdFFXBp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2017 19:01:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id f27so25611842pfe.0
        for <linux-arch@vger.kernel.org>; Tue, 06 Jun 2017 16:01:40 -0700 (PDT)
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, Palmer Dabbelt <palmer@dabbelt.com>

These files are mostly based on the score port, but as all the non-stub
functions are very ISA specific they've been heavily modified.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/mm/Makefile  |   1 +
 arch/riscv/mm/extable.c |  37 +++++++
 arch/riscv/mm/fault.c   | 280 ++++++++++++++++++++++++++++++++++++++++++++++++
 arch/riscv/mm/init.c    |  72 +++++++++++++
 arch/riscv/mm/ioremap.c |  93 ++++++++++++++++
 5 files changed, 483 insertions(+)
 create mode 100644 arch/riscv/mm/Makefile
 create mode 100644 arch/riscv/mm/extable.c
 create mode 100644 arch/riscv/mm/fault.c
 create mode 100644 arch/riscv/mm/init.c
 create mode 100644 arch/riscv/mm/ioremap.c

diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
new file mode 100644
index 000000000000..36ebe6feb5d6
--- /dev/null
+++ b/arch/riscv/mm/Makefile
@@ -0,0 +1 @@
+obj-y := init.o fault.o extable.o ioremap.o
diff --git a/arch/riscv/mm/extable.c b/arch/riscv/mm/extable.c
new file mode 100644
index 000000000000..11bb9417123b
--- /dev/null
+++ b/arch/riscv/mm/extable.c
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2009 Sunplus Core Technology Co., Ltd.
+ *  Lennox Wu <lennox.wu@sunplusct.com>
+ *  Chen Liqin <liqin.chen@sunplusct.com>
+ * Copyright (C) 2013 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ */
+
+
+#include <linux/extable.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+
+int fixup_exception(struct pt_regs *regs)
+{
+	const struct exception_table_entry *fixup;
+
+	fixup = search_exception_tables(regs->sepc);
+	if (fixup) {
+		regs->sepc = fixup->fixup;
+		return 1;
+	}
+	return 0;
+}
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
new file mode 100644
index 000000000000..b2a431c7f233
--- /dev/null
+++ b/arch/riscv/mm/fault.c
@@ -0,0 +1,280 @@
+/*
+ * Copyright (C) 2009 Sunplus Core Technology Co., Ltd.
+ *  Lennox Wu <lennox.wu@sunplusct.com>
+ *  Chen Liqin <liqin.chen@sunplusct.com>
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ */
+
+
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/perf_event.h>
+#include <linux/signal.h>
+#include <linux/uaccess.h>
+
+#include <asm/pgalloc.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+
+/*
+ * This routine handles page faults.  It determines the address and the
+ * problem, and then passes it off to one of the appropriate routines.
+ */
+asmlinkage void do_page_fault(struct pt_regs *regs)
+{
+	struct task_struct *tsk;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+	unsigned long addr, cause;
+	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	int fault, code = SEGV_MAPERR;
+
+	cause = regs->scause;
+	addr = regs->sbadaddr;
+
+	tsk = current;
+	mm = tsk->mm;
+
+	/*
+	 * Fault-in kernel-space virtual memory on-demand.
+	 * The 'reference' page table is init_mm.pgd.
+	 *
+	 * NOTE! We MUST NOT take any locks for this case. We may
+	 * be in an interrupt or a critical region, and should
+	 * only copy the information from the master page table,
+	 * nothing more.
+	 */
+	if (unlikely((addr >= VMALLOC_START) && (addr <= VMALLOC_END)))
+		goto vmalloc_fault;
+
+	/* Enable interrupts if they were enabled in the parent context. */
+	if (likely(regs->sstatus & SR_PIE))
+		local_irq_enable();
+
+	/*
+	 * If we're in an interrupt, have no user context, or are running
+	 * in an atomic region, then we must not take the fault.
+	 */
+	if (unlikely(faulthandler_disabled() || !mm))
+		goto no_context;
+
+	if (user_mode(regs))
+		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
+
+retry:
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, addr);
+	if (unlikely(!vma))
+		goto bad_area;
+	if (likely(vma->vm_start <= addr))
+		goto good_area;
+	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
+		goto bad_area;
+	if (unlikely(expand_stack(vma, addr)))
+		goto bad_area;
+
+	/*
+	 * Ok, we have a good vm_area for this memory access, so
+	 * we can handle it.
+	 */
+good_area:
+	code = SEGV_ACCERR;
+
+	switch (cause) {
+	case EXC_INST_PAGE_FAULT:
+		if (!(vma->vm_flags & VM_EXEC))
+			goto bad_area;
+		break;
+	case EXC_LOAD_PAGE_FAULT:
+		if (!(vma->vm_flags & VM_READ))
+			goto bad_area;
+		break;
+	case EXC_STORE_PAGE_FAULT:
+		if (!(vma->vm_flags & VM_WRITE))
+			goto bad_area;
+		flags |= FAULT_FLAG_WRITE;
+		break;
+	default:
+		panic("%s: unhandled cause %lu", __func__, cause);
+	}
+
+	/*
+	 * If for any reason at all we could not handle the fault,
+	 * make sure we exit gracefully rather than endlessly redo
+	 * the fault.
+	 */
+	fault = handle_mm_fault(vma, addr, flags);
+
+	/*
+	 * If we need to retry but a fatal signal is pending, handle the
+	 * signal first. We do not need to release the mmap_sem because it
+	 * would already be released in __lock_page_or_retry in mm/filemap.c.
+	 */
+	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(tsk))
+		return;
+
+	if (unlikely(fault & VM_FAULT_ERROR)) {
+		if (fault & VM_FAULT_OOM)
+			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGBUS)
+			goto do_sigbus;
+		BUG();
+	}
+
+	/*
+	 * Major/minor page fault accounting is only done on the
+	 * initial attempt. If we go through a retry, it is extremely
+	 * likely that the page will be found in page cache at that point.
+	 */
+	if (flags & FAULT_FLAG_ALLOW_RETRY) {
+		if (fault & VM_FAULT_MAJOR) {
+			tsk->maj_flt++;
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
+				      1, regs, addr);
+		} else {
+			tsk->min_flt++;
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
+				      1, regs, addr);
+		}
+		if (fault & VM_FAULT_RETRY) {
+			/*
+			 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
+			 * of starvation.
+			 */
+			flags &= ~(FAULT_FLAG_ALLOW_RETRY);
+			flags |= FAULT_FLAG_TRIED;
+
+			/*
+			 * No need to up_read(&mm->mmap_sem) as we would
+			 * have already released it in __lock_page_or_retry
+			 * in mm/filemap.c.
+			 */
+			goto retry;
+		}
+	}
+
+	up_read(&mm->mmap_sem);
+	return;
+
+	/*
+	 * Something tried to access memory that isn't in our memory map.
+	 * Fix it, but check if it's kernel or user first.
+	 */
+bad_area:
+	up_read(&mm->mmap_sem);
+	/* User mode accesses just cause a SIGSEGV */
+	if (user_mode(regs)) {
+		do_trap(regs, SIGSEGV, code, addr, tsk);
+		return;
+	}
+
+no_context:
+	/* Are we prepared to handle this kernel fault? */
+	if (fixup_exception(regs))
+		return;
+
+	/*
+	 * Oops. The kernel tried to access some bad page. We'll have to
+	 * terminate things with extreme prejudice.
+	 */
+	bust_spinlocks(1);
+	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n",
+		(addr < PAGE_SIZE) ? "NULL pointer dereference" :
+		"paging request", addr);
+	die(regs, "Oops");
+	do_exit(SIGKILL);
+
+	/*
+	 * We ran out of memory, call the OOM killer, and return the userspace
+	 * (which will retry the fault, or kill us if we got oom-killed).
+	 */
+out_of_memory:
+	up_read(&mm->mmap_sem);
+	if (!user_mode(regs))
+		goto no_context;
+	pagefault_out_of_memory();
+	return;
+
+do_sigbus:
+	up_read(&mm->mmap_sem);
+	/* Kernel mode? Handle exceptions or die */
+	if (!user_mode(regs))
+		goto no_context;
+	do_trap(regs, SIGBUS, BUS_ADRERR, addr, tsk);
+	return;
+
+vmalloc_fault:
+	{
+		pgd_t *pgd, *pgd_k;
+		pud_t *pud, *pud_k;
+		p4d_t *p4d, *p4d_k;
+		pmd_t *pmd, *pmd_k;
+		pte_t *pte_k;
+		int index;
+
+		if (user_mode(regs))
+			goto bad_area;
+
+		/*
+		 * Synchronize this task's top level page-table
+		 * with the 'reference' page table.
+		 *
+		 * Do _not_ use "tsk->active_mm->pgd" here.
+		 * We might be inside an interrupt in the middle
+		 * of a task switch.
+		 */
+		index = pgd_index(addr);
+		pgd = (pgd_t *)pfn_to_virt(csr_read(sptbr)) + index;
+		pgd_k = init_mm.pgd + index;
+
+		if (!pgd_present(*pgd_k))
+			goto no_context;
+		set_pgd(pgd, *pgd_k);
+
+		p4d = p4d_offset(pgd, addr);
+		p4d_k = p4d_offset(pgd_k, addr);
+		if (!p4d_present(*p4d_k))
+			goto no_context;
+
+		pud = pud_offset(p4d, addr);
+		pud_k = pud_offset(p4d_k, addr);
+		if (!pud_present(*pud_k))
+			goto no_context;
+
+		/* Since the vmalloc area is global, it is unnecessary
+		 * to copy individual PTEs
+		 */
+		pmd = pmd_offset(pud, addr);
+		pmd_k = pmd_offset(pud_k, addr);
+		if (!pmd_present(*pmd_k))
+			goto no_context;
+		set_pmd(pmd, *pmd_k);
+
+		/* Make sure the actual PTE exists as well to
+		 * catch kernel vmalloc-area accesses to non-mapped
+		 * addresses. If we don't do this, this will just
+		 * silently loop forever.
+		 */
+		pte_k = pte_offset_kernel(pmd_k, addr);
+		if (!pte_present(*pte_k))
+			goto no_context;
+		return;
+	}
+}
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
new file mode 100644
index 000000000000..8ad464ce4a4c
--- /dev/null
+++ b/arch/riscv/mm/init.c
@@ -0,0 +1,72 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/initrd.h>
+#include <linux/memblock.h>
+#include <linux/swap.h>
+
+#include <asm/tlbflush.h>
+#include <asm/sections.h>
+#include <asm/pgtable.h>
+#include <asm/io.h>
+
+static void __init zone_sizes_init(void)
+{
+	unsigned long zones_size[MAX_NR_ZONES];
+
+	memset(zones_size, 0, sizeof(zones_size));
+	zones_size[ZONE_NORMAL] = pfn_base + max_mapnr;
+	free_area_init_node(0, zones_size, pfn_base, NULL);
+}
+
+void setup_zero_page(void)
+{
+	memset((void *)empty_zero_page, 0, PAGE_SIZE);
+}
+
+void __init paging_init(void)
+{
+	init_mm.pgd = (pgd_t *)pfn_to_virt(csr_read(sptbr));
+
+	setup_zero_page();
+	local_flush_tlb_all();
+	zone_sizes_init();
+}
+
+void __init mem_init(void)
+{
+#ifdef CONFIG_FLATMEM
+	BUG_ON(!mem_map);
+#endif /* CONFIG_FLATMEM */
+
+	high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
+	free_all_bootmem();
+
+	mem_init_print_info(NULL);
+}
+
+void free_initmem(void)
+{
+	free_initmem_default(0);
+}
+
+#ifdef CONFIG_BLK_DEV_INITRD
+void free_initrd_mem(unsigned long start, unsigned long end)
+{
+//	free_reserved_area(start, end, 0, "initrd");
+}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
diff --git a/arch/riscv/mm/ioremap.c b/arch/riscv/mm/ioremap.c
new file mode 100644
index 000000000000..c5cc0935096d
--- /dev/null
+++ b/arch/riscv/mm/ioremap.c
@@ -0,0 +1,93 @@
+/*
+ * (C) Copyright 1995 1996 Linus Torvalds
+ * (C) Copyright 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/io.h>
+
+#include <asm/pgtable.h>
+
+/*
+ * Remap an arbitrary physical address space into the kernel virtual
+ * address space. Needed when the kernel wants to access high addresses
+ * directly.
+ *
+ * NOTE! We need to allow non-page-aligned mappings too: we will obviously
+ * have to convert them into an offset in a page-aligned mapping, but the
+ * caller shouldn't need to know that small detail.
+ */
+static void __iomem *__ioremap_caller(phys_addr_t addr, size_t size,
+	pgprot_t prot, void *caller)
+{
+	phys_addr_t last_addr;
+	unsigned long offset, vaddr;
+	struct vm_struct *area;
+
+	/* Disallow wrap-around or zero size */
+	last_addr = addr + size - 1;
+	if (!size || last_addr < addr)
+		return NULL;
+
+	/* Page-align mappings */
+	offset = addr & (~PAGE_MASK);
+	addr &= PAGE_MASK;
+	size = PAGE_ALIGN(size + offset);
+
+	area = get_vm_area_caller(size, VM_IOREMAP, caller);
+	if (!area)
+		return NULL;
+	vaddr = (unsigned long)area->addr;
+
+	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
+		free_vm_area(area);
+		return NULL;
+	}
+
+	return (void __iomem *)(vaddr + offset);
+}
+
+/*
+ * ioremap     -   map bus memory into CPU space
+ * @offset:    bus address of the memory
+ * @size:      size of the resource to map
+ *
+ * ioremap performs a platform specific sequence of operations to
+ * make bus memory CPU accessible via the readb/readw/readl/writeb/
+ * writew/writel functions and the other mmio helpers. The returned
+ * address is not guaranteed to be usable directly as a virtual
+ * address.
+ *
+ * Must be freed with iounmap.
+ */
+void __iomem *ioremap(phys_addr_t offset, unsigned long size)
+{
+	return __ioremap_caller(offset, size, PAGE_KERNEL,
+		__builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap);
+
+
+/**
+ * iounmap - Free a IO remapping
+ * @addr: virtual address from ioremap_*
+ *
+ * Caller must ensure there is only one unmapping for the same pointer.
+ */
+void iounmap(void __iomem *addr)
+{
+	vunmap((void *)((unsigned long)addr & PAGE_MASK));
+}
+EXPORT_SYMBOL(iounmap);
+
-- 
2.13.0
