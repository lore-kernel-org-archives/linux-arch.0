Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam01on0047.outbound.protection.outlook.com ([104.47.32.47]:36219
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751691AbeCOLCM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Mar 2018 07:02:12 -0400
From: Aaron Wu <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 26/28] samples: Remove Blackfin gptimers sample code
Date: Thu, 15 Mar 2018 18:50:26 +0800
Message-ID: <1521111028-19856-26-git-send-email-aaron.wu@analog.com>
In-Reply-To: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
References: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, f.fainelli@gmail.com, linux-arch@vger.kernel.org, kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, liqin.linux@gmail.com, lennox.wu@gmail.com, gxt@mprc.pku.edu.cn, linux@roeck-us.net
Cc: viro@zeniv.linux.org.uk, jhogan@kernel.org, linux-metag@vger.kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, openrisc@lists.librecores.org, dhowells@redhat.com, peterz@infradead.org, aaron.wu@analog.com

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin gptimers sample code
---
 samples/Kconfig                     |  6 ---
 samples/Makefile                    |  2 +-
 samples/blackfin/Makefile           |  1 -
 samples/blackfin/gptimers-example.c | 91 -------------------------------------
 4 files changed, 1 insertion(+), 99 deletions(-)
 delete mode 100644 samples/blackfin/Makefile
 delete mode 100644 samples/blackfin/gptimers-example.c

diff --git a/samples/Kconfig b/samples/Kconfig
index c332a3b..f524f55 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -98,12 +98,6 @@ config SAMPLE_SECCOMP
 	  Build samples of seccomp filters using various methods of
 	  BPF filter construction.
 
-config SAMPLE_BLACKFIN_GPTIMERS
-	tristate "Build blackfin gptimers sample code -- loadable modules only"
-	depends on BLACKFIN && BFIN_GPTIMERS && m
-	help
-	  Build samples of blackfin gptimers sample module.
-
 config SAMPLE_VFIO_MDEV_MTTY
 	tristate "Build VFIO mtty example mediated device sample code -- loadable modules only"
 	depends on VFIO_MDEV_DEVICE && m
diff --git a/samples/Makefile b/samples/Makefile
index db54e76..70cf375 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -2,5 +2,5 @@
 
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
-			   configfs/ connector/ v4l/ trace_printk/ blackfin/ \
+			   configfs/ connector/ v4l/ trace_printk/ \
 			   vfio-mdev/ statx/
diff --git a/samples/blackfin/Makefile b/samples/blackfin/Makefile
deleted file mode 100644
index 89b86cf..0000000
--- a/samples/blackfin/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_SAMPLE_BLACKFIN_GPTIMERS) += gptimers-example.o
diff --git a/samples/blackfin/gptimers-example.c b/samples/blackfin/gptimers-example.c
deleted file mode 100644
index 283eba9..0000000
--- a/samples/blackfin/gptimers-example.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * Simple gptimers example
- *	http://docs.blackfin.uclinux.org/doku.php?id=linux-kernel:drivers:gptimers
- *
- * Copyright 2007-2009 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/interrupt.h>
-#include <linux/module.h>
-
-#include <asm/gptimers.h>
-#include <asm/portmux.h>
-
-/* ... random driver includes ... */
-
-#define DRIVER_NAME "gptimer_example"
-
-#ifdef IRQ_TIMER5
-#define SAMPLE_IRQ_TIMER IRQ_TIMER5
-#else
-#define SAMPLE_IRQ_TIMER IRQ_TIMER2
-#endif
-
-struct gptimer_data {
-	uint32_t period, width;
-};
-static struct gptimer_data data;
-
-/* ... random driver state ... */
-
-static irqreturn_t gptimer_example_irq(int irq, void *dev_id)
-{
-	struct gptimer_data *data = dev_id;
-
-	/* make sure it was our timer which caused the interrupt */
-	if (!get_gptimer_intr(TIMER5_id))
-		return IRQ_NONE;
-
-	/* read the width/period values that were captured for the waveform */
-	data->width = get_gptimer_pwidth(TIMER5_id);
-	data->period = get_gptimer_period(TIMER5_id);
-
-	/* acknowledge the interrupt */
-	clear_gptimer_intr(TIMER5_id);
-
-	/* tell the upper layers we took care of things */
-	return IRQ_HANDLED;
-}
-
-/* ... random driver code ... */
-
-static int __init gptimer_example_init(void)
-{
-	int ret;
-
-	/* grab the peripheral pins */
-	ret = peripheral_request(P_TMR5, DRIVER_NAME);
-	if (ret) {
-		printk(KERN_NOTICE DRIVER_NAME ": peripheral request failed\n");
-		return ret;
-	}
-
-	/* grab the IRQ for the timer */
-	ret = request_irq(SAMPLE_IRQ_TIMER, gptimer_example_irq,
-			IRQF_SHARED, DRIVER_NAME, &data);
-	if (ret) {
-		printk(KERN_NOTICE DRIVER_NAME ": IRQ request failed\n");
-		peripheral_free(P_TMR5);
-		return ret;
-	}
-
-	/* setup the timer and enable it */
-	set_gptimer_config(TIMER5_id,
-			WDTH_CAP | PULSE_HI | PERIOD_CNT | IRQ_ENA);
-	enable_gptimers(TIMER5bit);
-
-	return 0;
-}
-module_init(gptimer_example_init);
-
-static void __exit gptimer_example_exit(void)
-{
-	disable_gptimers(TIMER5bit);
-	free_irq(SAMPLE_IRQ_TIMER, &data);
-	peripheral_free(P_TMR5);
-}
-module_exit(gptimer_example_exit);
-
-MODULE_LICENSE("BSD");
-- 
2.7.4
