Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:50239 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754401AbdKHGVN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 01:21:13 -0500
From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH 30/31] dt-bindings: nds32 CPU Bindings
Date: Wed,  8 Nov 2017 13:55:18 +0800
Message-ID: <1a8efba0727437d510d10755f3fcea806833651d.1510118606.git.green.hu@gmail.com>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>, Rick Chen <rick@andestech.com>, Zong Li <zong@andestech.com>
Message-ID: <20171108055518.xzg7TMmgYHb-5QVtNLt9KMxRqIVg8r1-9fQ997MQ5JE@z>

From: Greentime Hu <greentime@andestech.com>

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Rick Chen <rick@andestech.com>
Signed-off-by: Zong Li <zong@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 Documentation/devicetree/bindings/nds32/cpus.txt |   33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt

diff --git a/Documentation/devicetree/bindings/nds32/cpus.txt b/Documentation/devicetree/bindings/nds32/cpus.txt
new file mode 100644
index 0000000..97394cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/nds32/cpus.txt
@@ -0,0 +1,33 @@
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
+
+    - device_type
+		Usage: required
+		Value type: <string>
+		Definition: must be "cpu"
+
+* Examples
+
+/ {
+	cpus {
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "andestech,n13", "andestech,n15";
+		};
+	};
+};
-- 
1.7.9.5
