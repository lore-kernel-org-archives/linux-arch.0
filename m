From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 06/10] signal: Helpers for faults with specialized siginfo layouts
Date: Tue, 23 Jan 2018 15:07:15 -0600
Message-ID: <20180123210719.10456-6-ebiederm@xmission.com>
References: <87607s5lra.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87607s5lra.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

The helpers added are:
send_sig_mceerr
force_sig_mceerr
force_sig_bnderr
force_sig_pkuerr

Filling out siginfo properly can ge tricky.  Especially for these
specialized cases where the temptation is to share code with other
cases which use a different subset of siginfo fields.  Unfortunately
that code sharing frequently results in bugs with the wrong siginfo
fields filled in, and makes it harder to verify that the siginfo
structure was properly initialized.

Provide these helpers instead that get all of the details right, and
guarantee that siginfo is properly initialized.

send_sig_mceerr and force_sig_mceer are a little special as two si
codes BUS_MCEERR_AO and BUS_MCEER_AR both use the same extended
signinfo layout.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  6 +++++
 kernel/signal.c              | 61 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 375f31eb3b6b..944fe6356f4a 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -305,6 +305,12 @@ int send_sig_fault(int sig, int code, void __user *addr
 	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
 	, struct task_struct *t);
 
+int force_sig_mceerr(int code, void __user *, short, struct task_struct *);
+int send_sig_mceerr(int code, void __user *, short, struct task_struct *);
+
+int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper);
+int force_sig_pkuerr(void __user *addr, u32 pkey);
+
 extern int send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int force_sigsegv(int, struct task_struct *);
 extern int force_sig_info(int, struct siginfo *, struct task_struct *);
diff --git a/kernel/signal.c b/kernel/signal.c
index 15ec7b3cbe69..4f6300ef8062 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1537,6 +1537,67 @@ int send_sig_fault(int sig, int code, void __user *addr
 	return send_sig_info(info.si_signo, &info, t);
 }
 
+#if defined(BUS_MCEERR_AO) && defined(BUS_MCEERR_AR)
+int force_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *t)
+{
+	struct siginfo info;
+
+	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
+	clear_siginfo(&info);
+	info.si_signo = SIGBUS;
+	info.si_errno = 0;
+	info.si_code = code;
+	info.si_addr = addr;
+	info.si_addr_lsb = lsb;
+	return force_sig_info(info.si_signo, &info, t);
+}
+
+int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *t)
+{
+	struct siginfo info;
+
+	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
+	clear_siginfo(&info);
+	info.si_signo = SIGBUS;
+	info.si_errno = 0;
+	info.si_code = code;
+	info.si_addr = addr;
+	info.si_addr_lsb = lsb;
+	return send_sig_info(info.si_signo, &info, t);
+}
+EXPORT_SYMBOL(send_sig_mceerr);
+#endif
+
+#ifdef SEGV_BNDERR
+int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
+{
+	struct siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = SIGSEGV;
+	info.si_errno = 0;
+	info.si_code  = SEGV_BNDERR;
+	info.si_addr  = addr;
+	info.si_lower = lower;
+	info.si_upper = upper;
+	return force_sig_info(info.si_signo, &info, current);
+}
+#endif
+
+#ifdef SEGV_PKUERR
+int force_sig_pkuerr(void __user *addr, u32 pkey)
+{
+	struct siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = SIGSEGV;
+	info.si_errno = 0;
+	info.si_code  = SEGV_PKUERR;
+	info.si_addr  = addr;
+	info.si_pkey  = pkey;
+	return force_sig_info(info.si_signo, &info, current);
+}
+#endif
 
 int kill_pgrp(struct pid *pid, int sig, int priv)
 {
-- 
2.14.1
