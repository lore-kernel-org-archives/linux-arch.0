From: guoren@kernel.org
Subject: [PATCH] csky: Fixup CONFIG_DEBUG_RSEQ
Date: Thu, 28 May 2020 08:14:29 +0800
Message-ID: <1590624869-6594-1-git-send-email-guoren@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgE1AOn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 20:14:43 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>

From: Guo Ren <guoren@linux.alibaba.com>

Put the rseq_syscall check point at the prologue of the syscall
will break the a0 ... a7. This will casue system call bug when
DEBUG_RSEQ is enabled.

So move it to the epilogue of syscall, but before syscall_trace.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/kernel/entry.S | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 9595e86..f138003 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -128,15 +128,11 @@ tlbop_end 1
 ENTRY(csky_systemcall)
 	SAVE_ALL TRAP0_SIZE
 	zero_fp
-#ifdef CONFIG_RSEQ_DEBUG
-	mov	a0, sp
-	jbsr	rseq_syscall
-#endif
 	psrset  ee, ie
 
 	lrw     r9, __NR_syscalls
 	cmphs   syscallid, r9		/* Check nr of syscall */
-	bt      ret_from_exception
+	bt      1f
 
 	lrw     r9, sys_call_table
 	ixw     r9, syscallid
@@ -162,6 +158,11 @@ ENTRY(csky_systemcall)
 	jsr     syscallid
 #endif
 	stw     a0, (sp, LSAVE_A0)      /* Save return value */
+1:
+#ifdef CONFIG_DEBUG_RSEQ
+	mov	a0, sp
+	jbsr	rseq_syscall
+#endif
 	jmpi    ret_from_exception
 
 csky_syscall_trace:
@@ -187,6 +188,10 @@ csky_syscall_trace:
 #endif
 	stw	a0, (sp, LSAVE_A0)	/* Save return value */
 
+#ifdef CONFIG_DEBUG_RSEQ
+	mov	a0, sp
+	jbsr	rseq_syscall
+#endif
 	mov     a0, sp                  /* right now, sp --> pt_regs */
 	jbsr    syscall_trace_exit
 	br	ret_from_exception
-- 
2.7.4
