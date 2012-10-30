Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:52258 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab2J3G0r (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Oct 2012 02:26:47 -0400
From: <gerg@snapgear.com>
Subject: [PATCH v3 09/11] m68k: switch to using the asm-generic sockios.h
Date: Tue, 30 Oct 2012 16:24:35 +1000
Message-ID: <1351578277-31882-10-git-send-email-gerg@snapgear.com>
In-Reply-To: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
References: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
Message-ID: <20121030062435.BS45yknv8hvdssJJCwVzexlKRoEhVRCBjBW0892a-lE@z>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local sockios.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/uapi/asm/Kbuild    |    2 +-
 arch/m68k/include/uapi/asm/sockios.h |   13 -------------
 2 files changed, 1 insertions(+), 14 deletions(-)
 delete mode 100644 arch/m68k/include/uapi/asm/sockios.h

diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 8b90cbd..5218f3d 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -6,6 +6,7 @@ generic-y += msgbuf.h
 generic-y += sembuf.h
 generic-y += shmbuf.h
 generic-y += socket.h
+generic-y += sockios.h
 
 header-y += a.out.h
 header-y += byteorder.h
@@ -19,7 +20,6 @@ header-y += ptrace.h
 header-y += setup.h
 header-y += sigcontext.h
 header-y += signal.h
-header-y += sockios.h
 header-y += stat.h
 header-y += swab.h
 header-y += termbits.h
diff --git a/arch/m68k/include/uapi/asm/sockios.h b/arch/m68k/include/uapi/asm/sockios.h
deleted file mode 100644
index c04a239..0000000
--- a/arch/m68k/include/uapi/asm/sockios.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __ARCH_M68K_SOCKIOS__
-#define __ARCH_M68K_SOCKIOS__
-
-/* Socket-level I/O control calls. */
-#define FIOSETOWN	0x8901
-#define SIOCSPGRP	0x8902
-#define FIOGETOWN	0x8903
-#define SIOCGPGRP	0x8904
-#define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
-
-#endif /* __ARCH_M68K_SOCKIOS__ */
-- 
1.7.0.4

