Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267197AbUHZAVh@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:14053 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266894AbUHZATQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 20:19:16 -0400
Date: Wed, 25 Aug 2004 17:19:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 1/8] signal handling race fix
In-Reply-To: <20040825160913.681d6868.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0408251702230.17766@ppc970.osdl.org>
References: <200408252140.i7PLeL131496@mail.osdl.org>
 <Pine.LNX.4.58.0408251536360.17766@ppc970.osdl.org> <20040825160913.681d6868.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, minyard@acm.org
List-ID: <linux-arch.vger.kernel.org>



On Wed, 25 Aug 2004, David S. Miller wrote:
> 
> I think this should be a seperate change and not block this one.

Agreed. This looks trivially obvious. No?

		Linus

-----
===== include/linux/sched.h 1.244 vs edited =====
--- 1.244/include/linux/sched.h	2004-08-24 02:08:42 -07:00
+++ edited/include/linux/sched.h	2004-08-25 17:00:19 -07:00
@@ -718,6 +718,7 @@
 extern void release_task(struct task_struct * p);
 extern int send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int send_group_sig_info(int, struct siginfo *, struct task_struct *);
+extern int force_sigsegv(int, struct task_struct *);
 extern int force_sig_info(int, struct siginfo *, struct task_struct *);
 extern int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp);
 extern int kill_pg_info(int, struct siginfo *, pid_t);
===== kernel/signal.c 1.127 vs edited =====
--- 1.127/kernel/signal.c	2004-07-06 23:25:30 -07:00
+++ edited/kernel/signal.c	2004-08-25 17:04:37 -07:00
@@ -1243,6 +1243,25 @@
 	force_sig_info(sig, (void*)1L, p);
 }
 
+/*
+ * When things go south during signal handling, we
+ * will force a SIGSEGV. And if the signal that caused
+ * the problem was already a SIGSEGV, we'll want to
+ * make sure we don't even try to deliver the signal..
+ */
+int
+force_sigsegv(int sig, struct task_struct *p)
+{
+	if (sig == SIGSEGV) {
+		unsigned long flags;
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		p->sighand->action[sig - 1].sa.sa_handler = SIG_DFL;
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	}
+	force_sig(SIGSEGV, p);
+	return 0;
+}
+
 int
 kill_pg(pid_t pgrp, int sig, int priv)
 {
===== arch/alpha/kernel/signal.c 1.24 vs edited =====
--- 1.24/arch/alpha/kernel/signal.c	2004-07-15 10:56:07 -07:00
+++ edited/arch/alpha/kernel/signal.c	2004-08-25 16:58:09 -07:00
@@ -469,9 +469,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 static void
@@ -533,9 +531,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 
===== arch/arm/kernel/signal.c 1.33 vs edited =====
--- 1.33/arch/arm/kernel/signal.c	2004-06-18 10:58:27 -07:00
+++ edited/arch/arm/kernel/signal.c	2004-08-25 16:54:07 -07:00
@@ -639,9 +639,7 @@
 		return;
 	}
 
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, tsk);
+	force_sigsegv(sig, tsk);
 }
 
 /*
===== arch/arm26/kernel/signal.c 1.1 vs edited =====
--- 1.1/arch/arm26/kernel/signal.c	2003-06-04 04:15:45 -07:00
+++ edited/arch/arm26/kernel/signal.c	2004-08-25 16:54:07 -07:00
@@ -465,9 +465,7 @@
 		return;
 	}
 
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, tsk);
+	force_sigsegv(sig, tsk);
 }
 
 /*
===== arch/cris/arch-v10/kernel/signal.c 1.13 vs edited =====
--- 1.13/arch/cris/arch-v10/kernel/signal.c	2004-06-01 02:27:58 -07:00
+++ edited/arch/cris/arch-v10/kernel/signal.c	2004-08-25 16:54:07 -07:00
@@ -409,9 +409,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
@@ -475,9 +473,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 /*
===== arch/h8300/kernel/signal.c 1.6 vs edited =====
--- 1.6/arch/h8300/kernel/signal.c	2004-05-14 19:00:16 -07:00
+++ edited/arch/h8300/kernel/signal.c	2004-08-25 16:55:15 -07:00
@@ -391,9 +391,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 static void setup_rt_frame (int sig, struct k_sigaction *ka, siginfo_t *info,
@@ -443,9 +441,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 static inline void
===== arch/i386/kernel/signal.c 1.41 vs edited =====
--- 1.41/arch/i386/kernel/signal.c	2004-07-13 05:53:49 -07:00
+++ edited/arch/i386/kernel/signal.c	2004-08-25 16:54:07 -07:00
@@ -411,9 +411,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
@@ -492,9 +490,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 /*
===== arch/ia64/ia32/ia32_signal.c 1.28 vs edited =====
--- 1.28/arch/ia64/ia32/ia32_signal.c	2004-05-10 23:44:41 -07:00
+++ edited/arch/ia64/ia32/ia32_signal.c	2004-08-25 16:54:07 -07:00
@@ -882,9 +882,7 @@
 	return 1;
 
   give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 	return 0;
 }
 
@@ -952,9 +950,7 @@
 	return 1;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 	return 0;
 }
 
===== arch/m68k/kernel/signal.c 1.19 vs edited =====
--- 1.19/arch/m68k/kernel/signal.c	2004-07-28 21:58:40 -07:00
+++ edited/arch/m68k/kernel/signal.c	2004-08-25 16:54:07 -07:00
@@ -842,9 +842,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 	goto adjust_stack;
 }
 
@@ -925,9 +923,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 	goto adjust_stack;
 }
 
===== arch/m68knommu/kernel/signal.c 1.10 vs edited =====
--- 1.10/arch/m68knommu/kernel/signal.c	2004-02-18 16:43:09 -08:00
+++ edited/arch/m68knommu/kernel/signal.c	2004-08-25 16:54:07 -07:00
@@ -616,9 +616,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 	goto adjust_stack;
 }
 
@@ -685,9 +683,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 	goto adjust_stack;
 }
 
===== arch/mips/kernel/irixsig.c 1.13 vs edited =====
--- 1.13/arch/mips/kernel/irixsig.c	2004-05-29 02:13:12 -07:00
+++ edited/arch/mips/kernel/irixsig.c	2004-08-25 17:12:52 -07:00
@@ -121,9 +121,7 @@
 	return;
 
 segv_and_exit:
-	if (signr == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(signr, current);
 }
 
 static void inline
===== arch/mips/kernel/signal.c 1.16 vs edited =====
--- 1.16/arch/mips/kernel/signal.c	2004-05-10 04:25:30 -07:00
+++ edited/arch/mips/kernel/signal.c	2004-08-25 16:54:07 -07:00
@@ -406,9 +406,7 @@
         return;
 
 give_sigsegv:
-	if (signr == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(signr, current);
 }
 #endif
 
@@ -475,9 +473,7 @@
 	return;
 
 give_sigsegv:
-	if (signr == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(signr, current);
 }
 
 extern void setup_rt_frame_n32(struct k_sigaction * ka,
===== arch/mips/kernel/signal32.c 1.17 vs edited =====
--- 1.17/arch/mips/kernel/signal32.c	2004-05-10 04:25:30 -07:00
+++ edited/arch/mips/kernel/signal32.c	2004-08-25 17:14:16 -07:00
@@ -574,9 +574,7 @@
         return;
 
 give_sigsegv:
-	if (signr == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(signr, current);
 }
 
 static inline void setup_rt_frame(struct k_sigaction * ka,
@@ -647,9 +645,7 @@
 	return;
 
 give_sigsegv:
-	if (signr == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(signr, current);
 }
 
 static inline void handle_signal(unsigned long sig, siginfo_t *info,
===== arch/mips/kernel/signal_n32.c 1.4 vs edited =====
--- 1.4/arch/mips/kernel/signal_n32.c	2004-05-10 04:25:30 -07:00
+++ edited/arch/mips/kernel/signal_n32.c	2004-08-25 17:12:52 -07:00
@@ -208,7 +208,5 @@
 	return;
 
 give_sigsegv:
-	if (signr == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(signr, current);
 }
===== arch/ppc/kernel/signal.c 1.35 vs edited =====
--- 1.35/arch/ppc/kernel/signal.c	2004-07-26 14:42:38 -07:00
+++ edited/arch/ppc/kernel/signal.c	2004-08-25 16:54:07 -07:00
@@ -404,9 +404,7 @@
 	printk("badframe in handle_rt_signal, regs=%p frame=%p newsp=%lx\n",
 	       regs, frame, newsp);
 #endif
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 static int do_setcontext(struct ucontext __user *ucp, struct pt_regs *regs, int sig)
@@ -556,9 +554,7 @@
 	printk("badframe in handle_signal, regs=%p frame=%p newsp=%lx\n",
 	       regs, frame, newsp);
 #endif
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 /*
===== arch/ppc64/kernel/signal32.c 1.54 vs edited =====
--- 1.54/arch/ppc64/kernel/signal32.c	2004-07-05 03:27:10 -07:00
+++ edited/arch/ppc64/kernel/signal32.c	2004-08-25 17:12:52 -07:00
@@ -699,9 +699,7 @@
 	printk("badframe in handle_rt_signal, regs=%p frame=%p newsp=%lx\n",
 	       regs, frame, newsp);
 #endif
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 static long do_setcontext32(struct ucontext32 __user *ucp, struct pt_regs *regs, int sig)
@@ -864,9 +862,7 @@
 	printk("badframe in handle_signal, regs=%p frame=%x newsp=%x\n",
 	       regs, frame, *newspp);
 #endif
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 /*
===== arch/s390/kernel/compat_signal.c 1.12 vs edited =====
--- 1.12/arch/s390/kernel/compat_signal.c	2004-08-07 11:05:35 -07:00
+++ edited/arch/s390/kernel/compat_signal.c	2004-08-25 16:54:07 -07:00
@@ -552,9 +552,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 static void setup_rt_frame32(int sig, struct k_sigaction *ka, siginfo_t *info,
@@ -604,9 +602,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 /*
===== arch/s390/kernel/signal.c 1.27 vs edited =====
--- 1.27/arch/s390/kernel/signal.c	2004-07-11 01:59:28 -07:00
+++ edited/arch/s390/kernel/signal.c	2004-08-25 16:54:07 -07:00
@@ -358,9 +358,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
@@ -414,9 +412,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 /*
===== arch/sh/kernel/signal.c 1.13 vs edited =====
--- 1.13/arch/sh/kernel/signal.c	2004-02-13 07:19:27 -08:00
+++ edited/arch/sh/kernel/signal.c	2004-08-25 16:54:07 -07:00
@@ -413,9 +413,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
@@ -490,9 +488,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 /*
===== arch/um/kernel/signal_kern.c 1.16 vs edited =====
--- 1.16/arch/um/kernel/signal_kern.c	2004-08-24 02:08:29 -07:00
+++ edited/arch/um/kernel/signal_kern.c	2004-08-25 17:12:52 -07:00
@@ -31,17 +31,6 @@
 EXPORT_SYMBOL(block_signals);
 EXPORT_SYMBOL(unblock_signals);
 
-static void force_segv(int sig)
-{
-	if(sig == SIGSEGV){
-		struct k_sigaction *ka;
-
-		ka = &current->sighand->action[SIGSEGV - 1];
-		ka->sa.sa_handler = SIG_DFL;
-	}
-	force_sig(SIGSEGV, current);
-}
-
 #define _S(nr) (1<<((nr)-1))
 
 #define _BLOCKABLE (~(_S(SIGKILL) | _S(SIGSTOP)))
@@ -124,7 +113,7 @@
 
 	return(0);
  segv:
-	force_segv(signr);
+	force_sigsegv(signr, current);
 	return(1);
 }
 
===== arch/v850/kernel/signal.c 1.8 vs edited =====
--- 1.8/arch/v850/kernel/signal.c	2003-02-17 18:41:09 -08:00
+++ edited/arch/v850/kernel/signal.c	2004-08-25 16:54:07 -07:00
@@ -344,9 +344,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
@@ -421,9 +419,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 /*
===== arch/x86_64/ia32/ia32_signal.c 1.27 vs edited =====
--- 1.27/arch/x86_64/ia32/ia32_signal.c	2004-08-24 02:08:31 -07:00
+++ edited/arch/x86_64/ia32/ia32_signal.c	2004-08-25 17:12:52 -07:00
@@ -499,9 +499,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	signal_fault(regs,frame,"32bit signal deliver");
+	force_sigsegv(sig, current);
 }
 
 void ia32_setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
@@ -595,8 +593,6 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	signal_fault(regs, frame, "32bit rt signal setup"); 
+	force_sigsegv(sig, current);
 }
 
===== arch/x86_64/kernel/signal.c 1.24 vs edited =====
--- 1.24/arch/x86_64/kernel/signal.c	2004-08-24 02:08:31 -07:00
+++ edited/arch/x86_64/kernel/signal.c	2004-08-25 17:12:52 -07:00
@@ -329,9 +329,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	signal_fault(regs,frame,"signal deliver");
+	force_sigsegv(sig, current);
 }
 
 /*
===== arch/sh64/kernel/signal.c 1.1 vs edited =====
--- 1.1/arch/sh64/kernel/signal.c	2004-06-29 07:44:46 -07:00
+++ edited/arch/sh64/kernel/signal.c	2004-08-25 16:56:02 -07:00
@@ -520,9 +520,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
@@ -628,9 +626,7 @@
 	return;
 
 give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 }
 
 /*
