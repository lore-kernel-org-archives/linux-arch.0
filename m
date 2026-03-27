Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4B22D7DC4;
	Fri, 27 Mar 2026 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634771; cv=none; b=MNTosP00n5kcTHKeXC61gj98YJ5HPdKgTasMu+M30g8z7nF7RBRD8zZW76KF2hEyV/EgcTj0zMUicgFOU9ao4fi3ba0J5WCK8MR7Em555ikaeuO4hd5Gecpw8WlrPdJdWD4Ek4L21H0JcycbhB/aQRfwUdf7tL7KTkVGasXTwRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634771; c=relaxed/simple;
	bh=ExYu4MocTJ/m1GTF+9uD6AaFYfgRkiFOMtaD+oQsvJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Up+OyCCJYxRxWEw7E8yi3WhONYqr/R3bZgJifO6DR8XUsk7pHMH53cvSPnsn7twNINqv11YcN/qfT5q87zV12esa1DTnR2NTSf+DMBIPQQymU4DDa0R/TS1Rhvboq/wy4jor1eAjAPi6FUnNMIPSbDEpOOgdARrzOaVbBHTbZcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rK8ANFM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rK8ANFM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB19C19424;
	Fri, 27 Mar 2026 18:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774634770;
	bh=ExYu4MocTJ/m1GTF+9uD6AaFYfgRkiFOMtaD+oQsvJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rK8ANFM4BAL1hIC9sfKsJYzdwehNcOzQwqOMlalkfUfOIXWFry+LU0YGXCGaxOY3u
	 X44QjXE9SH3Mjg7RhVZ2o2P0qQfdTrNKl2hfdMRMNwSvjcCGGakOe6uir5CBdr0xnK
	 zWcVKB3G5/MEho8UFNtdmtwsvkyaXNQki52Ut3AvGYC0y+8c7OSjFSjWlH2VqODF93
	 10KWWpL0yDLRu3N7trRaVbN1uylhI8qc46grthBUg693owEBaLQWvKHKj0ZTvQK+Ri
	 hu0m0bmyiusF+Sdo2sw/Qgd2SY3kVhZRlHdIalsYRIbk23k2NfVf23jRaBe8I9P6zV
	 wL7ezdmXggvTA==
From: Daniel Lezcano <daniel.lezcano@kernel.org>
To: daniel.lezcano@kernel.org,
	tglx@kernel.org,
	zhipeng.wang_1@nxp.com
Cc: shawnguo@kernel.org,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH resend v1 1/7] clocksource/drivers/timer-probe: Create a platform_device before the framework is initialized
Date: Fri, 27 Mar 2026 19:05:53 +0100
Message-ID: <20260327180600.8150-2-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327180600.8150-1-daniel.lezcano@kernel.org>
References: <20260327180600.8150-1-daniel.lezcano@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Daniel Lezcano <daniel.lezcano@linaro.org>

In the context of the time keeping and the timers, some platforms have
timers which need to be initialized very early. It is the case of the
ARM platform which do not have the architected timers.

The macro TIMER_OF_DECLARE adds an entry in the timer init functions
array at compile time and the function timer_probe is called from the
timer_init() function in kernel/time.c

This array contains a tuple with the init function and the compatible
string.

The init function has a device node pointer parameter.

The timer_probe() function browses the of nodes and find the ones
matching the compatible string given when using the TIMER_OF_DECLARE
macro. It then calls the init function with the device node as a
pointer.

But there are some platforms where there are multiple timers like the
ARM64 with the architected timers. Those are always initialized very
early and the other timers can be initialized later.

For this reason we find timer drivers with the platform_driver
incarnation. Consequently their init functions are different, they
have a platform_device pointer parameter and rely on the devm_
function for rollbacking.

To summarize, we have:
 - TIMER_OF_DECLARE with init function prototype:
   int (*init)(struct device_node *np);

 - module_platform_driver (and variant) with the probe function
   prototype:
   int (*init)(struct platform_device *pdev);

The current situation with the timers is the following:

 - Two platforms can have the same timer hardware, hence the same
   driver but one without alternate timers and the other with multiple
   timers. For example, the Exynos platform has only the Exynos MCT on
   ARM but has the architeched timers in addition on the ARM64.

 - The timer drivers can be modules now which was not the case until
   recently. TIMER_OF_DECLARE do not allow the build as a module.

It results in duplicate init functions (one with rollback and one with
devm_) and different way to declare the driver (TIMER_OF_DECLARE and
module_platform_driver).

This proposed change is to unify the prototyping of the init functions
to receive a platform_device pointer as parameter. Consequently, it
will allow a smoother and nicer module conversion and a huge cleanup
of the init functions by removing all the rollback code from all the
timer drivers. It introduces a TIMER_PDEV_DECLARE() macro.

If the macro is used a platform_device is manually allocated and
initialized with the needed information for the probe
function. Otherwise module_platform_driver can be use instead with the
same probe function without the timer_probe() initialization.

The plan is to have all timers to use TIMER_PDEV_DECLARE with all the
init functions optimized and then remove the TIMER_OF_DECLARE macro.

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clocksource/timer-probe.c | 66 +++++++++++++++++++++++++++++--
 include/asm-generic/vmlinux.lds.h | 10 +++++
 include/linux/clocksource.h       | 21 ++++++++++
 3 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index b7860bc0db4b..cdaceb68d356 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -7,13 +7,11 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/clocksource.h>
+#include <linux/platform_device.h>
 
 extern struct of_device_id __timer_of_table[];
 
-static const struct of_device_id __timer_of_table_sentinel
-	__used __section("__timer_of_table_end");
-
-void __init timer_probe(void)
+static int __init timer_of_probe(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
@@ -38,6 +36,66 @@ void __init timer_probe(void)
 		timers++;
 	}
 
+	return timers;
+}
+
+static int __init __timer_pdev_probe(struct platform_driver *drv)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+	const struct of_device_id *match;
+	unsigned int timers = 0;
+	int ret;
+
+	for_each_matching_node_and_match(np, drv->driver.of_match_table, &match) {
+		if (!of_device_is_available(np))
+			continue;
+
+		pdev = platform_device_alloc(of_node_full_name(np), -1);
+		if (!pdev)
+			continue;
+
+		ret = device_add_of_node(&pdev->dev, np);
+		if (ret) {
+			platform_device_put(pdev);
+			continue;
+		}
+
+		dev_set_name(&pdev->dev, pdev->name);
+
+		ret = drv->probe(pdev);
+		if (!ret) {
+			timers++;
+			continue;
+		}
+
+		if (ret != -EPROBE_DEFER)
+			pr_err("Failed to initialize '%pOF': %d\n", np, ret);
+
+		device_remove_of_node(&pdev->dev);
+
+		platform_device_put(pdev);
+	}
+
+	return timers;
+}
+
+static int __init timer_pdev_probe(void)
+{
+	struct platform_driver **drv;
+
+	for_each_pdev_timer_table(drv)
+		__timer_pdev_probe(*drv);
+
+	return 0;
+}
+
+void __init timer_probe(void)
+{
+	unsigned timers = 0;
+
+	timers += timer_of_probe();
+	timers += timer_pdev_probe();
 	timers += acpi_probe_device_table(timer);
 
 	if (!timers)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index eeb070f330bd..5d619e831dce 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -359,6 +359,15 @@
 #define THERMAL_TABLE(name)
 #endif
 
+#ifdef CONFIG_TIMER_OF
+#define TIMER_TABLE(name)						\
+	. = ALIGN(8);							\
+	BOUNDED_SECTION_POST_LABEL(__##name##_timer_table,		\
+				   __##name##_timer_table,, _end)
+#else
+#define TIMER_TABLE(name)
+#endif
+
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
 	__dtb_start = .;						\
@@ -738,6 +747,7 @@
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
 	THERMAL_TABLE(governor)						\
+	TIMER_TABLE(pdev)						\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
 	EARLY_LSM_TABLE()						\
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 65b7c41471c3..6e05b78e64b8 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/clocksource_ids.h>
+#include <linux/platform_device.h>
 #include <asm/div64.h>
 #include <asm/io.h>
 
@@ -295,6 +296,26 @@ extern void timer_probe(void);
 static inline void timer_probe(void) {}
 #endif
 
+extern struct platform_driver *__pdev_timer_table[];
+extern struct platform_driver *__pdev_timer_table_end[];
+
+#define TIMER_PDEV_DECLARE(__name, __probe, __remove, __match)		\
+	static struct platform_driver __pdev_timer_table_entry_##__name = { \
+		.probe = __probe,					\
+		.remove = __remove,					\
+		.driver = {						\
+			.name = #__name,				\
+			.of_match_table = __match			\
+		},							\
+	};								\
+	static struct platform_driver *___pdev_timer_table_entry_##__name \
+	__used __section("__pdev_timer_table") = &__pdev_timer_table_entry_##__name
+
+#define for_each_pdev_timer_table(__pdev)     \
+	for (__pdev = __pdev_timer_table;     \
+	     __pdev < __pdev_timer_table_end; \
+	     __pdev++)
+
 #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
 
-- 
2.43.0

