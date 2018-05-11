Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34933 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeEKQVa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 May 2018 12:21:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id o78-v6so4267341wmg.0
        for <linux-arch@vger.kernel.org>; Fri, 11 May 2018 09:21:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 03/12] platform/early: export platform_match() locally
Date: Fri, 11 May 2018 18:20:19 +0200
Message-ID: <20180511162028.20616-4-brgl@bgdev.pl>
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Message-ID: <20180511162019.W5q_3SLJCnRe2w_9LAKCbIeDTtbh7DPf9krCwZMKqvQ@z>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We will use this function to match devices in the early platform core
code. Export it locally in drivers/base.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/base.h     | 3 +++
 drivers/base/platform.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index d800de650fa5..7a72ae72a98e 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -161,3 +161,6 @@ extern void device_links_driver_cleanup(struct device *dev);
 extern void device_links_no_driver(struct device *dev);
 extern bool device_links_busy(struct device *dev);
 extern void device_links_unbind_consumers(struct device *dev);
+
+/* Platform device helpers. */
+extern int platform_match(struct device *dev, struct device_driver *drv);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 70b156ee267a..0c53e3e3e5aa 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -961,7 +961,7 @@ static const struct platform_device_id *platform_match_id(
  * and compare it against the name of the driver. Return whether they match
  * or not.
  */
-static int platform_match(struct device *dev, struct device_driver *drv)
+int platform_match(struct device *dev, struct device_driver *drv)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct platform_driver *pdrv = to_platform_driver(drv);
-- 
2.17.0
