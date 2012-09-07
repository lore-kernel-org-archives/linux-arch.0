Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34240 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab2IGQ1w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:52 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 06/31] arm64: MMU fault handling and page table management
Date: Fri,  7 Sep 2012 17:26:41 +0100
Message-ID: <1347035226-18649-7-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120907162641.1Jm-f1MdhaBpjA27MAM2nB2W45JNHe2QdlbzGFu-jxM@z>

This patch adds support for the handling of the MMU faults (exception
entry code introduced by a previous patch) and page table management.

The user translation table is pointed to by TTBR0 and the kernel one
(swapper_pg_dir) by TTBR1. There is no translation information shared or
address space overlapping between user and kernel page tables.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/include/asm/page.h    |   67 +++++
 arch/arm64/include/asm/pgalloc.h |  113 ++++++++
 arch/arm64/mm/copypage.c         |   34 +++
 arch/arm64/mm/extable.c          |   17 ++
 arch/arm64/mm/fault.c            |  534 ++++++++++++++++++++++++++++++++++=
++++
 arch/arm64/mm/mm.h               |    2 +
 arch/arm64/mm/mmap.c             |  144 ++++++++++
 arch/arm64/mm/pgd.c              |   54 ++++
 8 files changed, 965 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/page.h
 create mode 100644 arch/arm64/include/asm/pgalloc.h
 create mode 100644 arch/arm64/mm/copypage.c
 create mode 100644 arch/arm64/mm/extable.c
 create mode 100644 arch/arm64/mm/fault.c
 create mode 100644 arch/arm64/mm/mm.h
 create mode 100644 arch/arm64/mm/mmap.c
 create mode 100644 arch/arm64/mm/pgd.c

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
new file mode 100644
index 0000000..46bf666
--- /dev/null
+++ b/arch/arm64/include/asm/page.h
@@ -0,0 +1,67 @@
+/*
+ * Based on arch/arm/include/asm/page.h
+ *
+ * Copyright (C) 1995-2003 Russell King
+ * Copyright (C) 2012 ARM Ltd.
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
+#ifndef __ASM_PAGE_H
+#define __ASM_PAGE_H
+
+/* PAGE_SHIFT determines the page size */
+#ifdef CONFIG_ARM64_64K_PAGES
+#define PAGE_SHIFT=09=0916
+#else
+#define PAGE_SHIFT=09=0912
+#endif
+#define PAGE_SIZE=09=09(_AC(1,UL) << PAGE_SHIFT)
+#define PAGE_MASK=09=09(~(PAGE_SIZE-1))
+
+/* We do define AT_SYSINFO_EHDR but don't use the gate mechanism */
+#define __HAVE_ARCH_GATE_AREA=09=091
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_ARM64_64K_PAGES
+#include <asm/pgtable-2level-types.h>
+#else
+#include <asm/pgtable-3level-types.h>
+#endif
+
+extern void __cpu_clear_user_page(void *p, unsigned long user);
+extern void __cpu_copy_user_page(void *to, const void *from,
+=09=09=09=09 unsigned long user);
+extern void copy_page(void *to, const void *from);
+extern void clear_page(void *to);
+
+#define clear_user_page(addr,vaddr,pg)  __cpu_clear_user_page(addr, vaddr)
+#define copy_user_page(to,from,vaddr,pg) __cpu_copy_user_page(to, from, va=
ddr)
+
+typedef struct page *pgtable_t;
+
+#ifdef CONFIG_HAVE_ARCH_PFN_VALID
+extern int pfn_valid(unsigned long);
+#endif
+
+#include <asm/memory.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#define VM_DATA_DEFAULT_FLAGS \
+=09(((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0) | \
+=09 VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#include <asm-generic/getorder.h>
+
+#endif
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgal=
loc.h
new file mode 100644
index 0000000..f214069
--- /dev/null
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -0,0 +1,113 @@
+/*
+ * Based on arch/arm/include/asm/pgalloc.h
+ *
+ * Copyright (C) 2000-2001 Russell King
+ * Copyright (C) 2012 ARM Ltd.
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
+#ifndef __ASM_PGALLOC_H
+#define __ASM_PGALLOC_H
+
+#include <asm/pgtable-hwdef.h>
+#include <asm/processor.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+
+#define check_pgt_cache()=09=09do { } while (0)
+
+#ifndef CONFIG_ARM64_64K_PAGES
+
+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long add=
r)
+{
+=09return (pmd_t *)get_zeroed_page(GFP_KERNEL | __GFP_REPEAT);
+}
+
+static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
+{
+=09BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
+=09free_page((unsigned long)pmd);
+}
+
+static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *p=
md)
+{
+=09set_pud(pud, __pud(__pa(pmd) | PMD_TYPE_TABLE));
+}
+
+#endif=09/* CONFIG_ARM64_64K_PAGES */
+
+extern pgd_t *pgd_alloc(struct mm_struct *mm);
+extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
+
+#define PGALLOC_GFP=09(GFP_KERNEL | __GFP_NOTRACK | __GFP_REPEAT | __GFP_Z=
ERO)
+
+static inline pte_t *
+pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
+{
+=09return (pte_t *)__get_free_page(PGALLOC_GFP);
+}
+
+static inline pgtable_t
+pte_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+=09struct page *pte;
+
+=09pte =3D alloc_pages(PGALLOC_GFP, 0);
+=09if (pte)
+=09=09pgtable_page_ctor(pte);
+
+=09return pte;
+}
+
+/*
+ * Free a PTE table.
+ */
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
+=09if (pte)
+=09=09free_page((unsigned long)pte);
+}
+
+static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
+{
+=09pgtable_page_dtor(pte);
+=09__free_page(pte);
+}
+
+static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t pte,
+=09=09=09=09  pmdval_t prot)
+{
+=09set_pmd(pmdp, __pmd(pte | prot));
+}
+
+/*
+ * Populate the pmdp entry with a pointer to the pte.  This pmd is part
+ * of the mm address space.
+ */
+static inline void
+pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
+{
+=09/*
+=09 * The pmd must be loaded with the physical address of the PTE table
+=09 */
+=09__pmd_populate(pmdp, __pa(ptep), PMD_TYPE_TABLE);
+}
+
+static inline void
+pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
+{
+=09__pmd_populate(pmdp, page_to_phys(ptep), PMD_TYPE_TABLE);
+}
+#define pmd_pgtable(pmd) pmd_page(pmd)
+
+#endif
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
new file mode 100644
index 0000000..9aecbac
--- /dev/null
+++ b/arch/arm64/mm/copypage.c
@@ -0,0 +1,34 @@
+/*
+ * Based on arch/arm/mm/copypage.c
+ *
+ * Copyright (C) 2002 Deep Blue Solutions Ltd, All Rights Reserved.
+ * Copyright (C) 2012 ARM Ltd.
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
+
+#include <asm/page.h>
+#include <asm/cacheflush.h>
+
+void __cpu_copy_user_page(void *kto, const void *kfrom, unsigned long vadd=
r)
+{
+=09copy_page(kto, kfrom);
+=09__flush_dcache_area(kto, PAGE_SIZE);
+}
+
+void __cpu_clear_user_page(void *kaddr, unsigned long vaddr)
+{
+=09clear_page(kaddr);
+}
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
new file mode 100644
index 0000000..7944427
--- /dev/null
+++ b/arch/arm64/mm/extable.c
@@ -0,0 +1,17 @@
+/*
+ * Based on arch/arm/mm/extable.c
+ */
+
+#include <linux/module.h>
+#include <linux/uaccess.h>
+
+int fixup_exception(struct pt_regs *regs)
+{
+=09const struct exception_table_entry *fixup;
+
+=09fixup =3D search_exception_tables(instruction_pointer(regs));
+=09if (fixup)
+=09=09regs->pc =3D fixup->fixup;
+
+=09return fixup !=3D NULL;
+}
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
new file mode 100644
index 0000000..1909a69
--- /dev/null
+++ b/arch/arm64/mm/fault.c
@@ -0,0 +1,534 @@
+/*
+ * Based on arch/arm/mm/fault.c
+ *
+ * Copyright (C) 1995  Linus Torvalds
+ * Copyright (C) 1995-2004 Russell King
+ * Copyright (C) 2012 ARM Ltd.
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
+#include <linux/signal.h>
+#include <linux/mm.h>
+#include <linux/hardirq.h>
+#include <linux/init.h>
+#include <linux/kprobes.h>
+#include <linux/uaccess.h>
+#include <linux/page-flags.h>
+#include <linux/sched.h>
+#include <linux/highmem.h>
+#include <linux/perf_event.h>
+
+#include <asm/exception.h>
+#include <asm/debug-monitors.h>
+#include <asm/system_misc.h>
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+
+/*
+ * Dump out the page tables associated with 'addr' in mm 'mm'.
+ */
+void show_pte(struct mm_struct *mm, unsigned long addr)
+{
+=09pgd_t *pgd;
+
+=09if (!mm)
+=09=09mm =3D &init_mm;
+
+=09pr_alert("pgd =3D %p\n", mm->pgd);
+=09pgd =3D pgd_offset(mm, addr);
+=09pr_alert("[%08lx] *pgd=3D%016llx", addr, pgd_val(*pgd));
+
+=09do {
+=09=09pud_t *pud;
+=09=09pmd_t *pmd;
+=09=09pte_t *pte;
+
+=09=09if (pgd_none_or_clear_bad(pgd))
+=09=09=09break;
+
+=09=09pud =3D pud_offset(pgd, addr);
+=09=09if (pud_none_or_clear_bad(pud))
+=09=09=09break;
+
+=09=09pmd =3D pmd_offset(pud, addr);
+=09=09printk(", *pmd=3D%016llx", pmd_val(*pmd));
+=09=09if (pmd_none_or_clear_bad(pmd))
+=09=09=09break;
+
+=09=09pte =3D pte_offset_map(pmd, addr);
+=09=09printk(", *pte=3D%016llx", pte_val(*pte));
+=09=09pte_unmap(pte);
+=09} while(0);
+
+=09printk("\n");
+}
+
+/*
+ * The kernel tried to access some page that wasn't present.
+ */
+static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
+=09=09=09      unsigned int esr, struct pt_regs *regs)
+{
+=09/*
+=09 * Are we prepared to handle this kernel fault?
+=09 */
+=09if (fixup_exception(regs))
+=09=09return;
+
+=09/*
+=09 * No handler, we'll have to terminate things with extreme prejudice.
+=09 */
+=09bust_spinlocks(1);
+=09pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
+=09=09 (addr < PAGE_SIZE) ? "NULL pointer dereference" :
+=09=09 "paging request", addr);
+
+=09show_pte(mm, addr);
+=09die("Oops", regs, esr);
+=09bust_spinlocks(0);
+=09do_exit(SIGKILL);
+}
+
+/*
+ * Something tried to access memory that isn't in our memory map. User mod=
e
+ * accesses just cause a SIGSEGV
+ */
+static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
+=09=09=09    unsigned int esr, unsigned int sig, int code,
+=09=09=09    struct pt_regs *regs)
+{
+=09struct siginfo si;
+
+=09if (show_unhandled_signals) {
+=09=09pr_info("%s[%d]: unhandled page fault (%d) at 0x%08lx, code 0x%03x\n=
",
+=09=09=09tsk->comm, task_pid_nr(tsk), sig, addr, esr);
+=09=09show_pte(tsk->mm, addr);
+=09=09show_regs(regs);
+=09}
+
+=09tsk->thread.fault_address =3D addr;
+=09si.si_signo =3D sig;
+=09si.si_errno =3D 0;
+=09si.si_code =3D code;
+=09si.si_addr =3D (void __user *)addr;
+=09force_sig_info(sig, &si, tsk);
+}
+
+void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *reg=
s)
+{
+=09struct task_struct *tsk =3D current;
+=09struct mm_struct *mm =3D tsk->active_mm;
+
+=09/*
+=09 * If we are in kernel mode at this point, we have no context to
+=09 * handle this fault with.
+=09 */
+=09if (user_mode(regs))
+=09=09__do_user_fault(tsk, addr, esr, SIGSEGV, SEGV_MAPERR, regs);
+=09else
+=09=09__do_kernel_fault(mm, addr, esr, regs);
+}
+
+#define VM_FAULT_BADMAP=09=090x010000
+#define VM_FAULT_BADACCESS=090x020000
+
+#define ESR_WRITE=09=09(1 << 6)
+#define ESR_LNX_EXEC=09=09(1 << 24)
+
+/*
+ * Check that the permissions on the VMA allow for the fault which occurre=
d.
+ * If we encountered a write fault, we must have write permission, otherwi=
se
+ * we allow any permission.
+ */
+static inline bool access_error(unsigned int esr, struct vm_area_struct *v=
ma)
+{
+=09unsigned int mask =3D VM_READ | VM_WRITE | VM_EXEC;
+
+=09if (esr & ESR_WRITE)
+=09=09mask =3D VM_WRITE;
+=09if (esr & ESR_LNX_EXEC)
+=09=09mask =3D VM_EXEC;
+
+=09return vma->vm_flags & mask ? false : true;
+}
+
+static int __do_page_fault(struct mm_struct *mm, unsigned long addr,
+=09=09=09   unsigned int esr, unsigned int flags,
+=09=09=09   struct task_struct *tsk)
+{
+=09struct vm_area_struct *vma;
+=09int fault;
+
+=09vma =3D find_vma(mm, addr);
+=09fault =3D VM_FAULT_BADMAP;
+=09if (unlikely(!vma))
+=09=09goto out;
+=09if (unlikely(vma->vm_start > addr))
+=09=09goto check_stack;
+
+=09/*
+=09 * Ok, we have a good vm_area for this memory access, so we can handle
+=09 * it.
+=09 */
+good_area:
+=09if (access_error(esr, vma)) {
+=09=09fault =3D VM_FAULT_BADACCESS;
+=09=09goto out;
+=09}
+
+=09return handle_mm_fault(mm, vma, addr & PAGE_MASK, flags);
+
+check_stack:
+=09if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr))
+=09=09goto good_area;
+out:
+=09return fault;
+}
+
+static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
+=09=09=09=09   struct pt_regs *regs)
+{
+=09struct task_struct *tsk;
+=09struct mm_struct *mm;
+=09int fault, sig, code;
+=09int write =3D esr & ESR_WRITE;
+=09unsigned int flags =3D FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE |
+=09=09(write ? FAULT_FLAG_WRITE : 0);
+
+=09tsk =3D current;
+=09mm  =3D tsk->mm;
+
+=09/* Enable interrupts if they were enabled in the parent context. */
+=09if (interrupts_enabled(regs))
+=09=09local_irq_enable();
+
+=09/*
+=09 * If we're in an interrupt or have no user context, we must not take
+=09 * the fault.
+=09 */
+=09if (in_atomic() || !mm)
+=09=09goto no_context;
+
+=09/*
+=09 * As per x86, we may deadlock here. However, since the kernel only
+=09 * validly references user space from well defined areas of the code,
+=09 * we can bug out early if this is from code which shouldn't.
+=09 */
+=09if (!down_read_trylock(&mm->mmap_sem)) {
+=09=09if (!user_mode(regs) && !search_exception_tables(regs->pc))
+=09=09=09goto no_context;
+retry:
+=09=09down_read(&mm->mmap_sem);
+=09} else {
+=09=09/*
+=09=09 * The above down_read_trylock() might have succeeded in which
+=09=09 * case, we'll have missed the might_sleep() from down_read().
+=09=09 */
+=09=09might_sleep();
+#ifdef CONFIG_DEBUG_VM
+=09=09if (!user_mode(regs) && !search_exception_tables(regs->pc))
+=09=09=09goto no_context;
+#endif
+=09}
+
+=09fault =3D __do_page_fault(mm, addr, esr, flags, tsk);
+
+=09/*
+=09 * If we need to retry but a fatal signal is pending, handle the
+=09 * signal first. We do not need to release the mmap_sem because it
+=09 * would already be released in __lock_page_or_retry in mm/filemap.c.
+=09 */
+=09if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+=09=09return 0;
+
+=09/*
+=09 * Major/minor page fault accounting is only done on the initial
+=09 * attempt. If we go through a retry, it is extremely likely that the
+=09 * page will be found in page cache at that point.
+=09 */
+
+=09perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
+=09if (flags & FAULT_FLAG_ALLOW_RETRY) {
+=09=09if (fault & VM_FAULT_MAJOR) {
+=09=09=09tsk->maj_flt++;
+=09=09=09perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
+=09=09=09=09      addr);
+=09=09} else {
+=09=09=09tsk->min_flt++;
+=09=09=09perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
+=09=09=09=09      addr);
+=09=09}
+=09=09if (fault & VM_FAULT_RETRY) {
+=09=09=09/*
+=09=09=09 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk of
+=09=09=09 * starvation.
+=09=09=09 */
+=09=09=09flags &=3D ~FAULT_FLAG_ALLOW_RETRY;
+=09=09=09goto retry;
+=09=09}
+=09}
+
+=09up_read(&mm->mmap_sem);
+
+=09/*
+=09 * Handle the "normal" case first - VM_FAULT_MAJOR / VM_FAULT_MINOR
+=09 */
+=09if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP |
+=09=09=09      VM_FAULT_BADACCESS))))
+=09=09return 0;
+
+=09if (fault & VM_FAULT_OOM) {
+=09=09/*
+=09=09 * We ran out of memory, call the OOM killer, and return to
+=09=09 * userspace (which will retry the fault, or kill us if we got
+=09=09 * oom-killed).
+=09=09 */
+=09=09pagefault_out_of_memory();
+=09=09return 0;
+=09}
+
+=09/*
+=09 * If we are in kernel mode at this point, we have no context to
+=09 * handle this fault with.
+=09 */
+=09if (!user_mode(regs))
+=09=09goto no_context;
+
+=09if (fault & VM_FAULT_SIGBUS) {
+=09=09/*
+=09=09 * We had some memory, but were unable to successfully fix up
+=09=09 * this page fault.
+=09=09 */
+=09=09sig =3D SIGBUS;
+=09=09code =3D BUS_ADRERR;
+=09} else {
+=09=09/*
+=09=09 * Something tried to access memory that isn't in our memory
+=09=09 * map.
+=09=09 */
+=09=09sig =3D SIGSEGV;
+=09=09code =3D fault =3D=3D VM_FAULT_BADACCESS ?
+=09=09=09SEGV_ACCERR : SEGV_MAPERR;
+=09}
+
+=09__do_user_fault(tsk, addr, esr, sig, code, regs);
+=09return 0;
+
+no_context:
+=09__do_kernel_fault(mm, addr, esr, regs);
+=09return 0;
+}
+
+/*
+ * First Level Translation Fault Handler
+ *
+ * We enter here because the first level page table doesn't contain a vali=
d
+ * entry for the address.
+ *
+ * If the address is in kernel space (>=3D TASK_SIZE), then we are probabl=
y
+ * faulting in the vmalloc() area.
+ *
+ * If the init_task's first level page tables contains the relevant entry,=
 we
+ * copy the it to this task.  If not, we send the process a signal, fixup =
the
+ * exception, or oops the kernel.
+ *
+ * NOTE! We MUST NOT take any locks for this case. We may be in an interru=
pt
+ * or a critical region, and should only copy the information from the mas=
ter
+ * page table, nothing more.
+ */
+static int __kprobes do_translation_fault(unsigned long addr,
+=09=09=09=09=09  unsigned int esr,
+=09=09=09=09=09  struct pt_regs *regs)
+{
+=09if (addr < TASK_SIZE)
+=09=09return do_page_fault(addr, esr, regs);
+
+=09do_bad_area(addr, esr, regs);
+=09return 0;
+}
+
+/*
+ * Some section permission faults need to be handled gracefully.  They can
+ * happen due to a __{get,put}_user during an oops.
+ */
+static int do_sect_fault(unsigned long addr, unsigned int esr,
+=09=09=09 struct pt_regs *regs)
+{
+=09do_bad_area(addr, esr, regs);
+=09return 0;
+}
+
+/*
+ * This abort handler always returns "fault".
+ */
+static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *re=
gs)
+{
+=09return 1;
+}
+
+static struct fault_info {
+=09int=09(*fn)(unsigned long addr, unsigned int esr, struct pt_regs *regs)=
;
+=09int=09sig;
+=09int=09code;
+=09const char *name;
+} fault_info[] =3D {
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"ttbr address size fault"=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"level 1 address size fault"=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"level 2 address size fault"=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"level 3 address size fault"=09},
+=09{ do_translation_fault,=09SIGSEGV, SEGV_MAPERR,=09"input address range =
fault"=09},
+=09{ do_translation_fault,=09SIGSEGV, SEGV_MAPERR,=09"level 1 translation =
fault"=09},
+=09{ do_translation_fault,=09SIGSEGV, SEGV_MAPERR,=09"level 2 translation =
fault"=09},
+=09{ do_page_fault,=09SIGSEGV, SEGV_MAPERR,=09"level 3 translation fault"=
=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"reserved access flag fault"=09},
+=09{ do_bad,=09=09SIGSEGV, SEGV_ACCERR,=09"level 1 access flag fault"=09},
+=09{ do_bad,=09=09SIGSEGV, SEGV_ACCERR,=09"level 2 access flag fault"=09},
+=09{ do_page_fault,=09SIGSEGV, SEGV_ACCERR,=09"level 3 access flag fault"=
=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"reserved permission fault"=09},
+=09{ do_bad,=09=09SIGSEGV, SEGV_ACCERR,=09"level 1 permission fault"=09},
+=09{ do_sect_fault,=09SIGSEGV, SEGV_ACCERR,=09"level 2 permission fault"=
=09},
+=09{ do_page_fault,=09SIGSEGV, SEGV_ACCERR,=09"level 3 permission fault"=
=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"synchronous external abort"=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"asynchronous external abort"=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 18"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 19"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"synchronous abort (translation table w=
alk)" },
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"synchronous abort (translation table w=
alk)" },
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"synchronous abort (translation table w=
alk)" },
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"synchronous abort (translation table w=
alk)" },
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"synchronous parity error"=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"asynchronous parity error"=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 26"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 27"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"synchronous parity error (translation =
table walk" },
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"synchronous parity error (translation =
table walk" },
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"synchronous parity error (translation =
table walk" },
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"synchronous parity error (translation =
table walk" },
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 32"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  BUS_ADRALN,=09"alignment fault"=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"debug event"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 35"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 36"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 37"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 38"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 39"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 40"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 41"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 42"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 43"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 44"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 45"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 46"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 47"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 48"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 49"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 50"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 51"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"implementation fault (lockdown abort)"=
 },
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 53"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 54"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 55"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 56"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 57"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"implementation fault (coprocessor abor=
t)" },
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 59"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 60"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 61"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 62"=09=09=09},
+=09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 63"=09=09=09},
+};
+
+/*
+ * Dispatch a data abort to the relevant handler.
+ */
+asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int =
esr,
+=09=09=09=09=09 struct pt_regs *regs)
+{
+=09const struct fault_info *inf =3D fault_info + (esr & 63);
+=09struct siginfo info;
+
+=09if (!inf->fn(addr, esr, regs))
+=09=09return;
+
+=09pr_alert("Unhandled fault: %s (0x%08x) at 0x%016lx\n",
+=09=09 inf->name, esr, addr);
+
+=09info.si_signo =3D inf->sig;
+=09info.si_errno =3D 0;
+=09info.si_code  =3D inf->code;
+=09info.si_addr  =3D (void __user *)addr;
+=09arm64_notify_die("", regs, &info, esr);
+}
+
+/*
+ * Handle stack alignment exceptions.
+ */
+asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
+=09=09=09=09=09   unsigned int esr,
+=09=09=09=09=09   struct pt_regs *regs)
+{
+=09struct siginfo info;
+
+=09info.si_signo =3D SIGBUS;
+=09info.si_errno =3D 0;
+=09info.si_code  =3D BUS_ADRALN;
+=09info.si_addr  =3D (void __user *)addr;
+=09arm64_notify_die("", regs, &info, esr);
+}
+
+static struct fault_info debug_fault_info[] =3D {
+=09{ do_bad,=09SIGTRAP,=09TRAP_HWBKPT,=09"hardware breakpoint"=09},
+=09{ do_bad,=09SIGTRAP,=09TRAP_HWBKPT,=09"hardware single-step"=09},
+=09{ do_bad,=09SIGTRAP,=09TRAP_HWBKPT,=09"hardware watchpoint"=09},
+=09{ do_bad,=09SIGBUS,=09=090,=09=09"unknown 3"=09=09},
+=09{ do_bad,=09SIGTRAP,=09TRAP_BRKPT,=09"aarch32 BKPT"=09=09},
+=09{ do_bad,=09SIGTRAP,=090,=09=09"aarch32 vector catch"=09},
+=09{ do_bad,=09SIGTRAP,=09TRAP_BRKPT,=09"aarch64 BRK"=09=09},
+=09{ do_bad,=09SIGBUS,=09=090,=09=09"unknown 7"=09=09},
+};
+
+void __init hook_debug_fault_code(int nr,
+=09=09=09=09  int (*fn)(unsigned long, unsigned int, struct pt_regs *),
+=09=09=09=09  int sig, int code, const char *name)
+{
+=09BUG_ON(nr < 0 || nr >=3D ARRAY_SIZE(debug_fault_info));
+
+=09debug_fault_info[nr].fn=09=09=3D fn;
+=09debug_fault_info[nr].sig=09=3D sig;
+=09debug_fault_info[nr].code=09=3D code;
+=09debug_fault_info[nr].name=09=3D name;
+}
+
+asmlinkage int __exception do_debug_exception(unsigned long addr,
+=09=09=09=09=09      unsigned int esr,
+=09=09=09=09=09      struct pt_regs *regs)
+{
+=09const struct fault_info *inf =3D debug_fault_info + DBG_ESR_EVT(esr);
+=09struct siginfo info;
+
+=09if (!inf->fn(addr, esr, regs))
+=09=09return 1;
+
+=09pr_alert("Unhandled debug exception: %s (0x%08x) at 0x%016lx\n",
+=09=09 inf->name, esr, addr);
+
+=09info.si_signo =3D inf->sig;
+=09info.si_errno =3D 0;
+=09info.si_code  =3D inf->code;
+=09info.si_addr  =3D (void __user *)addr;
+=09arm64_notify_die("", regs, &info, esr);
+
+=09return 0;
+}
diff --git a/arch/arm64/mm/mm.h b/arch/arm64/mm/mm.h
new file mode 100644
index 0000000..c84f68b
--- /dev/null
+++ b/arch/arm64/mm/mm.h
@@ -0,0 +1,2 @@
+extern void __flush_dcache_page(struct address_space *mapping, struct page=
 *page);
+extern void __init bootmem_init(void);
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
new file mode 100644
index 0000000..7c7be78
--- /dev/null
+++ b/arch/arm64/mm/mmap.c
@@ -0,0 +1,144 @@
+/*
+ * Based on arch/arm/mm/mmap.c
+ *
+ * Copyright (C) 2012 ARM Ltd.
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
+#include <linux/elf.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/export.h>
+#include <linux/shm.h>
+#include <linux/sched.h>
+#include <linux/io.h>
+#include <linux/personality.h>
+#include <linux/random.h>
+
+#include <asm/cputype.h>
+
+/*
+ * Leave enough space between the mmap area and the stack to honour ulimit=
 in
+ * the face of randomisation.
+ */
+#define MIN_GAP (SZ_128M + ((STACK_RND_MASK << PAGE_SHIFT) + 1))
+#define MAX_GAP=09(STACK_TOP/6*5)
+
+static int mmap_is_legacy(void)
+{
+=09if (current->personality & ADDR_COMPAT_LAYOUT)
+=09=09return 1;
+
+=09if (rlimit(RLIMIT_STACK) =3D=3D RLIM_INFINITY)
+=09=09return 1;
+
+=09return sysctl_legacy_va_layout;
+}
+
+/*
+ * Since get_random_int() returns the same value within a 1 jiffy window, =
we
+ * will almost always get the same randomisation for the stack and mmap
+ * region. This will mean the relative distance between stack and mmap wil=
l be
+ * the same.
+ *
+ * To avoid this we can shift the randomness by 1 bit.
+ */
+static unsigned long mmap_rnd(void)
+{
+=09unsigned long rnd =3D 0;
+
+=09if (current->flags & PF_RANDOMIZE)
+=09=09rnd =3D (long)get_random_int() & (STACK_RND_MASK >> 1);
+
+=09return rnd << (PAGE_SHIFT + 1);
+}
+
+static unsigned long mmap_base(void)
+{
+=09unsigned long gap =3D rlimit(RLIMIT_STACK);
+
+=09if (gap < MIN_GAP)
+=09=09gap =3D MIN_GAP;
+=09else if (gap > MAX_GAP)
+=09=09gap =3D MAX_GAP;
+
+=09return PAGE_ALIGN(STACK_TOP - gap - mmap_rnd());
+}
+
+/*
+ * This function, called very early during the creation of a new process V=
M
+ * image, sets up which VM layout function to use:
+ */
+void arch_pick_mmap_layout(struct mm_struct *mm)
+{
+=09/*
+=09 * Fall back to the standard layout if the personality bit is set, or
+=09 * if the expected stack growth is unlimited:
+=09 */
+=09if (mmap_is_legacy()) {
+=09=09mm->mmap_base =3D TASK_UNMAPPED_BASE;
+=09=09mm->get_unmapped_area =3D arch_get_unmapped_area;
+=09=09mm->unmap_area =3D arch_unmap_area;
+=09} else {
+=09=09mm->mmap_base =3D mmap_base();
+=09=09mm->get_unmapped_area =3D arch_get_unmapped_area_topdown;
+=09=09mm->unmap_area =3D arch_unmap_area_topdown;
+=09}
+}
+EXPORT_SYMBOL_GPL(arch_pick_mmap_layout);
+
+
+/*
+ * You really shouldn't be using read() or write() on /dev/mem.  This migh=
t go
+ * away in the future.
+ */
+int valid_phys_addr_range(unsigned long addr, size_t size)
+{
+=09if (addr < PHYS_OFFSET)
+=09=09return 0;
+=09if (addr + size > __pa(high_memory - 1) + 1)
+=09=09return 0;
+
+=09return 1;
+}
+
+/*
+ * Do not allow /dev/mem mappings beyond the supported physical range.
+ */
+int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
+{
+=09return !(((pfn << PAGE_SHIFT) + size) & ~PHYS_MASK);
+}
+
+#ifdef CONFIG_STRICT_DEVMEM
+
+#include <linux/ioport.h>
+
+/*
+ * devmem_is_allowed() checks to see if /dev/mem access to a certain addre=
ss
+ * is valid. The argument is a physical page number.  We mimic x86 here by
+ * disallowing access to system RAM as well as device-exclusive MMIO regio=
ns.
+ * This effectively disable read()/write() on /dev/mem.
+ */
+int devmem_is_allowed(unsigned long pfn)
+{
+=09if (iomem_is_exclusive(pfn << PAGE_SHIFT))
+=09=09return 0;
+=09if (!page_is_ram(pfn))
+=09=09return 1;
+=09return 0;
+}
+
+#endif
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
new file mode 100644
index 0000000..7083cda
--- /dev/null
+++ b/arch/arm64/mm/pgd.c
@@ -0,0 +1,54 @@
+/*
+ * PGD allocation/freeing
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Catalin Marinas <catalin.marinas@arm.com>
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
+#include <linux/gfp.h>
+#include <linux/highmem.h>
+#include <linux/slab.h>
+
+#include <asm/pgalloc.h>
+#include <asm/page.h>
+#include <asm/tlbflush.h>
+
+#include "mm.h"
+
+#define PGD_SIZE=09(PTRS_PER_PGD * sizeof(pgd_t))
+
+pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+=09pgd_t *new_pgd;
+
+=09if (PGD_SIZE =3D=3D PAGE_SIZE)
+=09=09new_pgd =3D (pgd_t *)get_zeroed_page(GFP_KERNEL);
+=09else
+=09=09new_pgd =3D kzalloc(PGD_SIZE, GFP_KERNEL);
+
+=09if (!new_pgd)
+=09=09return NULL;
+
+=09return new_pgd;
+}
+
+void pgd_free(struct mm_struct *mm, pgd_t *pgd)
+{
+=09if (PGD_SIZE =3D=3D PAGE_SIZE)
+=09=09free_page((unsigned long)pgd);
+=09else
+=09=09kfree(pgd);
+}

