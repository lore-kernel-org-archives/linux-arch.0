From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 5/5] signal/um: More carefully relay signals in relay_signal.
Date: Sat, 28 Apr 2018 09:07:02 -0500
Message-ID: <20180428140702.3925-5-ebiederm@xmission.com>
References: <87zi1nctut.fsf_-_@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87zi1nctut.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux-Arch <linux-arch@vger.kernel.org>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Richard Weinberger <richard.weinberger@gmail.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, =?UTF-8?q?Martin=20P=C3=A4rtel?= <martin.partel@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

There is a bug in relay signal.  It assumes that when a signal is
relayed the signal never uses a signal independent si_code, such
as SI_USER, SI_KERNEL, SI_QUEUE, ... SI_SIGIO etc.  In practice
siginfo was assuming it was relaying a signal with the SIL_FAULT
layout.  As that is the common cases for the signals it supported
that is a reasonable assumption.

Further user mode linux must be very careful when relaying different
kinds of signals to prevent an information leak.  This means simply
increasing the kinds of signals that are handled in relay_signal
is non-trivial.

Therefore use siginfo_layout and force_sig_fault to simplify
the signal relaying in relay_signal.

By taking advantage of the fact that user mode linux only works
on x86 and x86_64 we can assume that si_trapno can be ignored,
and that si_errno is always zero.

For the signals SIGLL, SIGFPE, SIGSEGV, SIGBUS, and SIGTRAP the only
fault handler I know of that sets si_errno is SIGTRAP TRAP_HWBKPT on a
few oddball architectures.  Those architectures have been modified to
use force_sig_ptrace_errno_trap.

Similarly only a few architectures set __ARCH_SI_TRAPNO.

At the point uml supports those architectures again these additional
cases can be examined and supported if desired in relay_signal.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Martin Pärtel <martin.partel@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-um@lists.infradead.org
Fixes: d3c1cfcdb43e ("um: pass siginfo to guest process")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/um/kernel/trap.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index d18be983814a..ec9a42c14c56 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -286,9 +286,7 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 
 void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 {
-	struct faultinfo *fi;
-	struct siginfo clean_si;
-
+	int code, err;
 	if (!UPT_IS_USER(regs)) {
 		if (sig == SIGBUS)
 			printk(KERN_ERR "Bus error - the host /dev/shm or /tmp "
@@ -298,29 +296,21 @@ void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 
 	arch_examine_signal(sig, regs);
 
-	clear_siginfo(&clean_si);
-	clean_si.si_signo = si->si_signo;
-	clean_si.si_errno = si->si_errno;
-	clean_si.si_code = si->si_code;
-	switch (sig) {
-	case SIGILL:
-	case SIGFPE:
-	case SIGSEGV:
-	case SIGBUS:
-	case SIGTRAP:
-		fi = UPT_FAULTINFO(regs);
-		clean_si.si_addr = (void __user *) FAULT_ADDRESS(*fi);
+	/* Is the signal layout for the signal known?
+	 * Signal data must be scrubbed to prevent information leaks.
+	 */
+	code = si->si_code;
+	err = si->si_errno;
+	if ((err == 0) && (siginfo_layout(sig, code) == SIL_FAULT)) {
+		struct faultinfo *fi = UPT_FAULTINFO(regs);
 		current->thread.arch.faultinfo = *fi;
-#ifdef __ARCH_SI_TRAPNO
-		clean_si.si_trapno = si->si_trapno;
-#endif
-		break;
-	default:
-		printk(KERN_ERR "Attempted to relay unknown signal %d (si_code = %d)\n",
-			sig, si->si_code);
+		force_sig_fault(sig, code, (void __user *)FAULT_ADDRESS(*fi),
+				current);
+	} else {
+		printk(KERN_ERR "Attempted to relay unknown signal %d (si_code = %d) with errno %d\n",
+		       sig, code, err);
+		force_sig(sig, current);
 	}
-
-	force_sig_info(sig, &clean_si, current);
 }
 
 void bus_handler(int sig, struct siginfo *si, struct uml_pt_regs *regs)
-- 
2.14.1
