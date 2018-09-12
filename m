Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39845 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728216AbeILSaj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Sep 2018 14:30:39 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V3 19/27] dt-bindings: timer: gx6605s SOC timer
Date: Wed, 12 Sep 2018 21:24:53 +0800
Message-ID: <e70d9055806db229a07d02fc80d45b3cc5d12ef3.1536757532.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536757532.git.ren_guo@c-sky.com>
References: <cover.1536757532.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536757532.git.ren_guo@c-sky.com>
References: <cover.1536757532.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org, andrea.parri@amarulasolutions.com, peterz@infradead.org
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
Message-ID: <20180912132453.gI9_zCYmyY8fwrPTr2tgbXvtEqHSfkqZNQXPQ_qGeoE@z>

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../bindings/timer/csky,gx6605s-timer.txt          | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
new file mode 100644
index 0000000..230a9ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
@@ -0,0 +1,42 @@
+=================
+gx6605s SOC Timer
+=================
+
+The timer is used in gx6605s soc as system timer and the driver
+contain clk event and clk source.
+
+==============================
+timer node bindings definition
+==============================
+
+        Description: Describes gx6605s SOC timer
+
+        PROPERTIES
+
+        - compatible
+                Usage: required
+                Value type: <string>
+                Definition: must be "csky,gx6605s-timer"
+	- reg
+		Usage: required
+		Value type: <u32 u32>
+		Definition: <phyaddr size> in soc from cpu view
+	- clocks
+		Usage: required
+		Value type: phandle + clock specifier cells
+		Definition: must be input clk node
+        - interrupt
+                Usage: required
+                Value type: <u32>
+                Definition: must be timer irq num defined by soc
+
+Examples:
+---------
+
+	timer0: timer@20a000 {
+		compatible = "csky,gx6605s-timer";
+		reg = <0x0020a000 0x400>;
+		clocks = <&dummy_apb_clk>;
+		interrupts = <10>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.7.4
