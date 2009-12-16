From: akpm@linux-foundation.org
Subject: [patch 093/175] ptrace: powerpc: implement user_single_step_siginfo()
Date: Tue, 15 Dec 2009 16:47:18 -0800
Message-ID: <200912160047.nBG0lI2H024648@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53348 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753118AbZLPArs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Dec 2009 19:47:48 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, oleg@redhat.com, hpa@zytor.com, linux-arch@vger.kernel.org, mingo@elte.hu, roland@redhat.com, tglx@linutronix.de

From: Oleg Nesterov <oleg@redhat.com>

Suggested by Roland.

Implement user_single_step_siginfo() for powerpc.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Roland McGrath <roland@redhat.com>
Cc: <linux-arch@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/include/asm/ptrace.h |    2 ++
 arch/powerpc/kernel/traps.c       |    9 +++++++++
 2 files changed, 11 insertions(+)

diff -puN arch/powerpc/include/asm/ptrace.h~ptrace-powerpc-implement-user_single_step_siginfo arch/powerpc/include/asm/ptrace.h
--- a/arch/powerpc/include/asm/ptrace.h~ptrace-powerpc-implement-user_single_step_siginfo
+++ a/arch/powerpc/include/asm/ptrace.h
@@ -140,6 +140,8 @@ extern void user_enable_single_step(stru
 extern void user_enable_block_step(struct task_struct *);
 extern void user_disable_single_step(struct task_struct *);
 
+#define ARCH_HAS_USER_SINGLE_STEP_INFO
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -puN arch/powerpc/kernel/traps.c~ptrace-powerpc-implement-user_single_step_siginfo arch/powerpc/kernel/traps.c
--- a/arch/powerpc/kernel/traps.c~ptrace-powerpc-implement-user_single_step_siginfo
+++ a/arch/powerpc/kernel/traps.c
@@ -174,6 +174,15 @@ int die(const char *str, struct pt_regs 
 	return 0;
 }
 
+void user_single_step_siginfo(struct task_struct *tsk,
+				struct pt_regs *regs, siginfo_t *info)
+{
+	memset(info, 0, sizeof(*info));
+	info->si_signo = SIGTRAP;
+	info->si_code = TRAP_TRACE;
+	info->si_addr = (void __user *)regs->nip;
+}
+
 void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 {
 	siginfo_t info;
_
