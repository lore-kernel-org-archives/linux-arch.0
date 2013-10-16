From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 01/17] xtensa: remove NO_IRQ definitions
Date: Thu, 17 Oct 2013 02:42:12 +0400
Message-ID: <1381963348-29448-2-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:60425 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758776Ab3JPWms (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:42:48 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so1163857lbh.23
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:42:47 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

These definitions (-1) were correct when used as a hardware IRQ number,
but are incorrect as a mapped IRQ number.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/xtfpga/include/platform/hardware.h | 4 ----
 arch/xtensa/variants/s6000/include/variant/irq.h         | 1 -
 2 files changed, 5 deletions(-)

diff --git a/arch/xtensa/platforms/xtfpga/include/platform/hardware.h b/arch/xtensa/platforms/xtfpga/include/platform/hardware.h
index 4416773..4b43ff1 100644
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
1.8.1.4
