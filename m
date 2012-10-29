Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dalsmrelay2.nai.com ([205.227.136.216]:49613 "EHLO
	dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867Ab2J2F5w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2012 01:57:52 -0400
From: <gerg@snapgear.com>
Subject: [PATCH v2 06/11] m68k: switch to using the asm-generic sembuf.h
Date: Mon, 29 Oct 2012 15:49:29 +1000
Message-ID: <1351489774-14263-7-git-send-email-gerg@snapgear.com>
In-Reply-To: <1351489774-14263-1-git-send-email-gerg@snapgear.com>
References: <1351489774-14263-1-git-send-email-gerg@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
Message-ID: <20121029054929.mVlfear7G10vExW53dtZXwDuX5CTSjxOSWG9Sgh3Syc@z>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local sembuf.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild        |    1 +
 arch/m68k/include/uapi/asm/Kbuild   |    1 -
 arch/m68k/include/uapi/asm/sembuf.h |   25 -------------------------
 3 files changed, 1 insertions(+), 26 deletions(-)
 delete mode 100644 arch/m68k/include/uapi/asm/sembuf.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 7541328..86d38c0 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -24,6 +24,7 @@ generic-y += percpu.h
 generic-y += resource.h
 generic-y += scatterlist.h
 generic-y += sections.h
+generic-y += sembuf.h
 generic-y += shmbuf.h
 generic-y += shmparam.h
 generic-y += siginfo.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 5d627ed..73de97a 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -10,7 +10,6 @@ header-y += param.h
 header-y += poll.h
 header-y += posix_types.h
 header-y += ptrace.h
-header-y += sembuf.h
 header-y += setup.h
 header-y += sigcontext.h
 header-y += signal.h
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

