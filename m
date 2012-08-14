Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55310 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756881Ab2HNRxM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:12 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 19/31] arm64: Signal handling support
Date: Tue, 14 Aug 2012 18:52:20 +0100
Message-ID: <1344966752-16102-20-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120814175220.TSDC-G5VBUz_1dY6A20bROuEw9aidNpEw-7_EZaYyMY@z>

This patch adds support for signal handling. The sigreturn is done via
VDSO, introduced by a previous patch. The SA_RESTORER is still defined
as it is required for 32-bit (compat) support but it is not to be used
for 64-bit applications.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/sigcontext.h |   69 ++++++
 arch/arm64/include/asm/siginfo.h    |   23 ++
 arch/arm64/include/asm/signal.h     |   24 ++
 arch/arm64/include/asm/ucontext.h   |   30 +++
 arch/arm64/kernel/signal.c          |  436 +++++++++++++++++++++++++++++++=
++++
 5 files changed, 582 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/sigcontext.h
 create mode 100644 arch/arm64/include/asm/siginfo.h
 create mode 100644 arch/arm64/include/asm/signal.h
 create mode 100644 arch/arm64/include/asm/ucontext.h
 create mode 100644 arch/arm64/kernel/signal.c

diff --git a/arch/arm64/include/asm/sigcontext.h b/arch/arm64/include/asm/s=
igcontext.h
new file mode 100644
index 0000000..573cec7
--- /dev/null
+++ b/arch/arm64/include/asm/sigcontext.h
@@ -0,0 +1,69 @@
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
+#ifndef __ASM_SIGCONTEXT_H
+#define __ASM_SIGCONTEXT_H
+
+#include <linux/types.h>
+
+/*
+ * Signal context structure - contains all info to do with the state
+ * before the signal handler was invoked.
+ */
+struct sigcontext {
+=09__u64 fault_address;
+=09/* AArch64 registers */
+=09__u64 regs[31];
+=09__u64 sp;
+=09__u64 pc;
+=09__u64 pstate;
+=09/* 4K reserved for FP/SIMD state and future expansion */
+=09__u8 __reserved[4096] __attribute__((__aligned__(16)));
+};
+
+/*
+ * Header to be used at the beginning of structures extending the user
+ * context. Such structures must be placed after the rt_sigframe on the st=
ack
+ * and be 16-byte aligned. The last structure must be a dummy one with the
+ * magic and size set to 0.
+ */
+struct _aarch64_ctx {
+=09__u32 magic;
+=09__u32 size;
+};
+
+#define FPSIMD_MAGIC=090x46508001
+
+struct fpsimd_context {
+=09struct _aarch64_ctx head;
+=09__u32 fpsr;
+=09__u32 fpcr;
+=09__uint128_t vregs[32];
+};
+
+#ifdef __KERNEL__
+/*
+ * Auxiliary context saved in the sigcontext.__reserved array. Not exporte=
d to
+ * user space as it will change with the addition of new context. User spa=
ce
+ * should check the magic/size information.
+ */
+struct aux_context {
+=09struct fpsimd_context fpsimd;
+=09/* additional context to be added before "end" */
+=09struct _aarch64_ctx end;
+};
+#endif
+
+#endif
diff --git a/arch/arm64/include/asm/siginfo.h b/arch/arm64/include/asm/sigi=
nfo.h
new file mode 100644
index 0000000..5a74a08
--- /dev/null
+++ b/arch/arm64/include/asm/siginfo.h
@@ -0,0 +1,23 @@
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
+#ifndef __ASM_SIGINFO_H
+#define __ASM_SIGINFO_H
+
+#define __ARCH_SI_PREAMBLE_SIZE=09(4 * sizeof(int))
+
+#include <asm-generic/siginfo.h>
+
+#endif
diff --git a/arch/arm64/include/asm/signal.h b/arch/arm64/include/asm/signa=
l.h
new file mode 100644
index 0000000..8d1e723
--- /dev/null
+++ b/arch/arm64/include/asm/signal.h
@@ -0,0 +1,24 @@
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
+#ifndef __ASM_SIGNAL_H
+#define __ASM_SIGNAL_H
+
+/* Required for AArch32 compatibility. */
+#define SA_RESTORER=090x04000000
+
+#include <asm-generic/signal.h>
+
+#endif
diff --git a/arch/arm64/include/asm/ucontext.h b/arch/arm64/include/asm/uco=
ntext.h
new file mode 100644
index 0000000..bde9607
--- /dev/null
+++ b/arch/arm64/include/asm/ucontext.h
@@ -0,0 +1,30 @@
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
+#ifndef __ASM_UCONTEXT_H
+#define __ASM_UCONTEXT_H
+
+struct ucontext {
+=09unsigned long=09  uc_flags;
+=09struct ucontext=09 *uc_link;
+=09stack_t=09=09  uc_stack;
+=09sigset_t=09  uc_sigmask;
+=09/* glibc uses a 1024-bit sigset_t */
+=09__u8=09=09  __unused[(1024 - sizeof(sigset_t)) / 8];
+=09/* last for future expansion */
+=09struct sigcontext uc_mcontext;
+};
+
+#endif /* __ASM_UCONTEXT_H */
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
new file mode 100644
index 0000000..a8f29d2
--- /dev/null
+++ b/arch/arm64/kernel/signal.c
@@ -0,0 +1,436 @@
+/*
+ * Based on arch/arm/kernel/signal.c
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
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/personality.h>
+#include <linux/freezer.h>
+#include <linux/uaccess.h>
+#include <linux/tracehook.h>
+#include <linux/ratelimit.h>
+
+#include <asm/debug-monitors.h>
+#include <asm/elf.h>
+#include <asm/cacheflush.h>
+#include <asm/ucontext.h>
+#include <asm/unistd.h>
+#include <asm/fpsimd.h>
+#include <asm/signal32.h>
+#include <asm/vdso.h>
+
+/*
+ * Do a signal return; undo the signal stack. These are aligned to 128-bit=
.
+ */
+struct rt_sigframe {
+=09struct siginfo info;
+=09struct ucontext uc;
+};
+
+static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
+{
+=09struct fpsimd_state *fpsimd =3D &current->thread.fpsimd_state;
+=09int err;
+
+=09/* dump the hardware registers to the fpsimd_state structure */
+=09fpsimd_save_state(fpsimd);
+
+=09/* copy the FP and status/control registers */
+=09err =3D __copy_to_user(ctx->vregs, fpsimd->vregs, sizeof(fpsimd->vregs)=
);
+=09__put_user_error(fpsimd->fpsr, &ctx->fpsr, err);
+=09__put_user_error(fpsimd->fpcr, &ctx->fpcr, err);
+
+=09/* copy the magic/size information */
+=09__put_user_error(FPSIMD_MAGIC, &ctx->head.magic, err);
+=09__put_user_error(sizeof(struct fpsimd_context), &ctx->head.size, err);
+
+=09return err ? -EFAULT : 0;
+}
+
+static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
+{
+=09struct fpsimd_state fpsimd;
+=09__u32 magic, size;
+=09int err =3D 0;
+
+=09/* check the magic/size information */
+=09__get_user_error(magic, &ctx->head.magic, err);
+=09__get_user_error(size, &ctx->head.size, err);
+=09if (err)
+=09=09return -EFAULT;
+=09if (magic !=3D FPSIMD_MAGIC || size !=3D sizeof(struct fpsimd_context))
+=09=09return -EINVAL;
+
+=09/* copy the FP and status/control registers */
+=09err =3D __copy_from_user(fpsimd.vregs, ctx->vregs,
+=09=09=09       sizeof(fpsimd.vregs));
+=09__get_user_error(fpsimd.fpsr, &ctx->fpsr, err);
+=09__get_user_error(fpsimd.fpcr, &ctx->fpcr, err);
+
+=09/* load the hardware registers from the fpsimd_state structure */
+=09if (!err) {
+=09=09preempt_disable();
+=09=09fpsimd_load_state(&fpsimd);
+=09=09preempt_enable();
+=09}
+
+=09return err ? -EFAULT : 0;
+}
+
+static int restore_sigframe(struct pt_regs *regs,
+=09=09=09    struct rt_sigframe __user *sf)
+{
+=09sigset_t set;
+=09int i, err;
+=09struct aux_context __user *aux =3D
+=09=09(struct aux_context __user *)sf->uc.uc_mcontext.__reserved;
+
+=09err =3D __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
+=09if (err =3D=3D 0)
+=09=09set_current_blocked(&set);
+
+=09for (i =3D 0; i < 31; i++)
+=09=09__get_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
+=09=09=09=09 err);
+=09__get_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
+=09__get_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
+=09__get_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
+
+=09/*
+=09 * Avoid sys_rt_sigreturn() restarting.
+=09 */
+=09regs->syscallno =3D ~0UL;
+
+=09err |=3D !valid_user_regs(&regs->user_regs);
+
+=09if (err =3D=3D 0)
+=09=09err |=3D restore_fpsimd_context(&aux->fpsimd);
+
+=09return err;
+}
+
+asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
+{
+=09struct rt_sigframe __user *frame;
+
+=09/* Always make any pending restarted system calls return -EINTR */
+=09current_thread_info()->restart_block.fn =3D do_no_restart_syscall;
+
+=09/*
+=09 * Since we stacked the signal on a 128-bit boundary, then 'sp' should
+=09 * be word aligned here.
+=09 */
+=09if (regs->sp & 15)
+=09=09goto badframe;
+
+=09frame =3D (struct rt_sigframe __user *)regs->sp;
+
+=09if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
+=09=09goto badframe;
+
+=09if (restore_sigframe(regs, frame))
+=09=09goto badframe;
+
+=09if (do_sigaltstack(&frame->uc.uc_stack,
+=09=09=09   NULL, regs->sp) =3D=3D -EFAULT)
+=09=09goto badframe;
+
+=09return regs->regs[0];
+
+badframe:
+=09if (show_unhandled_signals)
+=09=09printk_ratelimited(KERN_INFO "%s[%d]: bad frame in %s: pc=3D%08llx s=
p=3D%08llx\n",
+=09=09=09=09   current->comm, task_pid_nr(current), __func__,
+=09=09=09=09   regs->pc, regs->sp);
+=09force_sig(SIGSEGV, current);
+=09return 0;
+}
+
+asmlinkage long sys_sigaltstack(const stack_t __user *uss, stack_t __user =
*uoss,
+=09=09=09=09unsigned long sp)
+{
+=09return do_sigaltstack(uss, uoss, sp);
+}
+
+static int setup_sigframe(struct rt_sigframe __user *sf,
+=09=09=09  struct pt_regs *regs, sigset_t *set)
+{
+=09int i, err =3D 0;
+=09struct aux_context __user *aux =3D
+=09=09(struct aux_context __user *)sf->uc.uc_mcontext.__reserved;
+
+=09for (i =3D 0; i < 31; i++)
+=09=09__put_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
+=09=09=09=09 err);
+=09__put_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
+=09__put_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
+=09__put_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
+
+=09__put_user_error(current->thread.fault_address, &sf->uc.uc_mcontext.fau=
lt_address, err);
+
+=09err |=3D __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
+
+=09if (err =3D=3D 0)
+=09=09err |=3D preserve_fpsimd_context(&aux->fpsimd);
+
+=09/* set the "end" magic */
+=09__put_user_error(0, &aux->end.magic, err);
+=09__put_user_error(0, &aux->end.size, err);
+
+=09return err;
+}
+
+static void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *r=
egs,
+=09=09=09=09 int framesize)
+{
+=09unsigned long sp, sp_top;
+=09void __user *frame;
+
+=09sp =3D sp_top =3D regs->sp;
+
+=09/*
+=09 * This is the X/Open sanctioned signal stack switching.
+=09 */
+=09if ((ka->sa.sa_flags & SA_ONSTACK) && !sas_ss_flags(sp))
+=09=09sp =3D sp_top =3D current->sas_ss_sp + current->sas_ss_size;
+
+=09/* room for stack frame (FP, LR) */
+=09sp -=3D 16;
+
+=09sp =3D (sp - framesize) & ~15;
+=09frame =3D (void __user *)sp;
+
+=09/*
+=09 * Check that we can actually write to the signal frame.
+=09 */
+=09if (!access_ok(VERIFY_WRITE, frame, sp_top - sp))
+=09=09frame =3D NULL;
+
+=09return frame;
+}
+
+static int setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+=09=09=09void __user *frame, int usig)
+{
+=09int err =3D 0;
+=09__sigrestore_t sigtramp;
+=09unsigned long __user *sp =3D (unsigned long __user *)regs->sp;
+
+=09/* set up the stack frame */
+=09__put_user_error(regs->regs[29], sp - 2, err);
+=09__put_user_error(regs->regs[30], sp - 1, err);
+
+=09regs->regs[0] =3D usig;
+=09regs->regs[29] =3D regs->sp - 16;
+=09regs->sp =3D (unsigned long)frame;
+=09regs->pc =3D (unsigned long)ka->sa.sa_handler;
+
+=09if (ka->sa.sa_flags & SA_RESTORER)
+=09=09sigtramp =3D ka->sa.sa_restorer;
+=09else
+=09=09sigtramp =3D VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
+
+=09regs->regs[30] =3D (unsigned long)sigtramp;
+
+=09return err;
+}
+
+static int setup_rt_frame(int usig, struct k_sigaction *ka, siginfo_t *inf=
o,
+=09=09=09  sigset_t *set, struct pt_regs *regs)
+{
+=09struct rt_sigframe __user *frame;
+=09stack_t stack;
+=09int err =3D 0;
+
+=09frame =3D get_sigframe(ka, regs, sizeof(*frame));
+=09if (!frame)
+=09=09return 1;
+
+=09__put_user_error(0, &frame->uc.uc_flags, err);
+=09__put_user_error(NULL, &frame->uc.uc_link, err);
+
+=09memset(&stack, 0, sizeof(stack));
+=09stack.ss_sp =3D (void __user *)current->sas_ss_sp;
+=09stack.ss_flags =3D sas_ss_flags(regs->sp);
+=09stack.ss_size =3D current->sas_ss_size;
+=09err |=3D __copy_to_user(&frame->uc.uc_stack, &stack, sizeof(stack));
+
+=09err |=3D setup_sigframe(frame, regs, set);
+=09if (err =3D=3D 0)
+=09=09err =3D setup_return(regs, ka, frame, usig);
+
+=09if (err =3D=3D 0 && ka->sa.sa_flags & SA_SIGINFO) {
+=09=09err |=3D copy_siginfo_to_user(&frame->info, info);
+=09=09regs->regs[1] =3D (unsigned long)&frame->info;
+=09=09regs->regs[2] =3D (unsigned long)&frame->uc;
+=09}
+
+=09return err;
+}
+
+static void setup_restart_syscall(struct pt_regs *regs)
+{
+=09if (test_thread_flag(TIF_32BIT))
+=09=09compat_setup_restart_syscall(regs);
+=09else
+=09=09regs->regs[8] =3D __NR_restart_syscall;
+}
+
+/*
+ * OK, we're invoking a handler
+ */
+static void handle_signal(unsigned long sig, struct k_sigaction *ka,
+=09=09=09  siginfo_t *info, struct pt_regs *regs)
+{
+=09struct thread_info *thread =3D current_thread_info();
+=09struct task_struct *tsk =3D current;
+=09sigset_t *oldset =3D sigmask_to_save();
+=09int usig =3D sig;
+=09int ret;
+
+=09/*
+=09 * translate the signal
+=09 */
+=09if (usig < 32 && thread->exec_domain && thread->exec_domain->signal_inv=
map)
+=09=09usig =3D thread->exec_domain->signal_invmap[usig];
+
+=09/*
+=09 * Set up the stack frame
+=09 */
+=09if (test_thread_flag(TIF_32BIT)) {
+=09=09if (ka->sa.sa_flags & SA_SIGINFO)
+=09=09=09ret =3D compat_setup_rt_frame(usig, ka, info, oldset,
+=09=09=09=09=09=09    regs);
+=09=09else
+=09=09=09ret =3D compat_setup_frame(usig, ka, oldset, regs);
+=09} else {
+=09=09ret =3D setup_rt_frame(usig, ka, info, oldset, regs);
+=09}
+
+=09/*
+=09 * Check that the resulting registers are actually sane.
+=09 */
+=09ret |=3D !valid_user_regs(&regs->user_regs);
+
+=09if (ret !=3D 0) {
+=09=09force_sigsegv(sig, tsk);
+=09=09return;
+=09}
+
+=09/*
+=09 * Fast forward the stepping logic so we step into the signal
+=09 * handler.
+=09 */
+=09user_fastforward_single_step(tsk);
+
+=09signal_delivered(sig, info, ka, regs, 0);
+}
+
+/*
+ * Note that 'init' is a special process: it doesn't get signals it doesn'=
t
+ * want to handle. Thus you cannot kill init even with a SIGKILL even by
+ * mistake.
+ *
+ * Note that we go through the signals twice: once to check the signals th=
at
+ * the kernel can handle, and then we build all the user-level signal hand=
ling
+ * stack-frames in one go after that.
+ */
+static void do_signal(struct pt_regs *regs)
+{
+=09unsigned long continue_addr =3D 0, restart_addr =3D 0;
+=09struct k_sigaction ka;
+=09siginfo_t info;
+=09int signr, retval =3D 0;
+=09int syscall =3D (int)regs->syscallno;
+
+=09/*
+=09 * If we were from a system call, check for system call restarting...
+=09 */
+=09if (syscall >=3D 0) {
+=09=09continue_addr =3D regs->pc;
+=09=09restart_addr =3D continue_addr - (compat_thumb_mode(regs) ? 2 : 4);
+=09=09retval =3D regs->regs[0];
+
+=09=09/*
+=09=09 * Avoid additional syscall restarting via ret_to_user.
+=09=09 */
+=09=09regs->syscallno =3D ~0UL;
+
+=09=09/*
+=09=09 * Prepare for system call restart. We do this here so that a
+=09=09 * debugger will see the already changed PC.
+=09=09 */
+=09=09switch (retval) {
+=09=09case -ERESTARTNOHAND:
+=09=09case -ERESTARTSYS:
+=09=09case -ERESTARTNOINTR:
+=09=09case -ERESTART_RESTARTBLOCK:
+=09=09=09regs->regs[0] =3D regs->orig_x0;
+=09=09=09regs->pc =3D restart_addr;
+=09=09=09break;
+=09=09}
+=09}
+
+=09/*
+=09 * Get the signal to deliver. When running under ptrace, at this point
+=09 * the debugger may change all of our registers.
+=09 */
+=09signr =3D get_signal_to_deliver(&info, &ka, regs, NULL);
+=09if (signr > 0) {
+=09=09/*
+=09=09 * Depending on the signal settings, we may need to revert the
+=09=09 * decision to restart the system call, but skip this if a
+=09=09 * debugger has chosen to restart at a different PC.
+=09=09 */
+=09=09if (regs->pc =3D=3D restart_addr &&
+=09=09    (retval =3D=3D -ERESTARTNOHAND ||
+=09=09     retval =3D=3D -ERESTART_RESTARTBLOCK ||
+=09=09     (retval =3D=3D -ERESTARTSYS &&
+=09=09      !(ka.sa.sa_flags & SA_RESTART)))) {
+=09=09=09regs->regs[0] =3D -EINTR;
+=09=09=09regs->pc =3D continue_addr;
+=09=09}
+
+=09=09handle_signal(signr, &ka, &info, regs);
+=09=09return;
+=09}
+
+=09/*
+=09 * Handle restarting a different system call. As above, if a debugger
+=09 * has chosen to restart at a different PC, ignore the restart.
+=09 */
+=09if (syscall >=3D 0 && regs->pc =3D=3D restart_addr) {
+=09=09if (retval =3D=3D -ERESTART_RESTARTBLOCK)
+=09=09=09setup_restart_syscall(regs);
+=09=09user_rewind_single_step(current);
+=09}
+
+=09restore_saved_sigmask();
+}
+
+asmlinkage void do_notify_resume(struct pt_regs *regs,
+=09=09=09=09 unsigned int thread_flags)
+{
+=09if (thread_flags & _TIF_SIGPENDING)
+=09=09do_signal(regs);
+
+=09if (thread_flags & _TIF_NOTIFY_RESUME) {
+=09=09clear_thread_flag(TIF_NOTIFY_RESUME);
+=09=09tracehook_notify_resume(regs);
+=09}
+}

