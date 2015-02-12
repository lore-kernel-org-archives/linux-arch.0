Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f66.google.com ([74.125.82.66]:47982 "EHLO
	mail-wg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbBLRq2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Feb 2015 12:46:28 -0500
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH 05/14] ARM: call reset_controller_of_init from default time_init handler
Date: Thu, 12 Feb 2015 18:45:55 +0100
Message-Id: <1423763164-5606-6-git-send-email-mcoquelin.stm32@gmail.com>
In-Reply-To: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

Some DT ARM platforms need the reset controllers to be initialized before
the timers.
This is the case of the stm32 and sunxi platforms.

This patch adds a call to reset_controller_of_init() to the default
.init_time callback when RESET_CONTROLLER is used by the platform.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/kernel/time.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 0cc7e58..4601b1e 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/profile.h>
+#include <linux/reset-controller.h>
 #include <linux/sched.h>
 #include <linux/sched_clock.h>
 #include <linux/smp.h>
@@ -117,6 +118,9 @@ void __init time_init(void)
 	if (machine_desc->init_time) {
 		machine_desc->init_time();
 	} else {
+#ifdef CONFIG_RESET_CONTROLLER
+		reset_controller_of_init();
+#endif
 #ifdef CONFIG_COMMON_CLK
 		of_clk_init(NULL);
 #endif
-- 
1.9.1

