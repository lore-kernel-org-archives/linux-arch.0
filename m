Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56726 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727623AbeILT6a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Sep 2018 15:58:30 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V4 21/27] dt-bindings: interrupt-controller: C-SKY APB intc
Date: Wed, 12 Sep 2018 22:52:03 +0800
Message-ID: <78e2aaf5d1aa428f18c6aa9a1cfead1cc9b5af7d.1536758961.git.ren_guo@c-sky.com>
In-Reply-To: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
References: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536758961.git.ren_guo@c-sky.com>
References: <cover.1536758961.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org, andrea.parri@amarulasolutions.com, peterz@infradead.org
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
Message-ID: <20180912145203.oIw8ATlCnlt8KmX4kkszTyZf3zFzGVfE3OK8krLhUis@z>

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../interrupt-controller/csky,apb-intc.txt         | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
new file mode 100644
index 0000000..dbe55f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
@@ -0,0 +1,45 @@
+==============================
+C-SKY APB Interrupt Controller
+==============================
+
+C-SKY APB Interrupt Controller is a simple soc interrupt controller
+on the apb bus and we only use it as root irq controller.
+
+ - csky,apb-intc is used in a lot of csky fpgas and socs, it support 64 irq nums.
+ - csky,dual-apb-intc consists of 2 apb-intc and 128 irq nums supported.
+ - csky,gx6605s-intc is gx6605s soc internal irq interrupt controller, 64 irq nums.
+
+=============================
+intc node bindings definition
+=============================
+
+        Description: Describes APB interrupt controller
+
+        PROPERTIES
+
+        - compatible
+                Usage: required
+                Value type: <string>
+                Definition: must be "csky,apb-intc"
+				    "csky,dual-apb-intc"
+				    "csky,gx6605s-intc"
+        - #interrupt-cells
+                Usage: required
+                Value type: <u32>
+                Definition: must be <1>
+	- reg
+		Usage: required
+		Value type: <u32 u32>
+                Definition: <phyaddr size> in soc from cpu view
+        - interrupt-controller:
+                Usage: required
+
+Examples:
+---------
+
+	intc: interrupt-controller@500000 {
+		compatible = "csky,apb-intc";
+		#interrupt-cells = <1>;
+		reg = <0x00500000 0x400>;
+		interrupt-controller;
+	};
-- 
2.7.4
