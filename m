From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: move NO_IRQ definition into asm/irq.h
Date: Thu, 12 Sep 2013 09:06:06 +0400
Message-ID: <1378962366-26818-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:42461 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab3ILFGU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2013 01:06:20 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so8126529lab.41
        for <linux-arch@vger.kernel.org>; Wed, 11 Sep 2013 22:06:19 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

This fixes the following allmodconfig build error:

sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_probe':
sound/soc/fsl/fsl_ssi.c:939:26: error: 'NO_IRQ' undeclared (first use in this function)

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/irq.h                      |    4 ++++
 .../platforms/xtfpga/include/platform/hardware.h   |    4 ----
 arch/xtensa/variants/s6000/include/variant/irq.h   |    1 -
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/include/asm/irq.h b/arch/xtensa/include/asm/irq.h
index 268eec5..56a9503 100644
--- a/arch/xtensa/include/asm/irq.h
+++ b/arch/xtensa/include/asm/irq.h
@@ -22,6 +22,10 @@ static inline void variant_irq_enable(unsigned int irq) { }
 static inline void variant_irq_disable(unsigned int irq) { }
 #endif
 
+#ifndef NO_IRQ
+#define NO_IRQ	((unsigned int)(-1))
+#endif
+
 #ifndef VARIANT_NR_IRQS
 # define VARIANT_NR_IRQS 0
 #endif
diff --git a/arch/xtensa/platforms/xtfpga/include/platform/hardware.h b/arch/xtensa/platforms/xtfpga/include/platform/hardware.h
index 4060297..42a731b 100644
--- a/arch/xtensa/platforms/xtfpga/include/platform/hardware.h
+++ b/arch/xtensa/platforms/xtfpga/include/platform/hardware.h
@@ -15,10 +15,6 @@
 #ifndef __XTENSA_XTAVNET_HARDWARE_H
 #define __XTENSA_XTAVNET_HARDWARE_H
 
-/* By default NO_IRQ is defined to 0 in Linux, but we use the
-   interrupt 0 for UART... */
-#define NO_IRQ                 -1
-
 /* Memory configuration. */
 
 #define PLATFORM_DEFAULT_MEM_START 0x00000000
diff --git a/arch/xtensa/variants/s6000/include/variant/irq.h b/arch/xtensa/variants/s6000/include/variant/irq.h
index 97d6fc4..39ca751 100644
--- a/arch/xtensa/variants/s6000/include/variant/irq.h
+++ b/arch/xtensa/variants/s6000/include/variant/irq.h
@@ -1,7 +1,6 @@
 #ifndef _XTENSA_S6000_IRQ_H
 #define _XTENSA_S6000_IRQ_H
 
-#define NO_IRQ		(-1)
 #define VARIANT_NR_IRQS 8 /* GPIO interrupts */
 
 extern void variant_irq_enable(unsigned int irq);
-- 
1.7.7.6
