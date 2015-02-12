Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f66.google.com ([74.125.82.66]:33111 "EHLO
	mail-wg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbbBLRqZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Feb 2015 12:46:25 -0500
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH 04/14] reset: Add reset_controller_of_init() function
Date: Thu, 12 Feb 2015 18:45:54 +0100
Message-Id: <1423763164-5606-5-git-send-email-mcoquelin.stm32@gmail.com>
In-Reply-To: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

Some platforms need to initialize the reset controller before the timers.

This patch introduces a reset_controller_of_init() function that can be
called before the timers intialization.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 drivers/reset/core.c              | 20 ++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  4 +++-
 include/linux/reset-controller.h  |  6 ++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 7955e00..18ee579 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -86,6 +86,26 @@ void reset_controller_unregister(struct reset_controller_dev *rcdev)
 }
 EXPORT_SYMBOL_GPL(reset_controller_unregister);
 
+extern struct of_device_id __reset_ctrl_of_table[];
+
+static const struct of_device_id __reset_ctrl_of_table_sentinel
+	__used __section(__reset_ctrl_of_table_end);
+
+void __init reset_controller_of_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+	of_init_fn_1 init_func;
+
+	for_each_matching_node_and_match(np, __reset_ctrl_of_table, &match) {
+		if (!of_device_is_available(np))
+			continue;
+
+		init_func = match->data;
+		init_func(np);
+	}
+}
+
 /**
  * reset_control_reset - reset the controlled device
  * @rstc: reset controller
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bee5d68..1f96365 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -168,6 +168,7 @@
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
 #define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
+#define RESET_CTRL_OF_TABLES()	OF_TABLE(CONFIG_RESET_CONTROLLER, reset_ctrl)
 
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
@@ -502,7 +503,8 @@
 	CPU_METHOD_OF_TABLES()						\
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
-	EARLYCON_OF_TABLES()
+	EARLYCON_OF_TABLES()						\
+	RESET_CTRL_OF_TABLES()
 
 #define INIT_TEXT							\
 	*(.init.text)							\
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index ce6b962..f8a030a 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -51,4 +51,10 @@ struct reset_controller_dev {
 int reset_controller_register(struct reset_controller_dev *rcdev);
 void reset_controller_unregister(struct reset_controller_dev *rcdev);
 
+
+#define RESET_CONTROLLER_OF_DECLARE(name, compat, fn) \
+	OF_DECLARE_1(reset_ctrl, name, compat, fn)
+
+void reset_controller_of_init(void);
+
 #endif
-- 
1.9.1

