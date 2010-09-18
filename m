From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 1/4] alpha: belated ERESTART_RESTARTBLOCK race fix
Date: Sat, 18 Sep 2010 09:38:47 +0100
Message-ID: <20100918083846.GA31363@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33931 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158Ab0IRIiu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 18 Sep 2010 04:38:50 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

same thing as had been done on other targets back in 2003 -
move setting ->restart_block.fn into {rt_,}sigreturn().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/kernel/signal.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/alpha/kernel/signal.c b/arch/alpha/kernel/signal.c
index 0932dbb..e5b1b3c 100644
--- a/arch/alpha/kernel/signal.c
+++ b/arch/alpha/kernel/signal.c
@@ -239,6 +239,8 @@ restore_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	unsigned long usp;
 	long i, err = __get_user(regs->pc, &sc->sc_pc);
 
+	current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
 	sw->r26 = (unsigned long) ret_from_sys_call;
 
 	err |= __get_user(regs->r0, sc->sc_regs+0);
@@ -591,7 +593,6 @@ syscall_restart(unsigned long r0, unsigned long r19,
 		regs->pc -= 4;
 		break;
 	case ERESTART_RESTARTBLOCK:
-		current_thread_info()->restart_block.fn = do_no_restart_syscall;
 		regs->r0 = EINTR;
 		break;
 	}
-- 
1.5.6.5
