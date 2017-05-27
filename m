From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 5/7] clocksource: Rename clksrc
Date: Sat, 27 May 2017 11:58:46 +0200
Message-ID: <1495879129-28109-5-git-send-email-daniel.lezcano@linaro.org>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34401 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755253AbdE0J7k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 May 2017 05:59:40 -0400
Received: by mail-wr0-f169.google.com with SMTP id j27so12809912wre.1
        for <linux-arch@vger.kernel.org>; Sat, 27 May 2017 02:59:39 -0700 (PDT)
In-Reply-To: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, daniel.lezcano@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>

The table name is now renamed to 'timer' for consistency with
the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/clksrc-probe.c | 18 +++++++++---------
 include/asm-generic/vmlinux.lds.h  |  6 +++---
 include/linux/clocksource.h        |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/clksrc-probe.c b/drivers/clocksource/clksrc-probe.c
index 5d549c2..da81e5d 100644
--- a/drivers/clocksource/clksrc-probe.c
+++ b/drivers/clocksource/clksrc-probe.c
@@ -19,20 +19,20 @@
 #include <linux/of.h>
 #include <linux/clocksource.h>
 
-extern struct of_device_id __clksrc_of_table[];
+extern struct of_device_id __timer_of_table[];
 
-static const struct of_device_id __clksrc_of_table_sentinel
-	__used __section(__clksrc_of_table_end);
+static const struct of_device_id __timer_of_table_sentinel
+	__used __section(__timer_of_table_end);
 
 void __init timer_probe(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
 	of_init_fn_1_ret init_func_ret;
-	unsigned clocksources = 0;
+	unsigned timers = 0;
 	int ret;
 
-	for_each_matching_node_and_match(np, __clksrc_of_table, &match) {
+	for_each_matching_node_and_match(np, __timer_of_table, &match) {
 		if (!of_device_is_available(np))
 			continue;
 
@@ -45,11 +45,11 @@ void __init timer_probe(void)
 			continue;
 		}
 
-		clocksources++;
+		timers++;
 	}
 
-	clocksources += acpi_probe_device_table(clksrc);
+	timers += acpi_probe_device_table(timer);
 
-	if (!clocksources)
-		pr_crit("%s: no matching clocksources found\n", __func__);
+	if (!timers)
+		pr_crit("%s: no matching timers found\n", __func__);
 }
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0968d13..ca922ae 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -172,7 +172,7 @@
 	KEEP(*(__##name##_of_table))					\
 	KEEP(*(__##name##_of_table_end))
 
-#define CLKSRC_OF_TABLES()	OF_TABLE(CONFIG_CLKSRC_OF, clksrc)
+#define TIMER_OF_TABLES()	OF_TABLE(CONFIG_CLKSRC_OF, timer)
 #define IRQCHIP_OF_MATCH_TABLE() OF_TABLE(CONFIG_IRQCHIP, irqchip)
 #define CLK_OF_TABLES()		OF_TABLE(CONFIG_COMMON_CLK, clk)
 #define IOMMU_OF_TABLES()	OF_TABLE(CONFIG_OF_IOMMU, iommu)
@@ -558,14 +558,14 @@
 	MEM_DISCARD(init.rodata)					\
 	CLK_OF_TABLES()							\
 	RESERVEDMEM_OF_TABLES()						\
-	CLKSRC_OF_TABLES()						\
+	TIMER_OF_TABLES()						\
 	IOMMU_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
 	CPUIDLE_METHOD_OF_TABLES()					\
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
-	ACPI_PROBE_TABLE(clksrc)					\
+	ACPI_PROBE_TABLE(timer)						\
 	ACPI_PROBE_TABLE(iort)						\
 	EARLYCON_TABLE()
 
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index e43f37f..7cd38b2 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -250,7 +250,7 @@ extern int clocksource_mmio_init(void __iomem *, const char *,
 extern int clocksource_i8253_init(void);
 
 #define TIMER_OF_DECLARE(name, compat, fn) \
-	OF_DECLARE_1_RET(clksrc, name, compat, fn)
+	OF_DECLARE_1_RET(timer, name, compat, fn)
 
 #ifdef CONFIG_CLKSRC_PROBE
 extern void timer_probe(void);
@@ -259,6 +259,6 @@ static inline void timer_probe(void) {}
 #endif
 
 #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
-	ACPI_DECLARE_PROBE_ENTRY(clksrc, name, table_id, 0, NULL, 0, fn)
+	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
 
 #endif /* _LINUX_CLOCKSOURCE_H */
-- 
2.7.4
