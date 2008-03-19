Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:55855 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936924AbYCSVSA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Mar 2008 17:18:00 -0400
From: Roland McGrath <roland@redhat.com>
Subject: [PATCH 1/8] ptrace: forced_successful_syscall_return() macro
Message-ID: <20080319211714.8B14226F995@magilla.localdomain>
Date: Wed, 19 Mar 2008 14:17:14 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Richard Henderson <rth@twiddle.net>, tony.luck@intel.com, linux-ia64@vger.kernel.org
Message-ID: <20080319211714.2kj-MI6Osc0G3hEcSeHl5oDKGVbdUtU31NJbP_qWC8k@z>

This adds the forced_successful_syscall_return() macro, a mate to
force_successful_syscall_return() to test rather than set the condition.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 include/linux/ptrace.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index ebe0c17..9272e63 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -124,8 +124,13 @@ int generic_ptrace_pokedata(struct task_struct *tsk, long addr, long data);
  * is a no-op and the spurious error condition needs to be filtered out by some
  * other means (e.g., in user-level, by passing an extra argument to the
  * syscall handler, or something along those lines).
+ *
+ * On architectures that define force_successful_syscall_return(),
+ * forced_successful_syscall_return() should also be defined.
+ * It returns nonzero if force_successful_syscall_return() was just used.
  */
 #define force_successful_syscall_return() do { } while (0)
+#define forced_successful_syscall_return() 0
 #endif
 
 /*
