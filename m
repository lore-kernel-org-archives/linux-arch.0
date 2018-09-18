Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:33552 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeIRFhj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 01:37:39 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 02:05:35 +0200
Message-ID: <20180918000546.12552-9-ebiederm@xmission.com>
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
Subject: [REVIEW][PATCH 09/20] signal/x86/traps: Use force_sig_bnderr
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180918000535.P4-n_X99sL4Y7DecpVraDqt9eLt1ntJz0p_JZ0W0i5M@z>

Instead of generating the siginfo in x86 specific code use the new
helper function force_sig_bnderr to separate the concerns of
collecting the information and generating a proper siginfo.

Making the code easier to understand and maintain.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/traps.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f31c0ddee278..9f7b3831fb7e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -499,8 +499,8 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 		break; /* Success, it was handled */
 	case 1: /* Bound violation. */
 	{
+		struct task_struct *tsk = current;
 		struct mpx_fault_info mpx;
-		struct siginfo info;
 
 		if (mpx_fault_info(&mpx, regs)) {
 			/*
@@ -511,19 +511,18 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 		}
 		/*
 		 * Success, we decoded the instruction and retrieved
-		 * an 'info' containing the address being accessed
+		 * an 'mpx' containing the address being accessed
 		 * which caused the exception.  This information
 		 * allows and application to possibly handle the
 		 * #BR exception itself.
 		 */
-		clear_siginfo(&info);
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		info.si_code  = SEGV_BNDERR;
-		info.si_addr  = mpx.addr;
-		info.si_lower = mpx.lower;
-		info.si_upper = mpx.upper;
-		do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, &info);
+		if (!do_trap_no_signal(tsk, X86_TRAP_BR, "bounds", regs,
+				       error_code))
+			break;
+
+		show_signal(tsk, SIGSEGV, "trap ", "bounds", regs, error_code);
+
+		force_sig_bnderr(mpx.addr, mpx.lower, mpx.upper);
 		break;
 	}
 	case 0: /* No exception caused by Intel MPX operations. */
-- 
2.17.1
