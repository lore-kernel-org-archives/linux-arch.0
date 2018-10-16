From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V9 18/21] dt-bindings: csky CPU Bindings
Date: Tue, 16 Oct 2018 10:58:37 +0800
Message-ID: <867b2328e3dbaef58d0b5e7fc58e8545d1510951.1539655732.git.ren_guo@c-sky.com>
References: <cover.1539655731.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1539655731.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1539655731.git.ren_guo@c-sky.com>
References: <cover.1539655731.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, hch@infradead.org, marc.zyngier@arm.com, mark.rutland@arm.com, peterz@infradead.org, robh@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

This patch adds the documentation to describe that how to add cpu nodes in
dts for SMP.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Rob Herring <robh@kernel.org>
---
Changelog:
 - Add compatible.
 - Remove status part.
---
---
 Documentation/devicetree/bindings/csky/cpus.txt | 73 +++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt

diff --git a/Documentation/devicetree/bindings/csky/cpus.txt b/Documentation/devicetree/bindings/csky/cpus.txt
new file mode 100644
index 0000000..ae79412
--- /dev/null
+++ b/Documentation/devicetree/bindings/csky/cpus.txt
@@ -0,0 +1,73 @@
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
+	Description: Container of cpu nodes
+
+	The node name must be "cpus".
+
+	A cpus node must define the following properties:
+
+	- #address-cells
+		Usage: required
+		Value type: <u32>
+		Definition: must be set to 1
+	- #size-cells
+		Usage: required
+		Value type: <u32>
+		Definition: must be set to 0
+
+- cpu node
+
+	Description: Describes one of SMP cores
+
+	PROPERTIES
+
+	- device_type
+		Usage: required
+		Value type: <string>
+		Definition: must be "cpu"
+	- reg
+		Usage: required
+		Value type: <u32>
+		Definition: CPU index
+	- compatible:
+		Usage: required
+		Value type: <string>
+		Definition: must contain "csky", eg:
+			"csky,610"
+			"csky,807"
+			"csky,810"
+			"csky,860"
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
