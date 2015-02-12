Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f67.google.com ([74.125.82.67]:62694 "EHLO
	mail-wg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbbBLSDr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Feb 2015 13:03:47 -0500
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH 11/14] ARM: dts: Add ARM System timer as clockevent in armv7m
Date: Thu, 12 Feb 2015 18:46:01 +0100
Message-Id: <1423763164-5606-12-git-send-email-mcoquelin.stm32@gmail.com>
In-Reply-To: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/armv7-m.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/armv7-m.dtsi b/arch/arm/boot/dts/armv7-m.dtsi
index 5a660d0..5b279d3 100644
--- a/arch/arm/boot/dts/armv7-m.dtsi
+++ b/arch/arm/boot/dts/armv7-m.dtsi
@@ -8,6 +8,13 @@
 		reg = <0xe000e100 0xc00>;
 	};
 
+	systick: system-timer {
+		compatible = "arm,armv7m-systick";
+		reg = <0xe000e010 0x10>;
+
+		status = "disabled";
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1

