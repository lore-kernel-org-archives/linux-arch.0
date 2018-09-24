Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:38152 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730163AbeIXUwI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 16:52:08 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 24 Sep 2018 16:49:09 +0200
Message-ID: <20180924144910.14902-1-ebiederm@xmission.com>
In-Reply-To: <874lef2bqn.fsf@xmission.com>
References: <874lef2bqn.fsf@xmission.com>
Subject: [REVIEW][PATCH 1/2] signal/arc: Push siginfo generation into unhandled_exception
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180924144909.qI-iE3jWhf_nALA54fYl83McmNndrY56U8vUNFwXumg@z>

Pass signr, sicode, and address into unhandled_exception as explicit
parameters instead of members of struct siginfo.  Then in unhandled
exception generate and send the siginfo using force_sig_fault.

This keeps the code simpler and less error prone.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arc/kernel/traps.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index b123558bf0bb..a7fcbc0d3943 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -42,21 +42,22 @@ void die(const char *str, struct pt_regs *regs, unsigned long address)
  *  -for kernel, chk if due to copy_(to|from)_user, otherwise die()
  */
 static noinline int
-unhandled_exception(const char *str, struct pt_regs *regs, siginfo_t *info)
+unhandled_exception(const char *str, struct pt_regs *regs,
+		    int signo, int si_code, void __user *addr)
 {
 	if (user_mode(regs)) {
 		struct task_struct *tsk = current;
 
-		tsk->thread.fault_address = (__force unsigned int)info->si_addr;
+		tsk->thread.fault_address = (__force unsigned int)addr;
 
-		force_sig_info(info->si_signo, info, tsk);
+		force_sig_fault(signo, si_code, addr, tsk);
 
 	} else {
 		/* If not due to copy_(to|from)_user, we are doomed */
 		if (fixup_exception(regs))
 			return 0;
 
-		die(str, regs, (unsigned long)info->si_addr);
+		die(str, regs, (unsigned long)addr);
 	}
 
 	return 1;
@@ -64,16 +65,9 @@ unhandled_exception(const char *str, struct pt_regs *regs, siginfo_t *info)
 
 #define DO_ERROR_INFO(signr, str, name, sicode) \
 int name(unsigned long address, struct pt_regs *regs) \
-{						\
-	siginfo_t info;				\
-						\
-	clear_siginfo(&info);			\
-	info.si_signo = signr;			\
-	info.si_errno = 0;			\
-	info.si_code  = sicode;			\
-	info.si_addr = (void __user *)address;	\
-						\
-	return unhandled_exception(str, regs, &info);\
+{								\
+	return unhandled_exception(str, regs, signr, sicode,	\
+				   (void __user *)address);	\
 }
 
 /*
-- 
2.17.1
