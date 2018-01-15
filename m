From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v6 32/36] dt-bindings: nds32 L2 cache controller Bindings
Date: Mon, 15 Jan 2018 13:53:40 +0800
Message-ID: <11bba5e5107a0b434f0ae19775fef8d36ccd7246.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1515766253.git.green.hu@gmail.com>
In-Reply-To: <cover.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch adds nds32 L2 cache controller binding documents.

Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/nds32/atl2c.txt |   29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nds32/atl2c.txt

diff --git a/Documentation/devicetree/bindings/nds32/atl2c.txt b/Documentation/devicetree/bindings/nds32/atl2c.txt
new file mode 100644
index 0000000..6b34e04
--- /dev/null
+++ b/Documentation/devicetree/bindings/nds32/atl2c.txt
@@ -0,0 +1,29 @@
+* Andestech L2 cache Controller
+
+The level-2 cache controller plays an important role in reducing memory latency
+for high performance systems, such as thoese designs with AndesCore processors.
+Level-2 cache controller in general enhances overall system performance
+signigicantly and the system power consumption might be reduced as well by
+reducing DRAM accesses.
+
+This binding specifies what properties must be available in the device tree
+representation of an Andestech L2 cache controller.
+
+Required properties:
+	- compatible:
+		Usage: required
+		Value type: <string>
+		Definition: "andestech,atl2c"
+	- reg : Physical base address and size of cache controller's memory mapped
+	- cache-unified : Specifies the cache is a unified cache.
+	- cache-level : Should be set to 2 for a level 2 cache.
+
+* Example
+
+	cache-controller@e0500000 {
+		compatible = "andestech,atl2c";
+		reg = <0xe0500000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
-- 
1.7.9.5
