Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f194.google.com ([209.85.212.194]:51335 "EHLO
	mail-wi0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938AbbBTSCA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Feb 2015 13:02:00 -0500
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH v2 10/18] dt-bindings: Document the STM32 pin controller
Date: Fri, 20 Feb 2015 19:01:09 +0100
Message-Id: <1424455277-29983-11-git-send-email-mcoquelin.stm32@gmail.com>
In-Reply-To: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: u.kleine-koenig@pengutronix.de, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

This adds documentation of device tree bindings for the
STM32 pin controller.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-stm32.txt  | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
new file mode 100644
index 0000000..0fb5b24
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
@@ -0,0 +1,99 @@
+* STM32 GPIO and Pin Mux/Config controller
+
+STMicroelectronics's STM32 MCUs intregrate a GPIO and Pin mux/config hardware
+controller. It controls the input/output settings on the available pins and
+also provides ability to multiplex and configure the output of various on-chip
+controllers onto these pads.
+
+Pin controller node:
+Required properies:
+- compatible	: "st,stm32-pinctrl"
+- #address-cells: The value of this property must be 1
+- #size-cells	: The value of this property must be 1
+- ranges	: defines mapping between pin controller node (parent) to
+  gpio-bank node (children).
+
+GPIO controller/bank node:
+Required properties:
+- gpio-controller : Indicates this device is a GPIO controller
+- #gpio-cells	  : Should be two.
+			The first cell is the pin number
+			The second one is the polarity:
+				- 0 for active high
+				- 1 for active low
+- reg		  : The gpio address range, relative to the pinctrl range
+- st,bank-name	  : Should be a name string for this bank as specified in
+  the datasheet
+
+Optional properties:
+- reset:	  : Reference to the reset controller
+
+Example:
+#include <dt-bindings/pinctrl/pinctrl-stm32.h>
+...
+
+	pin-controller {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,stm32-pinctrl";
+		ranges = <0 0x40020000 0x3000>;
+
+		gpioa: gpio@40020000 {
+			gpio-controller;
+			#gpio-cells = <2>;
+			reg = <0x0 0x400>;
+			resets = <&reset_ahb1 0>;
+			st,bank-name = "GPIOA";
+		};
+		...
+		pin-functions nodes follow...
+	};
+
+Contents of function subnode node:
+----------------------------------
+
+Required properties for pin configuration node:
+- st,pins	: Child node with list of pins with configuration.
+
+Below is the format of how each pin conf should look like.
+
+<bank offset altmode pull type speed>
+
+Every PIO is represented with 4 to 6 parameters.
+Each parameter is explained as below.
+
+- bank	  : Should be bank phandle to which this PIO belongs.
+- offset  : Offset in the PIO bank.
+- altmode : Should be mode or alternate function number associated this pin, as
+described in the datasheet (IN, OUT, ALT0...ALT15, ANALOG)
+- pull	  : Should be either NO_PULL, PULL_UP or PULL_DOWN
+- type	  : Should be either PUSH_PULL or OPEN_DRAIN.
+	    Setting it is not needed for IN and ANALOG modes, or alternate
+	    functions acting as inputs.
+- speed	  : Value taken from the datasheet, depending on the function
+(LOW_SPEED, MEDIUM_SPEED, FAST_SPEED, HIGH_SPEED)
+	    Setting it is not needed for IN and ANALOG modes, or alternate
+	    functions acting as inputs.
+
+usart1 {
+	pinctrl_usart1: usart1-0 {
+		st,pins {
+			tx = <&gpioa 9 ALT7 NO_PULL PUSH_PULL LOW_SPEED>;
+			rx = <&gpioa 10 ALT7 NO_PULL PUSH_PULL LOW_SPEED>;
+		};
+	};
+};
+
+adc2 {
+	pinctrl_adc2: adc2-0 {
+		st,pins {
+			adc0 = <&gpioe 4 ANALOG NO_PULL>;
+		};
+	};
+};
+
+usart1: usart@40011000 {
+	...
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usart1>;
+};
-- 
1.9.1

