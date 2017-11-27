From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 35/35] dt-bindings: timer: Add andestech atcpit100 timer binding doc
Date: Mon, 27 Nov 2017 20:28:22 +0800
Message-ID: <60f23e7fcff11f16b0bca4753a39d098849eeac3.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
Cc: Rick Chen <rickchen36@gmail.com>, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

From: Rick Chen <rickchen36@gmail.com>

Add a document to describe Andestech atcpit100 timer and
binding information.

Signed-off-by: Rick Chen <rickchen36@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greentime Hu <green.hu@gmail.com>
---
 .../bindings/timer/andestech,atcpit100-timer.txt   |   33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt b/Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
new file mode 100644
index 0000000..b97ff32
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
+- clock-names : should be "PCLK" for the external tick timer.
+
+Examples:
+
+timer0: timer@f0400000 {
+	compatible = "andestech,atcpit100";
+	reg = <0xf0400000 0x1000>;
+	interrupts = <2 4>;
+	clocks = <&clk_pll>;
+	clock-names = "PCLK";
+};
-- 
1.7.9.5
