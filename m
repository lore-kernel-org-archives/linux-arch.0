Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:44015 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbeIXV3I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 17:29:08 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 24 Sep 2018 17:25:36 +0200
Message-ID: <20180924152537.19515-2-ebiederm@xmission.com>
In-Reply-To: <87lg7q2a2w.fsf@xmission.com>
References: <87lg7q2a2w.fsf@xmission.com>
Subject: [REVIEW][PATCH 2/3] signal/unicore32: Generate siginfo in ucs32_notify_die
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Guan Xuetao <gxt@pku.edu.cn>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180924152536.H_956FL6C0w3fL_1YmvGilsbpeK0-KX4fU50HmF-OAg@z>

Pass the signal number, and the signal code, and the faulting
address into uc32_notify_die so the callers do not need
to generate a struct siginfo.

In ucs32_ntoify_die use the newly passed in information to
call force_sig_fault to generate the siginfo and send the error.

This simplifies the code making the chances of bugs much less likely.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/unicore32/include/asm/bug.h |  3 ++-
 arch/unicore32/kernel/traps.c    |  5 +++--
 arch/unicore32/mm/fault.c        | 18 ++++--------------
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/unicore32/include/asm/bug.h b/arch/unicore32/include/asm/bug.h
index 93a56f3e2344..83c7687a0e61 100644
--- a/arch/unicore32/include/asm/bug.h
+++ b/arch/unicore32/include/asm/bug.h
@@ -17,6 +17,7 @@ struct siginfo;
 
 extern void die(const char *msg, struct pt_regs *regs, int err);
 extern void uc32_notify_die(const char *str, struct pt_regs *regs,
-		struct siginfo *info, unsigned long err, unsigned long trap);
+		int sig, int code, void __user *addr,
+		unsigned long err, unsigned long trap);
 
 #endif /* __UNICORE_BUG_H__ */
diff --git a/arch/unicore32/kernel/traps.c b/arch/unicore32/kernel/traps.c
index c4ac6043ebb0..fb376d83e043 100644
--- a/arch/unicore32/kernel/traps.c
+++ b/arch/unicore32/kernel/traps.c
@@ -241,13 +241,14 @@ void die(const char *str, struct pt_regs *regs, int err)
 }
 
 void uc32_notify_die(const char *str, struct pt_regs *regs,
-		struct siginfo *info, unsigned long err, unsigned long trap)
+		int sig, int code, void __user *addr,
+		unsigned long err, unsigned long trap)
 {
 	if (user_mode(regs)) {
 		current->thread.error_code = err;
 		current->thread.trap_no = trap;
 
-		force_sig_info(info->si_signo, info, current);
+		force_sig_fault(sig, code, addr, current);
 	} else
 		die(str, regs, err);
 }
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 8f12a5b50a42..a942776110a0 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -466,7 +466,6 @@ asmlinkage void do_DataAbort(unsigned long addr, unsigned int fsr,
 			struct pt_regs *regs)
 {
 	const struct fsr_info *inf = fsr_info + fsr_fs(fsr);
-	struct siginfo info;
 
 	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
 		return;
@@ -474,19 +473,14 @@ asmlinkage void do_DataAbort(unsigned long addr, unsigned int fsr,
 	printk(KERN_ALERT "Unhandled fault: %s (0x%03x) at 0x%08lx\n",
 	       inf->name, fsr, addr);
 
-	clear_siginfo(&info);
-	info.si_signo = inf->sig;
-	info.si_errno = 0;
-	info.si_code = inf->code;
-	info.si_addr = (void __user *)addr;
-	uc32_notify_die("", regs, &info, fsr, 0);
+	uc32_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
+			fsr, 0);
 }
 
 asmlinkage void do_PrefetchAbort(unsigned long addr,
 			unsigned int ifsr, struct pt_regs *regs)
 {
 	const struct fsr_info *inf = fsr_info + fsr_fs(ifsr);
-	struct siginfo info;
 
 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
 		return;
@@ -494,10 +488,6 @@ asmlinkage void do_PrefetchAbort(unsigned long addr,
 	printk(KERN_ALERT "Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
 	       inf->name, ifsr, addr);
 
-	clear_siginfo(&info);
-	info.si_signo = inf->sig;
-	info.si_errno = 0;
-	info.si_code = inf->code;
-	info.si_addr = (void __user *)addr;
-	uc32_notify_die("", regs, &info, ifsr, 0);
+	uc32_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
+			ifsr, 0);
 }
-- 
2.17.1
