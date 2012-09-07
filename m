From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 01/31] arm64: Assembly macros and definitions
Date: Fri,  7 Sep 2012 17:26:36 +0100
Message-ID: <1347035226-18649-2-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34140 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab2IGQ1v (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:51 -0400
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

This patch introduces several assembly macros and definitions used in
the .S files across arch/arm64/ like IRQ disabling/enabling, together
with asm-offsets.c.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/asm-offsets.h |    1 +
 arch/arm64/include/asm/assembler.h   |  109 ++++++++++++++++++++++++++++++=
++++
 arch/arm64/kernel/asm-offsets.c      |  108 ++++++++++++++++++++++++++++++=
+++
 arch/arm64/mm/proc-macros.S          |   55 +++++++++++++++++
 4 files changed, 273 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/asm-offsets.h
 create mode 100644 arch/arm64/include/asm/assembler.h
 create mode 100644 arch/arm64/kernel/asm-offsets.c
 create mode 100644 arch/arm64/mm/proc-macros.S

diff --git a/arch/arm64/include/asm/asm-offsets.h b/arch/arm64/include/asm/=
asm-offsets.h
new file mode 100644
index 0000000..d370ee3
--- /dev/null
+++ b/arch/arm64/include/asm/asm-offsets.h
@@ -0,0 +1 @@
+#include <generated/asm-offsets.h>
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/as=
sembler.h
new file mode 100644
index 0000000..da2a13e
--- /dev/null
+++ b/arch/arm64/include/asm/assembler.h
@@ -0,0 +1,109 @@
+/*
+ * Based on arch/arm/include/asm/assembler.h
+ *
+ * Copyright (C) 1996-2000 Russell King
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
+#ifndef __ASSEMBLY__
+#error "Only include this from assembly code"
+#endif
+
+#include <asm/ptrace.h>
+
+/*
+ * Stack pushing/popping (register pairs only). Equivalent to store decrem=
ent
+ * before, load increment after.
+ */
+=09.macro=09push, xreg1, xreg2
+=09stp=09\xreg1, \xreg2, [sp, #-16]!
+=09.endm
+
+=09.macro=09pop, xreg1, xreg2
+=09ldp=09\xreg1, \xreg2, [sp], #16
+=09.endm
+
+/*
+ * Enable and disable interrupts.
+ */
+=09.macro=09disable_irq
+=09msr=09daifset, #2
+=09.endm
+
+=09.macro=09enable_irq
+=09msr=09daifclr, #2
+=09.endm
+
+/*
+ * Save/disable and restore interrupts.
+ */
+=09.macro=09save_and_disable_irqs, olddaif
+=09mrs=09\olddaif, daif
+=09disable_irq
+=09.endm
+
+=09.macro=09restore_irqs, olddaif
+=09msr=09daif, \olddaif
+=09.endm
+
+/*
+ * Enable and disable debug exceptions.
+ */
+=09.macro=09disable_dbg
+=09msr=09daifset, #8
+=09.endm
+
+=09.macro=09enable_dbg
+=09msr=09daifclr, #8
+=09.endm
+
+=09.macro=09disable_step, tmp
+=09mrs=09\tmp, mdscr_el1
+=09bic=09\tmp, \tmp, #1
+=09msr=09mdscr_el1, \tmp
+=09.endm
+
+=09.macro=09enable_step, tmp
+=09mrs=09\tmp, mdscr_el1
+=09orr=09\tmp, \tmp, #1
+=09msr=09mdscr_el1, \tmp
+=09.endm
+
+=09.macro=09enable_dbg_if_not_stepping, tmp
+=09mrs=09\tmp, mdscr_el1
+=09tbnz=09\tmp, #1, 9990f
+=09enable_dbg
+9990:
+=09.endm
+
+/*
+ * SMP data memory barrier
+ */
+=09.macro=09smp_dmb, opt
+#ifdef CONFIG_SMP
+=09dmb=09\opt
+#endif
+=09.endm
+
+#define USER(l, x...)=09=09=09=09\
+9999:=09x;=09=09=09=09=09\
+=09.section __ex_table,"a";=09=09\
+=09.align=093;=09=09=09=09\
+=09.quad=099999b,l;=09=09=09\
+=09.previous
+
+/*
+ * Register aliases.
+ */
+lr=09.req=09x30=09=09// link register
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offset=
s.c
new file mode 100644
index 0000000..a2a4d81
--- /dev/null
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -0,0 +1,108 @@
+/*
+ * Based on arch/arm/kernel/asm-offsets.c
+ *
+ * Copyright (C) 1995-2003 Russell King
+ *               2001-2002 Keith Owens
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
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+#include <asm/thread_info.h>
+#include <asm/memory.h>
+#include <asm/cputable.h>
+#include <asm/vdso_datapage.h>
+#include <linux/kbuild.h>
+
+int main(void)
+{
+  DEFINE(TSK_ACTIVE_MM,=09=09offsetof(struct task_struct, active_mm));
+  BLANK();
+  DEFINE(TI_FLAGS,=09=09offsetof(struct thread_info, flags));
+  DEFINE(TI_PREEMPT,=09=09offsetof(struct thread_info, preempt_count));
+  DEFINE(TI_ADDR_LIMIT,=09=09offsetof(struct thread_info, addr_limit));
+  DEFINE(TI_TASK,=09=09offsetof(struct thread_info, task));
+  DEFINE(TI_EXEC_DOMAIN,=09offsetof(struct thread_info, exec_domain));
+  DEFINE(TI_CPU,=09=09offsetof(struct thread_info, cpu));
+  BLANK();
+  DEFINE(THREAD_CPU_CONTEXT,=09offsetof(struct task_struct, thread.cpu_con=
text));
+  BLANK();
+  DEFINE(S_X0,=09=09=09offsetof(struct pt_regs, regs[0]));
+  DEFINE(S_X1,=09=09=09offsetof(struct pt_regs, regs[1]));
+  DEFINE(S_X2,=09=09=09offsetof(struct pt_regs, regs[2]));
+  DEFINE(S_X3,=09=09=09offsetof(struct pt_regs, regs[3]));
+  DEFINE(S_X4,=09=09=09offsetof(struct pt_regs, regs[4]));
+  DEFINE(S_X5,=09=09=09offsetof(struct pt_regs, regs[5]));
+  DEFINE(S_X6,=09=09=09offsetof(struct pt_regs, regs[6]));
+  DEFINE(S_X7,=09=09=09offsetof(struct pt_regs, regs[7]));
+  DEFINE(S_LR,=09=09=09offsetof(struct pt_regs, regs[30]));
+  DEFINE(S_SP,=09=09=09offsetof(struct pt_regs, sp));
+#ifdef CONFIG_COMPAT
+  DEFINE(S_COMPAT_SP,=09=09offsetof(struct pt_regs, compat_sp));
+#endif
+  DEFINE(S_PSTATE,=09=09offsetof(struct pt_regs, pstate));
+  DEFINE(S_PC,=09=09=09offsetof(struct pt_regs, pc));
+  DEFINE(S_ORIG_X0,=09=09offsetof(struct pt_regs, orig_x0));
+  DEFINE(S_SYSCALLNO,=09=09offsetof(struct pt_regs, syscallno));
+  DEFINE(S_FRAME_SIZE,=09=09sizeof(struct pt_regs));
+  BLANK();
+  DEFINE(MM_CONTEXT_ID,=09=09offsetof(struct mm_struct, context.id));
+  BLANK();
+  DEFINE(VMA_VM_MM,=09=09offsetof(struct vm_area_struct, vm_mm));
+  DEFINE(VMA_VM_FLAGS,=09=09offsetof(struct vm_area_struct, vm_flags));
+  BLANK();
+  DEFINE(VM_EXEC,=09       =09VM_EXEC);
+  BLANK();
+  DEFINE(PAGE_SZ,=09       =09PAGE_SIZE);
+  BLANK();
+  DEFINE(CPU_INFO_SZ,=09=09sizeof(struct cpu_info));
+  DEFINE(CPU_INFO_SETUP,=09offsetof(struct cpu_info, cpu_setup));
+  BLANK();
+  DEFINE(DMA_BIDIRECTIONAL,=09DMA_BIDIRECTIONAL);
+  DEFINE(DMA_TO_DEVICE,=09=09DMA_TO_DEVICE);
+  DEFINE(DMA_FROM_DEVICE,=09DMA_FROM_DEVICE);
+  BLANK();
+  DEFINE(CLOCK_REALTIME,=09CLOCK_REALTIME);
+  DEFINE(CLOCK_MONOTONIC,=09CLOCK_MONOTONIC);
+  DEFINE(CLOCK_REALTIME_RES,=09MONOTONIC_RES_NSEC);
+  DEFINE(CLOCK_REALTIME_COARSE,=09CLOCK_REALTIME_COARSE);
+  DEFINE(CLOCK_MONOTONIC_COARSE,CLOCK_MONOTONIC_COARSE);
+  DEFINE(CLOCK_COARSE_RES,=09LOW_RES_NSEC);
+  DEFINE(NSEC_PER_SEC,=09=09NSEC_PER_SEC);
+  BLANK();
+  DEFINE(VDSO_CS_CYCLE_LAST,=09offsetof(struct vdso_data, cs_cycle_last));
+  DEFINE(VDSO_XTIME_CLK_SEC,=09offsetof(struct vdso_data, xtime_clock_sec)=
);
+  DEFINE(VDSO_XTIME_CLK_NSEC,=09offsetof(struct vdso_data, xtime_clock_nse=
c));
+  DEFINE(VDSO_XTIME_CRS_SEC,=09offsetof(struct vdso_data, xtime_coarse_sec=
));
+  DEFINE(VDSO_XTIME_CRS_NSEC,=09offsetof(struct vdso_data, xtime_coarse_ns=
ec));
+  DEFINE(VDSO_WTM_CLK_SEC,=09offsetof(struct vdso_data, wtm_clock_sec));
+  DEFINE(VDSO_WTM_CLK_NSEC,=09offsetof(struct vdso_data, wtm_clock_nsec));
+  DEFINE(VDSO_TB_SEQ_COUNT,=09offsetof(struct vdso_data, tb_seq_count));
+  DEFINE(VDSO_CS_MULT,=09=09offsetof(struct vdso_data, cs_mult));
+  DEFINE(VDSO_CS_SHIFT,=09=09offsetof(struct vdso_data, cs_shift));
+  DEFINE(VDSO_TZ_MINWEST,=09offsetof(struct vdso_data, tz_minuteswest));
+  DEFINE(VDSO_TZ_DSTTIME,=09offsetof(struct vdso_data, tz_dsttime));
+  DEFINE(VDSO_USE_SYSCALL,=09offsetof(struct vdso_data, use_syscall));
+  BLANK();
+  DEFINE(TVAL_TV_SEC,=09=09offsetof(struct timeval, tv_sec));
+  DEFINE(TVAL_TV_USEC,=09=09offsetof(struct timeval, tv_usec));
+  DEFINE(TSPEC_TV_SEC,=09=09offsetof(struct timespec, tv_sec));
+  DEFINE(TSPEC_TV_NSEC,=09=09offsetof(struct timespec, tv_nsec));
+  BLANK();
+  DEFINE(TZ_MINWEST,=09=09offsetof(struct timezone, tz_minuteswest));
+  DEFINE(TZ_DSTTIME,=09=09offsetof(struct timezone, tz_dsttime));
+  return 0;
+}
diff --git a/arch/arm64/mm/proc-macros.S b/arch/arm64/mm/proc-macros.S
new file mode 100644
index 0000000..8957b82
--- /dev/null
+++ b/arch/arm64/mm/proc-macros.S
@@ -0,0 +1,55 @@
+/*
+ * Based on arch/arm/mm/proc-macros.S
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
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+
+/*
+ * vma_vm_mm - get mm pointer from vma pointer (vma->vm_mm)
+ */
+=09.macro=09vma_vm_mm, rd, rn
+=09ldr=09\rd, [\rn, #VMA_VM_MM]
+=09.endm
+
+/*
+ * mmid - get context id from mm pointer (mm->context.id)
+ */
+=09.macro=09mmid, rd, rn
+=09ldr=09\rd, [\rn, #MM_CONTEXT_ID]
+=09.endm
+
+/*
+ * dcache_line_size - get the minimum D-cache line size from the CTR regis=
ter.
+ */
+=09.macro=09dcache_line_size, reg, tmp
+=09mrs=09\tmp, ctr_el0=09=09=09// read CTR
+=09lsr=09\tmp, \tmp, #16
+=09and=09\tmp, \tmp, #0xf=09=09// cache line size encoding
+=09mov=09\reg, #4=09=09=09// bytes per word
+=09lsl=09\reg, \reg, \tmp=09=09// actual cache line size
+=09.endm
+
+/*
+ * icache_line_size - get the minimum I-cache line size from the CTR regis=
ter.
+ */
+=09.macro=09icache_line_size, reg, tmp
+=09mrs=09\tmp, ctr_el0=09=09=09// read CTR
+=09and=09\tmp, \tmp, #0xf=09=09// cache line size encoding
+=09mov=09\reg, #4=09=09=09// bytes per word
+=09lsl=09\reg, \reg, \tmp=09=09// actual cache line size
+=09.endm
