From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2 2/5] ptrace: powerpc: implement
	user_single_step_siginfo()
Date: Thu, 12 Nov 2009 18:38:48 +0100
Message-ID: <20091112173848.GA12271@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39192 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861AbZKLRoH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Nov 2009 12:44:07 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Roland McGrath <roland@redhat.com>, Srinivasa Ds <srinivasa@in.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Suggested by Roland.

Implement user_single_step_siginfo() for powerpc.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Roland McGrath <roland@redhat.com>
---

 arch/powerpc/include/asm/ptrace.h |    2 ++
 arch/powerpc/kernel/traps.c       |    9 +++++++++
 2 files changed, 11 insertions(+)

--- TH/arch/powerpc/include/asm/ptrace.h~2_PPC_HELPER	2009-11-10 01:03:23.000000000 +0100
+++ TH/arch/powerpc/include/asm/ptrace.h	2009-11-10 21:48:53.000000000 +0100
@@ -140,6 +140,8 @@ extern void user_enable_single_step(stru
 extern void user_enable_block_step(struct task_struct *);
 extern void user_disable_single_step(struct task_struct *);
 
+#define ARCH_HAS_USER_SINGLE_STEP_INFO
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
--- TH/arch/powerpc/kernel/traps.c~2_PPC_HELPER	2009-11-10 01:06:41.000000000 +0100
+++ TH/arch/powerpc/kernel/traps.c	2009-11-10 21:52:45.000000000 +0100
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
