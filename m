Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfDBIDR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Apr 2019 04:03:17 -0400
From: guoren@kernel.org
Subject: [PATCH 1/3] csky: Use in_syscall & forget_syscall instead of r11_sig
Date: Tue,  2 Apr 2019 16:02:31 +0800
Message-ID: <1554192153-2587-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, palmer@sifive.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ren_guo@c-sky.com, linux-riscv@lists.infradead.org
Message-ID: <20190402080231.DvFXNv4F6B20Ahusg-QmGo0y_hPqX-MDAZNVcrhxq78@z>

From: Guo Ren <ren_guo@c-sky.com>

We could use regs->sr 16-24 bits to detect syscall: VEC_TRAP0 and
r11_sig is no necessary for current implementation.

In this patch, we implement the in_syscall and forget_syscall which are
inspired from arm & nds32, but csky pt_regs has no syscall_num element
and we just set zero to regs->sr's vector-bits-field instead.

For ret_from_fork, current task was forked from parent which is in syscall
progress and its regs->sr has been already setted with VEC_TRAP0. See:
arch/csky/kernel/process.c: copy_thread()

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv1/inc/abi/regdef.h |  2 --
 arch/csky/abiv2/inc/abi/regdef.h |  2 --
 arch/csky/include/asm/ptrace.h   | 12 ++++++++++++
 arch/csky/kernel/entry.S         | 11 +----------
 arch/csky/kernel/signal.c        | 15 +++++++++------
 5 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/regdef.h b/arch/csky/abiv1/inc/abi/regdef.h
index 8766892..9e7e692 100644
--- a/arch/csky/abiv1/inc/abi/regdef.h
+++ b/arch/csky/abiv1/inc/abi/regdef.h
@@ -5,8 +5,6 @@
 #define __ASM_CSKY_REGDEF_H
 
 #define syscallid	r1
-#define r11_sig		r11
-
 #define regs_syscallid(regs) regs->regs[9]
 
 /*
diff --git a/arch/csky/abiv2/inc/abi/regdef.h b/arch/csky/abiv2/inc/abi/regdef.h
index c72abb7..652f5ce 100644
--- a/arch/csky/abiv2/inc/abi/regdef.h
+++ b/arch/csky/abiv2/inc/abi/regdef.h
@@ -5,8 +5,6 @@
 #define __ASM_CSKY_REGDEF_H
 
 #define syscallid	r7
-#define r11_sig		r11
-
 #define regs_syscallid(regs) regs->regs[3]
 
 /*
diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptrace.h
index 1e00578..d0aba7b 100644
--- a/arch/csky/include/asm/ptrace.h
+++ b/arch/csky/include/asm/ptrace.h
@@ -5,6 +5,8 @@
 #define __ASM_CSKY_PTRACE_H
 
 #include <uapi/asm/ptrace.h>
+#include <asm/traps.h>
+#include <linux/types.h>
 
 #ifndef __ASSEMBLY__
 
@@ -20,6 +22,16 @@
 #define instruction_pointer(regs) ((regs)->pc)
 #define profile_pc(regs) instruction_pointer(regs)
 
+static inline bool in_syscall(struct pt_regs const *regs)
+{
+	return ((regs->sr >> 16) & 0xff) == VEC_TRAP0;
+}
+
+static inline void forget_syscall(struct pt_regs *regs)
+{
+	regs->sr &= ~(0xff << 16);
+}
+
 static inline unsigned long regs_return_value(struct pt_regs *regs)
 {
 	return regs->a0;
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index c18859a..d40fbd5 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -32,7 +32,6 @@
 	RD_MEH	a1
 	psrset  ee, ie
 	jbsr    do_page_fault
-	movi    r11_sig, 0             /* r11 = 0, Not a syscall. */
 	jmpi    ret_from_exception
 .endm
 
@@ -125,7 +124,6 @@ ENTRY(ret_from_fork)
 	bmaski	r10, THREAD_SHIFT
 	andn	r9, r10
 	ldw	r8, (r9, TINFO_FLAGS)
-	movi	r11_sig, 1
 	ANDI_R3	r8, (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)
 	cmpnei	r8, 0
 	bf	3f
@@ -160,12 +158,8 @@ exit_work:
 	/* If thread_info->flag is empty, RESTORE_ALL */
 	cmpnei	r8, 0
 	bf	1b
-	mov	a1, sp
 	mov	a0, r8
-	mov	a2, r11_sig		/* syscall? */
-	btsti	r8, TIF_SIGPENDING	/* delivering a signal? */
-	/* prevent further restarts(set r11 = 0) */
-	clrt	r11_sig
+	mov	a1, sp
 	jbsr	do_notify_resume	/* do signals */
 	br	resume_userspace
 
@@ -175,13 +169,11 @@ work_resched:
 	jmpi	schedule
 
 ENTRY(sys_rt_sigreturn)
-	movi	r11_sig, 0
 	jmpi	do_rt_sigreturn
 
 ENTRY(csky_trap)
 	SAVE_ALL EPC_KEEP
 	psrset	ee
-	movi	r11_sig, 0             /* r11 = 0, Not a syscall. */
 	mov	a0, sp                 /* Push Stack pointer arg */
 	jbsr	trap_c                 /* Call C-level trap handler */
 	jmpi	ret_from_exception
@@ -215,7 +207,6 @@ ENTRY(csky_get_tls)
 ENTRY(csky_irq)
 	SAVE_ALL EPC_KEEP
 	psrset	ee
-	movi	r11_sig, 0		/* r11 = 0, Not a syscall. */
 
 #ifdef CONFIG_PREEMPT
 	mov	r9, sp			/* Get current stack  pointer */
diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index 207a891..5a18940 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -224,7 +224,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
  * that the kernel can handle, and then we build all the user-level signal
  * handling stack-frames in one go after that.
  */
-static void do_signal(struct pt_regs *regs, int syscall)
+static void do_signal(struct pt_regs *regs)
 {
 	unsigned int retval = 0, continue_addr = 0, restart_addr = 0;
 	struct ksignal ksig;
@@ -241,7 +241,9 @@ static void do_signal(struct pt_regs *regs, int syscall)
 	/*
 	 * If we were from a system call, check for system call restarting...
 	 */
-	if (syscall) {
+	if (in_syscall(regs)) {
+		forget_syscall(regs);
+
 		continue_addr = regs->pc;
 #if defined(__CSKYABIV2__)
 		restart_addr = continue_addr - 4;
@@ -249,7 +251,6 @@ static void do_signal(struct pt_regs *regs, int syscall)
 		restart_addr = continue_addr - 2;
 #endif
 		retval = regs->a0;
-
 		/*
 		 * Prepare for system call restart.  We do this here so that a
 		 * debugger will see the already changed.
@@ -304,7 +305,9 @@ static void do_signal(struct pt_regs *regs, int syscall)
 	}
 
 no_signal:
-	if (syscall) {
+	if (in_syscall(regs)) {
+		forget_syscall(regs);
+
 		/*
 		 * Handle restarting a different system call.  As above,
 		 * if a debugger has chosen to restart at a different PC,
@@ -333,10 +336,10 @@ static void do_signal(struct pt_regs *regs, int syscall)
 }
 
 asmlinkage void
-do_notify_resume(unsigned int thread_flags, struct pt_regs *regs, int syscall)
+do_notify_resume(unsigned int thread_flags, struct pt_regs *regs)
 {
 	if (thread_flags & _TIF_SIGPENDING)
-		do_signal(regs, syscall);
+		do_signal(regs);
 
 	if (thread_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
-- 
2.7.4
