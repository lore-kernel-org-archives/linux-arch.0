Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42988 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727997AbeIEQjB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Sep 2018 12:39:01 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V3 20/26] dt-bindings: timer: C-SKY Multi-processor timer
Date: Wed,  5 Sep 2018 20:07:59 +0800
Message-ID: <18101ebf957fc8cdfa2cb931c539750e7def0969.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
Message-ID: <20180905120759.ggUMtuL7k2RS4Lk-jxvBTd9czEfaqaVug0dSLq4l8-w@z>

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../devicetree/bindings/timer/csky,mptimer.txt     | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt

diff --git a/Documentation/devicetree/bindings/timer/csky,mptimer.txt b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
new file mode 100644
index 0000000..0d7369f
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
@@ -0,0 +1,46 @@
+============================
+C-SKY Multi-processors Timer
+============================
+
+C-SKY multi-processors timer is designed for C-SKY SMP system and the
+regs is accessed by cpu co-processor 4 registers with mtcr/mfcr.
+
+ - PTIM_CTLR "cr<0, 14>" Control reg to start reset timer.
+ - PTIM_TSR  "cr<1, 14>" Interrupt cleanup status reg.
+ - PTIM_CCVR "cr<3, 14>" Current counter value reg.
+ - PTIM_LVR  "cr<6, 14>" Window value reg to triger next event.
+
+==============================
+timer node bindings definition
+==============================
+
+        Description: Describes SMP timer
+
+        PROPERTIES
+
+        - compatible
+                Usage: required
+                Value type: <string>
+                Definition: must be "csky,mptimer"
+	- clocks
+		Usage: required
+		Value type: <node>
+                Definition: must be input clk node
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
+	timer: timer {
+		compatible = "csky,mptimer";
+		clocks = <&dummy_apb_clk>;
+		interrupts = <16>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.7.4
