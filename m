Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:19166 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbbBUHyJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 21 Feb 2015 02:54:09 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v4 02/15] h8300: UAPI headers
Date: Sat, 21 Feb 2015 16:53:46 +0900
Message-ID: <1424505239-7082-3-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1424505239-7082-1-git-send-email-ysato@users.sourceforge.jp>
References: <1424505239-7082-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150221075346.OREM_dilgS61CY-zgEj1dKofp0Cf5C3aQgduLKK0v1s@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/include/uapi/asm/Kbuild       |  29 ++++++++
 arch/h8300/include/uapi/asm/auxvec.h     |   4 ++
 arch/h8300/include/uapi/asm/byteorder.h  |   6 ++
 arch/h8300/include/uapi/asm/ptrace.h     |  42 +++++++++++
 arch/h8300/include/uapi/asm/sigcontext.h |  18 +++++
 arch/h8300/include/uapi/asm/signal.h     | 115 +++++++++++++++++++++++++++++++
 arch/h8300/include/uapi/asm/swab.h       |   1 +
 arch/h8300/include/uapi/asm/unistd.h     |   3 +
 8 files changed, 218 insertions(+)
 create mode 100644 arch/h8300/include/uapi/asm/Kbuild
 create mode 100644 arch/h8300/include/uapi/asm/auxvec.h
 create mode 100644 arch/h8300/include/uapi/asm/byteorder.h
 create mode 100644 arch/h8300/include/uapi/asm/ptrace.h
 create mode 100644 arch/h8300/include/uapi/asm/sigcontext.h
 create mode 100644 arch/h8300/include/uapi/asm/signal.h
 create mode 100644 arch/h8300/include/uapi/asm/swab.h
 create mode 100644 arch/h8300/include/uapi/asm/unistd.h

diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..077e720
--- /dev/null
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -0,0 +1,29 @@
+# UAPI Header export list
+include include/uapi/asm-generic/Kbuild.asm
+
+header-y += auxvec.h
+header-y += bitsperlong.h
+header-y += errno.h
+header-y += fcntl.h
+header-y += ioctl.h
+header-y += ioctls.h
+header-y += ipcbuf.h
+header-y += kvm_para.h
+header-y += mman.h
+header-y += msgbuf.h
+header-y += param.h
+header-y += poll.h
+header-y += posix_types.h
+header-y += resource.h
+header-y += sembuf.h
+header-y += setup.h
+header-y += shmbuf.h
+header-y += siginfo.h
+header-y += socket.h
+header-y += sockios.h
+header-y += stat.h
+header-y += statfs.h
+header-y += termbits.h
+header-y += termios.h
+header-y += types.h
+header-y += unistd.h
diff --git a/arch/h8300/include/uapi/asm/auxvec.h b/arch/h8300/include/uapi/asm/auxvec.h
new file mode 100644
index 0000000..1d36fe38
--- /dev/null
+++ b/arch/h8300/include/uapi/asm/auxvec.h
@@ -0,0 +1,4 @@
+#ifndef __ASMH8300_AUXVEC_H
+#define __ASMH8300_AUXVEC_H
+
+#endif
diff --git a/arch/h8300/include/uapi/asm/byteorder.h b/arch/h8300/include/uapi/asm/byteorder.h
new file mode 100644
index 0000000..13539da
--- /dev/null
+++ b/arch/h8300/include/uapi/asm/byteorder.h
@@ -0,0 +1,6 @@
+#ifndef _H8300_BYTEORDER_H
+#define _H8300_BYTEORDER_H
+
+#include <linux/byteorder/big_endian.h>
+
+#endif /* _H8300_BYTEORDER_H */
diff --git a/arch/h8300/include/uapi/asm/ptrace.h b/arch/h8300/include/uapi/asm/ptrace.h
new file mode 100644
index 0000000..e132670d
--- /dev/null
+++ b/arch/h8300/include/uapi/asm/ptrace.h
@@ -0,0 +1,42 @@
+#ifndef _UAPI_H8300_PTRACE_H
+#define _UAPI_H8300_PTRACE_H
+
+#ifndef __ASSEMBLY__
+
+#define PT_ER1	   0
+#define PT_ER2	   1
+#define PT_ER3	   2
+#define PT_ER4	   3
+#define PT_ER5	   4
+#define PT_ER6	   5
+#define PT_ER0	   6
+#define PT_USP	   7
+#define PT_ORIG_ER0	   8
+#define PT_CCR	   9
+#define PT_PC	   10
+#define PT_EXR     11
+
+/* this struct defines the way the registers are stored on the
+   stack during a system call. */
+
+struct pt_regs {
+	long     retpc;
+	long     er4;
+	long     er5;
+	long     er6;
+	long     er3;
+	long     er2;
+	long     er1;
+	long     orig_er0;
+	long	 sp;
+	unsigned short	 ccr;
+	long     er0;
+	long     vector;
+#if defined(__H8300S__)
+	unsigned short	 exr;
+#endif
+	unsigned long  pc;
+} __attribute__((aligned(2), packed));
+
+#endif /* __ASSEMBLY__ */
+#endif /* _UAPI_H8300_PTRACE_H */
diff --git a/arch/h8300/include/uapi/asm/sigcontext.h b/arch/h8300/include/uapi/asm/sigcontext.h
new file mode 100644
index 0000000..c41fdaa
--- /dev/null
+++ b/arch/h8300/include/uapi/asm/sigcontext.h
@@ -0,0 +1,18 @@
+#ifndef _ASM_H8300_SIGCONTEXT_H
+#define _ASM_H8300_SIGCONTEXT_H
+
+struct sigcontext {
+	unsigned long  sc_mask;		/* old sigmask */
+	unsigned long  sc_usp;		/* old user stack pointer */
+	unsigned long  sc_er0;
+	unsigned long  sc_er1;
+	unsigned long  sc_er2;
+	unsigned long  sc_er3;
+	unsigned long  sc_er4;
+	unsigned long  sc_er5;
+	unsigned long  sc_er6;
+	unsigned short sc_ccr;
+	unsigned long  sc_pc;
+};
+
+#endif
diff --git a/arch/h8300/include/uapi/asm/signal.h b/arch/h8300/include/uapi/asm/signal.h
new file mode 100644
index 0000000..af3a6c3
--- /dev/null
+++ b/arch/h8300/include/uapi/asm/signal.h
@@ -0,0 +1,115 @@
+#ifndef _UAPI_H8300_SIGNAL_H
+#define _UAPI_H8300_SIGNAL_H
+
+#include <linux/types.h>
+
+/* Avoid too many header ordering problems.  */
+struct siginfo;
+
+#ifndef __KERNEL__
+/* Here we must cater to libcs that poke about in kernel headers.  */
+
+#define NSIG		32
+typedef unsigned long sigset_t;
+
+#endif /* __KERNEL__ */
+
+#define SIGHUP		 1
+#define SIGINT		 2
+#define SIGQUIT		 3
+#define SIGILL		 4
+#define SIGTRAP		 5
+#define SIGABRT		 6
+#define SIGIOT		 6
+#define SIGBUS		 7
+#define SIGFPE		 8
+#define SIGKILL		 9
+#define SIGUSR1		10
+#define SIGSEGV		11
+#define SIGUSR2		12
+#define SIGPIPE		13
+#define SIGALRM		14
+#define SIGTERM		15
+#define SIGSTKFLT	16
+#define SIGCHLD		17
+#define SIGCONT		18
+#define SIGSTOP		19
+#define SIGTSTP		20
+#define SIGTTIN		21
+#define SIGTTOU		22
+#define SIGURG		23
+#define SIGXCPU		24
+#define SIGXFSZ		25
+#define SIGVTALRM	26
+#define SIGPROF		27
+#define SIGWINCH	28
+#define SIGIO		29
+#define SIGPOLL		SIGIO
+/*
+#define SIGLOST		29
+*/
+#define SIGPWR		30
+#define SIGSYS		31
+#define	SIGUNUSED	31
+
+/* These should not be considered constants from userland.  */
+#define SIGRTMIN	32
+#define SIGRTMAX	_NSIG
+
+/*
+ * SA_FLAGS values:
+ *
+ * SA_ONSTACK indicates that a registered stack_t will be used.
+ * SA_RESTART flag to get restarting signals (which were the default long ago)
+ * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
+ * SA_RESETHAND clears the handler when the signal is delivered.
+ * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
+ * SA_NODEFER prevents the current signal from being masked in the handler.
+ *
+ * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
+ * Unix names RESETHAND and NODEFER respectively.
+ */
+#define SA_NOCLDSTOP	0x00000001
+#define SA_NOCLDWAIT	0x00000002 /* not supported yet */
+#define SA_SIGINFO	0x00000004
+#define SA_ONSTACK	0x08000000
+#define SA_RESTART	0x10000000
+#define SA_NODEFER	0x40000000
+#define SA_RESETHAND	0x80000000
+
+#define SA_NOMASK	SA_NODEFER
+#define SA_ONESHOT	SA_RESETHAND
+
+#define SA_RESTORER	0x04000000
+
+#define MINSIGSTKSZ	2048
+#define SIGSTKSZ	8192
+
+#include <asm-generic/signal-defs.h>
+
+#ifndef __KERNEL__
+/* Here we must cater to libcs that poke about in kernel headers.  */
+
+struct sigaction {
+	union {
+	  __sighandler_t _sa_handler;
+	  void (*_sa_sigaction)(int, struct siginfo *, void *);
+	} _u;
+	sigset_t sa_mask;
+	unsigned long sa_flags;
+	void (*sa_restorer)(void);
+};
+
+#define sa_handler	_u._sa_handler
+#define sa_sigaction	_u._sa_sigaction
+
+#endif /* __KERNEL__ */
+
+typedef struct sigaltstack {
+	void *ss_sp;
+	int ss_flags;
+	size_t ss_size;
+} stack_t;
+
+
+#endif /* _UAPI_H8300_SIGNAL_H */
diff --git a/arch/h8300/include/uapi/asm/swab.h b/arch/h8300/include/uapi/asm/swab.h
new file mode 100644
index 0000000..7847e56
--- /dev/null
+++ b/arch/h8300/include/uapi/asm/swab.h
@@ -0,0 +1 @@
+#include <asm-generic/swab.h>
diff --git a/arch/h8300/include/uapi/asm/unistd.h b/arch/h8300/include/uapi/asm/unistd.h
new file mode 100644
index 0000000..7a2eb69
--- /dev/null
+++ b/arch/h8300/include/uapi/asm/unistd.h
@@ -0,0 +1,3 @@
+#define __ARCH_NOMMU
+
+#include <asm-generic/unistd.h>
-- 
2.1.4

