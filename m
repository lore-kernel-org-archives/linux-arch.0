From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 08/20] signal/x86/traps: Move setting error_code and trap_nr into do_trap_no_signal
Date: Tue, 18 Sep 2018 02:05:34 +0200
Message-ID: <20180918000546.12552-8-ebiederm@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Half of the times when error_code and trap_nr are set are already in
do_trap_no_signal.  Move the other time these are set into do_trap_no_signal,
and give do_trap_no_signal a single exit where a signals are sent.

After the move the comment documeting this all is much easier to follow
as everything is together in one place.

Also update the string that is passed in to const.  The only user of that
str is die and it already takes a const string, so this just makes it explicit
that the string won't change.

This prepares the way for adding a second caller to do_trap_no_signal.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/traps.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 31a689b67be3..f31c0ddee278 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -189,7 +189,7 @@ int fixup_bug(struct pt_regs *regs, int trapnr)
 }
 
 static nokprobe_inline int
-do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
+do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
 		  struct pt_regs *regs,	long error_code)
 {
 	if (v8086_mode(regs)) {
@@ -202,10 +202,8 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
 						error_code, trapnr))
 				return 0;
 		}
-		return -1;
 	}
-
-	if (!user_mode(regs)) {
+	else if (!user_mode(regs)) {
 		if (fixup_exception(regs, trapnr))
 			return 0;
 
@@ -214,6 +212,18 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
 		die(str, regs, error_code);
 	}
 
+	/*
+	 * We want error_code and trap_nr set for userspace faults and
+	 * kernelspace faults which result in die(), but not
+	 * kernelspace faults which are fixed up.  die() gives the
+	 * process no chance to handle the signal and notice the
+	 * kernel fault information, so that won't result in polluting
+	 * the information about previously queued, but not yet
+	 * delivered, faults.  See also do_general_protection below.
+	 */
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_nr = trapnr;
+
 	return -1;
 }
 
@@ -271,17 +281,6 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
 
 	if (!do_trap_no_signal(tsk, trapnr, str, regs, error_code))
 		return;
-	/*
-	 * We want error_code and trap_nr set for userspace faults and
-	 * kernelspace faults which result in die(), but not
-	 * kernelspace faults which are fixed up.  die() gives the
-	 * process no chance to handle the signal and notice the
-	 * kernel fault information, so that won't result in polluting
-	 * the information about previously queued, but not yet
-	 * delivered, faults.  See also do_general_protection below.
-	 */
-	tsk->thread.error_code = error_code;
-	tsk->thread.trap_nr = trapnr;
 
 	show_signal(tsk, signr, "trap ", str, regs, error_code);
 
-- 
2.17.1
