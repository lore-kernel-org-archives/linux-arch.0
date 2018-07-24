From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/4] ARC: DTS: mark DMA devices connected through IOC port as dma-coherent
Date: Tue, 24 Jul 2018 13:09:58 +0300
Message-ID: <20180724101001.31965-2-Eugeniy.Paltsev@synopsys.com>
References: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-arch.vger.kernel.org

Mark DMA devices on AXS103 and HSDK boards connected through IOC
port as dma-coherent.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/boot/dts/axc003.dtsi     | 26 ++++++++++++++++++++++++++
 arch/arc/boot/dts/axc003_idu.dtsi | 26 ++++++++++++++++++++++++++
 arch/arc/boot/dts/hsdk.dts        |  4 ++++
 3 files changed, 56 insertions(+)

diff --git a/arch/arc/boot/dts/axc003.dtsi b/arch/arc/boot/dts/axc003.dtsi
index dc91c663bcc0..d75d65ddf8e3 100644
--- a/arch/arc/boot/dts/axc003.dtsi
+++ b/arch/arc/boot/dts/axc003.dtsi
@@ -93,6 +93,32 @@
 		};
 	};
 
+	/*
+	 * Mark DMA peripherals connected via IOC port as dma-coherent. We do
+	 * it via overlay because peripherals defined in axs10x_mb.dtsi are
+	 * used for both AXS101 and AXS103 boards and only AXS103 has IOC (so
+	 * only AXS103 board has HW-coherent DMA peripherals)
+	 * We don't need to mark pgu@17000 as dma-coherent because it uses
+	 * external DMA buffer located outside of IOC aperture.
+	 */
+	axs10x_mb {
+		ethernet@0x18000 {
+			dma-coherent;
+		};
+
+		ehci@0x40000 {
+			dma-coherent;
+		};
+
+		ohci@0x60000 {
+			dma-coherent;
+		};
+
+		mmc@0x15000 {
+			dma-coherent;
+		};
+	};
+
 	/*
 	 * The DW APB ICTL intc on MB is connected to CPU intc via a
 	 * DT "invisible" DW APB GPIO block, configured to simply pass thru
diff --git a/arch/arc/boot/dts/axc003_idu.dtsi b/arch/arc/boot/dts/axc003_idu.dtsi
index 69ff4895f2ba..a05bb737ea63 100644
--- a/arch/arc/boot/dts/axc003_idu.dtsi
+++ b/arch/arc/boot/dts/axc003_idu.dtsi
@@ -100,6 +100,32 @@
 		};
 	};
 
+	/*
+	 * Mark DMA peripherals connected via IOC port as dma-coherent. We do
+	 * it via overlay because peripherals defined in axs10x_mb.dtsi are
+	 * used for both AXS101 and AXS103 boards and only AXS103 has IOC (so
+	 * only AXS103 board has HW-coherent DMA peripherals)
+	 * We don't need to mark pgu@17000 as dma-coherent because it uses
+	 * external DMA buffer located outside of IOC aperture.
+	 */
+	axs10x_mb {
+		ethernet@0x18000 {
+			dma-coherent;
+		};
+
+		ehci@0x40000 {
+			dma-coherent;
+		};
+
+		ohci@0x60000 {
+			dma-coherent;
+		};
+
+		mmc@0x15000 {
+			dma-coherent;
+		};
+	};
+
 	/*
 	 * This INTC is actually connected to DW APB GPIO
 	 * which acts as a wire between MB INTC and CPU INTC.
diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 006aa3de5348..ebb686c21393 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -176,6 +176,7 @@
 			phy-handle = <&phy0>;
 			resets = <&cgu_rst HSDK_ETH_RESET>;
 			reset-names = "stmmaceth";
+			dma-coherent;
 
 			mdio {
 				#address-cells = <1>;
@@ -194,12 +195,14 @@
 			compatible = "snps,hsdk-v1.0-ohci", "generic-ohci";
 			reg = <0x60000 0x100>;
 			interrupts = <15>;
+			dma-coherent;
 		};
 
 		ehci@40000 {
 			compatible = "snps,hsdk-v1.0-ehci", "generic-ehci";
 			reg = <0x40000 0x100>;
 			interrupts = <15>;
+			dma-coherent;
 		};
 
 		mmc@a000 {
@@ -212,6 +215,7 @@
 			clock-names = "biu", "ciu";
 			interrupts = <12>;
 			bus-width = <4>;
+			dma-coherent;
 		};
 	};
 
-- 
2.14.4
