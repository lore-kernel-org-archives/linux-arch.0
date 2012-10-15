Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:28927 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab2JOGqn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2012 02:46:43 -0400
From: <gerg@snapgear.com>
Subject: [PATCH 04/11] m68k: switch to using the asm-generic msgbuf.h
Date: Mon, 15 Oct 2012 16:49:12 +1000
Message-ID: <1350283759-31158-5-git-send-email-gerg@snapgear.com>
In-Reply-To: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
References: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
Message-ID: <20121015064912.hFX3iJKJW231IOfsdMPDa_PQOiVZdS1ej28rWKN7Vjk@z>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local msgbuf.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild   |    1 +
 arch/m68k/include/asm/msgbuf.h |   31 -------------------------------
 2 files changed, 1 insertions(+), 31 deletions(-)
 delete mode 100644 arch/m68k/include/asm/msgbuf.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 83fcc34..677eace 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -20,6 +20,7 @@ generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += local.h
 generic-y += mman.h
+generic-y += msgbuf.h
 generic-y += mutex.h
 generic-y += percpu.h
 generic-y += resource.h
diff --git a/arch/m68k/include/asm/msgbuf.h b/arch/m68k/include/asm/msgbuf.h
deleted file mode 100644
index 243cb79..0000000
--- a/arch/m68k/include/asm/msgbuf.h
+++ /dev/null
@@ -1,31 +0,0 @@
-#ifndef _M68K_MSGBUF_H
-#define _M68K_MSGBUF_H
-
-/*
- * The msqid64_ds structure for m68k architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
- */
-
-struct msqid64_ds {
-	struct ipc64_perm msg_perm;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	unsigned long	__unused1;
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	unsigned long	__unused2;
-	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned long	__unused3;
-	unsigned long  msg_cbytes;	/* current number of bytes on queue */
-	unsigned long  msg_qnum;	/* number of messages in queue */
-	unsigned long  msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long  __unused4;
-	unsigned long  __unused5;
-};
-
-#endif /* _M68K_MSGBUF_H */
-- 
1.7.0.4

