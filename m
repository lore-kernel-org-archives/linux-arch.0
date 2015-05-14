From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH 4/4] ARC: [axs101] STAR 9000799830: Fix SD cards support
Date: Thu, 14 May 2015 15:48:44 +0300
Message-ID: <1431607724-9142-5-git-send-email-abrodkin@synopsys.com>
References: <1431607724-9142-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431607724-9142-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, devicetree@vger.kernel.org, Vineet.Gupta1@synopsys.com, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
List-Id: linux-arch.vger.kernel.org

As DW Mobile Storage databook says it's required to use "Hold Register"
if card is enumerated in SDR12 or SDR25 modes.
It means we need to act in the same way as in Altera's Socfpga
implementation - set "use hold reg" bit in commad.

Note that for upstream proper solution would be to remove
dw_mci_pltfm_prepare_command() at all and set the bit right in
dw_mci_prepare_command() for all platforms.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/boot/dts/axs10x_mb.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arc/boot/dts/axs10x_mb.dtsi b/arch/arc/boot/dts/axs10x_mb.dtsi
index 255c712..5d06f1f 100644
--- a/arch/arc/boot/dts/axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/axs10x_mb.dtsi
@@ -77,8 +77,26 @@
 			interrupts = < 8 >;
 		};
 
+		/*
+		 * According to DW Mobile Storage databook it is required
+		 * to use  "Hold Register" if card is enumerated in SDR12 or
+		 * SDR25 modes.
+		 *
+		 * Utilization of "Hold Register" is already implemented via
+		 * dw_mci_pltfm_prepare_command() which in its turn gets
+		 * used through dw_mci_drv_data->prepare_command call-back.
+		 * This call-back is used in Altera Socfpga platform and so
+		 * we may reuse it saying that we're compatible with their
+		 * "altr,socfpga-dw-mshc".
+		 *
+		 * Most probably "Hold Register" utilization is platform-
+		 * independent requirement which means that single unified
+		 * "snps,dw-mshc" should be enough for all users of DW MMC once
+		 * dw_mci_pltfm_prepare_command() is used in generic platform
+		 * code.
+		 */
 		mmc@0x15000 {
-			compatible = "snps,dw-mshc";
+			compatible = "altr,socfpga-dw-mshc";
 			reg = < 0x15000 0x400 >;
 			num-slots = < 1 >;
 			fifo-depth = < 16 >;
-- 
2.1.0
