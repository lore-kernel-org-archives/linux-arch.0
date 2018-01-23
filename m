From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 05/10] signal: Add send_sig_fault and force_sig_fault
Date: Tue, 23 Jan 2018 15:07:14 -0600
Message-ID: <20180123210719.10456-5-ebiederm@xmission.com>
References: <87607s5lra.fsf_-_@xmission.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:51899 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932195AbeAWVJI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jan 2018 16:09:08 -0500
In-Reply-To: <87607s5lra.fsf_-_@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>

The vast majority of signals sent from architecture specific code are
simple faults.  Encapsulate this reality with two helper functions so
that the nit-picky implementation of preparing a siginfo does not need
to be repeated many times on each architecture.

As only some architectures support the trapno field, make the trapno
arguement only present on those architectures.

Similary as ia64 has three fields: imm, flags, and isr that
are specific to it.  Have those arguments always present on ia64
and no where else.

This ensures the architecture specific code always remembers which
fields it needs to pass into the siginfo structure.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h | 20 +++++++++++++++++++
 kernel/signal.c              | 47 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0aa4548fb492..375f31eb3b6b 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -285,6 +285,26 @@ static inline void kernel_signal_stop(void)
 
 	schedule();
 }
+#ifdef __ARCH_SI_TRAPNO
+# define ___ARCH_SI_TRAPNO(_a1) , _a1
+#else
+# define ___ARCH_SI_TRAPNO(_a1)
+#endif
+#ifdef __ia64__
+# define ___ARCH_SI_IA64(_a1, _a2, _a3) , _a1, _a2, _a3
+#else
+# define ___ARCH_SI_IA64(_a1, _a2, _a3)
+#endif
+
+int force_sig_fault(int sig, int code, void __user *addr
+	___ARCH_SI_TRAPNO(int trapno)
+	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
+	, struct task_struct *t);
+int send_sig_fault(int sig, int code, void __user *addr
+	___ARCH_SI_TRAPNO(int trapno)
+	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
+	, struct task_struct *t);
+
 extern int send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int force_sigsegv(int, struct task_struct *);
 extern int force_sig_info(int, struct siginfo *, struct task_struct *);
diff --git a/kernel/signal.c b/kernel/signal.c
index f14492ff976f..15ec7b3cbe69 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1491,6 +1491,53 @@ force_sigsegv(int sig, struct task_struct *p)
 	return 0;
 }
 
+int force_sig_fault(int sig, int code, void __user *addr
+	___ARCH_SI_TRAPNO(int trapno)
+	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
+	, struct task_struct *t)
+{
+	struct siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = sig;
+	info.si_errno = 0;
+	info.si_code  = code;
+	info.si_addr  = addr;
+#ifdef __ARCH_SI_TRAPNO
+	info.si_trapno = trapno;
+#endif
+#ifdef __ia64__
+	info.si_imm = imm;
+	info.si_flags = flags;
+	info.si_isr = isr;
+#endif
+	return force_sig_info(info.si_signo, &info, t);
+}
+
+int send_sig_fault(int sig, int code, void __user *addr
+	___ARCH_SI_TRAPNO(int trapno)
+	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
+	, struct task_struct *t)
+{
+	struct siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = sig;
+	info.si_errno = 0;
+	info.si_code  = code;
+	info.si_addr  = addr;
+#ifdef __ARCH_SI_TRAPNO
+	info.si_trapno = trapno;
+#endif
+#ifdef __ia64__
+	info.si_imm = imm;
+	info.si_flags = flags;
+	info.si_isr = isr;
+#endif
+	return send_sig_info(info.si_signo, &info, t);
+}
+
+
 int kill_pgrp(struct pid *pid, int sig, int priv)
 {
 	int ret;
-- 
2.14.1
