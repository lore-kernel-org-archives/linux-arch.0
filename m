Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:52241 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab2J3G0g (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Oct 2012 02:26:36 -0400
From: <gerg@snapgear.com>
Subject: [PATCH v3 01/11] m68k: switch to using the asm-generic hw_irq.h
Date: Tue, 30 Oct 2012 16:24:27 +1000
Message-ID: <1351578277-31882-2-git-send-email-gerg@snapgear.com>
In-Reply-To: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
References: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
Message-ID: <20121030062427.9T0N1XEu7AmkF_BYyi6kBcwXaNqs_sChDM-rfkunN0c@z>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local hw_irq.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild   |    1 +
 arch/m68k/include/asm/hw_irq.h |    6 ------
 2 files changed, 1 insertions(+), 6 deletions(-)
 delete mode 100644 arch/m68k/include/asm/hw_irq.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 88fa3ac..bf28713 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -7,6 +7,7 @@ generic-y += emergency-restart.h
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

