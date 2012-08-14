Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54945 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769Ab2HNRxF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:05 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 03/31] arm64: Exception handling
Date: Tue, 14 Aug 2012 18:52:04 +0100
Message-ID: <1344966752-16102-4-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120814175204.jYtNNBPUTT4DzGRwDdhUxJ6kmgoYO_Y8BTU3apCusJ8@z>

The patch contains the exception entry code (kernel/entry.S), pt_regs
structure and related accessors, undefined instruction trapping and
stack tracing.

AArch64 Linux kernel (including kernel threads) runs in EL1 mode using
the SP1 stack. The vectors don't have a fixed address, only alignment
(2^11) requirements.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/ptrace.h     |  206 +++++++++++
 arch/arm64/include/asm/stacktrace.h |   29 ++
 arch/arm64/include/asm/traps.h      |   30 ++
 arch/arm64/kernel/entry.S           |  695 +++++++++++++++++++++++++++++++=
++++
 arch/arm64/kernel/stacktrace.c      |  127 +++++++
 arch/arm64/kernel/traps.c           |  357 ++++++++++++++++++
 6 files changed, 1444 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/ptrace.h
 create mode 100644 arch/arm64/include/asm/stacktrace.h
 create mode 100644 arch/arm64/include/asm/traps.h
 create mode 100644 arch/arm64/kernel/entry.S
 create mode 100644 arch/arm64/kernel/stacktrace.c
 create mode 100644 arch/arm64/kernel/traps.c

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrac=
e.h
new file mode 100644
index 0000000..a9abace
--- /dev/null
+++ b/arch/arm64/include/asm/ptrace.h
@@ -0,0 +1,206 @@
+/*
+ * Based on arch/arm/include/asm/ptrace.h
+ *
+ * Copyright (C) 1996-2003 Russell King
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
+#ifndef __ASM_PTRACE_H
+#define __ASM_PTRACE_H
+
+#include <linux/types.h>
+
+#include <asm/hwcap.h>
+
+#define PTRACE_GETREGS=09=0912
+#define PTRACE_SETREGS=09=0913
+#define PTRACE_GETFPSIMDREGS=0914
+#define PTRACE_SETFPSIMDREGS=0915
+/* PTRACE_ATTACH is 16 */
+/* PTRACE_DETACH is 17 */
+#define PTRACE_GET_THREAD_AREA=0922
+#define PTRACE_SET_SYSCALL=0923
+#define PTRACE_GETHBPREGS=0929
+#define PTRACE_SETHBPREGS=0930
+
+/* AArch32-specific ptrace requests */
+#define COMPAT_PTRACE_GETVFPREGS=0927
+#define COMPAT_PTRACE_SETVFPREGS=0928
+
+/*
+ * PSR bits
+ */
+#define PSR_MODE_EL0t=090x00000000
+#define PSR_MODE_EL1t=090x00000004
+#define PSR_MODE_EL1h=090x00000005
+#define PSR_MODE_EL2t=090x00000008
+#define PSR_MODE_EL2h=090x00000009
+#define PSR_MODE_EL3t=090x0000000c
+#define PSR_MODE_EL3h=090x0000000d
+#define PSR_MODE_MASK=090x0000000f
+
+/* AArch32 CPSR bits */
+#define PSR_MODE32_BIT=09=090x00000010
+#define COMPAT_PSR_MODE_USR=090x00000010
+#define COMPAT_PSR_T_BIT=090x00000020
+#define COMPAT_PSR_IT_MASK=090x0600fc00=09/* If-Then execution state mask =
*/
+
+/* AArch64 SPSR bits */
+#define PSR_F_BIT=090x00000040
+#define PSR_I_BIT=090x00000080
+#define PSR_A_BIT=090x00000100
+#define PSR_D_BIT=090x00000200
+#define PSR_Q_BIT=090x08000000
+#define PSR_V_BIT=090x10000000
+#define PSR_C_BIT=090x20000000
+#define PSR_Z_BIT=090x40000000
+#define PSR_N_BIT=090x80000000
+
+/*
+ * Groups of PSR bits
+ */
+#define PSR_f=09=090xff000000=09/* Flags=09=09*/
+#define PSR_s=09=090x00ff0000=09/* Status=09=09*/
+#define PSR_x=09=090x0000ff00=09/* Extension=09=09*/
+#define PSR_c=09=090x000000ff=09/* Control=09=09*/
+
+/*
+ * These are 'magic' values for PTRACE_PEEKUSR that return info about wher=
e a
+ * process is located in memory.
+ */
+#define PT_TEXT_ADDR=09=090x10000
+#define PT_DATA_ADDR=09=090x10004
+#define PT_TEXT_END_ADDR=090x10008
+
+#ifndef __ASSEMBLY__
+
+/*
+ * User structures for general purpose and floating point registers.
+ */
+struct user_pt_regs {
+=09__u64=09=09regs[31];
+=09__u64=09=09sp;
+=09__u64=09=09pc;
+=09__u64=09=09pstate;
+};
+
+struct user_fpsimd_state {
+=09__uint128_t=09vregs[32];
+=09__u32=09=09fpsr;
+=09__u32=09=09fpcr;
+};
+
+#ifdef __KERNEL__
+
+#ifdef CONFIG_AARCH32_EMULATION
+/* sizeof(struct user) for AArch32 */
+#define COMPAT_USER_SZ=09296
+/* AArch32 uses x13 as the stack pointer... */
+#define compat_sp=09regs[13]
+/* ... and x14 as the link register. */
+#define compat_lr=09regs[14]
+#endif
+
+/*
+ * This struct defines the way the registers are stored on the stack durin=
g an
+ * exception. Note that sizeof(struct pt_regs) has to be a multiple of 16 =
(for
+ * stack alignment). struct user_pt_regs must form a prefix of struct pt_r=
egs.
+ */
+struct pt_regs {
+=09union {
+=09=09struct user_pt_regs user_regs;
+=09=09struct {
+=09=09=09u64 regs[31];
+=09=09=09u64 sp;
+=09=09=09u64 pc;
+=09=09=09u64 pstate;
+=09=09};
+=09};
+=09u64 orig_x0;
+=09u64 syscallno;
+};
+
+#define arch_has_single_step()=09(1)
+
+#ifdef CONFIG_AARCH32_EMULATION
+#define compat_thumb_mode(regs) \
+=09(((regs)->pstate & COMPAT_PSR_T_BIT))
+#else
+#define compat_thumb_mode(regs) (0)
+#endif
+
+#define user_mode(regs)=09\
+=09(((regs)->pstate & PSR_MODE_MASK) =3D=3D PSR_MODE_EL0t)
+
+#define compat_user_mode(regs)=09\
+=09(((regs)->pstate & (PSR_MODE32_BIT | PSR_MODE_MASK)) =3D=3D \
+=09 (PSR_MODE32_BIT | PSR_MODE_EL0t))
+
+#define processor_mode(regs) \
+=09((regs)->pstate & PSR_MODE_MASK)
+
+#define interrupts_enabled(regs) \
+=09(!((regs)->pstate & PSR_I_BIT))
+
+#define fast_interrupts_enabled(regs) \
+=09(!((regs)->pstate & PSR_F_BIT))
+
+#define user_stack_pointer(regs) \
+=09((regs)->sp)
+
+/*
+ * Are the current registers suitable for user mode? (used to maintain
+ * security in signal handlers)
+ */
+static inline int valid_user_regs(struct user_pt_regs *regs)
+{
+=09if (user_mode(regs) && (regs->pstate & PSR_I_BIT) =3D=3D 0) {
+=09=09regs->pstate &=3D ~(PSR_F_BIT | PSR_A_BIT);
+
+=09=09/* The T bit is reserved for AArch64 */
+=09=09if (!(regs->pstate & PSR_MODE32_BIT))
+=09=09=09regs->pstate &=3D ~COMPAT_PSR_T_BIT;
+
+=09=09return 1;
+=09}
+
+=09/*
+=09 * Force PSR to something logical...
+=09 */
+=09regs->pstate &=3D PSR_f | PSR_s | (PSR_x & ~PSR_A_BIT) | \
+=09=09=09COMPAT_PSR_T_BIT | PSR_MODE32_BIT;
+
+=09if (!(regs->pstate & PSR_MODE32_BIT)) {
+=09=09regs->pstate &=3D ~COMPAT_PSR_T_BIT;
+=09=09regs->pstate |=3D PSR_MODE_EL0t;
+=09}
+
+=09return 0;
+}
+
+#define instruction_pointer(regs)=09(regs)->pc
+
+#ifdef CONFIG_SMP
+extern unsigned long profile_pc(struct pt_regs *regs);
+#else
+#define profile_pc(regs) instruction_pointer(regs)
+#endif
+
+extern int aarch32_break_trap(struct pt_regs *regs);
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/s=
tacktrace.h
new file mode 100644
index 0000000..7318f6d
--- /dev/null
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -0,0 +1,29 @@
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
+#ifndef __ASM_STACKTRACE_H
+#define __ASM_STACKTRACE_H
+
+struct stackframe {
+=09unsigned long fp;
+=09unsigned long sp;
+=09unsigned long pc;
+};
+
+extern int unwind_frame(struct stackframe *frame);
+extern void walk_stackframe(struct stackframe *frame,
+=09=09=09    int (*fn)(struct stackframe *, void *), void *data);
+
+#endif=09/* __ASM_STACKTRACE_H */
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.=
h
new file mode 100644
index 0000000..10ca8ff
--- /dev/null
+++ b/arch/arm64/include/asm/traps.h
@@ -0,0 +1,30 @@
+/*
+ * Based on arch/arm/include/asm/traps.h
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
+#ifndef __ASM_TRAP_H
+#define __ASM_TRAP_H
+
+static inline int in_exception_text(unsigned long ptr)
+{
+=09extern char __exception_text_start[];
+=09extern char __exception_text_end[];
+
+=09return ptr >=3D (unsigned long)&__exception_text_start &&
+=09       ptr < (unsigned long)&__exception_text_end;
+}
+
+#endif
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
new file mode 100644
index 0000000..32b96ab
--- /dev/null
+++ b/arch/arm64/kernel/entry.S
@@ -0,0 +1,695 @@
+/*
+ * Low-level exception handling code
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Authors:=09Catalin Marinas <catalin.marinas@arm.com>
+ *=09=09Will Deacon <will.deacon@arm.com>
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
+
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+#include <asm/errno.h>
+#include <asm/thread_info.h>
+#include <asm/unistd.h>
+
+/*
+ * Bad Abort numbers
+ *-----------------
+ */
+#define BAD_SYNC=090
+#define BAD_IRQ=09=091
+#define BAD_FIQ=09=092
+#define BAD_ERROR=093
+
+=09.macro=09kernel_entry, el, regsize =3D 64
+=09sub=09sp, sp, #S_FRAME_SIZE - S_LR=09// room for LR, SP, SPSR, ELR
+=09.if=09\regsize =3D=3D 32
+=09mov=09w0, w0=09=09=09=09// zero upper 32 bits of x0
+=09.endif
+=09push=09x28, x29
+=09push=09x26, x27
+=09push=09x24, x25
+=09push=09x22, x23
+=09push=09x20, x21
+=09push=09x18, x19
+=09push=09x16, x17
+=09push=09x14, x15
+=09push=09x12, x13
+=09push=09x10, x11
+=09push=09x8, x9
+=09push=09x6, x7
+=09push=09x4, x5
+=09push=09x2, x3
+=09push=09x0, x1
+=09.if=09\el =3D=3D 0
+=09mrs=09x21, sp_el0
+=09.else
+=09add=09x21, sp, #S_FRAME_SIZE
+=09.endif
+=09mrs=09x22, elr_el1
+=09mrs=09x23, spsr_el1
+=09stp=09lr, x21, [sp, #S_LR]
+=09stp=09x22, x23, [sp, #S_PC]
+
+=09/*
+=09 * Set syscallno to -1 by default (overridden later if real syscall).
+=09 */
+=09.if=09\el =3D=3D 0
+=09mvn=09x21, xzr
+=09str=09x21, [sp, #S_SYSCALLNO]
+=09.endif
+
+=09/*
+=09 * Registers that may be useful after this macro is invoked:
+=09 *
+=09 * x21 - aborted SP
+=09 * x22 - aborted PC
+=09 * x23 - aborted PSTATE
+=09*/
+=09.endm
+
+=09.macro=09kernel_exit, el, ret =3D 0
+=09ldp=09x21, x22, [sp, #S_PC]=09=09// load ELR, SPSR
+=09.if=09\el =3D=3D 0
+=09ldr=09x23, [sp, #S_SP]=09=09// load return stack pointer
+=09.endif
+=09.if=09\ret
+=09ldr=09x1, [sp, #S_X1]=09=09=09// preserve x0 (syscall return)
+=09add=09sp, sp, S_X2
+=09.else
+=09pop=09x0, x1
+=09.endif
+=09pop=09x2, x3=09=09=09=09// load the rest of the registers
+=09pop=09x4, x5
+=09pop=09x6, x7
+=09pop=09x8, x9
+=09msr=09elr_el1, x21=09=09=09// set up the return data
+=09msr=09spsr_el1, x22
+=09.if=09\el =3D=3D 0
+=09msr=09sp_el0, x23
+=09.endif
+=09pop=09x10, x11
+=09pop=09x12, x13
+=09pop=09x14, x15
+=09pop=09x16, x17
+=09pop=09x18, x19
+=09pop=09x20, x21
+=09pop=09x22, x23
+=09pop=09x24, x25
+=09pop=09x26, x27
+=09pop=09x28, x29
+=09ldr=09lr, [sp], #S_FRAME_SIZE - S_LR=09// load LR and restore SP
+=09eret=09=09=09=09=09// return to kernel
+=09.endm
+
+=09.macro=09get_thread_info, rd
+=09mov=09\rd, sp
+=09and=09\rd, \rd, #~((1 << 13) - 1)=09// top of 8K stack
+=09.endm
+
+/*
+ * These are the registers used in the syscall handler, and allow us to
+ * have in theory up to 7 arguments to a function - x0 to x6.
+ *
+ * x7 is reserved for the system call number in 32-bit mode.
+ */
+sc_nr=09.req=09x25=09=09// number of system calls
+scno=09.req=09x26=09=09// syscall number
+stbl=09.req=09x27=09=09// syscall table pointer
+tsk=09.req=09x28=09=09// current thread_info
+
+/*
+ * Interrupt handling.
+ */
+=09.macro=09irq_handler
+=09ldr=09x1, handle_arch_irq
+=09mov=09x0, sp
+=09blr=09x1
+=09.endm
+
+=09.text
+
+/*
+ * Exception vectors.
+ */
+=09.macro=09ventry=09label
+=09.align=097
+=09b=09\label
+=09.endm
+
+=09.align=0911
+ENTRY(vectors)
+=09ventry=09el1_sync_invalid=09=09// Synchronous EL1t
+=09ventry=09el1_irq_invalid=09=09=09// IRQ EL1t
+=09ventry=09el1_fiq_invalid=09=09=09// FIQ EL1t
+=09ventry=09el1_error_invalid=09=09// Error EL1t
+
+=09ventry=09el1_sync=09=09=09// Synchronous EL1h
+=09ventry=09el1_irq=09=09=09=09// IRQ EL1h
+=09ventry=09el1_fiq_invalid=09=09=09// FIQ EL1h
+=09ventry=09el1_error_invalid=09=09// Error EL1h
+
+=09ventry=09el0_sync=09=09=09// Synchronous 64-bit EL0
+=09ventry=09el0_irq=09=09=09=09// IRQ 64-bit EL0
+=09ventry=09el0_fiq_invalid=09=09=09// FIQ 64-bit EL0
+=09ventry=09el0_error_invalid=09=09// Error 64-bit EL0
+
+#ifdef CONFIG_AARCH32_EMULATION
+=09ventry=09el0_sync_compat=09=09=09// Synchronous 32-bit EL0
+=09ventry=09el0_irq_compat=09=09=09// IRQ 32-bit EL0
+=09ventry=09el0_fiq_invalid_compat=09=09// FIQ 32-bit EL0
+=09ventry=09el0_error_invalid_compat=09// Error 32-bit EL0
+#else
+=09ventry=09el0_sync_invalid=09=09// Synchronous 32-bit EL0
+=09ventry=09el0_irq_invalid=09=09=09// IRQ 32-bit EL0
+=09ventry=09el0_fiq_invalid=09=09=09// FIQ 32-bit EL0
+=09ventry=09el0_error_invalid=09=09// Error 32-bit EL0
+#endif
+END(vectors)
+
+/*
+ * Invalid mode handlers
+ */
+=09.macro=09inv_entry, el, reason, regsize =3D 64
+=09kernel_entry el, \regsize
+=09mov=09x0, sp
+=09mov=09x1, #\reason
+=09mrs=09x2, esr_el1
+=09b=09bad_mode
+=09.endm
+
+el0_sync_invalid:
+=09inv_entry 0, BAD_SYNC
+ENDPROC(el0_sync_invalid)
+
+el0_irq_invalid:
+=09inv_entry 0, BAD_IRQ
+ENDPROC(el0_irq_invalid)
+
+el0_fiq_invalid:
+=09inv_entry 0, BAD_FIQ
+ENDPROC(el0_fiq_invalid)
+
+el0_error_invalid:
+=09inv_entry 0, BAD_ERROR
+ENDPROC(el0_error_invalid)
+
+#ifdef CONFIG_AARCH32_EMULATION
+el0_fiq_invalid_compat:
+=09inv_entry 0, BAD_FIQ, 32
+ENDPROC(el0_fiq_invalid_compat)
+
+el0_error_invalid_compat:
+=09inv_entry 0, BAD_ERROR, 32
+ENDPROC(el0_error_invalid_compat)
+#endif
+
+el1_sync_invalid:
+=09inv_entry 1, BAD_SYNC
+ENDPROC(el1_sync_invalid)
+
+el1_irq_invalid:
+=09inv_entry 1, BAD_IRQ
+ENDPROC(el1_irq_invalid)
+
+el1_fiq_invalid:
+=09inv_entry 1, BAD_FIQ
+ENDPROC(el1_fiq_invalid)
+
+el1_error_invalid:
+=09inv_entry 1, BAD_ERROR
+ENDPROC(el1_error_invalid)
+
+/*
+ * EL1 mode handlers.
+ */
+=09.align=096
+el1_sync:
+=09kernel_entry 1
+=09mrs=09x1, esr_el1=09=09=09// read the syndrome register
+=09lsr=09x24, x1, #26=09=09=09// exception class
+=09cmp=09x24, #0x25=09=09=09// data abort in EL1
+=09b.eq=09el1_da
+=09cmp=09x24, #0x18=09=09=09// configurable trap
+=09b.eq=09el1_undef
+=09cmp=09x24, #0x26=09=09=09// stack alignment exception
+=09b.eq=09el1_sp_pc
+=09cmp=09x24, #0x22=09=09=09// pc alignment exception
+=09b.eq=09el1_sp_pc
+=09cmp=09x24, #0x00=09=09=09// unknown exception in EL1
+=09b.eq=09el1_undef
+=09cmp=09x24, #0x30=09=09=09// debug exception in EL1
+=09b.ge=09el1_dbg
+=09b=09el1_inv
+el1_da:
+=09/*
+=09 * Data abort handling
+=09 */
+=09mrs=09x0, far_el1
+=09enable_dbg_if_not_stepping x2
+=09// re-enable interrupts if they were enabled in the aborted context
+=09tbnz=09x23, #7, 1f=09=09=09// PSR_I_BIT
+=09enable_irq
+1:
+=09mov=09x2, sp=09=09=09=09// struct pt_regs
+=09bl=09do_mem_abort
+
+=09// disable interrupts before pulling preserved data off the stack
+=09disable_irq
+=09kernel_exit 1
+el1_sp_pc:
+=09/*
+=09 *Stack or PC alignment exception handling
+=09 */
+=09mrs=09x0, far_el1
+=09mov=09x1, x25
+=09mov=09x2, sp
+=09b=09do_sp_pc_abort
+el1_undef:
+=09/*
+=09 *Undefined instruction
+=09 */
+=09mov=09x0, sp
+=09b=09do_undefinstr
+el1_dbg:
+=09/*
+=09 * Debug exception handling
+=09 */
+=09tbz=09x24, #0, el1_inv=09=09// EL1 only
+=09mrs=09x0, far_el1
+=09mov=09x2, sp=09=09=09=09// struct pt_regs
+=09bl=09do_debug_exception
+
+=09kernel_exit 1
+el1_inv:
+=09// TODO: add support for undefined instructions in kernel mode
+=09mov=09x0, sp
+=09mov=09x1, #BAD_SYNC
+=09mrs=09x2, esr_el1
+=09b=09bad_mode
+ENDPROC(el1_sync)
+
+=09.align=096
+el1_irq:
+=09kernel_entry 1
+=09enable_dbg_if_not_stepping x0
+#ifdef CONFIG_TRACE_IRQFLAGS
+=09bl=09trace_hardirqs_off
+#endif
+#ifdef CONFIG_PREEMPT
+=09get_thread_info tsk
+=09ldr=09x24, [tsk, #TI_PREEMPT]=09=09// get preempt count
+=09add=09x0, x24, #1=09=09=09// increment it
+=09str=09x0, [tsk, #TI_PREEMPT]
+#endif
+=09irq_handler
+#ifdef CONFIG_PREEMPT
+=09str=09x24, [tsk, #TI_PREEMPT]=09=09// restore preempt count
+=09cbnz=09x24, 1f=09=09=09=09// preempt count !=3D 0
+=09ldr=09x0, [tsk, #TI_FLAGS]=09=09// get flags
+=09tbz=09x0, #TIF_NEED_RESCHED, 1f=09// needs rescheduling?
+=09bl=09el1_preempt
+1:
+#endif
+#ifdef CONFIG_TRACE_IRQFLAGS
+=09bl=09trace_hardirqs_on
+#endif
+=09kernel_exit 1
+ENDPROC(el1_irq)
+
+#ifdef CONFIG_PREEMPT
+el1_preempt:
+=09mov=09x24, lr
+1:=09enable_dbg
+=09bl=09preempt_schedule_irq=09=09// irq en/disable is done inside
+=09ldr=09x0, [tsk, #TI_FLAGS]=09=09// get new tasks TI_FLAGS
+=09tbnz=09x0, #TIF_NEED_RESCHED, 1b=09// needs rescheduling?
+=09ret=09x24
+#endif
+
+/*
+ * EL0 mode handlers.
+ */
+=09.align=096
+el0_sync:
+=09kernel_entry 0
+=09mrs=09x25, esr_el1=09=09=09// read the syndrome register
+=09lsr=09x24, x25, #26=09=09=09// exception class
+=09cmp=09x24, #0x15=09=09=09// SVC in 64-bit state
+=09b.eq=09el0_svc
+=09adr=09lr, ret_from_exception
+=09cmp=09x24, #0x24=09=09=09// data abort in EL0
+=09b.eq=09el0_da
+=09cmp=09x24, #0x20=09=09=09// instruction abort in EL0
+=09b.eq=09el0_ia
+=09cmp=09x24, #0x07=09=09=09// FP/ASIMD access
+=09b.eq=09el0_fpsimd_acc
+=09cmp=09x24, #0x2c=09=09=09// FP/ASIMD exception
+=09b.eq=09el0_fpsimd_exc
+=09cmp=09x24, #0x18=09=09=09// configurable trap
+=09b.eq=09el0_undef
+=09cmp=09x24, #0x26=09=09=09// stack alignment exception
+=09b.eq=09el0_sp_pc
+=09cmp=09x24, #0x22=09=09=09// pc alignment exception
+=09b.eq=09el0_sp_pc
+=09cmp=09x24, #0x00=09=09=09// unknown exception in EL0
+=09b.eq=09el0_undef
+=09cmp=09x24, #0x30=09=09=09// debug exception in EL0
+=09b.ge=09el0_dbg
+=09b=09el0_inv
+
+#ifdef CONFIG_AARCH32_EMULATION
+=09.align=096
+el0_sync_compat:
+=09kernel_entry 0, 32
+=09mrs=09x25, esr_el1=09=09=09// read the syndrome register
+=09lsr=09x24, x25, #26=09=09=09// exception class
+=09cmp=09x24, #0x11=09=09=09// SVC in 32-bit state
+=09b.eq=09el0_svc_compat
+=09adr=09lr, ret_from_exception
+=09cmp=09x24, #0x24=09=09=09// data abort in EL0
+=09b.eq=09el0_da
+=09cmp=09x24, #0x20=09=09=09// instruction abort in EL0
+=09b.eq=09el0_ia
+=09cmp=09x24, #0x07=09=09=09// FP/ASIMD access
+=09b.eq=09el0_fpsimd_acc
+=09cmp=09x24, #0x28=09=09=09// FP/ASIMD exception
+=09b.eq=09el0_fpsimd_exc
+=09cmp=09x24, #0x00=09=09=09// unknown exception in EL0
+=09b.eq=09el0_undef
+=09cmp=09x24, #0x30=09=09=09// debug exception in EL0
+=09b.ge=09el0_dbg
+=09b=09el0_inv
+el0_svc_compat:
+=09/*
+=09 * AArch32 syscall handling
+=09 */
+=09adr=09stbl, compat_sys_call_table=09// load compat syscall table pointe=
r
+=09uxtw=09scno, w7=09=09=09// syscall number in w7 (r7)
+=09mov     sc_nr, #__NR_compat_syscalls
+=09b=09el0_svc_naked
+
+=09.align=096
+el0_irq_compat:
+=09kernel_entry 0, 32
+=09b=09el0_irq_naked
+#endif
+
+el0_da:
+=09/*
+=09 * Data abort handling
+=09 */
+=09mrs=09x0, far_el1
+=09disable_step x1
+=09isb
+=09enable_dbg
+=09// enable interrupts before calling the main handler
+=09enable_irq
+=09mov=09x1, x25
+=09mov=09x2, sp
+=09b=09do_mem_abort
+el0_ia:
+=09/*
+=09 * Instruction abort handling
+=09 */
+=09mrs=09x0, far_el1
+=09disable_step x1
+=09isb
+=09enable_dbg
+=09// enable interrupts before calling the main handler
+=09enable_irq
+=09orr=09x1, x25, #1 << 24=09=09// use reserved ISS bit for instruction ab=
orts
+=09mov=09x2, sp
+=09b=09do_mem_abort
+el0_fpsimd_acc:
+=09/*
+=09 * Floating Point or Advanced SIMD access
+=09 */
+=09mov=09x0, x25
+=09mov=09x1, sp
+=09b=09do_fpsimd_acc
+el0_fpsimd_exc:
+=09/*
+=09 * Floating Point or Advanced SIMD exception
+=09 */
+=09mov=09x0, x25
+=09mov=09x1, sp
+=09b=09do_fpsimd_exc
+el0_sp_pc:
+=09/*
+=09 * Stack or PC alignment exception handling
+=09 */
+=09mrs=09x0, far_el1
+=09disable_step x1
+=09isb
+=09enable_dbg
+=09// enable interrupts before calling the main handler
+=09enable_irq
+=09mov=09x1, x25
+=09mov=09x2, sp
+=09b=09do_sp_pc_abort
+el0_undef:
+=09/*
+=09 *Undefined instruction
+=09 */
+=09mov=09x0, sp
+=09b=09do_undefinstr
+el0_dbg:
+=09/*
+=09 * Debug exception handling
+=09 */
+=09tbnz=09x24, #0, el0_inv=09=09// EL0 only
+=09mrs=09x0, far_el1
+=09disable_step x1
+=09mov=09x1, x25
+=09mov=09x2, sp
+=09b=09do_debug_exception
+el0_inv:
+=09mov=09x0, sp
+=09mov=09x1, #BAD_SYNC
+=09mrs=09x2, esr_el1
+=09b=09bad_mode
+ENDPROC(el0_sync)
+
+=09.align=096
+el0_irq:
+=09kernel_entry 0
+el0_irq_naked:
+=09disable_step x1
+=09isb
+=09enable_dbg
+#ifdef CONFIG_TRACE_IRQFLAGS
+=09bl=09trace_hardirqs_off
+#endif
+=09get_thread_info tsk
+#ifdef CONFIG_PREEMPT
+=09ldr=09x24, [tsk, #TI_PREEMPT]=09=09// get preempt count
+=09add=09x23, x24, #1=09=09=09// increment it
+=09str=09x23, [tsk, #TI_PREEMPT]
+#endif
+=09irq_handler
+#ifdef CONFIG_PREEMPT
+=09ldr=09x0, [tsk, #TI_PREEMPT]
+=09str=09x24, [tsk, #TI_PREEMPT]
+=09cmp=09x0, x23
+=09b.eq=091f
+=09mov=09x1, #0
+=09str=09x1, [x1]=09=09=09// BUG
+1:
+#endif
+#ifdef CONFIG_TRACE_IRQFLAGS
+=09bl=09trace_hardirqs_on
+#endif
+=09b=09ret_to_user
+ENDPROC(el0_irq)
+
+/*
+ * This is the return code to user mode for abort handlers
+ */
+ENTRY(ret_from_exception)
+=09get_thread_info tsk
+=09b=09ret_to_user
+ENDPROC(ret_from_exception)
+
+/*
+ * Register switch for AArch64. The callee-saved registers need to be save=
d
+ * and restored. On entry:
+ *   x0 =3D previous task_struct (must be preserved across the switch)
+ *   x1 =3D next task_struct
+ * Previous and next are guaranteed not to be the same.
+ *
+ */
+ENTRY(cpu_switch_to)
+=09add=09x8, x0, #THREAD_CPU_CONTEXT
+=09mov=09x9, sp
+=09stp=09x19, x20, [x8], #16=09=09// store callee-saved registers
+=09stp=09x21, x22, [x8], #16
+=09stp=09x23, x24, [x8], #16
+=09stp=09x25, x26, [x8], #16
+=09stp=09x27, x28, [x8], #16
+=09stp=09x29, x9, [x8], #16
+=09str=09lr, [x8]
+=09add=09x8, x1, #THREAD_CPU_CONTEXT
+=09ldp=09x19, x20, [x8], #16=09=09// restore callee-saved registers
+=09ldp=09x21, x22, [x8], #16
+=09ldp=09x23, x24, [x8], #16
+=09ldp=09x25, x26, [x8], #16
+=09ldp=09x27, x28, [x8], #16
+=09ldp=09x29, x9, [x8], #16
+=09ldr=09lr, [x8]
+=09mov=09sp, x9
+=09ret
+ENDPROC(cpu_switch_to)
+
+/*
+ * This is the fast syscall return path.  We do as little as possible here=
,
+ * and this includes saving x0 back into the kernel stack.
+ */
+ret_fast_syscall:
+=09disable_irq=09=09=09=09// disable interrupts
+=09ldr=09x1, [tsk, #TI_FLAGS]
+=09and=09x2, x1, #_TIF_WORK_MASK
+=09cbnz=09x2, fast_work_pending
+=09tbz=09x1, #TIF_SINGLESTEP, fast_exit
+=09disable_dbg
+=09enable_step x2
+fast_exit:
+=09kernel_exit 0, ret =3D 1
+
+/*
+ * Ok, we need to do extra processing, enter the slow path.
+ */
+fast_work_pending:
+=09str=09x0, [sp, #S_X0]=09=09=09// returned x0
+work_pending:
+=09tbnz=09x1, #TIF_NEED_RESCHED, work_resched
+=09/* TIF_SIGPENDING or TIF_NOTIFY_RESUME case */
+=09ldr=09x2, [sp, #S_PSTATE]
+=09mov=09x0, sp=09=09=09=09// 'regs'
+=09tst=09x2, #PSR_MODE_MASK=09=09// user mode regs?
+=09b.ne=09no_work_pending=09=09=09// returning to kernel
+=09bl=09do_notify_resume
+=09b=09ret_to_user
+work_resched:
+=09enable_dbg
+=09bl=09schedule
+
+/*
+ * "slow" syscall return path.
+ */
+ENTRY(ret_to_user)
+=09disable_irq=09=09=09=09// disable interrupts
+=09ldr=09x1, [tsk, #TI_FLAGS]
+=09and=09x2, x1, #_TIF_WORK_MASK
+=09cbnz=09x2, work_pending
+=09tbz=09x1, #TIF_SINGLESTEP, no_work_pending
+=09disable_dbg
+=09enable_step x2
+no_work_pending:
+=09kernel_exit 0, ret =3D 0
+ENDPROC(ret_to_user)
+
+/*
+ * This is how we return from a fork.
+ */
+ENTRY(ret_from_fork)
+=09bl=09schedule_tail
+=09get_thread_info tsk
+=09b=09ret_to_user
+ENDPROC(ret_from_fork)
+
+/*
+ * SVC handler.
+ */
+=09.align=096
+ENTRY(el0_svc)
+=09adrp=09stbl, sys_call_table=09=09// load syscall table pointer
+=09uxtw=09scno, w8=09=09=09// syscall number in w8
+=09mov=09sc_nr, #__NR_syscalls
+el0_svc_naked:=09=09=09=09=09// compat entry point
+=09stp=09x0, scno, [sp, #S_ORIG_X0]=09// save the original x0 and syscall =
number
+=09disable_step x16
+=09isb
+=09enable_dbg
+=09enable_irq
+
+=09get_thread_info tsk
+=09ldr=09x16, [tsk, #TI_FLAGS]=09=09// check for syscall tracing
+=09tbnz=09x16, #TIF_SYSCALL_TRACE, __sys_trace // are we tracing syscalls?
+=09adr=09lr, ret_fast_syscall=09=09// return address
+=09cmp     scno, sc_nr                     // check upper syscall limit
+=09b.hs=09ni_sys
+=09ldr=09x16, [stbl, scno, lsl #3]=09// address in the syscall table
+=09br=09x16=09=09=09=09// call sys_* routine
+ni_sys:
+=09mov=09x0, sp
+=09b=09do_ni_syscall
+ENDPROC(el0_svc)
+
+=09/*
+=09 * This is the really slow path.  We're going to be doing context
+=09 * switches, and waiting for our parent to respond.
+=09 */
+__sys_trace:
+=09mov=09x1, sp
+=09mov=09w0, #0=09=09=09=09// trace entry
+=09bl=09syscall_trace
+=09adr=09lr, __sys_trace_return=09=09// return address
+=09uxtw=09scno, w0=09=09=09// syscall number (possibly new)
+=09mov=09x1, sp=09=09=09=09// pointer to regs
+=09cmp=09scno, sc_nr=09=09=09// check upper syscall limit
+=09b.hs=09ni_sys
+=09ldp=09x0, x1, [sp]=09=09=09// restore the syscall args
+=09ldp=09x2, x3, [sp, #S_X2]
+=09ldp=09x4, x5, [sp, #S_X4]
+=09ldp=09x6, x7, [sp, #S_X6]
+=09ldr=09x16, [stbl, scno, lsl #3]=09// address in the syscall table
+=09br=09x16=09=09=09=09// call sys_* routine
+
+__sys_trace_return:
+=09str=09x0, [sp]=09=09=09// save returned x0
+=09mov=09x1, sp
+=09mov=09w0, #1=09=09=09=09// trace exit
+=09bl=09syscall_trace
+=09b=09ret_to_user
+
+/*
+ * Special system call wrappers.
+ */
+ENTRY(sys_execve_wrapper)
+=09mov=09x3, sp
+=09b=09sys_execve
+ENDPROC(sys_execve_wrapper)
+
+ENTRY(sys_clone_wrapper)
+=09mov=09x5, sp
+=09b=09sys_clone
+ENDPROC(sys_clone_wrapper)
+
+ENTRY(sys_rt_sigreturn_wrapper)
+=09mov=09x0, sp
+=09b=09sys_rt_sigreturn
+ENDPROC(sys_rt_sigreturn_wrapper)
+
+ENTRY(sys_sigaltstack_wrapper)
+=09ldr=09x2, [sp, #S_SP]
+=09b=09sys_sigaltstack
+ENDPROC(sys_sigaltstack_wrapper)
+
+ENTRY(handle_arch_irq)
+=09.quad=090
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.=
c
new file mode 100644
index 0000000..d25459f
--- /dev/null
+++ b/arch/arm64/kernel/stacktrace.c
@@ -0,0 +1,127 @@
+/*
+ * Stack tracing support
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
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/stacktrace.h>
+
+#include <asm/stacktrace.h>
+
+/*
+ * AArch64 PCS assigns the frame pointer to x29.
+ *
+ * A simple function prologue looks like this:
+ * =09sub=09sp, sp, #0x10
+ *   =09stp=09x29, x30, [sp]
+ *=09mov=09x29, sp
+ *
+ * A simple function epilogue looks like this:
+ *=09mov=09sp, x29
+ *=09ldp=09x29, x30, [sp]
+ *=09add=09sp, sp, #0x10
+ */
+int unwind_frame(struct stackframe *frame)
+{
+=09unsigned long high, low;
+=09unsigned long fp =3D frame->fp;
+
+=09low  =3D frame->sp;
+=09high =3D ALIGN(low, THREAD_SIZE);
+
+=09if (fp < low || fp > high || fp & 0xf)
+=09=09return -EINVAL;
+
+=09frame->sp =3D fp + 0x10;
+=09frame->fp =3D *(unsigned long *)(fp);
+=09frame->pc =3D *(unsigned long *)(fp + 8);
+
+=09return 0;
+}
+
+void notrace walk_stackframe(struct stackframe *frame,
+=09=09     int (*fn)(struct stackframe *, void *), void *data)
+{
+=09while (1) {
+=09=09int ret;
+
+=09=09if (fn(frame, data))
+=09=09=09break;
+=09=09ret =3D unwind_frame(frame);
+=09=09if (ret < 0)
+=09=09=09break;
+=09}
+}
+EXPORT_SYMBOL(walk_stackframe);
+
+#ifdef CONFIG_STACKTRACE
+struct stack_trace_data {
+=09struct stack_trace *trace;
+=09unsigned int no_sched_functions;
+=09unsigned int skip;
+};
+
+static int save_trace(struct stackframe *frame, void *d)
+{
+=09struct stack_trace_data *data =3D d;
+=09struct stack_trace *trace =3D data->trace;
+=09unsigned long addr =3D frame->pc;
+
+=09if (data->no_sched_functions && in_sched_functions(addr))
+=09=09return 0;
+=09if (data->skip) {
+=09=09data->skip--;
+=09=09return 0;
+=09}
+
+=09trace->entries[trace->nr_entries++] =3D addr;
+
+=09return trace->nr_entries >=3D trace->max_entries;
+}
+
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *tra=
ce)
+{
+=09struct stack_trace_data data;
+=09struct stackframe frame;
+
+=09data.trace =3D trace;
+=09data.skip =3D trace->skip;
+
+=09if (tsk !=3D current) {
+=09=09data.no_sched_functions =3D 1;
+=09=09frame.fp =3D thread_saved_fp(tsk);
+=09=09frame.sp =3D thread_saved_sp(tsk);
+=09=09frame.pc =3D thread_saved_pc(tsk);
+=09} else {
+=09=09register unsigned long current_sp asm("sp");
+=09=09data.no_sched_functions =3D 0;
+=09=09frame.fp =3D (unsigned long)__builtin_frame_address(0);
+=09=09frame.sp =3D current_sp;
+=09=09frame.pc =3D (unsigned long)save_stack_trace_tsk;
+=09}
+
+=09walk_stackframe(&frame, save_trace, &data);
+=09if (trace->nr_entries < trace->max_entries)
+=09=09trace->entries[trace->nr_entries++] =3D ULONG_MAX;
+}
+
+void save_stack_trace(struct stack_trace *trace)
+{
+=09save_stack_trace_tsk(current, trace);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace);
+#endif
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
new file mode 100644
index 0000000..8712a8e
--- /dev/null
+++ b/arch/arm64/kernel/traps.c
@@ -0,0 +1,357 @@
+/*
+ * Based on arch/arm/kernel/traps.c
+ *
+ * Copyright (C) 1995-2009 Russell King
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
+#include <linux/signal.h>
+#include <linux/personality.h>
+#include <linux/kallsyms.h>
+#include <linux/spinlock.h>
+#include <linux/uaccess.h>
+#include <linux/hardirq.h>
+#include <linux/kdebug.h>
+#include <linux/module.h>
+#include <linux/kexec.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/syscalls.h>
+
+#include <asm/atomic.h>
+#include <asm/traps.h>
+#include <asm/stacktrace.h>
+#include <asm/exception.h>
+#include <asm/system_misc.h>
+
+static const char *handler[]=3D {
+=09"Synchronous Abort",
+=09"IRQ",
+=09"FIQ",
+=09"Error"
+};
+
+int show_unhandled_signals =3D 1;
+
+/*
+ * Dump out the contents of some memory nicely...
+ */
+static void dump_mem(const char *lvl, const char *str, unsigned long botto=
m,
+=09=09     unsigned long top)
+{
+=09unsigned long first;
+=09mm_segment_t fs;
+=09int i;
+
+=09/*
+=09 * We need to switch to kernel mode so that we can use __get_user
+=09 * to safely read from kernel space.  Note that we now dump the
+=09 * code first, just in case the backtrace kills us.
+=09 */
+=09fs =3D get_fs();
+=09set_fs(KERNEL_DS);
+
+=09printk("%s%s(0x%016lx to 0x%016lx)\n", lvl, str, bottom, top);
+
+=09for (first =3D bottom & ~31; first < top; first +=3D 32) {
+=09=09unsigned long p;
+=09=09char str[sizeof(" 12345678") * 8 + 1];
+
+=09=09memset(str, ' ', sizeof(str));
+=09=09str[sizeof(str) - 1] =3D '\0';
+
+=09=09for (p =3D first, i =3D 0; i < 8 && p < top; i++, p +=3D 4) {
+=09=09=09if (p >=3D bottom && p < top) {
+=09=09=09=09unsigned int val;
+=09=09=09=09if (__get_user(val, (unsigned int *)p) =3D=3D 0)
+=09=09=09=09=09sprintf(str + i * 9, " %08x", val);
+=09=09=09=09else
+=09=09=09=09=09sprintf(str + i * 9, " ????????");
+=09=09=09}
+=09=09}
+=09=09printk("%s%04lx:%s\n", lvl, first & 0xffff, str);
+=09}
+
+=09set_fs(fs);
+}
+
+static void dump_backtrace_entry(unsigned long where, unsigned long stack)
+{
+=09print_ip_sym(where);
+=09if (in_exception_text(where))
+=09=09dump_mem("", "Exception stack", stack,
+=09=09=09 stack + sizeof(struct pt_regs));
+}
+
+static void dump_instr(const char *lvl, struct pt_regs *regs)
+{
+=09unsigned long addr =3D instruction_pointer(regs);
+=09mm_segment_t fs;
+=09char str[sizeof("00000000 ") * 5 + 2 + 1], *p =3D str;
+=09int i;
+
+=09/*
+=09 * We need to switch to kernel mode so that we can use __get_user
+=09 * to safely read from kernel space.  Note that we now dump the
+=09 * code first, just in case the backtrace kills us.
+=09 */
+=09fs =3D get_fs();
+=09set_fs(KERNEL_DS);
+
+=09for (i =3D -4; i < 1; i++) {
+=09=09unsigned int val, bad;
+
+=09=09bad =3D __get_user(val, &((u32 *)addr)[i]);
+
+=09=09if (!bad)
+=09=09=09p +=3D sprintf(p, i =3D=3D 0 ? "(%08x) " : "%08x ", val);
+=09=09else {
+=09=09=09p +=3D sprintf(p, "bad PC value");
+=09=09=09break;
+=09=09}
+=09}
+=09printk("%sCode: %s\n", lvl, str);
+
+=09set_fs(fs);
+}
+
+static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
+{
+=09struct stackframe frame;
+=09const register unsigned long current_sp asm ("sp");
+
+=09pr_debug("%s(regs =3D %p tsk =3D %p)\n", __func__, regs, tsk);
+
+=09if (!tsk)
+=09=09tsk =3D current;
+
+=09if (regs) {
+=09=09frame.fp =3D regs->regs[29];
+=09=09frame.sp =3D regs->sp;
+=09=09frame.pc =3D regs->pc;
+=09} else if (tsk =3D=3D current) {
+=09=09frame.fp =3D (unsigned long)__builtin_frame_address(0);
+=09=09frame.sp =3D current_sp;
+=09=09frame.pc =3D (unsigned long)dump_backtrace;
+=09} else {
+=09=09/*
+=09=09 * task blocked in __switch_to
+=09=09 */
+=09=09frame.fp =3D thread_saved_fp(tsk);
+=09=09frame.sp =3D thread_saved_sp(tsk);
+=09=09frame.pc =3D thread_saved_pc(tsk);
+=09}
+
+=09printk("Call trace:\n");
+=09while (1) {
+=09=09unsigned long where =3D frame.pc;
+=09=09int ret;
+
+=09=09ret =3D unwind_frame(&frame);
+=09=09if (ret < 0)
+=09=09=09break;
+=09=09dump_backtrace_entry(where, frame.sp);
+=09}
+}
+
+void dump_stack(void)
+{
+=09dump_backtrace(NULL, NULL);
+}
+
+EXPORT_SYMBOL(dump_stack);
+
+void show_stack(struct task_struct *tsk, unsigned long *sp)
+{
+=09dump_backtrace(NULL, tsk);
+=09barrier();
+}
+
+#ifdef CONFIG_PREEMPT
+#define S_PREEMPT " PREEMPT"
+#else
+#define S_PREEMPT ""
+#endif
+#ifdef CONFIG_SMP
+#define S_SMP " SMP"
+#else
+#define S_SMP ""
+#endif
+
+static int __die(const char *str, int err, struct thread_info *thread,
+=09=09 struct pt_regs *regs)
+{
+=09struct task_struct *tsk =3D thread->task;
+=09static int die_counter;
+=09int ret;
+
+=09pr_emerg("Internal error: %s: %x [#%d]" S_PREEMPT S_SMP "\n",
+=09=09 str, err, ++die_counter);
+
+=09/* trap and error numbers are mostly meaningless on ARM */
+=09ret =3D notify_die(DIE_OOPS, str, regs, err, 0, SIGSEGV);
+=09if (ret =3D=3D NOTIFY_STOP)
+=09=09return ret;
+
+=09print_modules();
+=09__show_regs(regs);
+=09pr_emerg("Process %.*s (pid: %d, stack limit =3D 0x%p)\n",
+=09=09 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), thread + 1);
+
+=09if (!user_mode(regs) || in_interrupt()) {
+=09=09dump_mem(KERN_EMERG, "Stack: ", regs->sp,
+=09=09=09 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
+=09=09dump_backtrace(regs, tsk);
+=09=09dump_instr(KERN_EMERG, regs);
+=09}
+
+=09return ret;
+}
+
+DEFINE_SPINLOCK(die_lock);
+
+/*
+ * This function is protected against re-entrancy.
+ */
+void die(const char *str, struct pt_regs *regs, int err)
+{
+=09struct thread_info *thread =3D current_thread_info();
+=09int ret;
+
+=09oops_enter();
+
+=09spin_lock_irq(&die_lock);
+=09console_verbose();
+=09bust_spinlocks(1);
+=09ret =3D __die(str, err, thread, regs);
+
+=09if (regs && kexec_should_crash(thread->task))
+=09=09crash_kexec(regs);
+
+=09bust_spinlocks(0);
+=09add_taint(TAINT_DIE);
+=09spin_unlock_irq(&die_lock);
+=09oops_exit();
+
+=09if (in_interrupt())
+=09=09panic("Fatal exception in interrupt");
+=09if (panic_on_oops)
+=09=09panic("Fatal exception");
+=09if (ret !=3D NOTIFY_STOP)
+=09=09do_exit(SIGSEGV);
+}
+
+void arm64_notify_die(const char *str, struct pt_regs *regs,
+=09=09      struct siginfo *info, int err)
+{
+=09if (user_mode(regs))
+=09=09force_sig_info(info->si_signo, info, current);
+=09else
+=09=09die(str, regs, err);
+}
+
+asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
+{
+=09siginfo_t info;
+=09void __user *pc =3D (void __user *)instruction_pointer(regs);
+
+#ifdef CONFIG_AARCH32_EMULATION
+=09/* check for AArch32 breakpoint instructions */
+=09if (compat_user_mode(regs) && aarch32_break_trap(regs) =3D=3D 0)
+=09=09return;
+#endif
+
+=09if (show_unhandled_signals) {
+=09=09pr_info("%s[%d]: undefined instruction: pc=3D%p\n",
+=09=09=09current->comm, task_pid_nr(current), pc);
+=09=09dump_instr(KERN_INFO, regs);
+=09}
+
+=09info.si_signo =3D SIGILL;
+=09info.si_errno =3D 0;
+=09info.si_code  =3D ILL_ILLOPC;
+=09info.si_addr  =3D pc;
+
+=09arm64_notify_die("Oops - undefined instruction", regs, &info, 0);
+}
+
+long compat_arm_syscall(struct pt_regs *regs);
+
+asmlinkage long do_ni_syscall(struct pt_regs *regs)
+{
+#ifdef CONFIG_AARCH32_EMULATION
+=09long ret;
+=09if (is_compat_task()) {
+=09=09ret =3D compat_arm_syscall(regs);
+=09=09if (ret !=3D -ENOSYS)
+=09=09=09return ret;
+=09}
+#endif
+
+=09if (show_unhandled_signals) {
+=09=09pr_info("%s[%d]: syscall %d\n", current->comm,
+=09=09=09task_pid_nr(current), (int)regs->syscallno);
+=09=09dump_instr("", regs);
+=09=09if (user_mode(regs))
+=09=09=09__show_regs(regs);
+=09}
+
+=09return sys_ni_syscall();
+}
+
+/*
+ * bad_mode handles the impossible case in the exception vector.
+ */
+asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int es=
r)
+{
+=09console_verbose();
+
+=09pr_crit("Bad mode in %s handler detected, code 0x%08x\n",
+=09=09handler[reason], esr);
+
+=09die("Oops - bad mode", regs, 0);
+=09local_irq_disable();
+=09panic("bad mode");
+}
+
+
+void __bad_xchg(volatile void *ptr, int size)
+{
+=09printk("xchg: bad data size: pc 0x%p, ptr 0x%p, size %d\n",
+=09=09__builtin_return_address(0), ptr, size);
+=09BUG();
+}
+EXPORT_SYMBOL(__bad_xchg);
+
+void __pte_error(const char *file, int line, unsigned long val)
+{
+=09printk("%s:%d: bad pte %016lx.\n", file, line, val);
+}
+
+void __pmd_error(const char *file, int line, unsigned long val)
+{
+=09printk("%s:%d: bad pmd %016lx.\n", file, line, val);
+}
+
+void __pgd_error(const char *file, int line, unsigned long val)
+{
+=09printk("%s:%d: bad pgd %016lx.\n", file, line, val);
+}
+
+void __init trap_init(void)
+{
+=09return;
+}

