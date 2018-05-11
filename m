From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 11/12] misc: implement a dummy early platform driver
Date: Fri, 11 May 2018 18:20:27 +0200
Message-ID: <20180511162028.20616-12-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-arch.vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Implement a very simple early platform driver. Its purpose is to show
how such drivers can be registered and to emit a message when probed.

It can be then added to the device tree or machine code to verify that
the early platform devices work as expected.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/Kconfig       |  8 ++++
 drivers/misc/Makefile      |  1 +
 drivers/misc/dummy-early.c | 82 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 drivers/misc/dummy-early.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 5d713008749b..60fef04eb236 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -91,6 +91,14 @@ config DUMMY_IRQ
 	  The sole purpose of this module is to help with debugging of systems on
 	  which spurious IRQs would happen on disabled IRQ vector.
 
+config DUMMY_EARLY
+	bool "Dummy early platform driver"
+	select EARLY_PLATFORM
+	default n
+	help
+	  This module's only function is to register itself with the early
+	  platform device framework and be probed early in the boot process.
+
 config IBM_ASM
 	tristate "Device driver for IBM RSA service processor"
 	depends on X86 && PCI && INPUT
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d0a8788d5151..6170855853a1 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_INTEL_MID_PTI)	+= pti.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_ATMEL_TCLIB)	+= atmel_tclib.o
 obj-$(CONFIG_DUMMY_IRQ)		+= dummy-irq.o
+obj-$(CONFIG_DUMMY_EARLY)	+= dummy-early.o
 obj-$(CONFIG_ICS932S401)	+= ics932s401.o
 obj-$(CONFIG_LKDTM)		+= lkdtm/
 obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
diff --git a/drivers/misc/dummy-early.c b/drivers/misc/dummy-early.c
new file mode 100644
index 000000000000..eb8f826aea64
--- /dev/null
+++ b/drivers/misc/dummy-early.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Texas Instruments
+ *
+ * Author:
+ *   Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ *
+ * Dummy testing driver whose only purpose is to be registered and probed
+ * using the early platform device mechanism.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/early_platform.h>
+
+struct dummy_early_data {
+	int a;
+	int b;
+};
+
+static int dummy_early_probe_early(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dummy_early_data *data;
+	struct resource *res;
+
+	dev_notice(dev, "dummy-early driver probed early!\n");
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->a = 123;
+	data->b = 321;
+
+	dev_dbg(dev, "setting driver data early: a = %d, b = %d\n",
+		data->a, data->b);
+	dev_set_drvdata(dev, data);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res)
+		dev_dbg(dev, "got early resource: start = 0x%08x, end = 0x%08x\n",
+			res->start, res->end);
+
+	return 0;
+}
+
+static int dummy_early_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dummy_early_data *data;
+
+	dev_notice(dev, "dummy-early driver probed late!\n");
+	data = dev_get_drvdata(dev);
+	dev_dbg(dev, "retrieving driver data late: a = %d, b = %d\n",
+		data->a, data->b);
+
+	return 0;
+}
+
+static const struct of_device_id dummy_early_of_match[] = {
+	{ .compatible = "dummy-early", },
+	{ },
+};
+
+static struct early_platform_driver dummy_early_driver = {
+	.early_probe = dummy_early_probe_early,
+	.pdrv = {
+		.probe = dummy_early_probe,
+		.driver = {
+			.name = "dummy-early",
+			.of_match_table = dummy_early_of_match,
+		},
+	}
+};
+module_early_platform_driver(dummy_early_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_DESCRIPTION("Dummy early platform device driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0
