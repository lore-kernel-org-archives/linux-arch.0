From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 19/22] signal/um: Use force_sig_fault in relay_signal.
Date: Fri, 20 Apr 2018 09:38:08 -0500
Message-ID: <20180420143811.9994-19-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

Today user mode linux only works on x86 and x86_64 and this allows
simplifications of relay_signal.

- x86 always set si_errno to 0 in fault handlers.
- x86 does not implement si_trapno.
- Only si_codes between SI_USER and SI_KERNEL have a fault address.

Therefore warn if si_errno is set (it should never be).
Use force_sig_info in the case where we know we have a good fault.

For signals whose content it is not clear how to relay use plain
force_sig and let the signal sending code come up with an
appropriate generic siginfo.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/um/kernel/trap.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index d4d38520c4c6..5f0ff17cd790 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -296,9 +296,6 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 
 void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 {
-	struct faultinfo *fi;
-	struct siginfo clean_si;
-
 	if (!UPT_IS_USER(regs)) {
 		if (sig == SIGBUS)
 			printk(KERN_ERR "Bus error - the host /dev/shm or /tmp "
@@ -308,29 +305,30 @@ void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 
 	arch_examine_signal(sig, regs);
 
-	clear_siginfo(&clean_si);
-	clean_si.si_signo = si->si_signo;
-	clean_si.si_errno = si->si_errno;
-	clean_si.si_code = si->si_code;
+	if (unlikely(si->si_errno)) {
+		printk(KERN_ERR "Attempted to relay signal %d (si_code = %d) with errno %d\n",
+		       sig, si->si_code, si->si_errno);
+	}
 	switch (sig) {
 	case SIGILL:
 	case SIGFPE:
 	case SIGSEGV:
 	case SIGBUS:
 	case SIGTRAP:
-		fi = UPT_FAULTINFO(regs);
-		clean_si.si_addr = (void __user *) FAULT_ADDRESS(*fi);
-		current->thread.arch.faultinfo = *fi;
-#ifdef __ARCH_SI_TRAPNO
-		clean_si.si_trapno = si->si_trapno;
-#endif
-		break;
+		if ((si->si_code > SI_USER) && (si->si_code < SI_KERNEL)) {
+			struct faultinfo *fi = UPT_FAULTINFO(regs);
+			current->thread.arch.faultinfo = *fi;
+			force_sig_fault(sig, si->si_code,
+					(void __user *)FAULT_ADDRESS(*fi),
+					current);
+			break;
+		}
 	default:
 		printk(KERN_ERR "Attempted to relay unknown signal %d (si_code = %d)\n",
 			sig, si->si_code);
 	}
 
-	force_sig_info(sig, &clean_si, current);
+	force_sig(sig, current);
 }
 
 void bus_handler(int sig, struct siginfo *si, struct uml_pt_regs *regs)
-- 
2.14.1
