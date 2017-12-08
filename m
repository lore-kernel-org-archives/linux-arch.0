From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v3 29/33] dt-bindings: nds32 CPU Bindings
Date: Fri,  8 Dec 2017 17:12:12 +0800
Message-ID: <b082ead87b647f6f0797e51d3ceeaf6c87038dd1.1512723245.git.green.hu@gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1512723245.git.green.hu@gmail.com>
In-Reply-To: <cover.1512723245.git.green.hu@gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>, Rick Chen <rick@andestech.com>, Zong Li <zong@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch adds nds32 CPU binding documents.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Rick Chen <rick@andestech.com>
Signed-off-by: Zong Li <zong@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 Documentation/devicetree/bindings/nds32/cpus.txt |   37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt

diff --git a/Documentation/devicetree/bindings/nds32/cpus.txt b/Documentation/devicetree/bindings/nds32/cpus.txt
new file mode 100644
index 0000000..9a52937
--- /dev/null
+++ b/Documentation/devicetree/bindings/nds32/cpus.txt
@@ -0,0 +1,37 @@
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
+		Definition: should be one of:
+			"andestech,n13"
+			"andestech,n15"
+			"andestech,d15"
+			"andestech,n10"
+			"andestech,d10"
+			"andestech,nds32v3"
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
1.7.9.5
