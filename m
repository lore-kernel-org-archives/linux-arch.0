From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 05/22] signal/m68k: Use force_sig_fault where appropriate
Date: Fri, 20 Apr 2018 09:37:54 -0500
Message-ID: <20180420143811.9994-5-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org
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

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/m68k/kernel/traps.c | 60 ++++++++++++++++++++----------------------------
 arch/m68k/mm/fault.c     | 25 +++++++++-----------
 2 files changed, 36 insertions(+), 49 deletions(-)

diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 0a00b476236d..b2fd000b9285 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -1007,11 +1007,10 @@ void bad_super_trap (struct frame *fp)
 
 asmlinkage void trap_c(struct frame *fp)
 {
-	int sig;
+	int sig, si_code;
+	void __user *addr;
 	int vector = (fp->ptregs.vector >> 2) & 0xff;
-	siginfo_t info;
 
-	clear_siginfo(&info);
 	if (fp->ptregs.sr & PS_S) {
 		if (vector == VEC_TRACE) {
 			/* traced a trapping instruction on a 68020/30,
@@ -1030,21 +1029,21 @@ asmlinkage void trap_c(struct frame *fp)
 	/* send the appropriate signal to the user program */
 	switch (vector) {
 	    case VEC_ADDRERR:
-		info.si_code = BUS_ADRALN;
+		si_code = BUS_ADRALN;
 		sig = SIGBUS;
 		break;
 	    case VEC_ILLEGAL:
 	    case VEC_LINE10:
 	    case VEC_LINE11:
-		info.si_code = ILL_ILLOPC;
+		si_code = ILL_ILLOPC;
 		sig = SIGILL;
 		break;
 	    case VEC_PRIV:
-		info.si_code = ILL_PRVOPC;
+		si_code = ILL_PRVOPC;
 		sig = SIGILL;
 		break;
 	    case VEC_COPROC:
-		info.si_code = ILL_COPROC;
+		si_code = ILL_COPROC;
 		sig = SIGILL;
 		break;
 	    case VEC_TRAP1:
@@ -1061,76 +1060,74 @@ asmlinkage void trap_c(struct frame *fp)
 	    case VEC_TRAP12:
 	    case VEC_TRAP13:
 	    case VEC_TRAP14:
-		info.si_code = ILL_ILLTRP;
+		si_code = ILL_ILLTRP;
 		sig = SIGILL;
 		break;
 	    case VEC_FPBRUC:
 	    case VEC_FPOE:
 	    case VEC_FPNAN:
-		info.si_code = FPE_FLTINV;
+		si_code = FPE_FLTINV;
 		sig = SIGFPE;
 		break;
 	    case VEC_FPIR:
-		info.si_code = FPE_FLTRES;
+		si_code = FPE_FLTRES;
 		sig = SIGFPE;
 		break;
 	    case VEC_FPDIVZ:
-		info.si_code = FPE_FLTDIV;
+		si_code = FPE_FLTDIV;
 		sig = SIGFPE;
 		break;
 	    case VEC_FPUNDER:
-		info.si_code = FPE_FLTUND;
+		si_code = FPE_FLTUND;
 		sig = SIGFPE;
 		break;
 	    case VEC_FPOVER:
-		info.si_code = FPE_FLTOVF;
+		si_code = FPE_FLTOVF;
 		sig = SIGFPE;
 		break;
 	    case VEC_ZERODIV:
-		info.si_code = FPE_INTDIV;
+		si_code = FPE_INTDIV;
 		sig = SIGFPE;
 		break;
 	    case VEC_CHK:
 	    case VEC_TRAP:
-		info.si_code = FPE_INTOVF;
+		si_code = FPE_INTOVF;
 		sig = SIGFPE;
 		break;
 	    case VEC_TRACE:		/* ptrace single step */
-		info.si_code = TRAP_TRACE;
+		si_code = TRAP_TRACE;
 		sig = SIGTRAP;
 		break;
 	    case VEC_TRAP15:		/* breakpoint */
-		info.si_code = TRAP_BRKPT;
+		si_code = TRAP_BRKPT;
 		sig = SIGTRAP;
 		break;
 	    default:
-		info.si_code = ILL_ILLOPC;
+		si_code = ILL_ILLOPC;
 		sig = SIGILL;
 		break;
 	}
-	info.si_signo = sig;
-	info.si_errno = 0;
 	switch (fp->ptregs.format) {
 	    default:
-		info.si_addr = (void *) fp->ptregs.pc;
+		addr = (void __user *) fp->ptregs.pc;
 		break;
 	    case 2:
-		info.si_addr = (void *) fp->un.fmt2.iaddr;
+		addr = (void __user *) fp->un.fmt2.iaddr;
 		break;
 	    case 7:
-		info.si_addr = (void *) fp->un.fmt7.effaddr;
+		addr = (void __user *) fp->un.fmt7.effaddr;
 		break;
 	    case 9:
-		info.si_addr = (void *) fp->un.fmt9.iaddr;
+		addr = (void __user *) fp->un.fmt9.iaddr;
 		break;
 	    case 10:
-		info.si_addr = (void *) fp->un.fmta.daddr;
+		addr = (void __user *) fp->un.fmta.daddr;
 		break;
 	    case 11:
-		info.si_addr = (void *) fp->un.fmtb.daddr;
+		addr = (void __user*) fp->un.fmtb.daddr;
 		break;
 	}
-	force_sig_info (sig, &info, current);
+	force_sig_fault(sig, si_code, addr, current);
 }
 
 void die_if_kernel (char *str, struct pt_regs *fp, int nr)
@@ -1162,13 +1159,6 @@ asmlinkage void fpsp040_die(void)
 #ifdef CONFIG_M68KFPU_EMU
 asmlinkage void fpemu_signal(int signal, int code, void *addr)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = signal;
-	info.si_errno = 0;
-	info.si_code = code;
-	info.si_addr = addr;
-	force_sig_info(signal, &info, current);
+	force_sig_fault(signal, code, addr, current);
 }
 #endif
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 03253c4f8e6a..f2ff3779875a 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -21,35 +21,32 @@ extern void die_if_kernel(char *, struct pt_regs *, long);
 
 int send_fault_sig(struct pt_regs *regs)
 {
-	siginfo_t siginfo;
+	int signo, si_code;
+	void __user *addr;
 
-	clear_siginfo(&siginfo);
-	siginfo.si_signo = current->thread.signo;
-	siginfo.si_code = current->thread.code;
-	siginfo.si_addr = (void *)current->thread.faddr;
-	pr_debug("send_fault_sig: %p,%d,%d\n", siginfo.si_addr,
-		 siginfo.si_signo, siginfo.si_code);
+	signo = current->thread.signo;
+	si_code = current->thread.code;
+	addr = (void __user *)current->thread.faddr;
+	pr_debug("send_fault_sig: %p,%d,%d\n", addr, signo, si_code);
 
 	if (user_mode(regs)) {
-		force_sig_info(siginfo.si_signo,
-			       &siginfo, current);
+		force_sig_fault(signo, si_code, addr, current);
 	} else {
 		if (fixup_exception(regs))
 			return -1;
 
-		//if (siginfo.si_signo == SIGBUS)
-		//	force_sig_info(siginfo.si_signo,
-		//		       &siginfo, current);
+		//if (signo == SIGBUS)
+		//	force_sig_fault(si_signo, si_code, addr, current);
 
 		/*
 		 * Oops. The kernel tried to access some bad page. We'll have to
 		 * terminate things with extreme prejudice.
 		 */
-		if ((unsigned long)siginfo.si_addr < PAGE_SIZE)
+		if ((unsigned long)addr < PAGE_SIZE)
 			pr_alert("Unable to handle kernel NULL pointer dereference");
 		else
 			pr_alert("Unable to handle kernel access");
-		pr_cont(" at virtual address %p\n", siginfo.si_addr);
+		pr_cont(" at virtual address %p\n", addr);
 		die_if_kernel("Oops", regs, 0 /*error_code*/);
 		do_exit(SIGKILL);
 	}
-- 
2.14.1
