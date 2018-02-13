Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45846 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933837AbeBMJN1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Feb 2018 04:13:27 -0500
From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 35/37] dt-bindings: interrupt-controller: Andestech Internal Vector Interrupt Controller
Date: Tue, 13 Feb 2018 17:09:39 +0800
Message-ID: <3fd9703061e1093ed5f678a98ad6caf17c2930eb.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Rick Chen <rick@andestech.com>
Message-ID: <20180213090939._8bxbQ1K74P7wUsiXbRHQOIKEUiiSk-SNs29bRvLnFE@z>

This patch adds an irqchip driver document for the Andestech Internal Vector
Interrupt Controller.

Signed-off-by: Rick Chen <rick@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 .../interrupt-controller/andestech,ativic32.txt       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt b/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
new file mode 100644
index 000000000000..f4b4193d830e
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
2.16.1
