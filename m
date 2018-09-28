Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42211 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728691AbeI1HNp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Sep 2018 03:13:45 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V6 18/33] dt-bindings: csky CPU Bindings
Date: Fri, 28 Sep 2018 08:51:15 +0800
Message-ID: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20180928005115.AEYnBj02Uq2nVC8Tf4D92LbUDddpC0_NRfzYe4e4qn8@z>

This patch adds the documentation to describe that how to add cpu nodes in
dts for SMP.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 Documentation/devicetree/bindings/csky/cpus.txt | 70 +++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt

diff --git a/Documentation/devicetree/bindings/csky/cpus.txt b/Documentation/devicetree/bindings/csky/cpus.txt
new file mode 100644
index 0000000..ee3901d
--- /dev/null
+++ b/Documentation/devicetree/bindings/csky/cpus.txt
@@ -0,0 +1,70 @@
+==================
+C-SKY CPU Bindings
+==================
+
+The device tree allows to describe the layout of CPUs in a system through
+the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
+defining properties for every cpu.
+
+Only SMP system need to care about the cpus node and single processor
+needn't define cpus node at all.
+
+=====================================
+cpus and cpu node bindings definition
+=====================================
+
+- cpus node
+
+        Description: Container of cpu nodes
+
+        The node name must be "cpus".
+
+        A cpus node must define the following properties:
+
+        - #address-cells
+                Usage: required
+                Value type: <u32>
+                Definition: must be set to 1
+        - #size-cells
+                Usage: required
+                Value type: <u32>
+                Definition: must be set to 0
+
+- cpu node
+
+        Description: Describes one of SMP cores
+
+        PROPERTIES
+
+        - device_type
+                Usage: required
+                Value type: <string>
+                Definition: must be "cpu"
+        - reg
+                Usage: required
+                Value type: <u32>
+                Definition: CPU index
+        - status:
+                Usage: required
+                Value type: <string>
+                Definition: "ok"       means enable  the cpu-core
+                            "disabled" means disable the cpu-core
+
+Example:
+--------
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			device_type = "cpu";
+			reg = <0>;
+			status = "ok";
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			reg = <1>;
+			status = "ok";
+		};
+	};
-- 
2.7.4
