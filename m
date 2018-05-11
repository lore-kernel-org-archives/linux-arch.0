From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 07/12] of/platform: provide a separate routine for setting up device resources
Date: Fri, 11 May 2018 18:20:23 +0200
Message-ID: <20180511162028.20616-8-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-arch.vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The early platform driver framework will need to setup the device
resources before the regular populating of the device tree happens.

Provide a separate function for that.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/of/platform.c       | 54 +++++++++++++++++++++++--------------
 include/linux/of_platform.h |  2 ++
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c00d81dfac0b..24791e558ec5 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -99,24 +99,12 @@ static void of_device_make_bus_id(struct device *dev)
 	}
 }
 
-/**
- * of_device_alloc - Allocate and initialize an of_device
- * @np: device node to assign to device
- * @bus_id: Name to assign to the device.  May be null to use default name.
- * @parent: Parent device.
- */
-struct platform_device *of_device_alloc(struct device_node *np,
-				  const char *bus_id,
-				  struct device *parent)
+int of_device_init_resources(struct platform_device *pdev,
+			     struct device_node *np)
 {
-	struct platform_device *dev;
 	int rc, i, num_reg = 0, num_irq;
 	struct resource *res, temp_res;
 
-	dev = platform_device_alloc("", PLATFORM_DEVID_NONE);
-	if (!dev)
-		return NULL;
-
 	/* count the io and irq resources */
 	while (of_address_to_resource(np, num_reg, &temp_res) == 0)
 		num_reg++;
@@ -125,22 +113,48 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	/* Populate the resource table */
 	if (num_irq || num_reg) {
 		res = kzalloc(sizeof(*res) * (num_irq + num_reg), GFP_KERNEL);
-		if (!res) {
-			platform_device_put(dev);
-			return NULL;
-		}
+		if (!res)
+			return -ENOMEM;
+
+		pdev->num_resources = num_reg + num_irq;
+		pdev->resource = res;
 
-		dev->num_resources = num_reg + num_irq;
-		dev->resource = res;
 		for (i = 0; i < num_reg; i++, res++) {
 			rc = of_address_to_resource(np, i, res);
 			WARN_ON(rc);
 		}
+
 		if (of_irq_to_resource_table(np, res, num_irq) != num_irq)
 			pr_debug("not all legacy IRQ resources mapped for %s\n",
 				 np->name);
 	}
 
+	return 0;
+}
+
+/**
+ * of_device_alloc - Allocate and initialize an of_device
+ * @np: device node to assign to device
+ * @bus_id: Name to assign to the device.  May be null to use default name.
+ * @parent: Parent device.
+ */
+struct platform_device *of_device_alloc(struct device_node *np,
+				  const char *bus_id,
+				  struct device *parent)
+{
+	struct platform_device *dev;
+	int rc;
+
+	dev = platform_device_alloc("", PLATFORM_DEVID_NONE);
+	if (!dev)
+		return NULL;
+
+	rc = of_device_init_resources(dev, np);
+	if (rc) {
+		platform_device_put(dev);
+		return NULL;
+	}
+
 	dev->dev.of_node = of_node_get(np);
 	dev->dev.fwnode = &np->fwnode;
 	dev->dev.parent = parent ? : &platform_bus;
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 84a966623e78..387ab4d4a210 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -52,6 +52,8 @@ extern const struct of_device_id of_default_bus_match_table[];
 extern struct platform_device *of_device_alloc(struct device_node *np,
 					 const char *bus_id,
 					 struct device *parent);
+extern int of_device_init_resources(struct platform_device *pdev,
+				    struct device_node *np);
 #ifdef CONFIG_OF
 extern struct platform_device *of_find_device_by_node(struct device_node *np);
 #else
-- 
2.17.0
