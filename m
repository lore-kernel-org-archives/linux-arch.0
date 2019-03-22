Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-12.nifty.com ([210.131.2.79]:22715 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfCVPPM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Mar 2019 11:15:12 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] treewide: replace #include <asm/sizes.h> with #include <linux/sizes.h>
Date: Sat, 23 Mar 2019 00:14:24 +0900
Message-ID: <1553267665-27228-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>
Message-ID: <20190322151424.KYfi_pWEm2USBI8PXchP0UbkbjtQH0UmullQgJVUpDA@z>

Since dccd2304cc90 ("ARM: 7430/1: sizes.h: move from asm-generic to
<linux/sizes.h>"), <asm/sizes.h> and <asm-generic/sizes.h> are just
wrappers of <linux/sizes.h>.

This commit replaces all <asm/sizes.h> and <asm-generic/sizes.h>
to prepare for the removal.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/common/sa1111.c                                | 2 +-
 arch/arm/mach-imx/devices/platform-fec.c                | 2 +-
 arch/arm/mach-imx/devices/platform-gpio_keys.c          | 2 +-
 arch/arm/mach-imx/devices/platform-imx2-wdt.c           | 2 +-
 arch/arm/mach-imx/devices/platform-mxc_nand.c           | 2 +-
 arch/arm/mach-imx/hardware.h                            | 2 +-
 arch/arm/mach-integrator/impd1.c                        | 2 +-
 arch/arm/mach-iop13xx/pci.c                             | 2 +-
 arch/arm/mach-iop13xx/tpmi.c                            | 2 +-
 arch/arm/mach-ixp4xx/common-pci.c                       | 2 +-
 arch/arm/mach-ks8695/include/mach/hardware.h            | 2 +-
 arch/arm/mach-omap1/include/mach/hardware.h             | 2 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c | 2 +-
 arch/arm/mach-prima2/common.c                           | 2 +-
 arch/arm/mach-pxa/balloon3.c                            | 2 +-
 arch/arm/mach-pxa/colibri-pxa270.c                      | 2 +-
 arch/arm/mach-pxa/colibri-pxa300.c                      | 2 +-
 arch/arm/mach-pxa/colibri-pxa320.c                      | 2 +-
 arch/arm/mach-pxa/colibri-pxa3xx.c                      | 2 +-
 arch/arm/mach-pxa/gumstix.c                             | 2 +-
 arch/arm/mach-pxa/lpd270.c                              | 2 +-
 arch/arm/mach-pxa/lubbock.c                             | 2 +-
 arch/arm/mach-pxa/mainstone.c                           | 2 +-
 arch/arm/mach-pxa/trizeps4.c                            | 2 +-
 arch/arm/mach-pxa/viper.c                               | 2 +-
 arch/arm/mach-s3c24xx/include/mach/hardware.h           | 2 +-
 arch/arm/mach-sa1100/include/mach/memory.h              | 2 +-
 arch/arm/mach-sa1100/neponset.c                         | 2 +-
 arch/arm/mach-tegra/iomap.h                             | 2 +-
 arch/arm/mach-tegra/irammap.h                           | 2 +-
 arch/arm/mach-w90x900/include/mach/hardware.h           | 2 +-
 arch/arm64/include/asm/boot.h                           | 2 +-
 arch/arm64/include/asm/memory.h                         | 2 +-
 arch/arm64/mm/init.c                                    | 2 +-
 arch/arm64/mm/mmu.c                                     | 2 +-
 arch/nds32/include/asm/pgtable.h                        | 2 +-
 arch/nds32/kernel/head.S                                | 2 +-
 arch/sh/boards/board-apsh4a3a.c                         | 2 +-
 arch/sh/boards/board-apsh4ad0a.c                        | 2 +-
 arch/sh/boards/board-edosk7705.c                        | 2 +-
 arch/sh/boards/board-edosk7760.c                        | 2 +-
 arch/sh/boards/board-espt.c                             | 2 +-
 arch/sh/boards/board-urquell.c                          | 2 +-
 arch/sh/boards/mach-microdev/setup.c                    | 2 +-
 arch/sh/boards/mach-sdk7786/fpga.c                      | 2 +-
 arch/sh/boards/mach-sdk7786/setup.c                     | 2 +-
 arch/sh/boards/mach-sdk7786/sram.c                      | 2 +-
 arch/sh/boards/mach-se/7343/irq.c                       | 2 +-
 arch/sh/boards/mach-se/7722/irq.c                       | 2 +-
 arch/sh/drivers/pci/pci-sh7751.c                        | 2 +-
 arch/sh/drivers/pci/pci-sh7780.c                        | 2 +-
 arch/sh/drivers/pci/pcie-sh7786.c                       | 2 +-
 arch/sh/mm/init.c                                       | 2 +-
 arch/sh/mm/pmb.c                                        | 2 +-
 arch/sh/mm/uncached.c                                   | 2 +-
 arch/unicore32/include/asm/memory.h                     | 2 +-
 arch/unicore32/mm/init.c                                | 2 +-
 arch/unicore32/mm/ioremap.c                             | 2 +-
 arch/unicore32/mm/mmu.c                                 | 2 +-
 arch/x86/events/intel/bts.c                             | 2 +-
 drivers/gpu/drm/msm/msm_drv.h                           | 2 +-
 drivers/iommu/msm_iommu.c                               | 2 +-
 drivers/mmc/host/mvsdio.c                               | 2 +-
 drivers/mmc/host/pxamci.c                               | 2 +-
 drivers/mtd/maps/sa1100-flash.c                         | 2 +-
 drivers/pcmcia/omap_cf.c                                | 2 +-
 drivers/sh/intc/userimask.c                             | 2 +-
 drivers/video/fbdev/fb-puv3.c                           | 2 +-
 68 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 45412d2..179ca87 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -32,7 +32,7 @@
 #include <mach/hardware.h>
 #include <asm/mach/irq.h>
 #include <asm/mach-types.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include <asm/hardware/sa1111.h>
 
diff --git a/arch/arm/mach-imx/devices/platform-fec.c b/arch/arm/mach-imx/devices/platform-fec.c
index b403a4f..605c0af 100644
--- a/arch/arm/mach-imx/devices/platform-fec.c
+++ b/arch/arm/mach-imx/devices/platform-fec.c
@@ -7,7 +7,7 @@
  * Free Software Foundation.
  */
 #include <linux/dma-mapping.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include "../hardware.h"
 #include "devices-common.h"
diff --git a/arch/arm/mach-imx/devices/platform-gpio_keys.c b/arch/arm/mach-imx/devices/platform-gpio_keys.c
index 4862825..9f0a132 100644
--- a/arch/arm/mach-imx/devices/platform-gpio_keys.c
+++ b/arch/arm/mach-imx/devices/platform-gpio_keys.c
@@ -15,7 +15,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor,
  * Boston, MA  02110-1301, USA.
  */
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include "../hardware.h"
 #include "devices-common.h"
diff --git a/arch/arm/mach-imx/devices/platform-imx2-wdt.c b/arch/arm/mach-imx/devices/platform-imx2-wdt.c
index 8c134c8..0c6d3c0 100644
--- a/arch/arm/mach-imx/devices/platform-imx2-wdt.c
+++ b/arch/arm/mach-imx/devices/platform-imx2-wdt.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include "../hardware.h"
 #include "devices-common.h"
diff --git a/arch/arm/mach-imx/devices/platform-mxc_nand.c b/arch/arm/mach-imx/devices/platform-mxc_nand.c
index 676df49..046e0cc 100644
--- a/arch/arm/mach-imx/devices/platform-mxc_nand.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_nand.c
@@ -6,7 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include "../hardware.h"
 #include "devices-common.h"
diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
index 90e10cb..b5ca8ceb 100644
--- a/arch/arm/mach-imx/hardware.h
+++ b/arch/arm/mach-imx/hardware.h
@@ -24,7 +24,7 @@
 #include <asm/io.h>
 #include <soc/imx/revision.h>
 #endif
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #define addr_in_module(addr, mod) \
 	((unsigned long)(addr) - mod ## _BASE_ADDR < mod ## _SIZE)
diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 8dfad01..6ddbe15 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -27,7 +27,7 @@
 #include <linux/irqchip/arm-vic.h>
 #include <linux/gpio/machine.h>
 
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include "lm.h"
 #include "impd1.h"
 
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index 070d92a..8426ab9 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -24,7 +24,7 @@
 #include <linux/export.h>
 #include <asm/irq.h>
 #include <mach/hardware.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/signal.h>
 #include <asm/mach/pci.h>
 #include "pci.h"
diff --git a/arch/arm/mach-iop13xx/tpmi.c b/arch/arm/mach-iop13xx/tpmi.c
index db511ec..e2270e7 100644
--- a/arch/arm/mach-iop13xx/tpmi.c
+++ b/arch/arm/mach-iop13xx/tpmi.c
@@ -23,7 +23,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <asm/irq.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <mach/irqs.h>
 
 /* assumes CONTROLLER_ONLY# is never asserted in the ESSR register */
diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 6835b17..a53104b 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -31,7 +31,7 @@
 
 #include <asm/cputype.h>
 #include <asm/irq.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/mach/pci.h>
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-ks8695/include/mach/hardware.h b/arch/arm/mach-ks8695/include/mach/hardware.h
index 959c748..877629b 100644
--- a/arch/arm/mach-ks8695/include/mach/hardware.h
+++ b/arch/arm/mach-ks8695/include/mach/hardware.h
@@ -14,7 +14,7 @@
 #ifndef __ASM_ARCH_HARDWARE_H
 #define __ASM_ARCH_HARDWARE_H
 
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 /*
  * Clocks are derived from MCLK, which is 25MHz
diff --git a/arch/arm/mach-omap1/include/mach/hardware.h b/arch/arm/mach-omap1/include/mach/hardware.h
index 5875a50..e7c8ac7 100644
--- a/arch/arm/mach-omap1/include/mach/hardware.h
+++ b/arch/arm/mach-omap1/include/mach/hardware.h
@@ -36,7 +36,7 @@
 #ifndef __ASM_ARCH_OMAP_HARDWARE_H
 #define __ASM_ARCH_OMAP_HARDWARE_H
 
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #ifndef __ASSEMBLER__
 #include <asm/types.h>
 #include <mach/soc.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
index 9b30b6b..e19f620 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -11,7 +11,7 @@
  * XXX handle crossbar/shared link difference for L3?
  * XXX these should be marked initdata for multi-OMAP kernels
  */
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include "omap_hwmod.h"
 #include "l3_2xxx.h"
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index ffe05c2..1607dea 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -8,7 +8,7 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <linux/of.h>
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 4bcbd3d..1f24e02 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -35,7 +35,7 @@
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index e68acdd..510625d 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -24,7 +24,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach-types.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include <mach/audio.h>
 #include "colibri.h"
diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
index 6a5558d..2f635bd 100644
--- a/arch/arm/mach-pxa/colibri-pxa300.c
+++ b/arch/arm/mach-pxa/colibri-pxa300.c
@@ -18,7 +18,7 @@
 #include <linux/interrupt.h>
 
 #include <asm/mach-types.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
index 17067a3..ffcefe6 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -19,7 +19,7 @@
 #include <linux/usb/gpio_vbus.h>
 
 #include <asm/mach-types.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c b/arch/arm/mach-pxa/colibri-pxa3xx.c
index e31a591..0c88e4e 100644
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
@@ -17,7 +17,7 @@
 #include <linux/etherdevice.h>
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/system_info.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index 4764acc..eb03283 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -33,7 +33,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index e9f401b..5c03c4f 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -33,7 +33,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index c1bd0d5..8259398 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -39,7 +39,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index d6e17d4..b3f8592 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -40,7 +40,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index c76f1da..99a2ee4 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -35,7 +35,7 @@
 #include <asm/memory.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index ab2f892..c4c25a2 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -58,7 +58,7 @@
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/system_info.h>
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-s3c24xx/include/mach/hardware.h b/arch/arm/mach-s3c24xx/include/mach/hardware.h
index 1b29757..f28ac6c 100644
--- a/arch/arm/mach-s3c24xx/include/mach/hardware.h
+++ b/arch/arm/mach-s3c24xx/include/mach/hardware.h
@@ -15,7 +15,7 @@ extern unsigned int s3c2410_modify_misccr(unsigned int clr, unsigned int chg);
 
 #endif /* __ASSEMBLY__ */
 
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <mach/map.h>
 
 #endif /* __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-sa1100/include/mach/memory.h b/arch/arm/mach-sa1100/include/mach/memory.h
index fa5cf47..3b19296 100644
--- a/arch/arm/mach-sa1100/include/mach/memory.h
+++ b/arch/arm/mach-sa1100/include/mach/memory.h
@@ -8,7 +8,7 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 /*
  * Because of the wide memory address space between physical RAM banks on the
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index eb60a71..a671e4c 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -21,7 +21,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/hardware/sa1111.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include <mach/hardware.h>
 #include <mach/assabet.h>
diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
index 9bc291e..4af9e92 100644
--- a/arch/arm/mach-tegra/iomap.h
+++ b/arch/arm/mach-tegra/iomap.h
@@ -20,7 +20,7 @@
 #define __MACH_TEGRA_IOMAP_H
 
 #include <asm/pgtable.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #define TEGRA_IRAM_BASE			0x40000000
 #define TEGRA_IRAM_SIZE			SZ_256K
diff --git a/arch/arm/mach-tegra/irammap.h b/arch/arm/mach-tegra/irammap.h
index e32e174..6a7bb88 100644
--- a/arch/arm/mach-tegra/irammap.h
+++ b/arch/arm/mach-tegra/irammap.h
@@ -17,7 +17,7 @@
 #ifndef __MACH_TEGRA_IRAMMAP_H
 #define __MACH_TEGRA_IRAMMAP_H
 
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 /* The first 1K of IRAM is permanently reserved for the CPU reset handler */
 #define TEGRA_IRAM_RESET_HANDLER_OFFSET	0
diff --git a/arch/arm/mach-w90x900/include/mach/hardware.h b/arch/arm/mach-w90x900/include/mach/hardware.h
index fe3c626..2e6555d 100644
--- a/arch/arm/mach-w90x900/include/mach/hardware.h
+++ b/arch/arm/mach-w90x900/include/mach/hardware.h
@@ -18,7 +18,7 @@
 #ifndef __ASM_ARCH_HARDWARE_H
 #define __ASM_ARCH_HARDWARE_H
 
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <mach/map.h>
 
 #endif /* __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
index 355e552..c7f67da 100644
--- a/arch/arm64/include/asm/boot.h
+++ b/arch/arm64/include/asm/boot.h
@@ -3,7 +3,7 @@
 #ifndef __ASM_BOOT_H
 #define __ASM_BOOT_H
 
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 /*
  * arm64 requires the DTB to be 8 byte aligned and
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 2901951..f747838 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -26,7 +26,7 @@
 #include <linux/types.h>
 #include <asm/bug.h>
 #include <asm/page-def.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 /*
  * Size of the PCI I/O space. This must remain a power of two so that
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 6bc1350..3483999 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -48,7 +48,7 @@
 #include <asm/numa.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/tlb.h>
 #include <asm/alternative.h>
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e97f018..e6acfa7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -40,7 +40,7 @@
 #include <asm/kernel-pgtable.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/tlb.h>
 #include <asm/mmu_context.h>
 #include <asm/ptdump.h>
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index 9f52db9..ee59c1f 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -6,7 +6,7 @@
 
 #define __PAGETABLE_PMD_FOLDED 1
 #include <asm-generic/4level-fixup.h>
-#include <asm-generic/sizes.h>
+#include <linux/sizes.h>
 
 #include <asm/memory.h>
 #include <asm/nds32.h>
diff --git a/arch/nds32/kernel/head.S b/arch/nds32/kernel/head.S
index db64b78..fcefb62 100644
--- a/arch/nds32/kernel/head.S
+++ b/arch/nds32/kernel/head.S
@@ -7,7 +7,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/thread_info.h>
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
diff --git a/arch/sh/boards/board-apsh4a3a.c b/arch/sh/boards/board-apsh4a3a.c
index 346eda7..abf19a9 100644
--- a/arch/sh/boards/board-apsh4a3a.c
+++ b/arch/sh/boards/board-apsh4a3a.c
@@ -16,7 +16,7 @@
 #include <linux/irq.h>
 #include <linux/clk.h>
 #include <asm/machvec.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/clock.h>
 
 static struct mtd_partition nor_flash_partitions[] = {
diff --git a/arch/sh/boards/board-apsh4ad0a.c b/arch/sh/boards/board-apsh4ad0a.c
index 4efa9c5..fa031a1 100644
--- a/arch/sh/boards/board-apsh4ad0a.c
+++ b/arch/sh/boards/board-apsh4ad0a.c
@@ -15,7 +15,7 @@
 #include <linux/irq.h>
 #include <linux/clk.h>
 #include <asm/machvec.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 /* Dummy supplies, where voltage doesn't matter */
 static struct regulator_consumer_supply dummy_supplies[] = {
diff --git a/arch/sh/boards/board-edosk7705.c b/arch/sh/boards/board-edosk7705.c
index 67a8803..0de7d60 100644
--- a/arch/sh/boards/board-edosk7705.c
+++ b/arch/sh/boards/board-edosk7705.c
@@ -16,7 +16,7 @@
 #include <linux/smc91x.h>
 #include <linux/sh_intc.h>
 #include <asm/machvec.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #define SMC_IOBASE	0xA2000000
 #define SMC_IO_OFFSET	0x300
diff --git a/arch/sh/boards/board-edosk7760.c b/arch/sh/boards/board-edosk7760.c
index 0fbe91c..7569d85 100644
--- a/arch/sh/boards/board-edosk7760.c
+++ b/arch/sh/boards/board-edosk7760.c
@@ -18,7 +18,7 @@
 #include <asm/addrspace.h>
 #include <asm/delay.h>
 #include <asm/i2c-sh7760.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 /* Bus state controller registers for CS4 area */
 #define BSC_CS4BCR	0xA4FD0010
diff --git a/arch/sh/boards/board-espt.c b/arch/sh/boards/board-espt.c
index f478fee..6e784b5 100644
--- a/arch/sh/boards/board-espt.c
+++ b/arch/sh/boards/board-espt.c
@@ -13,7 +13,7 @@
 #include <linux/sh_eth.h>
 #include <linux/sh_intc.h>
 #include <asm/machvec.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 /* NOR Flash */
 static struct mtd_partition espt_nor_flash_partitions[] = {
diff --git a/arch/sh/boards/board-urquell.c b/arch/sh/boards/board-urquell.c
index 799af57..dad2b3b 100644
--- a/arch/sh/boards/board-urquell.c
+++ b/arch/sh/boards/board-urquell.c
@@ -21,7 +21,7 @@
 #include <mach/urquell.h>
 #include <cpu/sh7786.h>
 #include <asm/heartbeat.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/smp-ops.h>
 
 /*
diff --git a/arch/sh/boards/mach-microdev/setup.c b/arch/sh/boards/mach-microdev/setup.c
index 706b48f..f4a777f 100644
--- a/arch/sh/boards/mach-microdev/setup.c
+++ b/arch/sh/boards/mach-microdev/setup.c
@@ -15,7 +15,7 @@
 #include <mach/microdev.h>
 #include <asm/io.h>
 #include <asm/machvec.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 static struct resource smc91x_resources[] = {
 	[0] = {
diff --git a/arch/sh/boards/mach-sdk7786/fpga.c b/arch/sh/boards/mach-sdk7786/fpga.c
index 6d2a3d3..895576ff 100644
--- a/arch/sh/boards/mach-sdk7786/fpga.c
+++ b/arch/sh/boards/mach-sdk7786/fpga.c
@@ -8,7 +8,7 @@
 #include <linux/io.h>
 #include <linux/bcd.h>
 #include <mach/fpga.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #define FPGA_REGS_OFFSET	0x03fff800
 #define FPGA_REGS_SIZE		0x490
diff --git a/arch/sh/boards/mach-sdk7786/setup.c b/arch/sh/boards/mach-sdk7786/setup.c
index 65721c3..d183026 100644
--- a/arch/sh/boards/mach-sdk7786/setup.c
+++ b/arch/sh/boards/mach-sdk7786/setup.c
@@ -19,7 +19,7 @@
 #include <mach/irq.h>
 #include <asm/machvec.h>
 #include <asm/heartbeat.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/clock.h>
 #include <asm/reboot.h>
 #include <asm/smp-ops.h>
diff --git a/arch/sh/boards/mach-sdk7786/sram.c b/arch/sh/boards/mach-sdk7786/sram.c
index d76cdb7..7c6ca97 100644
--- a/arch/sh/boards/mach-sdk7786/sram.c
+++ b/arch/sh/boards/mach-sdk7786/sram.c
@@ -13,7 +13,7 @@
 #include <linux/string.h>
 #include <mach/fpga.h>
 #include <asm/sram.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 static int __init fpga_sram_init(void)
 {
diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
index 39a3175..1aedbfe 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -16,7 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <mach-se/mach/se7343.h>
 
 #define PA_CPLD_BASE_ADDR	0x11400000
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index f6e3009..6d34592 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -14,7 +14,7 @@
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/err.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <mach-se/mach/se7722.h>
 
 #define IRQ01_BASE_ADDR	0x11800000
diff --git a/arch/sh/drivers/pci/pci-sh7751.c b/arch/sh/drivers/pci/pci-sh7751.c
index 1b9e5ca..11ed21c 100644
--- a/arch/sh/drivers/pci/pci-sh7751.c
+++ b/arch/sh/drivers/pci/pci-sh7751.c
@@ -14,7 +14,7 @@
 #include <linux/io.h>
 #include "pci-sh4.h"
 #include <asm/addrspace.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 static int __init __area_sdram_check(struct pci_channel *chan,
 				     unsigned int area)
diff --git a/arch/sh/drivers/pci/pci-sh7780.c b/arch/sh/drivers/pci/pci-sh7780.c
index 3fd0f39..287b3a6 100644
--- a/arch/sh/drivers/pci/pci-sh7780.c
+++ b/arch/sh/drivers/pci/pci-sh7780.c
@@ -16,7 +16,7 @@
 #include <linux/log2.h>
 #include "pci-sh4.h"
 #include <asm/mmu.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #if defined(CONFIG_CPU_BIG_ENDIAN)
 # define PCICR_ENDIANNESS SH4_PCICR_BSWP
diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index a58b77c..e0b568a 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -18,7 +18,7 @@
 #include <linux/sh_intc.h>
 #include <cpu/sh7786.h>
 #include "pcie-sh7786.h"
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 struct sh7786_pcie_port {
 	struct pci_channel	*hose;
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 7062132..77a80d4 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -26,7 +26,7 @@
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/cache.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index 7b2cc49..a53a040 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -24,7 +24,7 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <asm/cacheflush.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <linux/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
diff --git a/arch/sh/mm/uncached.c b/arch/sh/mm/uncached.c
index 010010b..bd1585e 100644
--- a/arch/sh/mm/uncached.c
+++ b/arch/sh/mm/uncached.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/init.h>
 #include <linux/module.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/page.h>
 #include <asm/addrspace.h>
 
diff --git a/arch/unicore32/include/asm/memory.h b/arch/unicore32/include/asm/memory.h
index 66bb9f6..46cf27e 100644
--- a/arch/unicore32/include/asm/memory.h
+++ b/arch/unicore32/include/asm/memory.h
@@ -16,7 +16,7 @@
 
 #include <linux/compiler.h>
 #include <linux/const.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <mach/memory.h>
 
 /*
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index 74b6a2e..3288dacd 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -23,7 +23,7 @@
 
 #include <asm/sections.h>
 #include <asm/setup.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/tlb.h>
 #include <asm/memblock.h>
 #include <mach/map.h>
diff --git a/arch/unicore32/mm/ioremap.c b/arch/unicore32/mm/ioremap.c
index bf012b2..b69cb18 100644
--- a/arch/unicore32/mm/ioremap.c
+++ b/arch/unicore32/mm/ioremap.c
@@ -34,7 +34,7 @@
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include <mach/map.h>
 #include "mm.h"
diff --git a/arch/unicore32/mm/mmu.c b/arch/unicore32/mm/mmu.c
index aa2060b..f0ae623 100644
--- a/arch/unicore32/mm/mmu.c
+++ b/arch/unicore32/mm/mmu.c
@@ -22,7 +22,7 @@
 #include <asm/cputype.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/tlb.h>
 #include <asm/memblock.h>
 
diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 7cdd7b1..890a3fb 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -23,7 +23,7 @@
 #include <linux/device.h>
 #include <linux/coredump.h>
 
-#include <asm-generic/sizes.h>
+#include <linux/sizes.h>
 #include <asm/perf_event.h>
 
 #include "../perf_event.h"
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index c56dade..8a9f381 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -33,7 +33,7 @@
 #include <linux/types.h>
 #include <linux/of_graph.h>
 #include <linux/of_device.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <linux/kthread.h>
 
 #include <drm/drmP.h>
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 9fb0eb7..b4b87d6 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -34,7 +34,7 @@
 #include <linux/of_iommu.h>
 
 #include <asm/cacheflush.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include "msm_iommu_hw-8xxx.h"
 #include "msm_iommu.h"
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index e22bbff..9cb93e1 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -24,7 +24,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/slot-gpio.h>
 
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/unaligned.h>
 
 #include "mvsdio.h"
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index c907bf5..29d4e08 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -35,7 +35,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include <mach/hardware.h>
 #include <linux/platform_data/mmc-pxamci.h>
diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
index fd5fe12..8932396 100644
--- a/drivers/mtd/maps/sa1100-flash.c
+++ b/drivers/mtd/maps/sa1100-flash.c
@@ -20,7 +20,7 @@
 #include <linux/mtd/concat.h>
 
 #include <mach/hardware.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/mach/flash.h>
 
 struct sa_subdev_info {
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index c2a17a7..267fb87 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -22,7 +22,7 @@
 
 #include <mach/hardware.h>
 #include <asm/io.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 
 #include <mach/mux.h>
 #include <mach/tc.h>
diff --git a/drivers/sh/intc/userimask.c b/drivers/sh/intc/userimask.c
index e649cea..87d69e7 100644
--- a/drivers/sh/intc/userimask.c
+++ b/drivers/sh/intc/userimask.c
@@ -14,7 +14,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/stat.h>
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include "internals.h"
 
 static void __iomem *uimask;
diff --git a/drivers/video/fbdev/fb-puv3.c b/drivers/video/fbdev/fb-puv3.c
index d9e816d..1bddcc2 100644
--- a/drivers/video/fbdev/fb-puv3.c
+++ b/drivers/video/fbdev/fb-puv3.c
@@ -20,7 +20,7 @@
 #include <linux/console.h>
 #include <linux/mm.h>
 
-#include <asm/sizes.h>
+#include <linux/sizes.h>
 #include <asm/pgtable.h>
 #include <mach/hardware.h>
 
-- 
2.7.4
