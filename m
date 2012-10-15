From: <gerg@snapgear.com>
Subject: [PATCH 03/11] m68k: switch to using the asm-generic shmparam.h
Date: Mon, 15 Oct 2012 16:49:11 +1000
Message-ID: <1350283759-31158-4-git-send-email-gerg@snapgear.com>
References: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:28925 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab2JOGql (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2012 02:46:41 -0400
In-Reply-To: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local shmparam.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild     |    1 +
 arch/m68k/include/asm/shmparam.h |    6 ------
 2 files changed, 1 insertions(+), 6 deletions(-)
 delete mode 100644 arch/m68k/include/asm/shmparam.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 3905fca..83fcc34 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -25,6 +25,7 @@ generic-y += percpu.h
 generic-y += resource.h
 generic-y += scatterlist.h
 generic-y += sections.h
+generic-y += shmparam.h
 generic-y += siginfo.h
 generic-y += statfs.h
 generic-y += topology.h
diff --git a/arch/m68k/include/asm/shmparam.h b/arch/m68k/include/asm/shmparam.h
deleted file mode 100644
index 558892a..0000000
--- a/arch/m68k/include/asm/shmparam.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _M68K_SHMPARAM_H
-#define _M68K_SHMPARAM_H
-
-#define	SHMLBA PAGE_SIZE		 /* attach addr a multiple of this */
-
-#endif /* _M68K_SHMPARAM_H */
-- 
1.7.0.4
