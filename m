From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 34/37] dt-bindings: nds32 SoC Bindings
Date: Tue, 13 Feb 2018 17:09:38 +0800
Message-ID: <d8d6fc1ab339328f6f7de9764a62b28bdf999c7a.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42556 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933975AbeBMJNW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Feb 2018 04:13:22 -0500
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com

This patch adds nds32 SoC(AE3XX and AG101P) binding documents.

Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 .../devicetree/bindings/nds32/andestech-boards     | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nds32/andestech-boards

diff --git a/Documentation/devicetree/bindings/nds32/andestech-boards b/Documentation/devicetree/bindings/nds32/andestech-boards
new file mode 100644
index 000000000000..f5d75693e3c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/nds32/andestech-boards
@@ -0,0 +1,40 @@
+Andestech(nds32) AE3XX Platform
+-----------------------------------------------------------------------------
+The AE3XX prototype demonstrates the AE3XX example platform on the FPGA. It
+is composed of one Andestech(nds32) processor and AE3XX.
+
+Required properties (in root node):
+- compatible = "andestech,ae3xx";
+
+Example:
+/dts-v1/;
+/ {
+	compatible = "andestech,ae3xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+};
+
+Andestech(nds32) AG101P Platform
+-----------------------------------------------------------------------------
+AG101P is a generic SoC Platform IP that works with any of Andestech(nds32)
+processors to provide a cost-effective and high performance solution for
+majority of embedded systems in variety of application domains. Users may
+simply attach their IP on one of the system buses together with certain glue
+logics to complete a SoC solution for a specific application. With
+comprehensive simulation and design environments, users may evaluate the
+system performance of their applications and track bugs of their designs
+efficiently. The optional hardware development platform further provides real
+system environment for early prototyping and software/hardware co-development.
+
+Required properties (in root node):
+	compatible = "andestech,ag101p";
+
+Example:
+/dts-v1/;
+/ {
+	compatible = "andestech,ag101p";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+};
-- 
2.16.1
