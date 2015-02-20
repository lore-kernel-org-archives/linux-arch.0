Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f196.google.com ([209.85.212.196]:52535 "EHLO
	mail-wi0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbbBTSBr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Feb 2015 13:01:47 -0500
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH v2 06/18] dt-bindings: Document the STM32 reset bindings
Date: Fri, 20 Feb 2015 19:01:05 +0100
Message-Id: <1424455277-29983-7-git-send-email-mcoquelin.stm32@gmail.com>
In-Reply-To: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: u.kleine-koenig@pengutronix.de, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

This adds documentation of device tree bindings for the
STM32 reset controller.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 .../devicetree/bindings/reset/st,stm32-reset.txt   | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/st,stm32-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/st,stm32-reset.txt b/Documentation/devicetree/bindings/reset/st,stm32-reset.txt
new file mode 100644
index 0000000..5982528
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/st,stm32-reset.txt
@@ -0,0 +1,36 @@
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
+
+Specifying softreset control of devices
+=======================================
+
+Device nodes should specify the reset channel required in their "resets"
+property, containing a phandle to the reset device node and an index specifying
+which channel to use, as described in reset.txt
+
+example:
+
+	timer2 {
+		resets			= <&resets TIM2_RESET>;
+	};
+
+Macro definitions for the supported reset channels can be found in:
+
+include/dt-bindings/reset/st,stm32f429.h
-- 
1.9.1

