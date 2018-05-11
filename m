From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 04/12] platform: provide a separate function for initializing platform devices
Date: Fri, 11 May 2018 18:20:20 +0200
Message-ID: <20180511162028.20616-5-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-arch.vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The early platform driver framework will allocate platform devices
using its own internal mechanisms. Provide a function that allows to
initialize a platform device object without allocating it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/platform.c         | 24 ++++++++++++++++++++----
 include/linux/platform_device.h |  2 ++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 0c53e3e3e5aa..0ba4effb9618 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -252,6 +252,25 @@ static void platform_device_release(struct device *dev)
 	kfree(pa);
 }
 
+/**
+ * platform_device_init - initialize a platform device
+ * @pdev: platform device to initialize
+ * @name: base name of the device we're adding, NOTE: it's not copied
+ * @id: instance id
+ *
+ * Initiate an already allocated platform device. This routine does not set
+ * the release device callback.
+ */
+void platform_device_init(struct platform_device *pdev,
+			  const char *name, int id)
+{
+	pdev->name = name;
+	pdev->id = id;
+	device_initialize(&pdev->dev);
+	arch_setup_pdev_archdata(pdev);
+}
+EXPORT_SYMBOL_GPL(platform_device_init);
+
 /**
  * platform_device_alloc - create a platform device
  * @name: base name of the device we're adding
@@ -267,11 +286,8 @@ struct platform_device *platform_device_alloc(const char *name, int id)
 	pa = kzalloc(sizeof(*pa) + strlen(name) + 1, GFP_KERNEL);
 	if (pa) {
 		strcpy(pa->name, name);
-		pa->pdev.name = pa->name;
-		pa->pdev.id = id;
-		device_initialize(&pa->pdev.dev);
+		platform_device_init(&pa->pdev, pa->name, id);
 		pa->pdev.dev.release = platform_device_release;
-		arch_setup_pdev_archdata(&pa->pdev);
 	}
 
 	return pa ? &pa->pdev : NULL;
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 099aaf804b50..46bfd5ff666f 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -165,6 +165,8 @@ static inline struct platform_device *platform_device_register_data(
 			NULL, 0, data, size);
 }
 
+extern void platform_device_init(struct platform_device *pdev,
+				 const char *name, int id);
 extern struct platform_device *platform_device_alloc(const char *name, int id);
 extern int platform_device_add_resources(struct platform_device *pdev,
 					 const struct resource *res,
-- 
2.17.0
