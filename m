From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2] xtensa: define NO_IRQ as 0, remove other definitions
Date: Thu, 12 Sep 2013 11:17:34 +0400
Message-ID: <1378970254-29094-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:53134 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab3ILHRv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2013 03:17:51 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so8251346lab.14
        for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2013 00:17:50 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, Baruch Siach <baruch@tkos.co.il>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

This fixes the following allmodconfig build error:

sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_probe':
sound/soc/fsl/fsl_ssi.c:939:26: error: 'NO_IRQ' undeclared (first use in this function)

Previous definitions (-1) were correct when used as a hardware IRQ number,
but are incorrect as a mapped IRQ number.

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
+#define NO_IRQ	0
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
