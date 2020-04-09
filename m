Return-Path: <SRS0=yGje=5Z=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgDIDTv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Apr 2020 23:19:51 -0400
From: guoren@kernel.org
Subject: [PATCH] csky: Fixup compile error for abiv1 entry.S
Date: Thu,  9 Apr 2020 11:19:41 +0800
Message-ID: <20200409031941.6288-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-csky@vger.kernel.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, guoren@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Message-ID: <20200409031941.xUxlNWt1LzUu6KJGJbUIlHQEfR4A_B5p1tcmqJq5AAI@z>

From: Guo Ren <guoren@linux.alibaba.com>

This bug is from uprobe signal definition in thread_info.h. The
instruction (andi) of abiv1 immediate is smaller than abiv2, then
it will cause:

  AS      arch/csky/kernel/entry.o
 arch/csky/kernel/entry.S: Assembler messages:
 arch/csky/kernel/entry.S:224: Error: Operand 2 immediate is overflow.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/include/asm/thread_info.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index 442fedad0260..5d33fcfd7f2a 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -54,10 +54,10 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SIGPENDING		0	/* signal pending */
 #define TIF_NOTIFY_RESUME	1       /* callback before returning to user */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
-#define TIF_SYSCALL_TRACE	3	/* syscall trace active */
-#define TIF_SYSCALL_TRACEPOINT	4       /* syscall tracepoint instrumentation */
-#define TIF_SYSCALL_AUDIT	5	/* syscall auditing */
-#define TIF_UPROBE		6	/* uprobe breakpoint or singlestep */
+#define TIF_UPROBE		3	/* uprobe breakpoint or singlestep */
+#define TIF_SYSCALL_TRACE	4	/* syscall trace active */
+#define TIF_SYSCALL_TRACEPOINT	5       /* syscall tracepoint instrumentation */
+#define TIF_SYSCALL_AUDIT	6	/* syscall auditing */
 #define TIF_POLLING_NRFLAG	16	/* poll_idle() is TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18      /* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	20	/* restore signal mask in do_signal() */
-- 
2.17.0
