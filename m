From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 32/37] dt-bindings: nds32 CPU Bindings
Date: Tue, 13 Feb 2018 17:09:36 +0800
Message-ID: <e08b102ed7e8c18e35e19652ec2db052f13105d0.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: netdev-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>, Rick Chen <rick@andestech.com>, Zong Li <zong@andestech.com>
List-Id: linux-arch.vger.kernel.org

This patch adds nds32 CPU binding documents.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Rick Chen <rick@andestech.com>
Signed-off-by: Zong Li <zong@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/nds32/cpus.txt | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt

diff --git a/Documentation/devicetree/bindings/nds32/cpus.txt b/Documentation/devicetree/bindings/nds32/cpus.txt
new file mode 100644
index 000000000000..6f9e311b6589
--- /dev/null
+++ b/Documentation/devicetree/bindings/nds32/cpus.txt
@@ -0,0 +1,38 @@
+* Andestech Processor Binding
+
+This binding specifies what properties must be available in the device tree
+representation of a Andestech Processor Core, which is the root node in the
+tree.
+
+Required properties:
+
+	- compatible:
+		Usage: required
+		Value type: <string>
+		Definition: Should be "andestech,<core_name>", "andestech,nds32v3" as fallback.
+		Must contain "andestech,nds32v3" as the most generic value, in addition to
+		one of the following identifiers for a particular CPU core:
+		"andestech,n13"
+		"andestech,n15"
+		"andestech,d15"
+		"andestech,n10"
+		"andestech,d10"
+	- device_type
+		Usage: required
+		Value type: <string>
+		Definition: must be "cpu"
+	- reg: Contains CPU index.
+	- clock-frequency: Contains the clock frequency for CPU, in Hz.
+
+* Examples
+
+/ {
+	cpus {
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "andestech,n13", "andestech,nds32v3";
+			reg = <0x0>;
+			clock-frequency = <60000000>
+		};
+	};
+};
-- 
2.16.1
