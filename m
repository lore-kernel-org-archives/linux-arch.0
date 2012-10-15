Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:28931 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab2JOGqq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2012 02:46:46 -0400
From: <gerg@snapgear.com>
Subject: [PATCH 05/11] m68k: switch to using the asm-generic shmbuf.h
Date: Mon, 15 Oct 2012 16:49:13 +1000
Message-ID: <1350283759-31158-6-git-send-email-gerg@snapgear.com>
In-Reply-To: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
References: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
Message-ID: <20121015064913.NvvpnTY-o-iaOBL4Aj9gXGc4tbuUvDoA5DXJQIBaJr0@z>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local shmbuf.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild   |    1 +
 arch/m68k/include/asm/shmbuf.h |   42 ----------------------------------------
 2 files changed, 1 insertions(+), 42 deletions(-)
 delete mode 100644 arch/m68k/include/asm/shmbuf.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 677eace..775eef9 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -26,6 +26,7 @@ generic-y += percpu.h
 generic-y += resource.h
 generic-y += scatterlist.h
 generic-y += sections.h
+generic-y += shmbuf.h
 generic-y += shmparam.h
 generic-y += siginfo.h
 generic-y += statfs.h
diff --git a/arch/m68k/include/asm/shmbuf.h b/arch/m68k/include/asm/shmbuf.h
deleted file mode 100644
index f8928d6..0000000
--- a/arch/m68k/include/asm/shmbuf.h
+++ /dev/null
@@ -1,42 +0,0 @@
-#ifndef _M68K_SHMBUF_H
-#define _M68K_SHMBUF_H
-
-/*
- * The shmid64_ds structure for m68k architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
- */
-
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	unsigned long		__unused1;
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	unsigned long		__unused2;
-	__kernel_time_t		shm_ctime;	/* last change time */
-	unsigned long		__unused3;
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused4;
-	unsigned long		__unused5;
-};
-
-struct shminfo64 {
-	unsigned long	shmmax;
-	unsigned long	shmmin;
-	unsigned long	shmmni;
-	unsigned long	shmseg;
-	unsigned long	shmall;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _M68K_SHMBUF_H */
-- 
1.7.0.4

