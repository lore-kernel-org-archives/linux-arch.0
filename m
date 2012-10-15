Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:28935 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab2JOGqs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2012 02:46:48 -0400
From: <gerg@snapgear.com>
Subject: [PATCH 06/11] m68k: switch to using the asm-generic sembuf.h
Date: Mon, 15 Oct 2012 16:49:14 +1000
Message-ID: <1350283759-31158-7-git-send-email-gerg@snapgear.com>
In-Reply-To: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
References: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
Message-ID: <20121015064914.5B5cNuhHdvQRAtP4VtPkmZ5aSi0jTpJAOGb0xHjub-Y@z>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local sembuf.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild   |    1 +
 arch/m68k/include/asm/sembuf.h |   25 -------------------------
 2 files changed, 1 insertions(+), 25 deletions(-)
 delete mode 100644 arch/m68k/include/asm/sembuf.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 775eef9..19f59dc 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -26,6 +26,7 @@ generic-y += percpu.h
 generic-y += resource.h
 generic-y += scatterlist.h
 generic-y += sections.h
+generic-y += sembuf.h
 generic-y += shmbuf.h
 generic-y += shmparam.h
 generic-y += siginfo.h
diff --git a/arch/m68k/include/asm/sembuf.h b/arch/m68k/include/asm/sembuf.h
deleted file mode 100644
index 2308052..0000000
--- a/arch/m68k/include/asm/sembuf.h
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

