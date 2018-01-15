From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v6 10/36] nds32: MMU fault handling and page table management
Date: Mon, 15 Jan 2018 13:53:18 +0800
Message-ID: <baad6ca0d7c2b2d1e2d91b9bb6735b50d886de95.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45973 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932634AbeAOFyx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 00:54:53 -0500
In-Reply-To: <cover.1515766253.git.green.hu@gmail.com>
In-Reply-To: <cover.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>

From: Greentime Hu <greentime@andestech.com>

This patch includes page fault handler, mmap and fixup implementations.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/lib/copy_page.S |   37 ++++
 arch/nds32/mm/extable.c    |   16 ++
 arch/nds32/mm/fault.c      |  410 ++++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/mm/mmap.c       |   73 ++++++++
 4 files changed, 536 insertions(+)
 create mode 100644 arch/nds32/lib/copy_page.S
 create mode 100644 arch/nds32/mm/extable.c
 create mode 100644 arch/nds32/mm/fault.c
 create mode 100644 arch/nds32/mm/mmap.c

diff --git a/arch/nds32/lib/copy_page.S b/arch/nds32/lib/copy_page.S
new file mode 100644
index 0000000..4a2ff85
--- /dev/null
+++ b/arch/nds32/lib/copy_page.S
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/linkage.h>
+#include <asm/page.h>
+
+	.text
+ENTRY(copy_page)
+	pushm	$r2, $r10
+	movi	$r2, PAGE_SIZE >> 5
+.Lcopy_loop:
+	lmw.bim	$r3, [$r1], $r10
+	smw.bim	$r3, [$r0], $r10
+	subi45	$r2, #1
+	bnez38	$r2, .Lcopy_loop
+	popm	$r2, $r10
+	ret
+ENDPROC(copy_page)
+
+ENTRY(clear_page)
+	pushm	$r1, $r9
+	movi	$r1, PAGE_SIZE >> 5
+	movi55	$r2, #0
+	movi55	$r3, #0
+	movi55	$r4, #0
+	movi55	$r5, #0
+	movi55	$r6, #0
+	movi55	$r7, #0
+	movi55	$r8, #0
+	movi55	$r9, #0
+.Lclear_loop:
+	smw.bim	$r2, [$r0], $r9
+	subi45	$r1, #1
+	bnez38	$r1, .Lclear_loop
+	popm	$r1, $r9
+        ret
+ENDPROC(clear_page)
diff --git a/arch/nds32/mm/extable.c b/arch/nds32/mm/extable.c
new file mode 100644
index 0000000..db7f0a7
--- /dev/null
+++ b/arch/nds32/mm/extable.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/extable.h>
+#include <linux/uaccess.h>
+
+int fixup_exception(struct pt_regs *regs)
+{
+	const struct exception_table_entry *fixup;
+
+	fixup = search_exception_tables(instruction_pointer(regs));
+	if (fixup)
+		regs->ipc = fixup->fixup;
+
+	return fixup != NULL;
+}
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
new file mode 100644
index 0000000..3a246fb
--- /dev/null
+++ b/arch/nds32/mm/fault.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/extable.h>
+#include <linux/module.h>
+#include <linux/signal.h>
+#include <linux/ptrace.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/hardirq.h>
+#include <linux/uaccess.h>
+
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+
+extern void die(const char *str, struct pt_regs *regs, long err);
+
+/*
+ * This is useful to dump out the page tables associated with
+ * 'addr' in mm 'mm'.
+ */
+void show_pte(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	if (!mm)
+		mm = &init_mm;
+
+	pr_alert("pgd = %p\n", mm->pgd);
+	pgd = pgd_offset(mm, addr);
+	pr_alert("[%08lx] *pgd=%08lx", addr, pgd_val(*pgd));
+
+	do {
+		pmd_t *pmd;
+
+		if (pgd_none(*pgd))
+			break;
+
+		if (pgd_bad(*pgd)) {
+			pr_alert("(bad)");
+			break;
+		}
+
+		pmd = pmd_offset(pgd, addr);
+#if PTRS_PER_PMD != 1
+		pr_alert(", *pmd=%08lx", pmd_val(*pmd));
+#endif
+
+		if (pmd_none(*pmd))
+			break;
+
+		if (pmd_bad(*pmd)) {
+			pr_alert("(bad)");
+			break;
+		}
+
+		if (IS_ENABLED(CONFIG_HIGHMEM))
+		{
+			pte_t *pte;
+			/* We must not map this if we have highmem enabled */
+			pte = pte_offset_map(pmd, addr);
+			pr_alert(", *pte=%08lx", pte_val(*pte));
+			pte_unmap(pte);
+		}
+	} while (0);
+
+	pr_alert("\n");
+}
+
+void do_page_fault(unsigned long entry, unsigned long addr,
+		   unsigned int error_code, struct pt_regs *regs)
+{
+	struct task_struct *tsk;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	siginfo_t info;
+	int fault;
+	unsigned int mask = VM_READ | VM_WRITE | VM_EXEC;
+	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+
+	error_code = error_code & (ITYPE_mskINST | ITYPE_mskETYPE);
+	tsk = current;
+	mm = tsk->mm;
+	info.si_code = SEGV_MAPERR;
+	/*
+	 * We fault-in kernel-space virtual memory on-demand. The
+	 * 'reference' page table is init_mm.pgd.
+	 *
+	 * NOTE! We MUST NOT take any locks for this case. We may
+	 * be in an interrupt or a critical region, and should
+	 * only copy the information from the master page table,
+	 * nothing more.
+	 */
+	if (addr >= TASK_SIZE) {
+		if (user_mode(regs))
+			goto bad_area_nosemaphore;
+
+		if (addr >= TASK_SIZE && addr < VMALLOC_END
+		    && (entry == ENTRY_PTE_NOT_PRESENT))
+			goto vmalloc_fault;
+		else
+			goto no_context;
+	}
+
+	/* Send a signal to the task for handling the unalignment access. */
+	if (entry == ENTRY_GENERAL_EXCPETION
+	    && error_code == ETYPE_ALIGNMENT_CHECK) {
+		if (user_mode(regs))
+			goto bad_area_nosemaphore;
+		else
+			goto no_context;
+	}
+
+	/*
+	 * If we're in an interrupt or have no user
+	 * context, we must not take the fault..
+	 */
+	if (unlikely(faulthandler_disabled() || !mm))
+		goto no_context;
+
+	/*
+	 * As per x86, we may deadlock here. However, since the kernel only
+	 * validly references user space from well defined areas of the code,
+	 * we can bug out early if this is from code which shouldn't.
+	 */
+	if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
+		if (!user_mode(regs) &&
+		    !search_exception_tables(instruction_pointer(regs)))
+			goto no_context;
+retry:
+		down_read(&mm->mmap_sem);
+	} else {
+		/*
+		 * The above down_read_trylock() might have succeeded in which
+		 * case, we'll have missed the might_sleep() from down_read().
+		 */
+		might_sleep();
+		if (IS_ENABLED(CONFIG_DEBUG_VM)) {
+			if (!user_mode(regs) &&
+			    !search_exception_tables(instruction_pointer(regs)))
+				goto no_context;
+		}
+	}
+
+	vma = find_vma(mm, addr);
+
+	if (unlikely(!vma))
+		goto bad_area;
+
+	if (vma->vm_start <= addr)
+		goto good_area;
+
+	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
+		goto bad_area;
+
+	if (unlikely(expand_stack(vma, addr)))
+		goto bad_area;
+
+	/*
+	 * Ok, we have a good vm_area for this memory access, so
+	 * we can handle it..
+	 */
+
+good_area:
+	info.si_code = SEGV_ACCERR;
+
+	/* first do some preliminary protection checks */
+	if (entry == ENTRY_PTE_NOT_PRESENT) {
+		if (error_code & ITYPE_mskINST)
+			mask = VM_EXEC;
+		else {
+			mask = VM_READ | VM_WRITE;
+			if (vma->vm_flags & VM_WRITE)
+				flags |= FAULT_FLAG_WRITE;
+		}
+	} else if (entry == ENTRY_TLB_MISC) {
+		switch (error_code & ITYPE_mskETYPE) {
+		case RD_PROT:
+			mask = VM_READ;
+			break;
+		case WRT_PROT:
+			mask = VM_WRITE;
+			flags |= FAULT_FLAG_WRITE;
+			break;
+		case NOEXEC:
+			mask = VM_EXEC;
+			break;
+		case PAGE_MODIFY:
+			mask = VM_WRITE;
+			flags |= FAULT_FLAG_WRITE;
+			break;
+		case ACC_BIT:
+			BUG();
+		default:
+			break;
+		}
+
+	}
+	if (!(vma->vm_flags & mask))
+		goto bad_area;
+
+	/*
+	 * If for any reason at all we couldn't handle the fault,
+	 * make sure we exit gracefully rather than endlessly redo
+	 * the fault.
+	 */
+
+	fault = handle_mm_fault(vma, addr, flags);
+
+	/*
+	 * If we need to retry but a fatal signal is pending, handle the
+	 * signal first. We do not need to release the mmap_sem because it
+	 * would already be released in __lock_page_or_retry in mm/filemap.c.
+	 */
+	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
+		if (!user_mode(regs))
+			goto no_context;
+		return;
+	}
+
+	if (unlikely(fault & VM_FAULT_ERROR)) {
+		if (fault & VM_FAULT_OOM)
+			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGBUS)
+			goto do_sigbus;
+		else
+			goto bad_area;
+	}
+
+	/*
+	 * Major/minor page fault accounting is only done on the initial
+	 * attempt. If we go through a retry, it is extremely likely that the
+	 * page will be found in page cache at that point.
+	 */
+	if (flags & FAULT_FLAG_ALLOW_RETRY) {
+		if (fault & VM_FAULT_MAJOR)
+			tsk->maj_flt++;
+		else
+			tsk->min_flt++;
+		if (fault & VM_FAULT_RETRY) {
+			flags &= ~FAULT_FLAG_ALLOW_RETRY;
+			flags |= FAULT_FLAG_TRIED;
+
+			/* No need to up_read(&mm->mmap_sem) as we would
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
+	 * Something tried to access memory that isn't in our memory map..
+	 * Fix it, but check if it's kernel or user first..
+	 */
+bad_area:
+	up_read(&mm->mmap_sem);
+
+bad_area_nosemaphore:
+
+	/* User mode accesses just cause a SIGSEGV */
+
+	if (user_mode(regs)) {
+		tsk->thread.address = addr;
+		tsk->thread.error_code = error_code;
+		tsk->thread.trap_no = entry;
+		info.si_signo = SIGSEGV;
+		info.si_errno = 0;
+		/* info.si_code has been set above */
+		info.si_addr = (void *)addr;
+		force_sig_info(SIGSEGV, &info, tsk);
+		return;
+	}
+
+no_context:
+
+	/* Are we prepared to handle this kernel fault?
+	 *
+	 * (The kernel has valid exception-points in the source
+	 *  when it acesses user-memory. When it fails in one
+	 *  of those points, we find it in a table and do a jump
+	 *  to some fixup code that loads an appropriate error
+	 *  code)
+	 */
+
+	{
+		const struct exception_table_entry *entry;
+
+		if ((entry =
+		     search_exception_tables(instruction_pointer(regs))) !=
+		    NULL) {
+			/* Adjust the instruction pointer in the stackframe */
+			instruction_pointer(regs) = entry->fixup;
+			return;
+		}
+	}
+
+	/*
+	 * Oops. The kernel tried to access some bad page. We'll have to
+	 * terminate things with extreme prejudice.
+	 */
+
+	bust_spinlocks(1);
+	pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
+		 (addr < PAGE_SIZE) ? "NULL pointer dereference" :
+		 "paging request", addr);
+
+	show_pte(mm, addr);
+	die("Oops", regs, error_code);
+	bust_spinlocks(0);
+	do_exit(SIGKILL);
+
+	return;
+
+	/*
+	 * We ran out of memory, or some other thing happened to us that made
+	 * us unable to handle the page fault gracefully.
+	 */
+
+out_of_memory:
+	up_read(&mm->mmap_sem);
+	if (!user_mode(regs))
+		goto no_context;
+	pagefault_out_of_memory();
+	return;
+
+do_sigbus:
+	up_read(&mm->mmap_sem);
+
+	/* Kernel mode? Handle exceptions or die */
+	if (!user_mode(regs))
+		goto no_context;
+
+	/*
+	 * Send a sigbus
+	 */
+	tsk->thread.address = addr;
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_no = entry;
+	info.si_signo = SIGBUS;
+	info.si_errno = 0;
+	info.si_code = BUS_ADRERR;
+	info.si_addr = (void *)addr;
+	force_sig_info(SIGBUS, &info, tsk);
+
+	return;
+
+vmalloc_fault:
+	{
+		/*
+		 * Synchronize this task's top level page-table
+		 * with the 'reference' page table.
+		 *
+		 * Use current_pgd instead of tsk->active_mm->pgd
+		 * since the latter might be unavailable if this
+		 * code is executed in a misfortunately run irq
+		 * (like inside schedule() between switch_mm and
+		 *  switch_to...).
+		 */
+
+		unsigned int index = pgd_index(addr);
+		pgd_t *pgd, *pgd_k;
+		pud_t *pud, *pud_k;
+		pmd_t *pmd, *pmd_k;
+		pte_t *pte_k;
+
+		pgd = (pgd_t *) __va(__nds32__mfsr(NDS32_SR_L1_PPTB)) + index;
+		pgd_k = init_mm.pgd + index;
+
+		if (!pgd_present(*pgd_k))
+			goto no_context;
+
+		pud = pud_offset(pgd, addr);
+		pud_k = pud_offset(pgd_k, addr);
+		if (!pud_present(*pud_k))
+			goto no_context;
+
+		pmd = pmd_offset(pud, addr);
+		pmd_k = pmd_offset(pud_k, addr);
+		if (!pmd_present(*pmd_k))
+			goto no_context;
+
+		if (!pmd_present(*pmd))
+			set_pmd(pmd, *pmd_k);
+		else
+			BUG_ON(pmd_page(*pmd) != pmd_page(*pmd_k));
+
+		/*
+		 * Since the vmalloc area is global, we don't
+		 * need to copy individual PTE's, it is enough to
+		 * copy the pgd pointer into the pte page of the
+		 * root task. If that is there, we'll find our pte if
+		 * it exists.
+		 */
+
+		/* Make sure the actual PTE exists as well to
+		 * catch kernel vmalloc-area accesses to non-mapped
+		 * addres. If we don't do this, this will just
+		 * silently loop forever.
+		 */
+
+		pte_k = pte_offset_kernel(pmd_k, addr);
+		if (!pte_present(*pte_k))
+			goto no_context;
+
+		return;
+	}
+}
diff --git a/arch/nds32/mm/mmap.c b/arch/nds32/mm/mmap.c
new file mode 100644
index 0000000..c206b31
--- /dev/null
+++ b/arch/nds32/mm/mmap.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/sched.h>
+#include <linux/mman.h>
+#include <linux/shm.h>
+
+#define COLOUR_ALIGN(addr,pgoff)		\
+	((((addr)+SHMLBA-1)&~(SHMLBA-1)) +	\
+	 (((pgoff)<<PAGE_SHIFT) & (SHMLBA-1)))
+
+/*
+ * We need to ensure that shared mappings are correctly aligned to
+ * avoid aliasing issues with VIPT caches.  We need to ensure that
+ * a specific page of an object is always mapped at a multiple of
+ * SHMLBA bytes.
+ *
+ * We unconditionally provide this function for all cases, however
+ * in the VIVT case, we optimise out the alignment rules.
+ */
+unsigned long
+arch_get_unmapped_area(struct file *filp, unsigned long addr,
+		       unsigned long len, unsigned long pgoff,
+		       unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	int do_align = 0;
+	struct vm_unmapped_area_info info;
+	int aliasing = 0;
+	if(IS_ENABLED(CONFIG_CPU_CACHE_ALIASING))
+		aliasing = 1;
+
+	/*
+	 * We only need to do colour alignment if either the I or D
+	 * caches alias.
+	 */
+	if (aliasing)
+		do_align = filp || (flags & MAP_SHARED);
+
+	/*
+	 * We enforce the MAP_FIXED case.
+	 */
+	if (flags & MAP_FIXED) {
+		if (aliasing && flags & MAP_SHARED &&
+		    (addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1))
+			return -EINVAL;
+		return addr;
+	}
+
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	if (addr) {
+		if (do_align)
+			addr = COLOUR_ALIGN(addr, pgoff);
+		else
+			addr = PAGE_ALIGN(addr);
+
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = mm->mmap_base;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
+	return vm_unmapped_area(&info);
+}
-- 
1.7.9.5
