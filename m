Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60844 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727997AbeIEQjF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Sep 2018 12:39:05 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V3 22/26] dt-bindings: interrupt-controller: C-SKY SMP intc
Date: Wed,  5 Sep 2018 20:08:01 +0800
Message-ID: <a82f72fd77a6c06d23e6d08acc9df2a816d6235d.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
Message-ID: <20180905120801.5YT_3K3N5IwFuUiBUvwXZw94kXXSF9mpLNa5SMCJjwE@z>

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../bindings/interrupt-controller/csky,mpintc.txt  | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
new file mode 100644
index 0000000..49d1658
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
@@ -0,0 +1,40 @@
+===========================================
+C-SKY Multi-processors Interrupt Controller
+===========================================
+
+C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
+SMP soc, and it also could be used in non-SMP system.
+
+Interrupt number definition:
+
+  0-15  : software irq, and we use 15 as our IPI_IRQ.
+ 16-31  : private  irq, and we use 16 as the co-processor timer.
+ 31-1024: common irq for soc ip.
+
+=============================
+intc node bindings definition
+=============================
+
+	Description: Describes SMP interrupt controller
+
+	PROPERTIES
+
+        - compatible
+		Usage: required
+                Value type: <string>
+                Definition: must be "csky,mpintc"
+        - interrupt-cells
+                Usage: required
+                Value type: <u32>
+                Definition: must be <1>
+        - interrupt-controller:
+                Usage: required
+
+Examples:
+---------
+
+	intc: interrupt-controller {
+		compatible = "csky,mpintc";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
-- 
2.7.4
