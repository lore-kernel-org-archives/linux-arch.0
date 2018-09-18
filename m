From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 2/2] dt-bindings: interrupt-controller: C-SKY APB intc
Date: Tue, 18 Sep 2018 21:49:40 +0800
Message-ID: <db9c62a8c722b1ed82044d50091f3099d38ee2f3.1537276735.git.ren_guo@c-sky.com>
References: <cover.1537276735.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537276735.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537276735.git.ren_guo@c-sky.com>
References: <cover.1537276735.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

 - Dt-bindings doc about C-SKY apb bus interrupt controller.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../interrupt-controller/csky,apb-intc.txt         | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
new file mode 100644
index 0000000..be7c3d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
@@ -0,0 +1,70 @@
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
+        - support-pulse-signal:
+                Usage: select
+		Description: to support pulse signal flag
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
+
+	intc: interrupt-controller@500000 {
+		compatible = "csky,apb-intc";
+		#interrupt-cells = <1>;
+		reg = <0x00500000 0x400>;
+		interrupt-controller;
+		support-pulse-signal;
+	};
+
+	intc: interrupt-controller@500000 {
+		compatible = "csky,dual-apb-intc";
+		#interrupt-cells = <1>;
+		reg = <0x00500000 0x400>;
+		interrupt-controller;
+	};
+
+	intc: interrupt-controller@500000 {
+		compatible = "csky,gx6605s-intc";
+		#interrupt-cells = <1>;
+		reg = <0x00500000 0x400>;
+		interrupt-controller;
+	};
-- 
2.7.4
