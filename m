From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 20/22] signal/um: Use force_sig_fault where appropriate
Date: Fri, 20 Apr 2018 09:38:09 -0500
Message-ID: <20180420143811.9994-20-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

Filling in struct siginfo before calling force_sig_info a tedious and
error prone process, where once in a great while the wrong fields
are filled out, and siginfo has been inconsistently cleared.

Simplify this process by using the helper force_sig_fault.  Which
takes as a parameters all of the information it needs, ensures
all of the fiddly bits of filling in struct siginfo are done properly
and then calls force_sig_info.

In short about a 5 line reduction in code for every time force_sig_info
is called, which makes the calling function clearer.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/um/kernel/ptrace.c | 13 +++----------
 arch/um/kernel/trap.c   | 26 ++++++++------------------
 2 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index bc2a516c190f..1a1d88a4d940 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -115,17 +115,10 @@ long arch_ptrace(struct task_struct *child, long request,
 static void send_sigtrap(struct task_struct *tsk, struct uml_pt_regs *regs,
 		  int error_code)
 {
-	struct siginfo info;
-
-	memset(&info, 0, sizeof(info));
-	info.si_signo = SIGTRAP;
-	info.si_code = TRAP_BRKPT;
-
-	/* User-mode eip? */
-	info.si_addr = UPT_IS_USER(regs) ? (void __user *) UPT_IP(regs) : NULL;
-
 	/* Send us the fake SIGTRAP */
-	force_sig_info(SIGTRAP, &info, tsk);
+	force_sig_fault(SIGTRAP, TRAP_BRKPT,
+			/* User-mode eip? */
+			UPT_IS_USER(regs) ? (void __user *) UPT_IP(regs) : NULL, tsk);
 }
 
 /*
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 5f0ff17cd790..48b70dcb6963 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -162,14 +162,9 @@ static void show_segv_info(struct uml_pt_regs *regs)
 
 static void bad_segv(struct faultinfo fi, unsigned long ip)
 {
-	struct siginfo si;
-
-	clear_siginfo(&si);
-	si.si_signo = SIGSEGV;
-	si.si_code = SEGV_ACCERR;
-	si.si_addr = (void __user *) FAULT_ADDRESS(fi);
 	current->thread.arch.faultinfo = fi;
-	force_sig_info(SIGSEGV, &si, current);
+	force_sig_fault(SIGSEGV, SEGV_ACCERR, (void __user *) FAULT_ADDRESS(fi),
+			current);
 }
 
 void fatal_sigsegv(void)
@@ -215,13 +210,12 @@ void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		   struct uml_pt_regs *regs)
 {
-	struct siginfo si;
 	jmp_buf *catcher;
+	int si_code;
 	int err;
 	int is_write = FAULT_WRITE(fi);
 	unsigned long address = FAULT_ADDRESS(fi);
 
-	clear_siginfo(&si);
 	if (!is_user && regs)
 		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
 
@@ -241,7 +235,7 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 
 	if (SEGV_IS_FIXABLE(&fi))
 		err = handle_page_fault(address, ip, is_write, is_user,
-					&si.si_code);
+					&si_code);
 	else {
 		err = -EFAULT;
 		/*
@@ -273,18 +267,14 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 	show_segv_info(regs);
 
 	if (err == -EACCES) {
-		si.si_signo = SIGBUS;
-		si.si_errno = 0;
-		si.si_code = BUS_ADRERR;
-		si.si_addr = (void __user *)address;
 		current->thread.arch.faultinfo = fi;
-		force_sig_info(SIGBUS, &si, current);
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address,
+				current);
 	} else {
 		BUG_ON(err != -EFAULT);
-		si.si_signo = SIGSEGV;
-		si.si_addr = (void __user *) address;
 		current->thread.arch.faultinfo = fi;
-		force_sig_info(SIGSEGV, &si, current);
+		force_sig_fault(SIGSEGV, si_code, (void __user *) address,
+				current);
 	}
 
 out:
-- 
2.14.1
