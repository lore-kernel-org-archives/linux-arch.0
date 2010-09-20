From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: powerpc: fix double syscall restarts
Date: Mon, 20 Sep 2010 21:51:53 +0100
Message-ID: <20100920205153.GG31363@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:36279 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757427Ab0ITUvy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Sep 2010 16:51:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1OxnL7-0000VM-Le
	for linux-arch@vger.kernel.org; Mon, 20 Sep 2010 20:51:53 +0000
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

[grrr... mangled address in previous posting]

Make sigreturn zero regs->trap, make do_signal() do the same on all
paths.  As it is, signal interrupting e.g. read() from fd 512 (==
ERESTARTSYS) with another signal getting unblocked when the first
handler finishes will lead to restart one insn earlier than it ought
to.  Same for multiple signals with in-kernel handlers interrupting
that sucker at the same time.  Same for multiple signals of any kind
interrupting that sucker on 64bit...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/kernel/signal.c    |    2 ++
 arch/powerpc/kernel/signal_32.c |    3 +--
 arch/powerpc/kernel/signal_64.c |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 7109f5b..2300426 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -138,6 +138,7 @@ static int do_signal_pending(sigset_t *oldset, struct pt_regs *regs)
 			ti->local_flags &= ~_TLF_RESTORE_SIGMASK;
 			sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
 		}
+		regs->trap = 0;
 		return 0;               /* no signals delivered */
 	}
 
@@ -164,6 +165,7 @@ static int do_signal_pending(sigset_t *oldset, struct pt_regs *regs)
 		ret = handle_rt_signal64(signr, &ka, &info, oldset, regs);
 	}
 
+	regs->trap = 0;
 	if (ret) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked, &current->blocked,
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 2666101..b96a3a0 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -511,6 +511,7 @@ static long restore_user_regs(struct pt_regs *regs,
 	if (!sig)
 		save_r2 = (unsigned int)regs->gpr[2];
 	err = restore_general_regs(regs, sr);
+	regs->trap = 0;
 	err |= __get_user(msr, &sr->mc_gregs[PT_MSR]);
 	if (!sig)
 		regs->gpr[2] = (unsigned long) save_r2;
@@ -884,7 +885,6 @@ int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 	regs->nip = (unsigned long) ka->sa.sa_handler;
 	/* enter the signal handler in big-endian mode */
 	regs->msr &= ~MSR_LE;
-	regs->trap = 0;
 	return 1;
 
 badframe:
@@ -1228,7 +1228,6 @@ int handle_signal32(unsigned long sig, struct k_sigaction *ka,
 	regs->nip = (unsigned long) ka->sa.sa_handler;
 	/* enter the signal handler in big-endian mode */
 	regs->msr &= ~MSR_LE;
-	regs->trap = 0;
 
 	return 1;
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 2fe6fc6..27c4a45 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -178,7 +178,7 @@ static long restore_sigcontext(struct pt_regs *regs, sigset_t *set, int sig,
 	err |= __get_user(regs->xer, &sc->gp_regs[PT_XER]);
 	err |= __get_user(regs->ccr, &sc->gp_regs[PT_CCR]);
 	/* skip SOFTE */
-	err |= __get_user(regs->trap, &sc->gp_regs[PT_TRAP]);
+	regs->trap = 0;
 	err |= __get_user(regs->dar, &sc->gp_regs[PT_DAR]);
 	err |= __get_user(regs->dsisr, &sc->gp_regs[PT_DSISR]);
 	err |= __get_user(regs->result, &sc->gp_regs[PT_RESULT]);
-- 
1.5.6.5
