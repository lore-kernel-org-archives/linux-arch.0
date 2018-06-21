From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH v3 3/3] sh: add the sh_ prefix to early platform symbols
Date: Thu, 21 Jun 2018 10:23:21 +0200
Message-ID: <20180621082321.4259-4-brgl@bgdev.pl>
References: <20180621082321.4259-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621082321.4259-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-arch.vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Old early platform device support is now sh-specific. Before moving on
to implementing new early platform framework based on real platform
devices, prefix all early platform symbols with 'sh_'.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/sh/drivers/platform_early.c       | 66 +++++++++++++-------------
 arch/sh/include/asm/platform_early.h   | 30 ++++++------
 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |  2 +-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |  2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |  2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |  2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |  2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c |  2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c |  2 +-
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |  2 +-
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  |  2 +-
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  |  2 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  |  2 +-
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |  2 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |  8 ++--
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |  2 +-
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |  2 +-
 arch/sh/kernel/cpu/sh5/setup-sh5.c     |  2 +-
 arch/sh/kernel/setup.c                 |  2 +-
 arch/sh/kernel/time.c                  |  4 +-
 drivers/clocksource/sh_cmt.c           |  6 +--
 drivers/clocksource/sh_mtu2.c          |  6 +--
 drivers/clocksource/sh_tmu.c           |  6 +--
 drivers/tty/serial/sh-sci.c            |  4 +-
 include/linux/platform_device.h        |  2 +-
 37 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
index bc094f6eb366..6eba755b8c12 100644
--- a/arch/sh/drivers/platform_early.c
+++ b/arch/sh/drivers/platform_early.c
@@ -3,8 +3,8 @@
 #include <asm/platform_early.h>
 #include <linux/pm.h>
 
-static __initdata LIST_HEAD(early_platform_driver_list);
-static __initdata LIST_HEAD(early_platform_device_list);
+static __initdata LIST_HEAD(sh_early_platform_driver_list);
+static __initdata LIST_HEAD(sh_early_platform_device_list);
 
 static const struct platform_device_id *
 platform_match_id(const struct platform_device_id *id,
@@ -57,13 +57,13 @@ static void pm_runtime_early_init(struct device *dev) {}
 #endif
 
 /**
- * early_platform_driver_register - register early platform driver
- * @epdrv: early_platform driver structure
+ * sh_early_platform_driver_register - register early platform driver
+ * @epdrv: sh_early_platform driver structure
  * @buf: string passed from early_param()
  *
- * Helper function for early_platform_init() / early_platform_init_buffer()
+ * Helper function for sh_early_platform_init() / sh_early_platform_init_buffer()
  */
-int __init early_platform_driver_register(struct early_platform_driver *epdrv,
+int __init sh_early_platform_driver_register(struct sh_early_platform_driver *epdrv,
 					  char *buf)
 {
 	char *tmp;
@@ -74,7 +74,7 @@ int __init early_platform_driver_register(struct early_platform_driver *epdrv,
 	 */
 	if (!epdrv->list.next) {
 		INIT_LIST_HEAD(&epdrv->list);
-		list_add_tail(&epdrv->list, &early_platform_driver_list);
+		list_add_tail(&epdrv->list, &sh_early_platform_driver_list);
 	}
 
 	/* If the user has specified device then make sure the driver
@@ -83,7 +83,7 @@ int __init early_platform_driver_register(struct early_platform_driver *epdrv,
 	 */
 	n = strlen(epdrv->pdrv->driver.name);
 	if (buf && !strncmp(buf, epdrv->pdrv->driver.name, n)) {
-		list_move(&epdrv->list, &early_platform_driver_list);
+		list_move(&epdrv->list, &sh_early_platform_driver_list);
 
 		/* Allow passing parameters after device name */
 		if (buf[n] == '\0' || buf[n] == ',')
@@ -113,14 +113,14 @@ int __init early_platform_driver_register(struct early_platform_driver *epdrv,
 }
 
 /**
- * early_platform_add_devices - adds a number of early platform devices
+ * sh_early_platform_add_devices - adds a number of early platform devices
  * @devs: array of early platform devices to add
  * @num: number of early platform devices in array
  *
  * Used by early architecture code to register early platform devices and
  * their platform data.
  */
-void __init early_platform_add_devices(struct platform_device **devs, int num)
+void __init sh_early_platform_add_devices(struct platform_device **devs, int num)
 {
 	struct device *dev;
 	int i;
@@ -133,20 +133,20 @@ void __init early_platform_add_devices(struct platform_device **devs, int num)
 			pm_runtime_early_init(dev);
 			INIT_LIST_HEAD(&dev->devres_head);
 			list_add_tail(&dev->devres_head,
-				      &early_platform_device_list);
+				      &sh_early_platform_device_list);
 		}
 	}
 }
 
 /**
- * early_platform_driver_register_all - register early platform drivers
+ * sh_early_platform_driver_register_all - register early platform drivers
  * @class_str: string to identify early platform driver class
  *
  * Used by architecture code to register all early platform drivers
  * for a certain class. If omitted then only early platform drivers
  * with matching kernel command line class parameters will be registered.
  */
-void __init early_platform_driver_register_all(char *class_str)
+void __init sh_early_platform_driver_register_all(char *class_str)
 {
 	/* The "class_str" parameter may or may not be present on the kernel
 	 * command line. If it is present then there may be more than one
@@ -159,23 +159,23 @@ void __init early_platform_driver_register_all(char *class_str)
 	 * We use parse_early_options() to make sure the early_param() gets
 	 * called at least once. The early_param() may be called more than
 	 * once since the name of the preferred device may be specified on
-	 * the kernel command line. early_platform_driver_register() handles
+	 * the kernel command line. sh_early_platform_driver_register() handles
 	 * this case for us.
 	 */
 	parse_early_options(class_str);
 }
 
 /**
- * early_platform_match - find early platform device matching driver
+ * sh_early_platform_match - find early platform device matching driver
  * @epdrv: early platform driver structure
  * @id: id to match against
  */
 static struct platform_device * __init
-early_platform_match(struct early_platform_driver *epdrv, int id)
+sh_early_platform_match(struct sh_early_platform_driver *epdrv, int id)
 {
 	struct platform_device *pd;
 
-	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
+	list_for_each_entry(pd, &sh_early_platform_device_list, dev.devres_head)
 		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
 			if (pd->id == id)
 				return pd;
@@ -184,16 +184,16 @@ early_platform_match(struct early_platform_driver *epdrv, int id)
 }
 
 /**
- * early_platform_left - check if early platform driver has matching devices
+ * sh_early_platform_left - check if early platform driver has matching devices
  * @epdrv: early platform driver structure
  * @id: return true if id or above exists
  */
-static int __init early_platform_left(struct early_platform_driver *epdrv,
+static int __init sh_early_platform_left(struct sh_early_platform_driver *epdrv,
 				       int id)
 {
 	struct platform_device *pd;
 
-	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
+	list_for_each_entry(pd, &sh_early_platform_device_list, dev.devres_head)
 		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
 			if (pd->id >= id)
 				return 1;
@@ -202,22 +202,22 @@ static int __init early_platform_left(struct early_platform_driver *epdrv,
 }
 
 /**
- * early_platform_driver_probe_id - probe drivers matching class_str and id
+ * sh_early_platform_driver_probe_id - probe drivers matching class_str and id
  * @class_str: string to identify early platform driver class
  * @id: id to match against
  * @nr_probe: number of platform devices to successfully probe before exiting
  */
-static int __init early_platform_driver_probe_id(char *class_str,
+static int __init sh_early_platform_driver_probe_id(char *class_str,
 						 int id,
 						 int nr_probe)
 {
-	struct early_platform_driver *epdrv;
+	struct sh_early_platform_driver *epdrv;
 	struct platform_device *match;
 	int match_id;
 	int n = 0;
 	int left = 0;
 
-	list_for_each_entry(epdrv, &early_platform_driver_list, list) {
+	list_for_each_entry(epdrv, &sh_early_platform_driver_list, list) {
 		/* only use drivers matching our class_str */
 		if (strcmp(class_str, epdrv->class_str))
 			continue;
@@ -228,7 +228,7 @@ static int __init early_platform_driver_probe_id(char *class_str,
 
 		} else {
 			match_id = id;
-			left += early_platform_left(epdrv, id);
+			left += sh_early_platform_left(epdrv, id);
 
 			/* skip requested id */
 			switch (epdrv->requested_id) {
@@ -250,7 +250,7 @@ static int __init early_platform_driver_probe_id(char *class_str,
 			match = NULL;
 			break;
 		default:
-			match = early_platform_match(epdrv, match_id);
+			match = sh_early_platform_match(epdrv, match_id);
 		}
 
 		if (match) {
@@ -292,7 +292,7 @@ static int __init early_platform_driver_probe_id(char *class_str,
 }
 
 /**
- * early_platform_driver_probe - probe a class of registered drivers
+ * sh_early_platform_driver_probe - probe a class of registered drivers
  * @class_str: string to identify early platform driver class
  * @nr_probe: number of platform devices to successfully probe before exiting
  * @user_only: only probe user specified early platform devices
@@ -301,7 +301,7 @@ static int __init early_platform_driver_probe_id(char *class_str,
  * within a certain class. For probe to happen a registered early platform
  * device matching a registered early platform driver is needed.
  */
-int __init early_platform_driver_probe(char *class_str,
+int __init sh_early_platform_driver_probe(char *class_str,
 				       int nr_probe,
 				       int user_only)
 {
@@ -309,7 +309,7 @@ int __init early_platform_driver_probe(char *class_str,
 
 	n = 0;
 	for (i = -2; n < nr_probe; i++) {
-		k = early_platform_driver_probe_id(class_str, i, nr_probe - n);
+		k = sh_early_platform_driver_probe_id(class_str, i, nr_probe - n);
 
 		if (k < 0)
 			break;
@@ -324,14 +324,14 @@ int __init early_platform_driver_probe(char *class_str,
 }
 
 /**
- * early_platform_cleanup - clean up early platform code
+ * sh_early_platform_cleanup - clean up early platform code
  */
-static int __init early_platform_cleanup(void)
+static int __init sh_early_platform_cleanup(void)
 {
 	struct platform_device *pd, *pd2;
 
 	/* clean up the devres list used to chain devices */
-	list_for_each_entry_safe(pd, pd2, &early_platform_device_list,
+	list_for_each_entry_safe(pd, pd2, &sh_early_platform_device_list,
 				 dev.devres_head) {
 		list_del(&pd->dev.devres_head);
 		memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
@@ -343,4 +343,4 @@ static int __init early_platform_cleanup(void)
  * This must happen once after all early devices are probed but before probing
  * real platform devices.
  */
-subsys_initcall(early_platform_cleanup);
+subsys_initcall(sh_early_platform_cleanup);
diff --git a/arch/sh/include/asm/platform_early.h b/arch/sh/include/asm/platform_early.h
index 4590ab757d5f..fc802137c37d 100644
--- a/arch/sh/include/asm/platform_early.h
+++ b/arch/sh/include/asm/platform_early.h
@@ -8,7 +8,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
-struct early_platform_driver {
+struct sh_early_platform_driver {
 	const char *class_str;
 	struct platform_driver *pdrv;
 	struct list_head list;
@@ -20,39 +20,39 @@ struct early_platform_driver {
 #define EARLY_PLATFORM_ID_UNSET -2
 #define EARLY_PLATFORM_ID_ERROR -3
 
-extern int early_platform_driver_register(struct early_platform_driver *epdrv,
+extern int sh_early_platform_driver_register(struct sh_early_platform_driver *epdrv,
 					  char *buf);
-extern void early_platform_add_devices(struct platform_device **devs, int num);
+extern void sh_early_platform_add_devices(struct platform_device **devs, int num);
 
-static inline int is_early_platform_device(struct platform_device *pdev)
+static inline int is_sh_early_platform_device(struct platform_device *pdev)
 {
 	return !pdev->dev.driver;
 }
 
-extern void early_platform_driver_register_all(char *class_str);
-extern int early_platform_driver_probe(char *class_str,
+extern void sh_early_platform_driver_register_all(char *class_str);
+extern int sh_early_platform_driver_probe(char *class_str,
 				       int nr_probe, int user_only);
 
-#define early_platform_init(class_string, platdrv)		\
-	early_platform_init_buffer(class_string, platdrv, NULL, 0)
+#define sh_early_platform_init(class_string, platdrv)		\
+	sh_early_platform_init_buffer(class_string, platdrv, NULL, 0)
 
 #ifndef MODULE
-#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
-static __initdata struct early_platform_driver early_driver = {		\
+#define sh_early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
+static __initdata struct sh_early_platform_driver early_driver = {		\
 	.class_str = class_string,					\
 	.buffer = buf,							\
 	.bufsize = bufsiz,						\
 	.pdrv = platdrv,						\
 	.requested_id = EARLY_PLATFORM_ID_UNSET,			\
 };									\
-static int __init early_platform_driver_setup_func(char *buffer)	\
+static int __init sh_early_platform_driver_setup_func(char *buffer)	\
 {									\
-	return early_platform_driver_register(&early_driver, buffer);	\
+	return sh_early_platform_driver_register(&early_driver, buffer);	\
 }									\
-early_param(class_string, early_platform_driver_setup_func)
+early_param(class_string, sh_early_platform_driver_setup_func)
 #else /* MODULE */
-#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
-static inline char *early_platform_driver_setup_func(void)		\
+#define sh_early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
+static inline char *sh_early_platform_driver_setup_func(void)		\
 {									\
 	return bufsiz ? buf : NULL;					\
 }
diff --git a/arch/sh/kernel/cpu/sh2/setup-sh7619.c b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
index a02fc03baef8..6d0425affa71 100644
--- a/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
@@ -203,6 +203,6 @@ void __init plat_early_device_setup(void)
 	/* enable CMT clock */
 	__raw_writeb(__raw_readb(STBCR3) & ~0x10, STBCR3);
 
-	early_platform_add_devices(sh7619_early_devices,
+	sh_early_platform_add_devices(sh7619_early_devices,
 				   ARRAY_SIZE(sh7619_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh2a/setup-mxg.c b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
index d33568a12fad..fb9dd473a9cc 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-mxg.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
@@ -173,6 +173,6 @@ static struct platform_device *mxg_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(mxg_early_devices,
+	sh_early_platform_add_devices(mxg_early_devices,
 				   ARRAY_SIZE(mxg_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
index b258c5c3af60..37357d0fc9bc 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
@@ -416,6 +416,6 @@ void __init plat_early_device_setup(void)
 	/* enable MTU2 clock */
 	__raw_writeb(__raw_readb(STBCR3) & ~0x20, STBCR3);
 
-	early_platform_add_devices(sh7201_early_devices,
+	sh_early_platform_add_devices(sh7201_early_devices,
 				   ARRAY_SIZE(sh7201_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
index db3f8df8d76d..79ba8d0db6b0 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
@@ -353,6 +353,6 @@ void __init plat_early_device_setup(void)
 	/* enable MTU2 clock */
 	__raw_writeb(__raw_readb(STBCR3) & ~0x20, STBCR3);
 
-	early_platform_add_devices(sh7203_early_devices,
+	sh_early_platform_add_devices(sh7203_early_devices,
 				   ARRAY_SIZE(sh7203_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
index e1be4fedc739..501922504a3f 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
@@ -289,6 +289,6 @@ void __init plat_early_device_setup(void)
 	/* enable MTU2 clock */
 	__raw_writeb(__raw_readb(STBCR3) & ~0x20, STBCR3);
 
-	early_platform_add_devices(sh7206_early_devices,
+	sh_early_platform_add_devices(sh7206_early_devices,
 				   ARRAY_SIZE(sh7206_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
index b5bed10d0d72..955f15386bbd 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
@@ -550,6 +550,6 @@ static struct platform_device *sh7264_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7264_early_devices,
+	sh_early_platform_add_devices(sh7264_early_devices,
 				   ARRAY_SIZE(sh7264_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
index 248a6732397a..d8ecb24a0888 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
@@ -566,6 +566,6 @@ static struct platform_device *sh7269_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7269_early_devices,
+	sh_early_platform_add_devices(sh7269_early_devices,
 				   ARRAY_SIZE(sh7269_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7705.c b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
index 7ec8c11c2f7a..481cfbc3b82d 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
@@ -182,7 +182,7 @@ static struct platform_device *sh7705_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7705_early_devices,
+	sh_early_platform_add_devices(sh7705_early_devices,
 				   ARRAY_SIZE(sh7705_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index 20839dd40a2f..d0cd14f5fc19 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -234,7 +234,7 @@ static struct platform_device *sh770x_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh770x_early_devices,
+	sh_early_platform_add_devices(sh770x_early_devices,
 				   ARRAY_SIZE(sh770x_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7710.c b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
index 780ccd202bab..fb680bae22c3 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
@@ -181,7 +181,7 @@ static struct platform_device *sh7710_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7710_early_devices,
+	sh_early_platform_add_devices(sh7710_early_devices,
 				   ARRAY_SIZE(sh7710_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7720.c b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
index 723bd9c04c8a..faf084cbbbed 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
@@ -215,7 +215,7 @@ static struct platform_device *sh7720_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7720_early_devices,
+	sh_early_platform_add_devices(sh7720_early_devices,
 				   ARRAY_SIZE(sh7720_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
index 4a5fa86006cd..123b848368d4 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
@@ -80,7 +80,7 @@ static struct platform_device *sh4202_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh4202_early_devices,
+	sh_early_platform_add_devices(sh4202_early_devices,
 				   ARRAY_SIZE(sh4202_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index abb3703c2273..8f6c83b745db 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -165,15 +165,15 @@ void __init plat_early_device_setup(void)
 	if (mach_is_rts7751r2d()) {
 		scif_platform_data.scscr |= SCSCR_CKE1;
 		dev[0] = &scif_device;
-		early_platform_add_devices(dev, 1);
+		sh_early_platform_add_devices(dev, 1);
 	} else {
 		dev[0] = &sci_device;
-		early_platform_add_devices(dev, 1);
+		sh_early_platform_add_devices(dev, 1);
 		dev[0] = &scif_device;
-		early_platform_add_devices(dev, 1);
+		sh_early_platform_add_devices(dev, 1);
 	}
 
-	early_platform_add_devices(sh7750_early_devices,
+	sh_early_platform_add_devices(sh7750_early_devices,
 				   ARRAY_SIZE(sh7750_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
index 649f4dcb5935..ab8cc1826d8c 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
@@ -275,7 +275,7 @@ static struct platform_device *sh7760_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7760_early_devices,
+	sh_early_platform_add_devices(sh7760_early_devices,
 				   ARRAY_SIZE(sh7760_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
index 73715a635048..a3ff0803b62e 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
@@ -300,7 +300,7 @@ static struct platform_device *sh7343_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7343_early_devices,
+	sh_early_platform_add_devices(sh7343_early_devices,
 				   ARRAY_SIZE(sh7343_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
index 942856048112..2ad400fef830 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
@@ -244,7 +244,7 @@ static struct platform_device *sh7366_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7366_early_devices,
+	sh_early_platform_add_devices(sh7366_early_devices,
 				   ARRAY_SIZE(sh7366_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index bf60456a8012..01e687d72c16 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -516,7 +516,7 @@ static struct platform_device *sh7722_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7722_early_devices,
+	sh_early_platform_add_devices(sh7722_early_devices,
 				   ARRAY_SIZE(sh7722_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index d25d3c3b44ab..6738c39413b2 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -414,7 +414,7 @@ static struct platform_device *sh7723_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7723_early_devices,
+	sh_early_platform_add_devices(sh7723_early_devices,
 				   ARRAY_SIZE(sh7723_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 0eeadabc8065..0163750a3fb0 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -834,7 +834,7 @@ static struct platform_device *sh7724_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7724_early_devices,
+	sh_early_platform_add_devices(sh7724_early_devices,
 				   ARRAY_SIZE(sh7724_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
index bed9d01fa85f..d3760029f0f3 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
@@ -284,7 +284,7 @@ static struct platform_device *sh7734_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7734_early_devices,
+	sh_early_platform_add_devices(sh7734_early_devices,
 		ARRAY_SIZE(sh7734_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index b5b19e81a8dc..25d655ab4114 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -771,7 +771,7 @@ static struct platform_device *sh7757_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7757_early_devices,
+	sh_early_platform_add_devices(sh7757_early_devices,
 				   ARRAY_SIZE(sh7757_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
index 51a6c64f860e..42f234efaa42 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
@@ -225,7 +225,7 @@ static struct platform_device *sh7763_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7763_early_devices,
+	sh_early_platform_add_devices(sh7763_early_devices,
 				   ARRAY_SIZE(sh7763_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
index 77f228e20599..35420329f5e1 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
@@ -320,7 +320,7 @@ static struct platform_device *sh7770_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7770_early_devices,
+	sh_early_platform_add_devices(sh7770_early_devices,
 				   ARRAY_SIZE(sh7770_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index c4cbb7584122..3a75db564c24 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -289,7 +289,7 @@ void __init plat_early_device_setup(void)
 		scif1_platform_data.scscr &= ~SCSCR_CKE1;
 	}
 
-	early_platform_add_devices(sh7780_early_devices,
+	sh_early_platform_add_devices(sh7780_early_devices,
 				   ARRAY_SIZE(sh7780_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index eda0d61ebf71..eb3c003223e2 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -357,7 +357,7 @@ static struct platform_device *sh7785_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7785_early_devices,
+	sh_early_platform_add_devices(sh7785_early_devices,
 				   ARRAY_SIZE(sh7785_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 77226a60c36f..46473345cb79 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -838,6 +838,6 @@ arch_initcall(sh7786_devices_setup);
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh7786_early_devices,
+	sh_early_platform_add_devices(sh7786_early_devices,
 				   ARRAY_SIZE(sh7786_early_devices));
 }
diff --git a/arch/sh/kernel/cpu/sh4a/setup-shx3.c b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
index 83feaf0a4aae..c531182425f7 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
@@ -156,7 +156,7 @@ arch_initcall(shx3_devices_setup);
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(shx3_early_devices,
+	sh_early_platform_add_devices(shx3_early_devices,
 				   ARRAY_SIZE(shx3_early_devices));
 }
 
diff --git a/arch/sh/kernel/cpu/sh5/setup-sh5.c b/arch/sh/kernel/cpu/sh5/setup-sh5.c
index 8ebd26a9fd90..034bb36bfdc2 100644
--- a/arch/sh/kernel/cpu/sh5/setup-sh5.c
+++ b/arch/sh/kernel/cpu/sh5/setup-sh5.c
@@ -119,6 +119,6 @@ arch_initcall(sh5_devices_setup);
 
 void __init plat_early_device_setup(void)
 {
-	early_platform_add_devices(sh5_early_devices,
+	sh_early_platform_add_devices(sh5_early_devices,
 				   ARRAY_SIZE(sh5_early_devices));
 }
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index aed8f331f66b..74548fc31a3d 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -328,7 +328,7 @@ void __init setup_arch(char **cmdline_p)
 	sh_mv_setup();
 
 	/* Let earlyprintk output early console messages */
-	early_platform_driver_probe("earlyprintk", 1, 1);
+	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
 #ifdef CONFIG_OF_FLATTREE
 #ifdef CONFIG_USE_BUILTIN_DTB
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index 674d8413491b..9c460a74e3c2 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -105,8 +105,8 @@ static void __init sh_late_time_init(void)
 	 * clocksource and the jiffies clocksource is used transparently
 	 * instead. No error handling is necessary here.
 	 */
-	early_platform_driver_register_all("earlytimer");
-	early_platform_driver_probe("earlytimer", 2, 0);
+	sh_early_platform_driver_register_all("earlytimer");
+	sh_early_platform_driver_probe("earlytimer", 2, 0);
 }
 
 void __init time_init(void)
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index fe9abe5b3e68..49f36c26e6fb 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -1047,7 +1047,7 @@ static int sh_cmt_probe(struct platform_device *pdev)
 	struct sh_cmt_device *cmt = platform_get_drvdata(pdev);
 	int ret;
 
-	if (!is_early_platform_device(pdev)) {
+	if (!is_sh_early_platform_device(pdev)) {
 		pm_runtime_set_active(&pdev->dev);
 		pm_runtime_enable(&pdev->dev);
 	}
@@ -1067,7 +1067,7 @@ static int sh_cmt_probe(struct platform_device *pdev)
 		pm_runtime_idle(&pdev->dev);
 		return ret;
 	}
-	if (is_early_platform_device(pdev))
+	if (is_sh_early_platform_device(pdev))
 		return 0;
 
  out:
@@ -1105,7 +1105,7 @@ static void __exit sh_cmt_exit(void)
 }
 
 #ifdef CONFIG_SUPERH
-early_platform_init("earlytimer", &sh_cmt_device_driver);
+sh_early_platform_init("earlytimer", &sh_cmt_device_driver);
 #endif
 
 subsys_initcall(sh_cmt_init);
diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index becff3a1a6fb..05120ef24833 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -454,7 +454,7 @@ static int sh_mtu2_probe(struct platform_device *pdev)
 	struct sh_mtu2_device *mtu = platform_get_drvdata(pdev);
 	int ret;
 
-	if (!is_early_platform_device(pdev)) {
+	if (!is_sh_early_platform_device(pdev)) {
 		pm_runtime_set_active(&pdev->dev);
 		pm_runtime_enable(&pdev->dev);
 	}
@@ -474,7 +474,7 @@ static int sh_mtu2_probe(struct platform_device *pdev)
 		pm_runtime_idle(&pdev->dev);
 		return ret;
 	}
-	if (is_early_platform_device(pdev))
+	if (is_sh_early_platform_device(pdev))
 		return 0;
 
  out:
@@ -524,7 +524,7 @@ static void __exit sh_mtu2_exit(void)
 }
 
 #ifdef CONFIG_SUPERH
-early_platform_init("earlytimer", &sh_mtu2_device_driver);
+sh_early_platform_init("earlytimer", &sh_mtu2_device_driver);
 #endif
 
 subsys_initcall(sh_mtu2_init);
diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 3f4783a9ecf0..6f2c5279c1fd 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -610,7 +610,7 @@ static int sh_tmu_probe(struct platform_device *pdev)
 	struct sh_tmu_device *tmu = platform_get_drvdata(pdev);
 	int ret;
 
-	if (!is_early_platform_device(pdev)) {
+	if (!is_sh_early_platform_device(pdev)) {
 		pm_runtime_set_active(&pdev->dev);
 		pm_runtime_enable(&pdev->dev);
 	}
@@ -631,7 +631,7 @@ static int sh_tmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (is_early_platform_device(pdev))
+	if (is_sh_early_platform_device(pdev))
 		return 0;
 
  out:
@@ -682,7 +682,7 @@ static void __exit sh_tmu_exit(void)
 }
 
 #ifdef CONFIG_SUPERH
-early_platform_init("earlytimer", &sh_tmu_device_driver);
+sh_early_platform_init("earlytimer", &sh_tmu_device_driver);
 #endif
 
 subsys_initcall(sh_tmu_init);
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index a6c3aa7a7de8..1d2e645f35d5 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3220,7 +3220,7 @@ static int sci_probe(struct platform_device *dev)
 	 * to make it beyond this yet.
 	 */
 #ifdef CONFIG_SUPERH
-	if (is_early_platform_device(dev))
+	if (is_sh_early_platform_device(dev))
 		return sci_probe_earlyprintk(dev);
 #endif
 
@@ -3320,7 +3320,7 @@ static void __exit sci_exit(void)
 }
 
 #if defined(CONFIG_SUPERH) && defined(CONFIG_SERIAL_SH_SCI_CONSOLE)
-early_platform_init_buffer("earlyprintk", &sci_driver,
+sh_early_platform_init_buffer("earlyprintk", &sci_driver,
 			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
 #endif
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7d7610da8377..a03d5cd7dc5a 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -324,7 +324,7 @@ extern int platform_dma_configure(struct device *dev);
  * drivers. It should go away once we introduce the new platform_device-based
  * early driver framework.
  */
-static inline int is_early_platform_device(struct platform_device *pdev)
+static inline int is_sh_early_platform_device(struct platform_device *pdev)
 {
 	return 0;
 }
-- 
2.17.1
