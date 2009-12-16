From: akpm@linux-foundation.org
Subject: [patch 092/175] ptrace: introduce user_single_step_siginfo() helper
Date: Tue, 15 Dec 2009 16:47:17 -0800
Message-ID: <200912160047.nBG0lHBG024644@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43305 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752899AbZLPArs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Dec 2009 19:47:48 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, oleg@redhat.com, hpa@zytor.com, linux-arch@vger.kernel.org, mingo@elte.hu, roland@redhat.com, tglx@linutronix.de

From: Oleg Nesterov <oleg@redhat.com>

Suggested by Roland.

Currently there is no way to synthesize a single-stepping trap in the
arch-independent manner.  This patch adds the default helper which fills
siginfo_t, arch/ can can override it.

Architetures which implement user_enable_single_step() should add
user_single_step_siginfo() also.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Roland McGrath <roland@redhat.com>
Cc: <linux-arch@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/ptrace.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff -puN include/linux/ptrace.h~ptrace-introduce-user_single_step_siginfo-helper include/linux/ptrace.h
--- a/include/linux/ptrace.h~ptrace-introduce-user_single_step_siginfo-helper
+++ a/include/linux/ptrace.h
@@ -273,6 +273,18 @@ static inline void user_enable_block_ste
 }
 #endif	/* arch_has_block_step */
 
+#ifdef ARCH_HAS_USER_SINGLE_STEP_INFO
+extern void user_single_step_siginfo(struct task_struct *tsk,
+				struct pt_regs *regs, siginfo_t *info);
+#else
+static inline void user_single_step_siginfo(struct task_struct *tsk,
+				struct pt_regs *regs, siginfo_t *info)
+{
+	memset(info, 0, sizeof(*info));
+	info->si_signo = SIGTRAP;
+}
+#endif
+
 #ifndef arch_ptrace_stop_needed
 /**
  * arch_ptrace_stop_needed - Decide whether arch_ptrace_stop() should be called
_
