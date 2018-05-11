From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 08/12] of/platform: provide a separate routine for device initialization
Date: Fri, 11 May 2018 18:20:24 +0200
Message-ID: <20180511162028.20616-9-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-arch.vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The early platform device framework will need to initialize the
platform device objects without them being allocated in
of_device_alloc(). Provide a routine that allows it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/of/platform.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 24791e558ec5..0e554fe1f325 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -132,6 +132,19 @@ int of_device_init_resources(struct platform_device *pdev,
 	return 0;
 }
 
+static void of_device_init(struct platform_device *pdev, struct device_node *np,
+			   const char *bus_id, struct device *parent)
+{
+	pdev->dev.of_node = of_node_get(np);
+	pdev->dev.fwnode = &np->fwnode;
+	pdev->dev.parent = parent ? : &platform_bus;
+
+	if (bus_id)
+		dev_set_name(&pdev->dev, "%s", bus_id);
+	else
+		of_device_make_bus_id(&pdev->dev);
+}
+
 /**
  * of_device_alloc - Allocate and initialize an of_device
  * @np: device node to assign to device
@@ -155,14 +168,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 		return NULL;
 	}
 
-	dev->dev.of_node = of_node_get(np);
-	dev->dev.fwnode = &np->fwnode;
-	dev->dev.parent = parent ? : &platform_bus;
-
-	if (bus_id)
-		dev_set_name(&dev->dev, "%s", bus_id);
-	else
-		of_device_make_bus_id(&dev->dev);
+	of_device_init(dev, np, bus_id, parent);
 
 	return dev;
 }
-- 
2.17.0
