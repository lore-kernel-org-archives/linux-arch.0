From: Rick Chen <rickchen36@gmail.com>
Subject: [PATCH v5 3/3] dt-bindings: timer: Add andestech atcpit100 timer binding doc
Date: Tue, 12 Dec 2017 13:47:01 +0800
Message-ID: <1513057621-19084-4-git-send-email-rickchen36@gmail.com>
References: <1513057621-19084-1-git-send-email-rickchen36@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34194 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbdLLGMR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Dec 2017 01:12:17 -0500
In-Reply-To: <1513057621-19084-1-git-send-email-rickchen36@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rickchen36@gmail.com, rick@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@linaro.org, daniel.lezcano@linaro.org, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, linux-serial@vger.kernel.org
Cc: Greentime Hu <green.hu@gmail.com>

Add a document to describe Andestech atcpit100 timer and
binding information.

Signed-off-by: Rick Chen <rickchen36@gmail.com>
Signed-off-by: Greentime Hu <green.hu@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/timer/andestech,atcpit100-timer.txt   | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt b/Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
new file mode 100644
index 0000000..14812f68
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
@@ -0,0 +1,33 @@
+Andestech ATCPIT100 timer
+------------------------------------------------------------------
+ATCPIT100 is a generic IP block from Andes Technology, embedded in
+Andestech AE3XX platforms and other designs.
+
+This timer is a set of compact multi-function timers, which can be
+used as pulse width modulators (PWM) as well as simple timers.
+
+It supports up to 4 PIT channels. Each PIT channel is a
+multi-function timer and provide the following usage scenarios:
+One 32-bit timer
+Two 16-bit timers
+Four 8-bit timers
+One 16-bit PWM
+One 16-bit timer and one 8-bit PWM
+Two 8-bit timer and one 8-bit PWM
+
+Required properties:
+- compatible	: Should be "andestech,atcpit100"
+- reg		: Address and length of the register set
+- interrupts	: Reference to the timer interrupt
+- clocks : a clock to provide the tick rate for "andestech,atcpit100"
+- clock-names : should be "PCLK" for the peripheral clock source.
+
+Examples:
+
+timer0: timer@f0400000 {
+	compatible = "andestech,atcpit100";
+	reg = <0xf0400000 0x1000>;
+	interrupts = <2 4>;
+	clocks = <&apb>;
+	clock-names = "PCLK";
+};
-- 
2.7.4
