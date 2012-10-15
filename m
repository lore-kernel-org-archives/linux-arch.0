Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:28951 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab2JOGq6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2012 02:46:58 -0400
From: <gerg@snapgear.com>
Subject: [PATCH 10/11] m68k: switch to using the asm-generic sockios.h
Date: Mon, 15 Oct 2012 16:49:18 +1000
Message-ID: <1350283759-31158-11-git-send-email-gerg@snapgear.com>
In-Reply-To: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
References: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
Message-ID: <20121015064918.D0qfZt4SB0fYcEC_l_ZevSLu_WN_x2qYmQ0V3ClvqeI@z>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local sockios.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild    |    1 +
 arch/m68k/include/asm/sockios.h |   13 -------------
 2 files changed, 1 insertions(+), 13 deletions(-)
 delete mode 100644 arch/m68k/include/asm/sockios.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 11ce0be..c9b3afc 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -30,6 +30,7 @@ generic-y += sembuf.h
 generic-y += shmbuf.h
 generic-y += shmparam.h
 generic-y += siginfo.h
+generic-y += sockios.h
 generic-y += spinlock.h
 generic-y += statfs.h
 generic-y += termbits.h
diff --git a/arch/m68k/include/asm/sockios.h b/arch/m68k/include/asm/sockios.h
deleted file mode 100644
index c04a239..0000000
--- a/arch/m68k/include/asm/sockios.h
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

