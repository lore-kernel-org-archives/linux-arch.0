Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dalsmrelay2.nai.com ([205.227.136.216]:49607 "EHLO
	dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756063Ab2J2F5o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2012 01:57:44 -0400
From: <gerg@snapgear.com>
Subject: [PATCH v2 02/11] m68k: switch to using the asm-generic hw_irq.h
Date: Mon, 29 Oct 2012 15:49:25 +1000
Message-ID: <1351489774-14263-3-git-send-email-gerg@snapgear.com>
In-Reply-To: <1351489774-14263-1-git-send-email-gerg@snapgear.com>
References: <1351489774-14263-1-git-send-email-gerg@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
Message-ID: <20121029054925.2FW2CSdoEHbt7BSrRYOzj7wWumqAxgGpc_ncqlZfZjc@z>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local hw_irq.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild   |    1 +
 arch/m68k/include/asm/hw_irq.h |    6 ------
 2 files changed, 1 insertions(+), 6 deletions(-)
 delete mode 100644 arch/m68k/include/asm/hw_irq.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 009446e..fbf0306 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -8,6 +8,7 @@ generic-y += emergency-restart.h
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

