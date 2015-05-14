From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH 2/4] ARC: [axs101] support early 8250 uart
Date: Thu, 14 May 2015 15:48:42 +0300
Message-ID: <1431607724-9142-3-git-send-email-abrodkin@synopsys.com>
References: <1431607724-9142-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431607724-9142-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, devicetree@vger.kernel.org, Vineet.Gupta1@synopsys.com
List-Id: linux-arch.vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

Earlycon calculates UART clock as "BASE_BAUD * 16". In case of ARC
"BASE_BAUD" is calculated dynamically in runtime, basically it is an
alias to arc_early_base_baud(), which in turn just does
"arc_base_baud/16".

8250 UART on AXS/SDP board uses 33.3MHz clock source which is set in
"arc_base_baud" with this change.

Additional compatibility string "snps,arc-sdp" is introduced as well
because there're different flavours of AXS boards but they all share the
same motherboard and so it's possible to re-use the same code for
motherbord even if CPU daughterboard changes.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 Documentation/devicetree/bindings/arc/axs10x.txt | 2 +-
 arch/arc/boot/dts/axs101.dts                     | 4 ++--
 arch/arc/kernel/devtree.c                        | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arc/axs10x.txt b/Documentation/devicetree/bindings/arc/axs10x.txt
index dcbb834..9021ab7 100644
--- a/Documentation/devicetree/bindings/arc/axs10x.txt
+++ b/Documentation/devicetree/bindings/arc/axs10x.txt
@@ -4,4 +4,4 @@ Synopsys DesignWare ARC Software Development Platforms Device Tree Bindings
 SDP boards with Synopsys ARC700 core shall have the following properties.
 
 Required root node properties:
-    - compatible = "snps,axs101";
+    - compatible = "snps,axs101", "snps,arc-sdp";
diff --git a/arch/arc/boot/dts/axs101.dts b/arch/arc/boot/dts/axs101.dts
index 6c3391d..3f9b058 100644
--- a/arch/arc/boot/dts/axs101.dts
+++ b/arch/arc/boot/dts/axs101.dts
@@ -13,9 +13,9 @@
 /include/ "axs10x_mb.dtsi"
 
 / {
-	compatible = "snps,axs101";
+	compatible = "snps,axs101", "snps,arc-sdp";
 
 	chosen {
-		bootargs = "console=tty0 console=ttyS3,115200n8 consoleblank=0";
+		bootargs = "earlycon=uart8250,mmio32,0xe0022000,115200n8 console=tty0 console=ttyS3,115200n8 consoleblank=0";
 	};
 };
diff --git a/arch/arc/kernel/devtree.c b/arch/arc/kernel/devtree.c
index e32b54a..f801d46 100644
--- a/arch/arc/kernel/devtree.c
+++ b/arch/arc/kernel/devtree.c
@@ -32,6 +32,8 @@ static void __init arc_set_early_base_baud(unsigned long dt_root)
 
 	if (of_flat_dt_is_compatible(dt_root, "abilis,arc-tb10x"))
 		arc_base_baud = core_clk/3;
+	else if (of_flat_dt_is_compatible(dt_root, "snps,arc-sdp"))
+		arc_base_baud = 33333333;	/* Fixed 33MHz clk */
 	else
 		arc_base_baud = core_clk;
 }
-- 
2.1.0
