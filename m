From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 26/28] ARC: [axs101] Prepare for AXS103
Date: Tue, 9 Jun 2015 17:18:26 +0530
Message-ID: <1433850508-26317-27-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33156 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933186AbbFILwy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:52:54 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>

From: Alexey Brodkin <abrodkin@synopsys.com>

To avoid duplicating the MB DTS file, move the MB intc entry into cpu
card specific file

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/boot/dts/axc001.dtsi    | 21 +++++++++++++++++++++
 arch/arc/boot/dts/axs10x_mb.dtsi | 17 -----------------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/arc/boot/dts/axc001.dtsi b/arch/arc/boot/dts/axc001.dtsi
index 6990ca45fc7b..a5e2726a067e 100644
--- a/arch/arc/boot/dts/axc001.dtsi
+++ b/arch/arc/boot/dts/axc001.dtsi
@@ -69,6 +69,27 @@
 		};
 	};
 
+	/*
+	 * This INTC is actually connected to DW APB GPIO
+	 * which acts as a wire between MB INTC and CPU INTC.
+	 * GPIO INTC is configured in platform init code
+	 * and here we mimic direct connection from MB INTC to
+	 * CPU INTC, thus we set "interrupts = <7>" instead of
+	 * "interrupts = <12>"
+	 *
+	 * This intc actually resides on MB, but we move it here to
+	 * avoid duplicating the MB dtsi file given that IRQ from
+	 * this intc to cpu intc are different for axs101 and axs103
+	 */
+	mb_intc: dw-apb-ictl@0xe0012000 {
+		#interrupt-cells = <1>;
+		compatible = "snps,dw-apb-ictl";
+		reg = < 0xe0012000 0x200 >;
+		interrupt-controller;
+		interrupt-parent = <&cpu_intc>;
+		interrupts = < 7 >;
+	};
+
 	memory {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arc/boot/dts/axs10x_mb.dtsi b/arch/arc/boot/dts/axs10x_mb.dtsi
index 5d06f1fb4266..f3db32154973 100644
--- a/arch/arc/boot/dts/axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/axs10x_mb.dtsi
@@ -36,23 +36,6 @@
 			};
 		};
 
-		/*
-		 * This INTC is actually connected to DW APB GPIO
-		 * which acts as a wire between MB INTC and CPU INTC.
-		 * GPIO INTC is configured in platform init code
-		 * and here we mimic direct connection from MB INTC to
-		 * CPU INTC, thus we set "interrupts = <7>" instead of
-		 * "interrupts = <12>"
-		 */
-		mb_intc: dw-apb-ictl@0x12000 {
-			#interrupt-cells = <1>;
-			compatible = "snps,dw-apb-ictl";
-			reg = < 0x12000 0x200 >;
-			interrupt-controller;
-			interrupt-parent = <&cpu_intc>;
-			interrupts = < 7 >;
-		};
-
 		ethernet@0x18000 {
 			#interrupt-cells = <1>;
 			compatible = "snps,dwmac";
-- 
1.9.1
