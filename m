From: <gerg@snapgear.com>
Subject: [PATCH v2 05/11] m68k: switch to using the asm-generic shmbuf.h
Date: Mon, 29 Oct 2012 15:49:28 +1000
Message-ID: <1351489774-14263-6-git-send-email-gerg@snapgear.com>
References: <1351489774-14263-1-git-send-email-gerg@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from dalsmrelay2.nai.com ([205.227.136.216]:49571 "EHLO
	dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023Ab2J2F5Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2012 01:57:25 -0400
In-Reply-To: <1351489774-14263-1-git-send-email-gerg@snapgear.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local shmbuf.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild        |    1 +
 arch/m68k/include/uapi/asm/Kbuild   |    1 -
 arch/m68k/include/uapi/asm/shmbuf.h |   42 -----------------------------------
 3 files changed, 1 insertions(+), 43 deletions(-)
 delete mode 100644 arch/m68k/include/uapi/asm/shmbuf.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 3144bb9..7541328 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -24,6 +24,7 @@ generic-y += percpu.h
 generic-y += resource.h
 generic-y += scatterlist.h
 generic-y += sections.h
+generic-y += shmbuf.h
 generic-y += shmparam.h
 generic-y += siginfo.h
 generic-y += statfs.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 5c99e46..5d627ed 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -12,7 +12,6 @@ header-y += posix_types.h
 header-y += ptrace.h
 header-y += sembuf.h
 header-y += setup.h
-header-y += shmbuf.h
 header-y += sigcontext.h
 header-y += signal.h
 header-y += socket.h
diff --git a/arch/m68k/include/uapi/asm/shmbuf.h b/arch/m68k/include/uapi/asm/shmbuf.h
deleted file mode 100644
index f8928d6..0000000
--- a/arch/m68k/include/uapi/asm/shmbuf.h
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
