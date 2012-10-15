Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:28923 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab2JOGqj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2012 02:46:39 -0400
From: <gerg@snapgear.com>
Subject: [PATCH 02/11] m68k: switch to using the asm-generic hw_irq.h
Date: Mon, 15 Oct 2012 16:49:10 +1000
Message-ID: <1350283759-31158-3-git-send-email-gerg@snapgear.com>
In-Reply-To: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
References: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
Message-ID: <20121015064910.5m0v3IfkoFkj5Sgbkx3rNbjOROV3nyDZ90eWTcQNCqc@z>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local hw_irq.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild   |    1 +
 arch/m68k/include/asm/hw_irq.h |    6 ------
 2 files changed, 1 insertions(+), 6 deletions(-)
 delete mode 100644 arch/m68k/include/asm/hw_irq.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 7de78bb..3905fca 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -10,6 +10,7 @@ generic-y += emergency-restart.h
 generic-y += errno.h
 generic-y += exec.h
 generic-y += futex.h
+generic-y += hw_irq.h
 generic-y += ioctl.h
 generic-y += ipcbuf.h
 generic-y += irq_regs.h
diff --git a/arch/m68k/include/asm/hw_irq.h b/arch/m68k/include/asm/hw_irq.h
deleted file mode 100644
index eacef09..0000000
--- a/arch/m68k/include/asm/hw_irq.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_M68K_HW_IRQ_H
-#define __ASM_M68K_HW_IRQ_H
-
-/* Dummy include. */
-
-#endif
-- 
1.7.0.4

