Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53202 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967773Ab2EQWOE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 May 2012 18:14:04 -0400
From: "H.J. Lu" <hjl.tools@gmail.com>
Subject: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
Date: Thu, 17 May 2012 15:13:34 -0700
Message-ID: <1337292816-10839-9-git-send-email-hjl.tools@gmail.com>
In-Reply-To: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de, "H.J. Lu" <hjl.tools@gmail.com>
Message-ID: <20120517221334.8CuUpGLbsBtceI2UmYGMctGbFPE3yPId2P_FgwYPCtQ@z>

From: "H.J. Lu" <hjl.tools@gmail.com>

Replace unsigned long with __kernel_ulong_t in struct msqid64_ds for
user space.  Don't change unsigned long when __BITS_PER_LONG != 64
since __kernel_ulong_t == unsigned long in this case.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 include/asm-generic/msgbuf.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/msgbuf.h b/include/asm-generic/msgbuf.h
index aec850d..f55ecc4 100644
--- a/include/asm-generic/msgbuf.h
+++ b/include/asm-generic/msgbuf.h
@@ -35,13 +35,13 @@ struct msqid64_ds {
 #if __BITS_PER_LONG != 64
 	unsigned long	__unused3;
 #endif
-	unsigned long  msg_cbytes;	/* current number of bytes on queue */
-	unsigned long  msg_qnum;	/* number of messages in queue */
-	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_ulong_t msg_cbytes;	/* current number of bytes on queue */
+	__kernel_ulong_t msg_qnum;	/* number of messages in queue */
+	__kernel_ulong_t msg_qbytes;	/* max number of bytes on queue */
 	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
 	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long  __unused4;
-	unsigned long  __unused5;
+	__kernel_ulong_t __unused4;
+	__kernel_ulong_t __unused5;
 };
 
 #endif /* __ASM_GENERIC_MSGBUF_H */
-- 
1.7.6.5

