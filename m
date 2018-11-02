Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40599 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726318AbeKCB71 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Nov 2018 21:59:27 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V13 resend 2/4] dt-bindings: timer: C-SKY Multi-processor timer
Date: Sat,  3 Nov 2018 00:51:29 +0800
Message-Id: <0f7cbde6462150c6ddb058d89d59ce35c3d6da9f.1539579760.git.ren_guo@c-sky.com>
In-Reply-To: <7becd836e1477d7ac2d3f8538a6d7f5b9651c389.1539579760.git.ren_guo@c-sky.com>
References: <7becd836e1477d7ac2d3f8538a6d7f5b9651c389.1539579760.git.ren_guo@c-sky.com>
In-Reply-To: <7becd836e1477d7ac2d3f8538a6d7f5b9651c389.1539579760.git.ren_guo@c-sky.com>
References: <7becd836e1477d7ac2d3f8538a6d7f5b9651c389.1539579760.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: daniel.lezcano@linaro.org, tglx@linutronix.de
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>

Dt-bingdings doc for C-SKY SMP system setting.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changelog:
 - Drop the interrupt-parent.
---
---
 .../devicetree/bindings/timer/csky,mptimer.txt     | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt

diff --git a/Documentation/devicetree/bindings/timer/csky,mptimer.txt b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
new file mode 100644
index 0000000..15cfec0
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
@@ -0,0 +1,42 @@
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
+	Description: Describes SMP timer
+
+	PROPERTIES
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,mptimer"
+	- clocks
+		Usage: required
+		Value type: <node>
+		Definition: must be input clk node
+	- interrupts
+		Usage: required
+		Value type: <u32>
+		Definition: must be timer irq num defined by soc
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
