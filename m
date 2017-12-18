From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v4 35/36] clocksource/drivers/atcpit100: VDSO support
Date: Mon, 18 Dec 2017 14:46:47 +0800
Message-ID: <550638791ee9f3b99f9a7b92a08e19a4c78ab49f.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45694 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932745AbdLRHO0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Dec 2017 02:14:26 -0500
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, pombredanne@nexb.com
Cc: Rick Chen <rickchen36@gmail.com>, green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>

From: Rick Chen <rickchen36@gmail.com>

VDSO needs real-time cycle count to ensure the time accuracy.
Unlike others, nds32 architecture does not define clock source,
hence VDSO needs atcpit100 offering real-time cycle count
to derive the correct time.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Rick Chen <rickchen36@gmail.com>
Signed-off-by: Greentime Hu <green.hu@gmail.com>
---
 drivers/clocksource/timer-atcpit100.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clocksource/timer-atcpit100.c b/drivers/clocksource/timer-atcpit100.c
index 0077fdb..9b2b628 100644
--- a/drivers/clocksource/timer-atcpit100.c
+++ b/drivers/clocksource/timer-atcpit100.c
@@ -29,6 +29,9 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include "timer-of.h"
+#ifdef CONFIG_NDS32
+#include <asm/vdso_timer_info.h>
+#endif
 
 /*
  * Definition of register offsets
@@ -211,6 +214,17 @@ static u64 notrace atcpit100_timer_sched_read(void)
 	return ~readl(timer_of_base(&to) + CH1_CNT);
 }
 
+#ifdef CONFIG_NDS32
+static void fill_vdso_need_info(struct device_node *node)
+{
+	struct resource timer_res;
+	of_address_to_resource(node, 0, &timer_res);
+	timer_info.mapping_base = (unsigned long)timer_res.start;
+	timer_info.cycle_count_down = true;
+	timer_info.cycle_count_reg_offset = CH1_CNT;
+}
+#endif
+
 static int __init atcpit100_timer_init(struct device_node *node)
 {
 	int ret;
@@ -249,6 +263,10 @@ static int __init atcpit100_timer_init(struct device_node *node)
 	val = readl(base + INT_EN);
 	writel(val | CH0INT0EN, base + INT_EN);
 
+#ifdef CONFIG_NDS32
+	fill_vdso_need_info(node);
+#endif
+
 	return ret;
 }
 
-- 
1.7.9.5
