From: Rick Chen <rickchen36@gmail.com>
Subject: [PATCH v5 2/3] clocksource/drivers/atcpit100: VDSO support
Date: Tue, 12 Dec 2017 13:47:00 +0800
Message-ID: <1513057621-19084-3-git-send-email-rickchen36@gmail.com>
References: <1513057621-19084-1-git-send-email-rickchen36@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34438 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbdLLGMM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Dec 2017 01:12:12 -0500
In-Reply-To: <1513057621-19084-1-git-send-email-rickchen36@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rickchen36@gmail.com, rick@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@linaro.org, daniel.lezcano@linaro.org, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, linux-serial@vger.kernel.org
Cc: Vincent Chen <vincentc@andestech.com>, Greentime Hu <green.hu@gmail.com>

VDSO needs real-time cycle count to ensure the time accuracy.
Unlike others, nds32 architecture does not define clock source,
hence VDSO needs atcpit100 offering real-time cycle count
to derive the correct time.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Rick Chen <rickchen36@gmail.com>
Signed-off-by: Greentime Hu <green.hu@gmail.com>
---
 drivers/clocksource/timer-atcpit100.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clocksource/timer-atcpit100.c b/drivers/clocksource/timer-atcpit100.c
index 0077fdb..1be6c0a 100644
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
@@ -211,6 +214,14 @@ static u64 notrace atcpit100_timer_sched_read(void)
 	return ~readl(timer_of_base(&to) + CH1_CNT);
 }
 
+#ifdef CONFIG_NDS32
+static void fill_vdso_need_info(void)
+{
+	timer_info.cycle_count_down = true;
+	timer_info.cycle_count_reg_offset = CH1_CNT;
+}
+#endif
+
 static int __init atcpit100_timer_init(struct device_node *node)
 {
 	int ret;
@@ -249,6 +260,10 @@ static int __init atcpit100_timer_init(struct device_node *node)
 	val = readl(base + INT_EN);
 	writel(val | CH0INT0EN, base + INT_EN);
 
+#ifdef CONFIG_NDS32
+	fill_vdso_need_info();
+#endif
+
 	return ret;
 }
 
-- 
2.7.4
