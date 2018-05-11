From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 12/12] of/platform: make the OF code aware of early platform drivers
Date: Fri, 11 May 2018 18:20:28 +0200
Message-ID: <20180511162028.20616-13-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-arch.vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Check the relevant flag in the device node and skip the allocation
part for devices that were populated early.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/of/platform.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 0e554fe1f325..91760e2d3dc7 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -21,6 +21,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/early_platform.h>
 
 const struct of_device_id of_default_bus_match_table[] = {
 	{ .compatible = "simple-bus", },
@@ -196,9 +197,17 @@ static struct platform_device *of_platform_device_create_pdata(
 	    of_node_test_and_set_flag(np, OF_POPULATED))
 		return NULL;
 
-	dev = of_device_alloc(np, bus_id, parent);
-	if (!dev)
-		goto err_clear_flag;
+	if (of_node_check_flag(np, OF_POPULATED_EARLY)) {
+		dev = of_early_to_platform_device(np);
+		if (IS_ERR(dev))
+			goto err_clear_flag;
+
+		of_device_init(dev, np, bus_id, parent);
+	} else {
+		dev = of_device_alloc(np, bus_id, parent);
+		if (!dev)
+			goto err_clear_flag;
+	}
 
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
-- 
2.17.0
