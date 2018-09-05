Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:35791 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728001AbeIEQiz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Sep 2018 12:38:55 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V3 19/26] dt-bindings: timer: gx6605s SOC timer
Date: Wed,  5 Sep 2018 20:07:58 +0800
Message-ID: <768ac390f9eee8acb4dc9ca85a489a1d2fd00628.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
Message-ID: <20180905120758.vlGZaHikUuidY8nlEhlIQNTmgb5G0_9ifeU5xecZ0Bc@z>

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../bindings/timer/csky,gx6605s-timer.txt          | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
new file mode 100644
index 0000000..1136d9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
@@ -0,0 +1,46 @@
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
+                Definition: must be "csky,gx6605s"
+	- reg
+		Usage: required
+		Value type: <u32 u32>
+		Definition: <phyaddr size> in soc from cpu view
+	- clocks
+		Usage: required
+		Value type: <node>
+		Definition: must be input clk node
+        - interrupt
+                Usage: required
+                Value type: <u32>
+                Definition: must be timer irq num defined by soc
+        - interrupt-parent:
+                Usage: required
+		Value type: <node>
+                Definition: must be interrupt controller node
+
+Examples:
+---------
+
+	timer:timer {
+		compatible = "csky,gx6605s-timer";
+		reg = <0x0020a000 0x400>;
+		clocks = <&dummy_apb_clk>;
+		interrupts = <10>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.7.4
