Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33085 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955AbbCLV4o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Mar 2015 17:56:44 -0400
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH v3  07/15] dt-bindings: Document the STM32 timer bindings
Date: Thu, 12 Mar 2015 22:55:53 +0100
Message-ID: <1426197361-19290-8-git-send-email-maxime.coquelin@st.com>
In-Reply-To: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
References: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: u.kleine-koenig@pengutronix.de, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, stefan@agner.ch, pmeerw@pmeerw.net, pebolle@tiscali.nl
Cc: Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, mcoquelin.stm32@gmail.com
Message-ID: <20150312215553.KoMr-l3DE-fKYJAOQXeJKuADSAMgXoj-JIyuIkqnbzY@z>

From: Maxime Coquelin <mcoquelin.stm32@gmail.com>

This adds documentation of device tree bindings for the
STM32 timer.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 .../devicetree/bindings/timer/st,stm32-timer.txt   | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/st,stm32-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/st,stm32-timer.txt b/Documentation/devicetree/bindings/timer/st,stm32-timer.txt
new file mode 100644
index 0000000..d3fdeb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/st,stm32-timer.txt
@@ -0,0 +1,22 @@
+. STMicroelectronics STM32 timer
+
+The STM32 MCUs family has several general-purpose 16 and 32 bits timers.
+
+Required properties:
+- compatible : Should be st,stm32-timer"
+- reg : Address and length of the register set
+- clocks : Reference on the timer input clock
+- interrupts : Reference to the timer interrupt
+
+Optional properties:
+- resets: Reference to a reset controller asserting the timer
+
+Example:
+
+timer5: timer@40000c00 {
+	compatible = "st,stm32-timer";
+	reg = <0x40000c00 0x400>;
+	interrupts = <50>;
+	resets = <&rrc 259>;
+	clocks = <&clk_pmtr1>;
+};
-- 
1.9.1

