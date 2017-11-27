Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39431 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752736AbdK0My4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 07:54:56 -0500
From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 26/35] dt-bindings: interrupt-controller: Andestech Internal Vector Interrupt Controller
Date: Mon, 27 Nov 2017 20:28:13 +0800
Message-ID: <d2539a0128f8c1cf0b32fd5151fd2f8775e5c511.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
Cc: green.hu@gmail.com, Rick Chen <rick@andestech.com>
Message-ID: <20171127122813.VQGGf6Ct1MXC76FyROpOuOP01j_Beu9jcjRmvP7-U3Q@z>

From: Greentime Hu <greentime@andestech.com>

This patch adds an irqchip driver document for the Andestech Internal Vector
Interrupt Controller.

Signed-off-by: Rick Chen <rick@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 .../interrupt-controller/andestech,ativic32.txt    |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt b/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
new file mode 100644
index 0000000..f4b4193
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
@@ -0,0 +1,19 @@
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
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells: 1 cells and refer to interrupt-controller/interrupts
+
+Examples:
+	intc: interrupt-controller {
+		compatible = "andestech,ativic32";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
-- 
1.7.9.5
