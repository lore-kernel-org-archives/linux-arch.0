Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34274 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab2IGQ1x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:53 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 08/31] arm64: CPU support
Date: Fri,  7 Sep 2012 17:26:43 +0100
Message-ID: <1347035226-18649-9-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120907162643.MBuVs_SIf7KH_NP_JmxJ-JN6w4hxIgcp9YyTtpZDU8I@z>

This patch adds AArch64 CPU specific functionality. It assumes that the
implementation is generic to AArch64 and does not require specific
identification. Different CPU implementations may require the setting of
various ACTLR_EL1 bits but such information is not currently available
and it should ideally be pushed to firmware.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/include/asm/cputable.h  |   30 ++++++
 arch/arm64/include/asm/cputype.h   |   49 ++++++++++
 arch/arm64/include/asm/proc-fns.h  |   51 ++++++++++
 arch/arm64/include/asm/processor.h |  175 ++++++++++++++++++++++++++++++++=
++
 arch/arm64/kernel/cputable.c       |   33 +++++++
 arch/arm64/mm/proc.S               |  181 ++++++++++++++++++++++++++++++++=
++++
 6 files changed, 519 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/cputable.h
 create mode 100644 arch/arm64/include/asm/cputype.h
 create mode 100644 arch/arm64/include/asm/proc-fns.h
 create mode 100644 arch/arm64/include/asm/processor.h
 create mode 100644 arch/arm64/kernel/cputable.c
 create mode 100644 arch/arm64/mm/proc.S

diff --git a/arch/arm64/include/asm/cputable.h b/arch/arm64/include/asm/cpu=
table.h
new file mode 100644
index 0000000..e3bd983
--- /dev/null
+++ b/arch/arm64/include/asm/cputable.h
@@ -0,0 +1,30 @@
+/*
+ * arch/arm64/include/asm/cputable.h
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
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
+#ifndef __ASM_CPUTABLE_H
+#define __ASM_CPUTABLE_H
+
+struct cpu_info {
+=09unsigned int=09cpu_id_val;
+=09unsigned int=09cpu_id_mask;
+=09const char=09*cpu_name;
+=09unsigned long=09(*cpu_setup)(void);
+};
+
+extern struct cpu_info *lookup_processor_type(unsigned int);
+
+#endif
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cput=
ype.h
new file mode 100644
index 0000000..ef54125
--- /dev/null
+++ b/arch/arm64/include/asm/cputype.h
@@ -0,0 +1,49 @@
+/*
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
+#ifndef __ASM_CPUTYPE_H
+#define __ASM_CPUTYPE_H
+
+#define ID_MIDR_EL1=09=09"midr_el1"
+#define ID_CTR_EL0=09=09"ctr_el0"
+
+#define ID_AA64PFR0_EL1=09=09"id_aa64pfr0_el1"
+#define ID_AA64DFR0_EL1=09=09"id_aa64dfr0_el1"
+#define ID_AA64AFR0_EL1=09=09"id_aa64afr0_el1"
+#define ID_AA64ISAR0_EL1=09"id_aa64isar0_el1"
+#define ID_AA64MMFR0_EL1=09"id_aa64mmfr0_el1"
+
+#define read_cpuid(reg) ({=09=09=09=09=09=09\
+=09u64 __val;=09=09=09=09=09=09=09\
+=09asm("mrs=09%0, " reg : "=3Dr" (__val));=09=09=09\
+=09__val;=09=09=09=09=09=09=09=09\
+})
+
+/*
+ * The CPU ID never changes at run time, so we might as well tell the
+ * compiler that it's constant.  Use this function to read the CPU ID
+ * rather than directly reading processor_id or read_cpuid() directly.
+ */
+static inline u32 __attribute_const__ read_cpuid_id(void)
+{
+=09return read_cpuid(ID_MIDR_EL1);
+}
+
+static inline u32 __attribute_const__ read_cpuid_cachetype(void)
+{
+=09return read_cpuid(ID_CTR_EL0);
+}
+
+#endif
diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/pro=
c-fns.h
new file mode 100644
index 0000000..520331b
--- /dev/null
+++ b/arch/arm64/include/asm/proc-fns.h
@@ -0,0 +1,51 @@
+/*
+ * Based on arch/arm/include/asm/proc-fns.h
+ *
+ * Copyright (C) 1997-1999 Russell King
+ * Copyright (C) 2000 Deep Blue Solutions Ltd
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
+#ifndef __ASM_PROCFNS_H
+#define __ASM_PROCFNS_H
+
+#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
+
+#include <asm/page.h>
+
+struct mm_struct;
+
+extern void cpu_proc_init(void);
+extern void cpu_proc_fin(void);
+extern void cpu_do_idle(void);
+extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm)=
;
+extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
+
+#include <asm/memory.h>
+
+#define cpu_switch_mm(pgd,mm) cpu_do_switch_mm(virt_to_phys(pgd),mm)
+
+#define cpu_get_pgd()=09=09=09=09=09\
+({=09=09=09=09=09=09=09\
+=09unsigned long pg;=09=09=09=09\
+=09asm("mrs=09%0, ttbr0_el1\n"=09=09\
+=09    : "=3Dr" (pg));=09=09=09=09\
+=09pg &=3D ~0xffff000000003ffful;=09=09=09\
+=09(pgd_t *)phys_to_virt(pg);=09=09=09\
+})
+
+#endif /* __ASSEMBLY__ */
+#endif /* __KERNEL__ */
+#endif /* __ASM_PROCFNS_H */
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/pr=
ocessor.h
new file mode 100644
index 0000000..39a208a
--- /dev/null
+++ b/arch/arm64/include/asm/processor.h
@@ -0,0 +1,175 @@
+/*
+ * Based on arch/arm/include/asm/processor.h
+ *
+ * Copyright (C) 1995-1999 Russell King
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
+#ifndef __ASM_PROCESSOR_H
+#define __ASM_PROCESSOR_H
+
+/*
+ * Default implementation of macro that returns current
+ * instruction pointer ("program counter").
+ */
+#define current_text_addr() ({ __label__ _l; _l: &&_l;})
+
+#ifdef __KERNEL__
+
+#include <linux/string.h>
+
+#include <asm/fpsimd.h>
+#include <asm/hw_breakpoint.h>
+#include <asm/ptrace.h>
+#include <asm/types.h>
+
+#ifdef __KERNEL__
+#define STACK_TOP_MAX=09=09TASK_SIZE_64
+#ifdef CONFIG_COMPAT
+#define AARCH32_VECTORS_BASE=090xffff0000
+#define STACK_TOP=09=09(test_thread_flag(TIF_32BIT) ? \
+=09=09=09=09AARCH32_VECTORS_BASE : STACK_TOP_MAX)
+#else
+#define STACK_TOP=09=09STACK_TOP_MAX
+#endif /* CONFIG_COMPAT */
+#endif /* __KERNEL__ */
+
+struct debug_info {
+=09/* Have we suspended stepping by a debugger? */
+=09int=09=09=09suspended_step;
+=09/* Allow breakpoints and watchpoints to be disabled for this thread. */
+=09int=09=09=09bps_disabled;
+=09int=09=09=09wps_disabled;
+=09/* Hardware breakpoints pinned to this task. */
+=09struct perf_event=09*hbp_break[ARM_MAX_BRP];
+=09struct perf_event=09*hbp_watch[ARM_MAX_WRP];
+};
+
+struct cpu_context {
+=09unsigned long x19;
+=09unsigned long x20;
+=09unsigned long x21;
+=09unsigned long x22;
+=09unsigned long x23;
+=09unsigned long x24;
+=09unsigned long x25;
+=09unsigned long x26;
+=09unsigned long x27;
+=09unsigned long x28;
+=09unsigned long fp;
+=09unsigned long sp;
+=09unsigned long pc;
+};
+
+struct thread_struct {
+=09struct cpu_context=09cpu_context;=09/* cpu context */
+=09unsigned long=09=09tp_value;
+=09struct fpsimd_state=09fpsimd_state;
+=09unsigned long=09=09fault_address;=09/* fault info */
+=09struct debug_info=09debug;=09=09/* debugging */
+};
+
+#define INIT_THREAD  {=09}
+
+static inline void start_thread_common(struct pt_regs *regs, unsigned long=
 pc)
+{
+=09memset(regs, 0, sizeof(*regs));
+=09regs->syscallno =3D ~0UL;
+=09regs->pc =3D pc;
+}
+
+static inline void start_thread(struct pt_regs *regs, unsigned long pc,
+=09=09=09=09unsigned long sp)
+{
+=09unsigned long *stack =3D (unsigned long *)sp;
+
+=09start_thread_common(regs, pc);
+=09regs->pstate =3D PSR_MODE_EL0t;
+=09regs->sp =3D sp;
+=09regs->regs[2] =3D stack[2];=09/* x2 (envp) */
+=09regs->regs[1] =3D stack[1];=09/* x1 (argv) */
+=09regs->regs[0] =3D stack[0];=09/* x0 (argc) */
+}
+
+#ifdef CONFIG_COMPAT
+static inline void compat_start_thread(struct pt_regs *regs, unsigned long=
 pc,
+=09=09=09=09       unsigned long sp)
+{
+=09unsigned int *stack =3D (unsigned int *)sp;
+
+=09start_thread_common(regs, pc);
+=09regs->pstate =3D COMPAT_PSR_MODE_USR;
+=09if (pc & 1)
+=09=09regs->pstate |=3D COMPAT_PSR_T_BIT;
+=09regs->compat_sp =3D sp;
+=09regs->regs[2] =3D stack[2];=09/* x2 (envp) */
+=09regs->regs[1] =3D stack[1];=09/* x1 (argv) */
+=09regs->regs[0] =3D stack[0];=09/* x0 (argc) */
+}
+#endif
+
+/* Forward declaration, a strange C thing */
+struct task_struct;
+
+/* Free all resources held by a thread. */
+extern void release_thread(struct task_struct *);
+
+/* Prepare to copy thread state - unlazy all lazy status */
+#define prepare_to_copy(tsk)=09do { } while (0)
+
+unsigned long get_wchan(struct task_struct *p);
+
+#define cpu_relax()=09=09=09barrier()
+
+/* Thread switching */
+extern struct task_struct *cpu_switch_to(struct task_struct *prev,
+=09=09=09=09=09 struct task_struct *next);
+
+/*
+ * Create a new kernel thread
+ */
+extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags=
);
+
+#define task_pt_regs(p) \
+=09((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
+
+#define KSTK_EIP(tsk)=09task_pt_regs(tsk)->pc
+#define KSTK_ESP(tsk)=09task_pt_regs(tsk)->sp
+
+/*
+ * Prefetching support
+ */
+#define ARCH_HAS_PREFETCH
+static inline void prefetch(const void *ptr)
+{
+=09asm volatile("prfm pldl1keep, %a0\n" : : "p" (ptr));
+}
+
+#define ARCH_HAS_PREFETCHW
+static inline void prefetchw(const void *ptr)
+{
+=09asm volatile("prfm pstl1keep, %a0\n" : : "p" (ptr));
+}
+
+#define ARCH_HAS_SPINLOCK_PREFETCH
+static inline void spin_lock_prefetch(const void *x)
+{
+=09prefetchw(x);
+}
+
+#define HAVE_ARCH_PICK_MMAP_LAYOUT
+
+#endif
+
+#endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/cputable.c b/arch/arm64/kernel/cputable.c
new file mode 100644
index 0000000..63cfc4a
--- /dev/null
+++ b/arch/arm64/kernel/cputable.c
@@ -0,0 +1,33 @@
+/*
+ * arch/arm64/kernel/cputable.c
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
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
+#include <linux/init.h>
+
+#include <asm/cputable.h>
+
+extern unsigned long __cpu_setup(void);
+
+struct cpu_info __initdata cpu_table[] =3D {
+=09{
+=09=09.cpu_id_val=09=3D 0x000f0000,
+=09=09.cpu_id_mask=09=3D 0x000f0000,
+=09=09.cpu_name=09=3D "AArch64 Processor",
+=09=09.cpu_setup=09=3D __cpu_setup,
+=09},
+=09{ /* Empty */ },
+};
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
new file mode 100644
index 0000000..674cd74
--- /dev/null
+++ b/arch/arm64/mm/proc.S
@@ -0,0 +1,181 @@
+/*
+ * Based on arch/arm/mm/proc.S
+ *
+ * Copyright (C) 2001 Deep Blue Solutions Ltd.
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
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+#include <asm/hwcap.h>
+#include <asm/pgtable-hwdef.h>
+#include <asm/pgtable.h>
+
+#include "proc-macros.S"
+
+#ifndef CONFIG_SMP
+/* PTWs cacheable, inner/outer WBWA not shareable */
+#define TCR_FLAGS=09TCR_IRGN_WBWA | TCR_ORGN_WBWA
+#else
+/* PTWs cacheable, inner/outer WBWA shareable */
+#define TCR_FLAGS=09TCR_IRGN_WBWA | TCR_ORGN_WBWA | TCR_SHARED
+#endif
+
+#define MAIR(attr, mt)=09((attr) << ((mt) * 8))
+
+ENTRY(cpu_proc_init)
+=09ret
+ENDPROC(cpu_proc_init)
+
+ENTRY(cpu_proc_fin)
+=09ret
+ENDPROC(cpu_proc_fin)
+
+/*
+ *=09cpu_reset(loc)
+ *
+ *=09Perform a soft reset of the system.  Put the CPU into the same state
+ *=09as it would be if it had been reset, and branch to what would be the
+ *=09reset vector. It must be executed with the flat identity mapping.
+ *
+ *=09- loc   - location to jump to for soft reset
+ */
+=09.align=095
+ENTRY(cpu_reset)
+=09mrs=09x1, sctlr_el1
+=09bic=09x1, x1, #1
+=09msr=09sctlr_el1, x1=09=09=09// disable the MMU
+=09isb
+=09ret=09x0
+ENDPROC(cpu_reset)
+
+/*
+ *=09cpu_do_idle()
+ *
+ *=09Idle the processor (wait for interrupt).
+ */
+ENTRY(cpu_do_idle)
+=09dsb=09sy=09=09=09=09// WFI may enter a low-power mode
+=09wfi
+=09ret
+ENDPROC(cpu_do_idle)
+
+/*
+ *=09cpu_switch_mm(pgd_phys, tsk)
+ *
+ *=09Set the translation table base pointer to be pgd_phys.
+ *
+ *=09- pgd_phys - physical address of new TTB
+ */
+ENTRY(cpu_do_switch_mm)
+=09mmid=09w1, x1=09=09=09=09// get mm->context.id
+=09bfi=09x0, x1, #48, #16=09=09// set the ASID
+=09msr=09ttbr0_el1, x0=09=09=09// set TTBR0
+=09isb
+=09ret
+ENDPROC(cpu_do_switch_mm)
+
+cpu_name:
+=09.ascii=09"AArch64 Processor"
+=09.align
+
+=09.section ".text.init", #alloc, #execinstr
+
+/*
+ *=09__cpu_setup
+ *
+ *=09Initialise the processor for turning the MMU on.  Return in x0 the
+ *=09value of the SCTLR_EL1 register.
+ */
+ENTRY(__cpu_setup)
+#ifdef CONFIG_SMP
+=09/* TODO: only do this for certain CPUs */
+=09/*
+=09 * Enable SMP/nAMP mode.
+=09 */
+=09mrs=09x0, actlr_el1
+=09tbnz=09x0, #6, 1f=09=09=09// already enabled?
+=09orr=09x0, x0, #1 << 6
+=09msr=09actlr_el1, x0
+1:
+#endif
+=09/*
+=09 * Preserve the link register across the function call.
+=09 */
+=09mov=09x28, lr
+=09bl=09__flush_dcache_all
+=09mov=09lr, x28
+=09ic=09iallu=09=09=09=09// I+BTB cache invalidate
+=09dsb=09sy
+
+=09mov=09x0, #3 << 20
+=09msr=09cpacr_el1, x0=09=09=09// Enable FP/ASIMD
+=09mov=09x0, #1
+=09msr=09oslar_el1, x0=09=09=09// Set the debug OS lock
+=09tlbi=09vmalle1is=09=09=09// invalidate I + D TLBs
+=09/*
+=09 * Memory region attributes for LPAE:
+=09 *
+=09 *   n =3D AttrIndx[2:0]
+=09 *=09=09=09n=09MAIR
+=09 *   DEVICE_nGnRnE=09000=0900000000
+=09 *   DEVICE_nGnRE=09001=0900000100
+=09 *   DEVICE_GRE=09=09010=0900001100
+=09 *   NORMAL_NC=09=09011=0901000100
+=09 *   NORMAL=09=09100=0911111111
+=09 */
+=09ldr=09x5, =3DMAIR(0x00, MT_DEVICE_nGnRnE) | \
+=09=09     MAIR(0x04, MT_DEVICE_nGnRE) | \
+=09=09     MAIR(0x0c, MT_DEVICE_GRE) | \
+=09=09     MAIR(0x44, MT_NORMAL_NC) | \
+=09=09     MAIR(0xff, MT_NORMAL)
+=09msr=09mair_el1, x5
+=09/*
+=09 * Prepare SCTLR
+=09 */
+=09adr=09x5, crval
+=09ldp=09w5, w6, [x5]
+=09mrs=09x0, sctlr_el1
+=09bic=09x0, x0, x5=09=09=09// clear bits
+=09orr=09x0, x0, x6=09=09=09// set bits
+=09/*
+=09 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
+=09 * both user and kernel.
+=09 */
+=09ldr=09x10, =3DTCR_TxSZ(VA_BITS) | TCR_FLAGS | TCR_IPS_40BIT | \
+=09=09      TCR_ASID16 | (1 << 31)
+#ifdef CONFIG_ARM64_64K_PAGES
+=09orr=09x10, x10, TCR_TG0_64K
+=09orr=09x10, x10, TCR_TG1_64K
+#endif
+=09msr=09tcr_el1, x10
+=09ret=09=09=09=09=09// return to head.S
+ENDPROC(__cpu_setup)
+
+=09/*
+=09 *                 n n            T
+=09 *       U E      WT T UD     US IHBS
+=09 *       CE0      XWHW CZ     ME TEEA S
+=09 * .... .IEE .... NEAI TE.I ..AD DEN0 ACAM
+=09 * 0011 0... 1101 ..0. ..0. 10.. .... .... < hardware reserved
+=09 * .... .100 .... 01.1 11.1 ..01 0001 1101 < software settings
+=09 */
+=09.type=09crval, #object
+crval:
+=09.word=090x030802e2=09=09=09// clear
+=09.word=090x0405d11d=09=09=09// set

