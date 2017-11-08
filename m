Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:49536 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754403AbdKHGVF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 01:21:05 -0500
From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH 27/31] dt-bindings: interrupt-controller: Andestech Internal Vector Interrupt Controller
Date: Wed,  8 Nov 2017 13:55:15 +0800
Message-ID: <a7b9f0a21bf6e0c3325a0d9a28a8503082cafd14.1510118606.git.green.hu@gmail.com>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org
Cc: green.hu@gmail.com, Rick Chen <rick@andestech.com>
Message-ID: <20171108055515.08CpbkIVrjol5UR_VCoLL9Tb-LEDE-Y84lefutWVY7c@z>

From: Greentime Hu <greentime@andestech.com>

Signed-off-by: Rick Chen <rick@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 .../interrupt-controller/andestech,ativic32.txt    |   27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt b/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
new file mode 100644
index 0000000..6bac908
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
@@ -0,0 +1,27 @@
+* Andestech Internal Vector Interrupt Controller
+
+The Internal Vector Interrupt Controller (IVIC) is a basic interrupt controller
+suitable for a simpler SoC platform not requiring a more sophisticated and
+bigger External Vector Interrupt Controller.
+
+
+Main node required properties:
+
+- compatible : should at least contain  "andestech,ativic32".
+- interrupt-parent: Empty for the interrupt controller itself
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells: The number of cells to define the interrupts. Should be 2.
+	The first cell is the IRQ number
+	The second cell is used to specify mode:
+		1 = low-to-high edge triggered
+		2 = high-to-low edge triggered
+		4 = active high level-sensitive
+		8 = active low level-sensitive
+		Default for internal sources should be set to 4 (active high).
+
+Examples:
+	intc: interrupt-controller {
+		compatible = "andestech,ativic32";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
-- 
1.7.9.5
