Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45102 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213Ab2BYDWq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2012 22:22:46 -0500
Received: by mail-yx0-f174.google.com with SMTP id m8so1458620yen.19
        for <linux-arch@vger.kernel.org>; Fri, 24 Feb 2012 19:22:46 -0800 (PST)
MIME-Version: 1.0
From: Will Drewry <wad@chromium.org>
Subject: [PATCH v11 04/12] asm/syscall.h: add syscall_get_arch
Date: Fri, 24 Feb 2012 21:21:43 -0600
Message-ID: <1330140111-17201-4-git-send-email-wad@chromium.org>
In-Reply-To: <1330140111-17201-1-git-send-email-wad@chromium.org>
References: <1330140111-17201-1-git-send-email-wad@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, davem@davemloft.net, hpa@zytor.com, mingo@redhat.com, oleg@redhat.com, peterz@infradead.org, rdunlap@xenotime.net, mcgrathr@chromium.org, tglx@linutronix.de, luto@mit.edu, eparis@redhat.com, serge.hallyn@canonical.com, djm@mindrot.org, scarybeasts@gmail.com, indan@nul.nu, pmoore@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, eric.dumazet@gmail.com, markus@chromium.org, coreyb@linux.vnet.ibm.com, keescook@chromium.org, Will Drewry <wad@chromium.org>
Message-ID: <20120225032143._F7Y0NeWXrU3k7sy_P5USgBRMetqoLJBfP8_O4OVGgo@z>

Adds a stub for a function that will return the AUDIT_ARCH_*
value appropriate to the supplied task based on the system
call convention.

For audit's use, the value can generally be hard-coded at the
audit-site.  However, for other functionality not inlined into
syscall entry/exit, this makes that information available.
seccomp_filter is the first planned consumer and, as such,
the comment indicates a tie to HAVE_ARCH_SECCOMP_FILTER.  That
is probably an unneeded detail.

Suggested-by: Roland McGrath <mcgrathr@chromium.org>
Signed-off-by: Will Drewry <wad@chromium.org>

v11: fixed improper return type (mcgrathr@chromium.org)
v10: introduced
---
 include/asm-generic/syscall.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 5c122ae..a2c13dc 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -142,4 +142,18 @@ void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 			   unsigned int i, unsigned int n,
 			   const unsigned long *args);
 
+/**
+ * syscall_get_arch - return the AUDIT_ARCH for the current system call
+ * @task:	task of interest, must be in system call entry tracing
+ * @regs:	task_pt_regs() of @task
+ *
+ * Returns the AUDIT_ARCH_* based on the system call convention in use.
+ *
+ * It's only valid to call this when @task is stopped on entry to a system
+ * call, due to %TIF_SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or %TIF_SECCOMP.
+ *
+ * Note, at present this function is only required with
+ * CONFIG_HAVE_ARCH_SECCOMP_FILTER.
+ */
+int syscall_get_arch(struct task_struct *task, struct pt_regs *regs);
 #endif	/* _ASM_SYSCALL_H */
-- 
1.7.5.4

