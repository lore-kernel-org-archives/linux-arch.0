From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH v3 2/3] platform: move the early platform device
 support to arch/sh
Date: Thu, 21 Jun 2018 10:23:20 +0200
Message-ID: <20180621082321.4259-3-brgl@bgdev.pl>
References: <20180621082321.4259-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180621082321.4259-1-brgl@bgdev.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: linux-arch@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-arch.vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

SuperH is the only user of the current implementation of early platform
device support. We want to introduce a more robust approach to early
probing. As the first step - move all the current early platform code
to arch/sh.

In order not to export internal drivers/base functions to arch code for
this temporary solution - copy the two needed routines for driver
matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.

Also: call early_platform_cleanup() from subsys_initcall() so that it's
called after all early devices are probed.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/drivers/Makefile               |   2 +-
 arch/sh/drivers/platform_early.c       | 346 +++++++++++++++++++++++++
 arch/sh/include/asm/platform_early.h   |  61 +++++
 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |   1 +
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |   1 +
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |   1 +
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |   1 +
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |   1 +
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c |   1 +
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh3.c     |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  |   1 +
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |   1 +
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |   1 +
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |   1 +
 arch/sh/kernel/cpu/sh5/setup-sh5.c     |   1 +
 arch/sh/kernel/setup.c                 |   1 +
 arch/sh/kernel/time.c                  |   1 +
 drivers/base/platform.c                | 288 --------------------
 drivers/clocksource/sh_cmt.c           |   7 +
 drivers/clocksource/sh_mtu2.c          |   7 +
 drivers/clocksource/sh_tmu.c           |   8 +
 drivers/tty/serial/sh-sci.c            |   7 +-
 include/linux/platform_device.h        |  64 +----
 40 files changed, 479 insertions(+), 342 deletions(-)
 create mode 100644 arch/sh/drivers/platform_early.c
 create mode 100644 arch/sh/include/asm/platform_early.h

diff --git a/arch/sh/drivers/Makefile b/arch/sh/drivers/Makefile
index 3e93b434e604..56b0acace6e7 100644
--- a/arch/sh/drivers/Makefile
+++ b/arch/sh/drivers/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the Linux SuperH-specific device drivers.
 #
 
-obj-y		+= dma/
+obj-y		+= dma/ platform_early.o
 
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
new file mode 100644
index 000000000000..bc094f6eb366
--- /dev/null
+++ b/arch/sh/drivers/platform_early.c
@@ -0,0 +1,346 @@
+// SPDX--License-Identifier: GPL-2.0
+
+#include <asm/platform_early.h>
+#include <linux/pm.h>
+
+static __initdata LIST_HEAD(early_platform_driver_list);
+static __initdata LIST_HEAD(early_platform_device_list);
+
+static const struct platform_device_id *
+platform_match_id(const struct platform_device_id *id,
+		  struct platform_device *pdev)
+{
+	while (id->name[0]) {
+		if (strcmp(pdev->name, id->name) == 0) {
+			pdev->id_entry = id;
+			return id;
+		}
+		id++;
+	}
+	return NULL;
+}
+
+static int platform_match(struct device *dev, struct device_driver *drv)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_driver *pdrv = to_platform_driver(drv);
+
+	/* When driver_override is set, only bind to the matching driver */
+	if (pdev->driver_override)
+		return !strcmp(pdev->driver_override, drv->name);
+
+	/* Then try to match against the id table */
+	if (pdrv->id_table)
+		return platform_match_id(pdrv->id_table, pdev) != NULL;
+
+	/* fall-back to driver name match */
+	return (strcmp(pdev->name, drv->name) == 0);
+}
+
+#ifdef CONFIG_PM
+static void device_pm_init_common(struct device *dev)
+{
+	if (!dev->power.early_init) {
+		spin_lock_init(&dev->power.lock);
+		dev->power.qos = NULL;
+		dev->power.early_init = true;
+	}
+}
+
+static void pm_runtime_early_init(struct device *dev)
+{
+	dev->power.disable_depth = 1;
+	device_pm_init_common(dev);
+}
+#else
+static void pm_runtime_early_init(struct device *dev) {}
+#endif
+
+/**
+ * early_platform_driver_register - register early platform driver
+ * @epdrv: early_platform driver structure
+ * @buf: string passed from early_param()
+ *
+ * Helper function for early_platform_init() / early_platform_init_buffer()
+ */
+int __init early_platform_driver_register(struct early_platform_driver *epdrv,
+					  char *buf)
+{
+	char *tmp;
+	int n;
+
+	/* Simply add the driver to the end of the global list.
+	 * Drivers will by default be put on the list in compiled-in order.
+	 */
+	if (!epdrv->list.next) {
+		INIT_LIST_HEAD(&epdrv->list);
+		list_add_tail(&epdrv->list, &early_platform_driver_list);
+	}
+
+	/* If the user has specified device then make sure the driver
+	 * gets prioritized. The driver of the last device specified on
+	 * command line will be put first on the list.
+	 */
+	n = strlen(epdrv->pdrv->driver.name);
+	if (buf && !strncmp(buf, epdrv->pdrv->driver.name, n)) {
+		list_move(&epdrv->list, &early_platform_driver_list);
+
+		/* Allow passing parameters after device name */
+		if (buf[n] == '\0' || buf[n] == ',')
+			epdrv->requested_id = -1;
+		else {
+			epdrv->requested_id = simple_strtoul(&buf[n + 1],
+							     &tmp, 10);
+
+			if (buf[n] != '.' || (tmp == &buf[n + 1])) {
+				epdrv->requested_id = EARLY_PLATFORM_ID_ERROR;
+				n = 0;
+			} else
+				n += strcspn(&buf[n + 1], ",") + 1;
+		}
+
+		if (buf[n] == ',')
+			n++;
+
+		if (epdrv->bufsize) {
+			memcpy(epdrv->buffer, &buf[n],
+			       min_t(int, epdrv->bufsize, strlen(&buf[n]) + 1));
+			epdrv->buffer[epdrv->bufsize - 1] = '\0';
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * early_platform_add_devices - adds a number of early platform devices
+ * @devs: array of early platform devices to add
+ * @num: number of early platform devices in array
+ *
+ * Used by early architecture code to register early platform devices and
+ * their platform data.
+ */
+void __init early_platform_add_devices(struct platform_device **devs, int num)
+{
+	struct device *dev;
+	int i;
+
+	/* simply add the devices to list */
+	for (i = 0; i < num; i++) {
+		dev = &devs[i]->dev;
+
+		if (!dev->devres_head.next) {
+			pm_runtime_early_init(dev);
+			INIT_LIST_HEAD(&dev->devres_head);
+			list_add_tail(&dev->devres_head,
+				      &early_platform_device_list);
+		}
+	}
+}
+
+/**
+ * early_platform_driver_register_all - register early platform drivers
+ * @class_str: string to identify early platform driver class
+ *
+ * Used by architecture code to register all early platform drivers
+ * for a certain class. If omitted then only early platform drivers
+ * with matching kernel command line class parameters will be registered.
+ */
+void __init early_platform_driver_register_all(char *class_str)
+{
+	/* The "class_str" parameter may or may not be present on the kernel
+	 * command line. If it is present then there may be more than one
+	 * matching parameter.
+	 *
+	 * Since we register our early platform drivers using early_param()
+	 * we need to make sure that they also get registered in the case
+	 * when the parameter is missing from the kernel command line.
+	 *
+	 * We use parse_early_options() to make sure the early_param() gets
+	 * called at least once. The early_param() may be called more than
+	 * once since the name of the preferred device may be specified on
+	 * the kernel command line. early_platform_driver_register() handles
+	 * this case for us.
+	 */
+	parse_early_options(class_str);
+}
+
+/**
+ * early_platform_match - find early platform device matching driver
+ * @epdrv: early platform driver structure
+ * @id: id to match against
+ */
+static struct platform_device * __init
+early_platform_match(struct early_platform_driver *epdrv, int id)
+{
+	struct platform_device *pd;
+
+	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
+		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
+			if (pd->id == id)
+				return pd;
+
+	return NULL;
+}
+
+/**
+ * early_platform_left - check if early platform driver has matching devices
+ * @epdrv: early platform driver structure
+ * @id: return true if id or above exists
+ */
+static int __init early_platform_left(struct early_platform_driver *epdrv,
+				       int id)
+{
+	struct platform_device *pd;
+
+	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
+		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
+			if (pd->id >= id)
+				return 1;
+
+	return 0;
+}
+
+/**
+ * early_platform_driver_probe_id - probe drivers matching class_str and id
+ * @class_str: string to identify early platform driver class
+ * @id: id to match against
+ * @nr_probe: number of platform devices to successfully probe before exiting
+ */
+static int __init early_platform_driver_probe_id(char *class_str,
+						 int id,
+						 int nr_probe)
+{
+	struct early_platform_driver *epdrv;
+	struct platform_device *match;
+	int match_id;
+	int n = 0;
+	int left = 0;
+
+	list_for_each_entry(epdrv, &early_platform_driver_list, list) {
+		/* only use drivers matching our class_str */
+		if (strcmp(class_str, epdrv->class_str))
+			continue;
+
+		if (id == -2) {
+			match_id = epdrv->requested_id;
+			left = 1;
+
+		} else {
+			match_id = id;
+			left += early_platform_left(epdrv, id);
+
+			/* skip requested id */
+			switch (epdrv->requested_id) {
+			case EARLY_PLATFORM_ID_ERROR:
+			case EARLY_PLATFORM_ID_UNSET:
+				break;
+			default:
+				if (epdrv->requested_id == id)
+					match_id = EARLY_PLATFORM_ID_UNSET;
+			}
+		}
+
+		switch (match_id) {
+		case EARLY_PLATFORM_ID_ERROR:
+			pr_warn("%s: unable to parse %s parameter\n",
+				class_str, epdrv->pdrv->driver.name);
+			/* fall-through */
+		case EARLY_PLATFORM_ID_UNSET:
+			match = NULL;
+			break;
+		default:
+			match = early_platform_match(epdrv, match_id);
+		}
+
+		if (match) {
+			/*
+			 * Set up a sensible init_name to enable
+			 * dev_name() and others to be used before the
+			 * rest of the driver core is initialized.
+			 */
+			if (!match->dev.init_name && slab_is_available()) {
+				if (match->id != -1)
+					match->dev.init_name =
+						kasprintf(GFP_KERNEL, "%s.%d",
+							  match->name,
+							  match->id);
+				else
+					match->dev.init_name =
+						kasprintf(GFP_KERNEL, "%s",
+							  match->name);
+
+				if (!match->dev.init_name)
+					return -ENOMEM;
+			}
+
+			if (epdrv->pdrv->probe(match))
+				pr_warn("%s: unable to probe %s early.\n",
+					class_str, match->name);
+			else
+				n++;
+		}
+
+		if (n >= nr_probe)
+			break;
+	}
+
+	if (left)
+		return n;
+	else
+		return -ENODEV;
+}
+
+/**
+ * early_platform_driver_probe - probe a class of registered drivers
+ * @class_str: string to identify early platform driver class
+ * @nr_probe: number of platform devices to successfully probe before exiting
+ * @user_only: only probe user specified early platform devices
+ *
+ * Used by architecture code to probe registered early platform drivers
+ * within a certain class. For probe to happen a registered early platform
+ * device matching a registered early platform driver is needed.
+ */
+int __init early_platform_driver_probe(char *class_str,
+				       int nr_probe,
+				       int user_only)
+{
+	int k, n, i;
+
+	n = 0;
+	for (i = -2; n < nr_probe; i++) {
+		k = early_platform_driver_probe_id(class_str, i, nr_probe - n);
+
+		if (k < 0)
+			break;
+
+		n += k;
+
+		if (user_only)
+			break;
+	}
+
+	return n;
+}
+
+/**
+ * early_platform_cleanup - clean up early platform code
+ */
+static int __init early_platform_cleanup(void)
+{
+	struct platform_device *pd, *pd2;
+
+	/* clean up the devres list used to chain devices */
+	list_for_each_entry_safe(pd, pd2, &early_platform_device_list,
+				 dev.devres_head) {
+		list_del(&pd->dev.devres_head);
+		memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
+	}
+
+	return 0;
+}
+/*
+ * This must happen once after all early devices are probed but before probing
+ * real platform devices.
+ */
+subsys_initcall(early_platform_cleanup);
diff --git a/arch/sh/include/asm/platform_early.h b/arch/sh/include/asm/platform_early.h
new file mode 100644
index 000000000000..4590ab757d5f
--- /dev/null
+++ b/arch/sh/include/asm/platform_early.h
@@ -0,0 +1,61 @@
+/* SPDX--License-Identifier: GPL-2.0 */
+
+#ifndef __PLATFORM_EARLY__
+#define __PLATFORM_EARLY__
+
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+struct early_platform_driver {
+	const char *class_str;
+	struct platform_driver *pdrv;
+	struct list_head list;
+	int requested_id;
+	char *buffer;
+	int bufsize;
+};
+
+#define EARLY_PLATFORM_ID_UNSET -2
+#define EARLY_PLATFORM_ID_ERROR -3
+
+extern int early_platform_driver_register(struct early_platform_driver *epdrv,
+					  char *buf);
+extern void early_platform_add_devices(struct platform_device **devs, int num);
+
+static inline int is_early_platform_device(struct platform_device *pdev)
+{
+	return !pdev->dev.driver;
+}
+
+extern void early_platform_driver_register_all(char *class_str);
+extern int early_platform_driver_probe(char *class_str,
+				       int nr_probe, int user_only);
+
+#define early_platform_init(class_string, platdrv)		\
+	early_platform_init_buffer(class_string, platdrv, NULL, 0)
+
+#ifndef MODULE
+#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
+static __initdata struct early_platform_driver early_driver = {		\
+	.class_str = class_string,					\
+	.buffer = buf,							\
+	.bufsize = bufsiz,						\
+	.pdrv = platdrv,						\
+	.requested_id = EARLY_PLATFORM_ID_UNSET,			\
+};									\
+static int __init early_platform_driver_setup_func(char *buffer)	\
+{									\
+	return early_platform_driver_register(&early_driver, buffer);	\
+}									\
+early_param(class_string, early_platform_driver_setup_func)
+#else /* MODULE */
+#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
+static inline char *early_platform_driver_setup_func(void)		\
+{									\
+	return bufsiz ? buf : NULL;					\
+}
+#endif /* MODULE */
+
+#endif /* __PLATFORM_EARLY__ */
diff --git a/arch/sh/kernel/cpu/sh2/setup-sh7619.c b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
index d08db08dec38..a02fc03baef8 100644
--- a/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
@@ -15,6 +15,7 @@
 #include <linux/sh_eth.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh2a/setup-mxg.c b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
index 060fdd369f09..d33568a12fad 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-mxg.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
@@ -12,6 +12,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
index c1301f68d3cd..b258c5c3af60 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
@@ -14,6 +14,7 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
index 32ec732e28e5..db3f8df8d76d 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
@@ -13,6 +13,7 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
index 8d8d354851ce..e1be4fedc739 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
@@ -14,6 +14,7 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
index ab71eab690fd..b5bed10d0d72 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
@@ -14,6 +14,7 @@
 #include <linux/usb/r8a66597.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
index c7e81b20967c..248a6732397a 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
@@ -15,6 +15,7 @@
 #include <linux/usb/r8a66597.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh3.c b/arch/sh/kernel/cpu/sh3/setup-sh3.c
index 53be70b98116..65a83ea4bde4 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh3.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh3.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 /* All SH3 devices are equipped with IRQ0->5 (except sh7708) */
 
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7705.c b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
index f6e392e0d27e..7ec8c11c2f7a 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
@@ -17,6 +17,7 @@
 #include <linux/sh_intc.h>
 #include <asm/rtc.h>
 #include <cpu/serial.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index 59a88611df55..20839dd40a2f 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -21,6 +21,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <cpu/serial.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7710.c b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
index ea52410b430d..780ccd202bab 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
@@ -16,6 +16,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <asm/rtc.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7720.c b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
index bf34b4e2e9ef..723bd9c04c8a 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
@@ -22,6 +22,7 @@
 #include <linux/sh_intc.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <asm/rtc.h>
+#include <asm/platform_early.h>
 #include <cpu/serial.h>
 
 static struct resource rtc_resources[] = {
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
index 2623f820d510..4a5fa86006cd 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
@@ -15,6 +15,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_REIE,
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index 57d30689204d..abb3703c2273 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -16,6 +16,7 @@
 #include <linux/sh_intc.h>
 #include <linux/serial_sci.h>
 #include <generated/machtypes.h>
+#include <asm/platform_early.h>
 
 static struct resource rtc_resources[] = {
 	[0] = {
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
index e51fe1734e13..649f4dcb5935 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
@@ -14,6 +14,7 @@
 #include <linux/sh_intc.h>
 #include <linux/serial_sci.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
index 5788073a7c30..73715a635048 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
@@ -15,6 +15,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <asm/clock.h>
+#include <asm/platform_early.h>
 
 /* Serial */
 static struct plat_sci_port scif0_platform_data = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
index 646918713d9a..942856048112 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
@@ -18,6 +18,7 @@
 #include <linux/sh_intc.h>
 #include <linux/usb/r8a66597.h>
 #include <asm/clock.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_REIE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 6b3a26e61abb..bf60456a8012 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -21,6 +21,7 @@
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 #include <asm/siu.h>
+#include <asm/platform_early.h>
 
 #include <cpu/dma-register.h>
 #include <cpu/sh7722.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index 1c1b3c469831..d25d3c3b44ab 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
+#include <asm/platform_early.h>
 #include <cpu/sh7723.h>
 
 /* Serial */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index c20258b18775..0eeadabc8065 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -27,6 +27,7 @@
 #include <asm/suspend.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
+#include <asm/platform_early.h>
 
 #include <cpu/dma-register.h>
 #include <cpu/sh7724.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
index 8c0c9da6b5b3..bed9d01fa85f 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <asm/clock.h>
 #include <asm/irq.h>
+#include <asm/platform_early.h>
 #include <cpu/sh7734.h>
 
 /* SCIF */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index a46a19b49e08..b5b19e81a8dc 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -22,6 +22,7 @@
 #include <linux/usb/ohci_pdriver.h>
 #include <cpu/dma-register.h>
 #include <cpu/sh7757.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_REIE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
index 40e6cda914d3..51a6c64f860e 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/serial_sci.h>
 #include <linux/usb/ohci_pdriver.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_REIE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
index 82e3bdf2e1b6..77f228e20599 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
@@ -14,6 +14,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_REIE | SCSCR_TOIE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index d90ff67a4633..c4cbb7584122 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -16,6 +16,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <cpu/dma-register.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index b0d6f82f2d71..eda0d61ebf71 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -17,6 +17,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <asm/mmzone.h>
+#include <asm/platform_early.h>
 #include <cpu/dma-register.h>
 
 static struct plat_sci_port scif0_platform_data = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 17aac38a6e90..77226a60c36f 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -26,6 +26,7 @@
 #include <linux/usb/ohci_pdriver.h>
 #include <cpu/dma-register.h>
 #include <asm/mmzone.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-shx3.c b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
index ee14d92d840f..83feaf0a4aae 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
@@ -17,6 +17,7 @@
 #include <linux/sh_intc.h>
 #include <cpu/shx3.h>
 #include <asm/mmzone.h>
+#include <asm/platform_early.h>
 
 /*
  * This intentionally only registers SCIF ports 0, 1, and 3. SCIF 2
diff --git a/arch/sh/kernel/cpu/sh5/setup-sh5.c b/arch/sh/kernel/cpu/sh5/setup-sh5.c
index 084a9cc99175..8ebd26a9fd90 100644
--- a/arch/sh/kernel/cpu/sh5/setup-sh5.c
+++ b/arch/sh/kernel/cpu/sh5/setup-sh5.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/sh_timer.h>
 #include <asm/addrspace.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_IOREMAP,
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index c286cf5da6e7..aed8f331f66b 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -43,6 +43,7 @@
 #include <asm/mmu_context.h>
 #include <asm/mmzone.h>
 #include <asm/sparsemem.h>
+#include <asm/platform_early.h>
 
 /*
  * Initialize loops_per_jiffy as 10000000 (1000MIPS).
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index fcd5e41977d1..674d8413491b 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -21,6 +21,7 @@
 #include <linux/rtc.h>
 #include <asm/clock.h>
 #include <asm/rtc.h>
+#include <asm/platform_early.h>
 
 /* Dummy RTC ops */
 static void null_rtc_get_time(struct timespec *tv)
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index dff82a3c2caa..56bdaacb8666 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1165,8 +1165,6 @@ int __init platform_bus_init(void)
 {
 	int error;
 
-	early_platform_cleanup();
-
 	error = device_register(&platform_bus);
 	if (error) {
 		put_device(&platform_bus);
@@ -1200,289 +1198,3 @@ u64 dma_get_required_mask(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
 #endif
-
-static __initdata LIST_HEAD(early_platform_driver_list);
-static __initdata LIST_HEAD(early_platform_device_list);
-
-/**
- * early_platform_driver_register - register early platform driver
- * @epdrv: early_platform driver structure
- * @buf: string passed from early_param()
- *
- * Helper function for early_platform_init() / early_platform_init_buffer()
- */
-int __init early_platform_driver_register(struct early_platform_driver *epdrv,
-					  char *buf)
-{
-	char *tmp;
-	int n;
-
-	/* Simply add the driver to the end of the global list.
-	 * Drivers will by default be put on the list in compiled-in order.
-	 */
-	if (!epdrv->list.next) {
-		INIT_LIST_HEAD(&epdrv->list);
-		list_add_tail(&epdrv->list, &early_platform_driver_list);
-	}
-
-	/* If the user has specified device then make sure the driver
-	 * gets prioritized. The driver of the last device specified on
-	 * command line will be put first on the list.
-	 */
-	n = strlen(epdrv->pdrv->driver.name);
-	if (buf && !strncmp(buf, epdrv->pdrv->driver.name, n)) {
-		list_move(&epdrv->list, &early_platform_driver_list);
-
-		/* Allow passing parameters after device name */
-		if (buf[n] == '\0' || buf[n] == ',')
-			epdrv->requested_id = -1;
-		else {
-			epdrv->requested_id = simple_strtoul(&buf[n + 1],
-							     &tmp, 10);
-
-			if (buf[n] != '.' || (tmp == &buf[n + 1])) {
-				epdrv->requested_id = EARLY_PLATFORM_ID_ERROR;
-				n = 0;
-			} else
-				n += strcspn(&buf[n + 1], ",") + 1;
-		}
-
-		if (buf[n] == ',')
-			n++;
-
-		if (epdrv->bufsize) {
-			memcpy(epdrv->buffer, &buf[n],
-			       min_t(int, epdrv->bufsize, strlen(&buf[n]) + 1));
-			epdrv->buffer[epdrv->bufsize - 1] = '\0';
-		}
-	}
-
-	return 0;
-}
-
-/**
- * early_platform_add_devices - adds a number of early platform devices
- * @devs: array of early platform devices to add
- * @num: number of early platform devices in array
- *
- * Used by early architecture code to register early platform devices and
- * their platform data.
- */
-void __init early_platform_add_devices(struct platform_device **devs, int num)
-{
-	struct device *dev;
-	int i;
-
-	/* simply add the devices to list */
-	for (i = 0; i < num; i++) {
-		dev = &devs[i]->dev;
-
-		if (!dev->devres_head.next) {
-			pm_runtime_early_init(dev);
-			INIT_LIST_HEAD(&dev->devres_head);
-			list_add_tail(&dev->devres_head,
-				      &early_platform_device_list);
-		}
-	}
-}
-
-/**
- * early_platform_driver_register_all - register early platform drivers
- * @class_str: string to identify early platform driver class
- *
- * Used by architecture code to register all early platform drivers
- * for a certain class. If omitted then only early platform drivers
- * with matching kernel command line class parameters will be registered.
- */
-void __init early_platform_driver_register_all(char *class_str)
-{
-	/* The "class_str" parameter may or may not be present on the kernel
-	 * command line. If it is present then there may be more than one
-	 * matching parameter.
-	 *
-	 * Since we register our early platform drivers using early_param()
-	 * we need to make sure that they also get registered in the case
-	 * when the parameter is missing from the kernel command line.
-	 *
-	 * We use parse_early_options() to make sure the early_param() gets
-	 * called at least once. The early_param() may be called more than
-	 * once since the name of the preferred device may be specified on
-	 * the kernel command line. early_platform_driver_register() handles
-	 * this case for us.
-	 */
-	parse_early_options(class_str);
-}
-
-/**
- * early_platform_match - find early platform device matching driver
- * @epdrv: early platform driver structure
- * @id: id to match against
- */
-static struct platform_device * __init
-early_platform_match(struct early_platform_driver *epdrv, int id)
-{
-	struct platform_device *pd;
-
-	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
-		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
-			if (pd->id == id)
-				return pd;
-
-	return NULL;
-}
-
-/**
- * early_platform_left - check if early platform driver has matching devices
- * @epdrv: early platform driver structure
- * @id: return true if id or above exists
- */
-static int __init early_platform_left(struct early_platform_driver *epdrv,
-				       int id)
-{
-	struct platform_device *pd;
-
-	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
-		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
-			if (pd->id >= id)
-				return 1;
-
-	return 0;
-}
-
-/**
- * early_platform_driver_probe_id - probe drivers matching class_str and id
- * @class_str: string to identify early platform driver class
- * @id: id to match against
- * @nr_probe: number of platform devices to successfully probe before exiting
- */
-static int __init early_platform_driver_probe_id(char *class_str,
-						 int id,
-						 int nr_probe)
-{
-	struct early_platform_driver *epdrv;
-	struct platform_device *match;
-	int match_id;
-	int n = 0;
-	int left = 0;
-
-	list_for_each_entry(epdrv, &early_platform_driver_list, list) {
-		/* only use drivers matching our class_str */
-		if (strcmp(class_str, epdrv->class_str))
-			continue;
-
-		if (id == -2) {
-			match_id = epdrv->requested_id;
-			left = 1;
-
-		} else {
-			match_id = id;
-			left += early_platform_left(epdrv, id);
-
-			/* skip requested id */
-			switch (epdrv->requested_id) {
-			case EARLY_PLATFORM_ID_ERROR:
-			case EARLY_PLATFORM_ID_UNSET:
-				break;
-			default:
-				if (epdrv->requested_id == id)
-					match_id = EARLY_PLATFORM_ID_UNSET;
-			}
-		}
-
-		switch (match_id) {
-		case EARLY_PLATFORM_ID_ERROR:
-			pr_warn("%s: unable to parse %s parameter\n",
-				class_str, epdrv->pdrv->driver.name);
-			/* fall-through */
-		case EARLY_PLATFORM_ID_UNSET:
-			match = NULL;
-			break;
-		default:
-			match = early_platform_match(epdrv, match_id);
-		}
-
-		if (match) {
-			/*
-			 * Set up a sensible init_name to enable
-			 * dev_name() and others to be used before the
-			 * rest of the driver core is initialized.
-			 */
-			if (!match->dev.init_name && slab_is_available()) {
-				if (match->id != -1)
-					match->dev.init_name =
-						kasprintf(GFP_KERNEL, "%s.%d",
-							  match->name,
-							  match->id);
-				else
-					match->dev.init_name =
-						kasprintf(GFP_KERNEL, "%s",
-							  match->name);
-
-				if (!match->dev.init_name)
-					return -ENOMEM;
-			}
-
-			if (epdrv->pdrv->probe(match))
-				pr_warn("%s: unable to probe %s early.\n",
-					class_str, match->name);
-			else
-				n++;
-		}
-
-		if (n >= nr_probe)
-			break;
-	}
-
-	if (left)
-		return n;
-	else
-		return -ENODEV;
-}
-
-/**
- * early_platform_driver_probe - probe a class of registered drivers
- * @class_str: string to identify early platform driver class
- * @nr_probe: number of platform devices to successfully probe before exiting
- * @user_only: only probe user specified early platform devices
- *
- * Used by architecture code to probe registered early platform drivers
- * within a certain class. For probe to happen a registered early platform
- * device matching a registered early platform driver is needed.
- */
-int __init early_platform_driver_probe(char *class_str,
-				       int nr_probe,
-				       int user_only)
-{
-	int k, n, i;
-
-	n = 0;
-	for (i = -2; n < nr_probe; i++) {
-		k = early_platform_driver_probe_id(class_str, i, nr_probe - n);
-
-		if (k < 0)
-			break;
-
-		n += k;
-
-		if (user_only)
-			break;
-	}
-
-	return n;
-}
-
-/**
- * early_platform_cleanup - clean up early platform code
- */
-void __init early_platform_cleanup(void)
-{
-	struct platform_device *pd, *pd2;
-
-	/* clean up the devres list used to chain devices */
-	list_for_each_entry_safe(pd, pd2, &early_platform_device_list,
-				 dev.devres_head) {
-		list_del(&pd->dev.devres_head);
-		memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
-	}
-}
-
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index bbbf37c471a3..fe9abe5b3e68 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -33,6 +33,10 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#ifdef CONFIG_SUPERH
+#include <asm/platform_early.h>
+#endif
+
 struct sh_cmt_device;
 
 /*
@@ -1100,7 +1104,10 @@ static void __exit sh_cmt_exit(void)
 	platform_driver_unregister(&sh_cmt_device_driver);
 }
 
+#ifdef CONFIG_SUPERH
 early_platform_init("earlytimer", &sh_cmt_device_driver);
+#endif
+
 subsys_initcall(sh_cmt_init);
 module_exit(sh_cmt_exit);
 
diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 6812e099b6a3..becff3a1a6fb 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -31,6 +31,10 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#ifdef CONFIG_SUPERH
+#include <asm/platform_early.h>
+#endif
+
 struct sh_mtu2_device;
 
 struct sh_mtu2_channel {
@@ -519,7 +523,10 @@ static void __exit sh_mtu2_exit(void)
 	platform_driver_unregister(&sh_mtu2_device_driver);
 }
 
+#ifdef CONFIG_SUPERH
 early_platform_init("earlytimer", &sh_mtu2_device_driver);
+#endif
+
 subsys_initcall(sh_mtu2_init);
 module_exit(sh_mtu2_exit);
 
diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index c74a6c543ca2..3f4783a9ecf0 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -32,6 +32,10 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#ifdef CONFIG_SUPERH
+#include <asm/platform_early.h>
+#endif
+
 enum sh_tmu_model {
 	SH_TMU,
 	SH_TMU_SH3,
@@ -626,6 +630,7 @@ static int sh_tmu_probe(struct platform_device *pdev)
 		pm_runtime_idle(&pdev->dev);
 		return ret;
 	}
+
 	if (is_early_platform_device(pdev))
 		return 0;
 
@@ -676,7 +681,10 @@ static void __exit sh_tmu_exit(void)
 	platform_driver_unregister(&sh_tmu_device_driver);
 }
 
+#ifdef CONFIG_SUPERH
 early_platform_init("earlytimer", &sh_tmu_device_driver);
+#endif
+
 subsys_initcall(sh_tmu_init);
 module_exit(sh_tmu_exit);
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index c181eb37f985..a6c3aa7a7de8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -54,6 +54,7 @@
 
 #ifdef CONFIG_SUPERH
 #include <asm/sh_bios.h>
+#include <asm/platform_early.h>
 #endif
 
 #include "serial_mctrl_gpio.h"
@@ -2986,6 +2987,7 @@ static struct console serial_console = {
 	.data		= &sci_uart_driver,
 };
 
+#ifdef CONFIG_SUPERH
 static struct console early_serial_console = {
 	.name           = "early_ttySC",
 	.write          = serial_console_write,
@@ -3014,6 +3016,7 @@ static int sci_probe_earlyprintk(struct platform_device *pdev)
 	register_console(&early_serial_console);
 	return 0;
 }
+#endif
 
 #define SCI_CONSOLE	(&serial_console)
 
@@ -3216,8 +3219,10 @@ static int sci_probe(struct platform_device *dev)
 	 * the special early probe. We don't have sufficient device state
 	 * to make it beyond this yet.
 	 */
+#ifdef CONFIG_SUPERH
 	if (is_early_platform_device(dev))
 		return sci_probe_earlyprintk(dev);
+#endif
 
 	if (dev->dev.of_node) {
 		p = sci_parse_dt(dev, &dev_id);
@@ -3314,7 +3319,7 @@ static void __exit sci_exit(void)
 		uart_unregister_driver(&sci_uart_driver);
 }
 
-#ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
+#if defined(CONFIG_SUPERH) && defined(CONFIG_SERIAL_SH_SCI_CONSOLE)
 early_platform_init_buffer("earlyprintk", &sci_driver,
 			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
 #endif
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 3097c943fab9..7d7610da8377 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -284,58 +284,6 @@ void platform_unregister_drivers(struct platform_driver * const *drivers,
 #define platform_register_drivers(drivers, count) \
 	__platform_register_drivers(drivers, count, THIS_MODULE)
 
-/* early platform driver interface */
-struct early_platform_driver {
-	const char *class_str;
-	struct platform_driver *pdrv;
-	struct list_head list;
-	int requested_id;
-	char *buffer;
-	int bufsize;
-};
-
-#define EARLY_PLATFORM_ID_UNSET -2
-#define EARLY_PLATFORM_ID_ERROR -3
-
-extern int early_platform_driver_register(struct early_platform_driver *epdrv,
-					  char *buf);
-extern void early_platform_add_devices(struct platform_device **devs, int num);
-
-static inline int is_early_platform_device(struct platform_device *pdev)
-{
-	return !pdev->dev.driver;
-}
-
-extern void early_platform_driver_register_all(char *class_str);
-extern int early_platform_driver_probe(char *class_str,
-				       int nr_probe, int user_only);
-extern void early_platform_cleanup(void);
-
-#define early_platform_init(class_string, platdrv)		\
-	early_platform_init_buffer(class_string, platdrv, NULL, 0)
-
-#ifndef MODULE
-#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
-static __initdata struct early_platform_driver early_driver = {		\
-	.class_str = class_string,					\
-	.buffer = buf,							\
-	.bufsize = bufsiz,						\
-	.pdrv = platdrv,						\
-	.requested_id = EARLY_PLATFORM_ID_UNSET,			\
-};									\
-static int __init early_platform_driver_setup_func(char *buffer)	\
-{									\
-	return early_platform_driver_register(&early_driver, buffer);	\
-}									\
-early_param(class_string, early_platform_driver_setup_func)
-#else /* MODULE */
-#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
-static inline char *early_platform_driver_setup_func(void)		\
-{									\
-	return bufsiz ? buf : NULL;					\
-}
-#endif /* MODULE */
-
 #ifdef CONFIG_SUSPEND
 extern int platform_pm_suspend(struct device *dev);
 extern int platform_pm_resume(struct device *dev);
@@ -370,4 +318,16 @@ extern int platform_dma_configure(struct device *dev);
 #define USE_PLATFORM_PM_SLEEP_OPS
 #endif
 
+#ifndef CONFIG_SUPERH
+/*
+ * REVISIT: This stub is needed for all non-SuperH users of early platform
+ * drivers. It should go away once we introduce the new platform_device-based
+ * early driver framework.
+ */
+static inline int is_early_platform_device(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif /* CONFIG_SUPERH */
+
 #endif /* _PLATFORM_DEVICE_H_ */
-- 
2.17.1
