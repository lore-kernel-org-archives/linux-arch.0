From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 33/37] dt-bindings: nds32 L2 cache controller Bindings
Date: Tue, 13 Feb 2018 17:09:37 +0800
Message-ID: <98f2057a0a26cfba1220386ebb9a0c389ac9c95b.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44125 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933880AbeBMJNR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Feb 2018 04:13:17 -0500
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com

This patch adds nds32 L2 cache controller binding documents.

Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/devicetree/bindings/nds32/atl2c.txt | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nds32/atl2c.txt

diff --git a/Documentation/devicetree/bindings/nds32/atl2c.txt b/Documentation/devicetree/bindings/nds32/atl2c.txt
new file mode 100644
index 000000000000..da8ab8e7ae9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/nds32/atl2c.txt
@@ -0,0 +1,28 @@
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
-- 
2.16.1
