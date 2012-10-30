From: <gerg@snapgear.com>
Subject: [PATCH v3 06/11] m68k: switch to using the asm-generic sembuf.h
Date: Tue, 30 Oct 2012 16:24:32 +1000
Message-ID: <1351578277-31882-7-git-send-email-gerg@snapgear.com>
References: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:52240 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab2J3G0f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Oct 2012 02:26:35 -0400
In-Reply-To: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local sembuf.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/uapi/asm/Kbuild   |    2 +-
 arch/m68k/include/uapi/asm/sembuf.h |   25 -------------------------
 2 files changed, 1 insertions(+), 26 deletions(-)
 delete mode 100644 arch/m68k/include/uapi/asm/sembuf.h

diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 391ff1c..637f15a 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -3,6 +3,7 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
 generic-y += msgbuf.h
+generic-y += sembuf.h
 
 header-y += a.out.h
 header-y += byteorder.h
@@ -13,7 +14,6 @@ header-y += param.h
 header-y += poll.h
 header-y += posix_types.h
 header-y += ptrace.h
-header-y += sembuf.h
 header-y += setup.h
 header-y += shmbuf.h
 header-y += sigcontext.h
diff --git a/arch/m68k/include/uapi/asm/sembuf.h b/arch/m68k/include/uapi/asm/sembuf.h
deleted file mode 100644
index 2308052..0000000
--- a/arch/m68k/include/uapi/asm/sembuf.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifndef _M68K_SEMBUF_H
-#define _M68K_SEMBUF_H
-
-/*
- * The semid64_ds structure for m68k architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
- */
-
-struct semid64_ds {
-	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	__kernel_time_t	sem_otime;		/* last semop time */
-	unsigned long	__unused1;
-	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long	__unused2;
-	unsigned long	sem_nsems;		/* no. of semaphores in array */
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _M68K_SEMBUF_H */
-- 
1.7.0.4
