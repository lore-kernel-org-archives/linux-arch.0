From: tip-bot for Frederic Weisbecker <fweisbec@gmail.com>
Subject: [tip:perf/urgent] perf: Fix unsafe frame rewinding with hot regs fetching
Date: Wed, 14 Apr 2010 06:48:06 GMT
Message-ID: <tip-ab285f2b5290d92b7ec1a6f9aad54308dadf6157@git.kernel.org>
Reply-To: linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
	  acme@redhat.com, paulus@samba.org, eric.dumazet@gmail.com,
	  a.p.zijlstra@chello.nl, davem@davemloft.net, fweisbec@gmail.com,
	  tglx@linutronix.de, linux-arch@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48364 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753365Ab0DNGsb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Apr 2010 02:48:31 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: paulus@samba.org, acme@redhat.com, hpa@zytor.com, mingo@redhat.com, eric.dumazet@gmail.com, a.p.zijlstra@chello.nl, davem@davemloft.net, fweisbec@gmail.com, tglx@linutronix.de, linux-arch@vger.kernel.org

Commit-ID:  ab285f2b5290d92b7ec1a6f9aad54308dadf6157
Gitweb:     http://git.kernel.org/tip/ab285f2b5290d92b7ec1a6f9aad54308dadf6157
Author:     Frederic Weisbecker <fweisbec@gmail.com>
AuthorDate: Thu, 8 Apr 2010 14:05:50 +0200
Committer:  Frederic Weisbecker <fweisbec@gmail.com>
CommitDate: Thu, 8 Apr 2010 19:03:28 +0200

perf: Fix unsafe frame rewinding with hot regs fetching

When we fetch the hot regs and rewind to the nth caller, it
might happen that we dereference a frame pointer outside the
kernel stack boundaries, like in this example:

	perf_trace_sched_switch+0xd5/0x120
        schedule+0x6b5/0x860
        retint_careful+0xd/0x21

Since we directly dereference a userspace frame pointer here while
rewinding behind retint_careful, this may end up in a crash.

Fix this by simply using probe_kernel_address() when we rewind the
frame pointer.

This issue will have a much more proper fix in the next version of the
perf_arch_fetch_caller_regs() API that will only need to rewind to the
first caller.

Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Tested-by: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: David Miller <davem@davemloft.net>
Cc: Archs <linux-arch@vger.kernel.org>
---
 arch/x86/kernel/dumpstack.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.h b/arch/x86/kernel/dumpstack.h
index e39e771..e1a93be 100644
--- a/arch/x86/kernel/dumpstack.h
+++ b/arch/x86/kernel/dumpstack.h
@@ -14,6 +14,8 @@
 #define get_bp(bp) asm("movq %%rbp, %0" : "=r" (bp) :)
 #endif
 
+#include <linux/uaccess.h>
+
 extern void
 show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 		unsigned long *stack, unsigned long bp, char *log_lvl);
@@ -42,8 +44,10 @@ static inline unsigned long rewind_frame_pointer(int n)
 	get_bp(frame);
 
 #ifdef CONFIG_FRAME_POINTER
-	while (n--)
-		frame = frame->next_frame;
+	while (n--) {
+		if (probe_kernel_address(&frame->next_frame, frame))
+			break;
+	}
 #endif
 
 	return (unsigned long)frame;
