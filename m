Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57748 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727946AbeKCB7c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Nov 2018 21:59:32 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V13 resend 4/4] dt-bindings: timer: gx6605s SOC timer
Date: Sat,  3 Nov 2018 00:51:31 +0800
Message-Id: <ad5c91023ae9bbb07aa0392882667a5a2b133fc5.1539579760.git.ren_guo@c-sky.com>
In-Reply-To: <7becd836e1477d7ac2d3f8538a6d7f5b9651c389.1539579760.git.ren_guo@c-sky.com>
References: <7becd836e1477d7ac2d3f8538a6d7f5b9651c389.1539579760.git.ren_guo@c-sky.com>
In-Reply-To: <7becd836e1477d7ac2d3f8538a6d7f5b9651c389.1539579760.git.ren_guo@c-sky.com>
References: <7becd836e1477d7ac2d3f8538a6d7f5b9651c389.1539579760.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: daniel.lezcano@linaro.org, tglx@linutronix.de
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>

Dt-bindings doc for gx6605s SOC's system timer.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/timer/csky,gx6605s-timer.txt          | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
new file mode 100644
index 0000000..6b04344
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
+	Description: Describes gx6605s SOC timer
+
+	PROPERTIES
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,gx6605s-timer"
+	- reg
+		Usage: required
+		Value type: <u32 u32>
+		Definition: <phyaddr size> in soc from cpu view
+	- clocks
+		Usage: required
+		Value type: phandle + clock specifier cells
+		Definition: must be input clk node
+	- interrupt
+		Usage: required
+		Value type: <u32>
+		Definition: must be timer irq num defined by soc
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
