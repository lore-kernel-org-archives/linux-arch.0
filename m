From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 5/5] mips: do_sigaltstack() expects userland pointers
Date: Tue, 28 Sep 2010 18:50:57 +0100
Message-ID: <E1P0eKP-0006jZ-5F@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ralf@linux-mips.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


o32 compat does the right thing, native and n32 compat do not...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/kernel/signal.c     |    5 +----
 arch/mips/kernel/signal_n32.c |    5 +++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 604f077..5922342 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -390,7 +390,6 @@ asmlinkage void sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct rt_sigframe __user *frame;
 	sigset_t set;
-	stack_t st;
 	int sig;
 
 	frame = (struct rt_sigframe __user *) regs.regs[29];
@@ -411,11 +410,9 @@ asmlinkage void sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 	else if (sig)
 		force_sig(sig, current);
 
-	if (__copy_from_user(&st, &frame->rs_uc.uc_stack, sizeof(st)))
-		goto badframe;
 	/* It is more difficult to avoid calling this function than to
 	   call it and ignore errors.  */
-	do_sigaltstack((stack_t __user *)&st, NULL, regs.regs[29]);
+	do_sigaltstack(&frame->rs_uc.uc_stack, NULL, regs.regs[29]);
 
 	/*
 	 * Don't let your children do this ...
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 2c5df81..ee24d81 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -109,6 +109,7 @@ asmlinkage int sysn32_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
 asmlinkage void sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct rt_sigframe_n32 __user *frame;
+	mm_segment_t old_fs;
 	sigset_t set;
 	stack_t st;
 	s32 sp;
@@ -143,7 +144,11 @@ asmlinkage void sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 
 	/* It is more difficult to avoid calling this function than to
 	   call it and ignore errors.  */
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
 	do_sigaltstack((stack_t __user *)&st, NULL, regs.regs[29]);
+	set_fs(old_fs);
+
 
 	/*
 	 * Don't let your children do this ...
-- 
1.5.6.5
