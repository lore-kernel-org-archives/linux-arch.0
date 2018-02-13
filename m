From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 2/3] clocksource/drivers/atcpit100: VDSO support
Date: Tue, 13 Feb 2018 17:13:18 +0800
Message-ID: <43bd7f8f5379f2c63af9dc0672e19f0e4671d425.1518505425.git.greentime@andestech.com>
References: <cover.1518505425.git.greentime@andestech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1518505425.git.greentime@andestech.com>
In-Reply-To: <cover.1518505425.git.greentime@andestech.com>
References: <cover.1518505425.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: Rick Chen <rickchen36@gmail.com>, green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Rick Chen <rickchen36@gmail.com>

VDSO needs real-time cycle count to ensure the time accuracy.
Unlike others, nds32 architecture does not define clock source,
hence VDSO needs atcpit100 offering real-time cycle count
to derive the correct time.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Rick Chen <rickchen36@gmail.com>
Signed-off-by: Greentime Hu <green.hu@gmail.com>
---
 drivers/clocksource/timer-atcpit100.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clocksource/timer-atcpit100.c b/drivers/clocksource/timer-atcpit100.c
index 2190096cffa3..5e23d7b4a722 100644
--- a/drivers/clocksource/timer-atcpit100.c
+++ b/drivers/clocksource/timer-atcpit100.c
@@ -18,6 +18,9 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include "timer-of.h"
+#ifdef CONFIG_NDS32
+#include <asm/vdso_timer_info.h>
+#endif
 
 /*
  * Definition of register offsets
@@ -204,6 +207,17 @@ static u64 notrace atcpit100_timer_sched_read(void)
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
@@ -242,6 +256,10 @@ static int __init atcpit100_timer_init(struct device_node *node)
 	val = readl(base + INT_EN);
 	writel(val | CH0INT0EN, base + INT_EN);
 
+#ifdef CONFIG_NDS32
+	fill_vdso_need_info(node);
+#endif
+
 	return ret;
 }
 
-- 
2.16.1
