From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 29/35] dt-bindings: nds32 CPU Bindings
Date: Mon, 27 Nov 2017 20:28:16 +0800
Message-ID: <20a04f4a5b08dcec221e0c511e42ff3df711ae66.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>, Rick Chen <rick@andestech.com>, Zong Li <zong@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch adds nds32 CPU binding documents.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Rick Chen <rick@andestech.com>
Signed-off-by: Zong Li <zong@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 Documentation/devicetree/bindings/nds32/cpus.txt |   32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt

diff --git a/Documentation/devicetree/bindings/nds32/cpus.txt b/Documentation/devicetree/bindings/nds32/cpus.txt
new file mode 100644
index 0000000..c302c89
--- /dev/null
+++ b/Documentation/devicetree/bindings/nds32/cpus.txt
@@ -0,0 +1,32 @@
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
+	- clock-frequency: Contains the clock frequency for CPU, in Hz.
+
+* Examples
+
+/ {
+	cpu {
+		device_type = "cpu";
+		compatible = "andestech,n13", "andestech,nds32v3";
+	};
+};
-- 
1.7.9.5
