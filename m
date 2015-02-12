Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f194.google.com ([209.85.212.194]:44222 "EHLO
	mail-wi0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbbBLTWs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Feb 2015 14:22:48 -0500
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH 06/14] drivers: reset: Add STM32 reset driver
Date: Thu, 12 Feb 2015 18:45:56 +0100
Message-Id: <1423763164-5606-7-git-send-email-mcoquelin.stm32@gmail.com>
In-Reply-To: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

The STM32 MCUs family IP can be reset by accessing some shared registers.

The specificity is that some reset lines are used by the timers.
At timer initialization time, the timer has to be reset, that's why
we cannot use a regular driver.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 .../devicetree/bindings/reset/st,stm32-reset.txt   |  19 ++++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-stm32.c                        | 124 +++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/st,stm32-reset.txt
 create mode 100644 drivers/reset/reset-stm32.c

diff --git a/Documentation/devicetree/bindings/reset/st,stm32-reset.txt b/Documentation/devicetree/bindings/reset/st,stm32-reset.txt
new file mode 100644
index 0000000..add1298
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/st,stm32-reset.txt
@@ -0,0 +1,19 @@
+STMicroelectronics STM32 Peripheral Reset Controller
+====================================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible: Should be "st,stm32-reset"
+- reg: should be register base and length as documented in the
+  datasheet
+- #reset-cells: 1, see below
+
+example:
+
+reset_ahb1: reset@40023810 {
+	#reset-cells = <1>;
+	compatible = "st,stm32-reset";
+	reg = <0x40023810 0x4>;
+};
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 157d421..aed12d1 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_RESET_CONTROLLER) += core.o
 obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
+obj-$(CONFIG_ARCH_STM32) += reset-stm32.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
diff --git a/drivers/reset/reset-stm32.c b/drivers/reset/reset-stm32.c
new file mode 100644
index 0000000..7a96677
--- /dev/null
+++ b/drivers/reset/reset-stm32.c
@@ -0,0 +1,124 @@
+/*
+ * Copyright (C) Maxime Coquelin 2015
+ * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ *
+ * Heavily based on sunxi driver from Maxime Ripard.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+struct stm32_reset_data {
+	spinlock_t			lock;
+	void __iomem			*membase;
+	struct reset_controller_dev	rcdev;
+};
+
+static int stm32_reset_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct stm32_reset_data *data = container_of(rcdev,
+						     struct stm32_reset_data,
+						     rcdev);
+	int bank = id / BITS_PER_LONG;
+	int offset = id % BITS_PER_LONG;
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	reg = readl_relaxed(data->membase + (bank * 4));
+	writel_relaxed(reg | BIT(offset), data->membase + (bank * 4));
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static int stm32_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct stm32_reset_data *data = container_of(rcdev,
+						     struct stm32_reset_data,
+						     rcdev);
+	int bank = id / BITS_PER_LONG;
+	int offset = id % BITS_PER_LONG;
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	reg = readl_relaxed(data->membase + (bank * 4));
+	writel_relaxed(reg & ~BIT(offset), data->membase + (bank * 4));
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static struct reset_control_ops stm32_reset_ops = {
+	.assert		= stm32_reset_assert,
+	.deassert	= stm32_reset_deassert,
+};
+
+static void stm32_reset_init(struct device_node *np)
+{
+	struct stm32_reset_data *data;
+	struct resource res;
+	resource_size_t size;
+	int err;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	err = of_address_to_resource(np, 0, &res);
+	if (err)
+		goto err_alloc;
+
+	size = resource_size(&res);
+	if (!request_mem_region(res.start, size, np->name)) {
+		err = -EINVAL;
+		goto err_alloc;
+	}
+
+	data->membase = ioremap(res.start, size);
+	if (!data->membase) {
+		err = -ENOMEM;
+		goto err_alloc;
+	}
+
+	spin_lock_init(&data->lock);
+
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = size * 8;
+	data->rcdev.ops = &stm32_reset_ops;
+	data->rcdev.of_node = np;
+
+	err = reset_controller_register(&data->rcdev);
+	if (err)
+		goto err_iomap;
+
+	pr_info("%s: %d reset lines registered\n", np->full_name,
+			data->rcdev.nr_resets);
+	return;
+
+err_iomap:
+	iounmap(data->membase);
+err_alloc:
+	kfree(data);
+	pr_err("%s: Reset ctrl registration failed (%d).\n",
+			np->full_name, err);
+}
+
+RESET_CONTROLLER_OF_DECLARE(stm32, "st,stm32-reset", stm32_reset_init);
+
-- 
1.9.1

