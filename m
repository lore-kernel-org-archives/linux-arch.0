From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 12/93] clocksource/drivers/clksrc-probe: Introduce init functions with return code
Date: Thu,  7 Jul 2016 10:00:45 +0200
Message-ID: <1467878526-1238-12-git-send-email-daniel.lezcano@linaro.org>
References: <577E0BED.3020608@linaro.org>
 <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, daniel.lezcano@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Currently, the clksrc-probe is not able to handle any error from the init
functions. There are different issues with the current code:
 - the code is duplicated in the init functions by writing error
 - every driver tends to panic in its own init function
 - counting the number of clocksources is not reliable

This patch adds another table to store the functions returning an error.
The table is temporary while we convert all the drivers to return an error
and will disappear.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/clksrc-probe.c | 22 ++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h  |  2 ++
 include/linux/clocksource.h        |  3 +++
 3 files changed, 27 insertions(+)

diff --git a/drivers/clocksource/clksrc-probe.c b/drivers/clocksource/clksrc-probe.c
index 7cb6c92..5fa6a55 100644
--- a/drivers/clocksource/clksrc-probe.c
+++ b/drivers/clocksource/clksrc-probe.c
@@ -20,16 +20,22 @@
 #include <linux/clocksource.h>
 
 extern struct of_device_id __clksrc_of_table[];
+extern struct of_device_id __clksrc_ret_of_table[];
 
 static const struct of_device_id __clksrc_of_table_sentinel
 	__used __section(__clksrc_of_table_end);
 
+static const struct of_device_id __clksrc_ret_of_table_sentinel
+	__used __section(__clksrc_ret_of_table_end);
+
 void __init clocksource_probe(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
 	of_init_fn_1 init_func;
+	of_init_fn_1_ret init_func_ret;
 	unsigned clocksources = 0;
+	int ret;
 
 	for_each_matching_node_and_match(np, __clksrc_of_table, &match) {
 		if (!of_device_is_available(np))
@@ -40,6 +46,22 @@ void __init clocksource_probe(void)
 		clocksources++;
 	}
 
+	for_each_matching_node_and_match(np, __clksrc_ret_of_table, &match) {
+		if (!of_device_is_available(np))
+			continue;
+
+		init_func_ret = match->data;
+
+		ret = init_func_ret(np);
+		if (ret) {
+			pr_err("Failed to initialize '%s': %d",
+			       of_node_full_name(np), ret);
+			continue;
+		}
+
+		clocksources++;
+	}
+
 	clocksources += acpi_probe_device_table(clksrc);
 
 	if (!clocksources)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 6a67ab9..8c6c626 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -173,6 +173,7 @@
 	*(__##name##_of_table_end)
 
 #define CLKSRC_OF_TABLES()	OF_TABLE(CONFIG_CLKSRC_OF, clksrc)
+#define CLKSRC_RET_OF_TABLES()	OF_TABLE(CONFIG_CLKSRC_OF, clksrc_ret)
 #define IRQCHIP_OF_MATCH_TABLE() OF_TABLE(CONFIG_IRQCHIP, irqchip)
 #define CLK_OF_TABLES()		OF_TABLE(CONFIG_COMMON_CLK, clk)
 #define IOMMU_OF_TABLES()	OF_TABLE(CONFIG_OF_IOMMU, iommu)
@@ -531,6 +532,7 @@
 	CLK_OF_TABLES()							\
 	RESERVEDMEM_OF_TABLES()						\
 	CLKSRC_OF_TABLES()						\
+	CLKSRC_RET_OF_TABLES()						\
 	IOMMU_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
 	CPUIDLE_METHOD_OF_TABLES()					\
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 44a1aff..15c3839 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -246,6 +246,9 @@ extern int clocksource_i8253_init(void);
 #define CLOCKSOURCE_OF_DECLARE(name, compat, fn) \
 	OF_DECLARE_1(clksrc, name, compat, fn)
 
+#define CLOCKSOURCE_OF_DECLARE_RET(name, compat, fn) \
+	OF_DECLARE_1_RET(clksrc_ret, name, compat, fn)
+
 #ifdef CONFIG_CLKSRC_PROBE
 extern void clocksource_probe(void);
 #else
-- 
1.9.1
