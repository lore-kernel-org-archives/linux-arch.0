From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] gpio: Include linux/gpio.h instead of asm/gpio.h
Date: Tue, 02 Feb 2016 13:53:23 -0600
Message-ID: <20160202195323.10827.26654.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58074 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933081AbcBBTx1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 2 Feb 2016 14:53:27 -0500
In-Reply-To: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org

Most arches have an asm/gpio.h that merely includes linux/gpio.h.  The
others select ARCH_HAVE_CUSTOM_GPIO_H, and when that's selected,
linux/gpio.h includes asm/gpio.h.

Therefore, code should include linux/gpio.h instead of including asm/gpio.h
directly.

Remove includes of asm/gpio.h, adding an include of linux/gpio.h when
necessary.

This is a follow-on to 7563bbf89d06 ("gpiolib/arches: Centralise
bolierplate asm/gpio.h").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/avr32/boards/merisc/setup.c                |    1 -
 arch/avr32/mach-at32ap/pio.c                    |    2 +-
 arch/blackfin/kernel/debug-mmrs.c               |    2 +-
 arch/blackfin/mach-bf538/boards/ezkit.c         |    2 +-
 arch/blackfin/mach-bf538/ext-gpio.c             |    2 +-
 arch/blackfin/mach-bf548/boards/cm_bf548.c      |    2 +-
 arch/blackfin/mach-bf548/boards/ezkit.c         |    2 +-
 arch/blackfin/mach-bf609/boards/ezkit.c         |    2 +-
 arch/blackfin/mach-common/ints-priority.c       |    2 +-
 arch/blackfin/mach-common/pm.c                  |    2 +-
 arch/sh/include/mach-common/mach/magicpanelr2.h |    2 +-
 drivers/ata/pata_at91.c                         |    3 +--
 drivers/ata/pata_bf54x.c                        |    2 +-
 drivers/gpio/gpio-mpc5200.c                     |    1 -
 drivers/mfd/menelaus.c                          |    2 +-
 drivers/mtd/onenand/omap2.c                     |    2 +-
 drivers/pcmcia/bfin_cf_pcmcia.c                 |    2 +-
 drivers/pcmcia/pxa2xx_vpac270.c                 |    1 -
 drivers/usb/gadget/udc/atmel_usba_udc.c         |    2 --
 drivers/usb/host/ohci-at91.c                    |    2 --
 drivers/video/fbdev/atmel_lcdfb.c               |    2 --
 drivers/video/fbdev/omap/lcd_h3.c               |    2 +-
 drivers/video/fbdev/omap/lcd_osk.c              |    3 +--
 drivers/video/fbdev/omap/lcd_palmtt.c           |    2 +-
 24 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/arch/avr32/boards/merisc/setup.c b/arch/avr32/boards/merisc/setup.c
index 83d896c..718a6d7 100644
--- a/arch/avr32/boards/merisc/setup.c
+++ b/arch/avr32/boards/merisc/setup.c
@@ -27,7 +27,6 @@
 
 #include <asm/io.h>
 #include <asm/setup.h>
-#include <asm/gpio.h>
 
 #include <mach/at32ap700x.h>
 #include <mach/board.h>
diff --git a/arch/avr32/mach-at32ap/pio.c b/arch/avr32/mach-at32ap/pio.c
index 5020057..83c2a00 100644
--- a/arch/avr32/mach-at32ap/pio.c
+++ b/arch/avr32/mach-at32ap/pio.c
@@ -14,8 +14,8 @@
 #include <linux/fs.h>
 #include <linux/platform_device.h>
 #include <linux/irq.h>
+#include <linux/gpio.h>
 
-#include <asm/gpio.h>
 #include <asm/io.h>
 
 #include <mach/portmux.h>
diff --git a/arch/blackfin/kernel/debug-mmrs.c b/arch/blackfin/kernel/debug-mmrs.c
index 86b1cd3..e272bca 100644
--- a/arch/blackfin/kernel/debug-mmrs.c
+++ b/arch/blackfin/kernel/debug-mmrs.c
@@ -11,9 +11,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/i2c/bfin_twi.h>
+#include <linux/gpio.h>
 
 #include <asm/blackfin.h>
-#include <asm/gpio.h>
 #include <asm/gptimers.h>
 #include <asm/bfin_can.h>
 #include <asm/bfin_dma.h>
diff --git a/arch/blackfin/mach-bf538/boards/ezkit.c b/arch/blackfin/mach-bf538/boards/ezkit.c
index ae2fcbb..c423af3 100644
--- a/arch/blackfin/mach-bf538/boards/ezkit.c
+++ b/arch/blackfin/mach-bf538/boards/ezkit.c
@@ -15,9 +15,9 @@
 #include <linux/spi/flash.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/gpio.h>
 #include <asm/bfin5xx_spi.h>
 #include <asm/dma.h>
-#include <asm/gpio.h>
 #include <asm/nand.h>
 #include <asm/portmux.h>
 #include <asm/dpmc.h>
diff --git a/arch/blackfin/mach-bf538/ext-gpio.c b/arch/blackfin/mach-bf538/ext-gpio.c
index 471a9b1..d3e7b66 100644
--- a/arch/blackfin/mach-bf538/ext-gpio.c
+++ b/arch/blackfin/mach-bf538/ext-gpio.c
@@ -8,8 +8,8 @@
 
 #include <linux/module.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <asm/blackfin.h>
-#include <asm/gpio.h>
 #include <asm/portmux.h>
 
 #define DEFINE_REG(reg, off) \
diff --git a/arch/blackfin/mach-bf548/boards/cm_bf548.c b/arch/blackfin/mach-bf548/boards/cm_bf548.c
index 6d5ffde..120c994 100644
--- a/arch/blackfin/mach-bf548/boards/cm_bf548.c
+++ b/arch/blackfin/mach-bf548/boards/cm_bf548.c
@@ -17,9 +17,9 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/usb/musb.h>
+#include <linux/gpio.h>
 #include <asm/bfin5xx_spi.h>
 #include <asm/dma.h>
-#include <asm/gpio.h>
 #include <asm/nand.h>
 #include <asm/portmux.h>
 #include <asm/bfin_sdh.h>
diff --git a/arch/blackfin/mach-bf548/boards/ezkit.c b/arch/blackfin/mach-bf548/boards/ezkit.c
index 4204b98..3cdd483 100644
--- a/arch/blackfin/mach-bf548/boards/ezkit.c
+++ b/arch/blackfin/mach-bf548/boards/ezkit.c
@@ -20,9 +20,9 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_data/pinctrl-adi2.h>
+#include <linux/gpio.h>
 #include <asm/bfin5xx_spi.h>
 #include <asm/dma.h>
-#include <asm/gpio.h>
 #include <asm/nand.h>
 #include <asm/dpmc.h>
 #include <asm/bfin_sport.h>
diff --git a/arch/blackfin/mach-bf609/boards/ezkit.c b/arch/blackfin/mach-bf609/boards/ezkit.c
index c7928d8..aad5d74 100644
--- a/arch/blackfin/mach-bf609/boards/ezkit.c
+++ b/arch/blackfin/mach-bf609/boards/ezkit.c
@@ -21,8 +21,8 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_data/pinctrl-adi2.h>
 #include <linux/spi/adi_spi3.h>
+#include <linux/gpio.h>
 #include <asm/dma.h>
-#include <asm/gpio.h>
 #include <asm/nand.h>
 #include <asm/dpmc.h>
 #include <asm/portmux.h>
diff --git a/arch/blackfin/mach-common/ints-priority.c b/arch/blackfin/mach-common/ints-priority.c
index e8d4d74..4986b4fb 100644
--- a/arch/blackfin/mach-common/ints-priority.c
+++ b/arch/blackfin/mach-common/ints-priority.c
@@ -17,13 +17,13 @@
 #include <linux/irq.h>
 #include <linux/sched.h>
 #include <linux/syscore_ops.h>
+#include <linux/gpio.h>
 #include <asm/delay.h>
 #ifdef CONFIG_IPIPE
 #include <linux/ipipe.h>
 #endif
 #include <asm/traps.h>
 #include <asm/blackfin.h>
-#include <asm/gpio.h>
 #include <asm/irq_handler.h>
 #include <asm/dpmc.h>
 #include <asm/traps.h>
diff --git a/arch/blackfin/mach-common/pm.c b/arch/blackfin/mach-common/pm.c
index a66d979..5ece38a 100644
--- a/arch/blackfin/mach-common/pm.c
+++ b/arch/blackfin/mach-common/pm.c
@@ -15,9 +15,9 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 
 #include <asm/cplb.h>
-#include <asm/gpio.h>
 #include <asm/dma.h>
 #include <asm/dpmc.h>
 #include <asm/pm.h>
diff --git a/arch/sh/include/mach-common/mach/magicpanelr2.h b/arch/sh/include/mach-common/mach/magicpanelr2.h
index 183a2f7..eb0cf20 100644
--- a/arch/sh/include/mach-common/mach/magicpanelr2.h
+++ b/arch/sh/include/mach-common/mach/magicpanelr2.h
@@ -13,7 +13,7 @@
 #ifndef __ASM_SH_MAGICPANELR2_H
 #define __ASM_SH_MAGICPANELR2_H
 
-#include <asm/gpio.h>
+#include <linux/gpio.h>
 
 #define __IO_PREFIX mpr2
 #include <asm/io_generic.h>
diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
index ace0a4d..9f27b14 100644
--- a/drivers/ata/pata_at91.c
+++ b/drivers/ata/pata_at91.c
@@ -30,8 +30,7 @@
 #include <linux/ata_platform.h>
 #include <linux/platform_data/atmel.h>
 #include <linux/regmap.h>
-
-#include <asm/gpio.h>
+#include <linux/gpio.h>
 
 #define DRV_NAME		"pata_at91"
 #define DRV_VERSION		"0.3"
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index dd74100..ec748d3 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -36,8 +36,8 @@
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 #include <asm/dma.h>
-#include <asm/gpio.h>
 #include <asm/portmux.h>
 
 #define DRV_NAME		"pata-bf54x"
diff --git a/drivers/gpio/gpio-mpc5200.c b/drivers/gpio/gpio-mpc5200.c
index 0e5a670..fc10cf5 100644
--- a/drivers/gpio/gpio-mpc5200.c
+++ b/drivers/gpio/gpio-mpc5200.c
@@ -25,7 +25,6 @@
 #include <linux/of_platform.h>
 #include <linux/module.h>
 
-#include <asm/gpio.h>
 #include <asm/mpc52xx.h>
 #include <sysdev/fsl_soc.h>
 
diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 3ac36f5..a4a8f1e 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -42,10 +42,10 @@
 #include <linux/bcd.h>
 #include <linux/slab.h>
 #include <linux/mfd/menelaus.h>
+#include <linux/gpio.h>
 
 #include <asm/mach/irq.h>
 
-#include <asm/gpio.h>
 
 #define DRIVER_NAME			"menelaus"
 
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 0aacf12..24a1388 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -35,10 +35,10 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>
+#include <linux/gpio.h>
 
 #include <asm/mach/flash.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
-#include <asm/gpio.h>
 
 #include <linux/omap-dma.h>
 
diff --git a/drivers/pcmcia/bfin_cf_pcmcia.c b/drivers/pcmcia/bfin_cf_pcmcia.c
index bba1dcb..8b0923f 100644
--- a/drivers/pcmcia/bfin_cf_pcmcia.c
+++ b/drivers/pcmcia/bfin_cf_pcmcia.c
@@ -36,10 +36,10 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 
 #include <pcmcia/ss.h>
 #include <pcmcia/cisreg.h>
-#include <asm/gpio.h>
 
 #define	SZ_1K	0x00000400
 #define	SZ_8K	0x00002000
diff --git a/drivers/pcmcia/pxa2xx_vpac270.c b/drivers/pcmcia/pxa2xx_vpac270.c
index a47dcd2..33c5b88 100644
--- a/drivers/pcmcia/pxa2xx_vpac270.c
+++ b/drivers/pcmcia/pxa2xx_vpac270.c
@@ -17,7 +17,6 @@
 
 #include <asm/mach-types.h>
 
-#include <asm/gpio.h>
 #include <mach/vpac270.h>
 
 #include "soc_common.h"
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 8755b2c..dbde114 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -25,8 +25,6 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 
-#include <asm/gpio.h>
-
 #include "atmel_usba_udc.h"
 
 #ifdef CONFIG_USB_GADGET_DEBUG_FS
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 8c6e15b..95c8ddd 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -24,8 +24,6 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 
-#include <asm/gpio.h>
-
 #include "ohci.h"
 
 #define valid_port(index)	((index) >= 0 && (index) < AT91_MAX_USBH_PORTS)
diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 19eb42b..e13b9e4 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -26,8 +26,6 @@
 #include <linux/regulator/consumer.h>
 #include <video/videomode.h>
 
-#include <asm/gpio.h>
-
 #include <video/atmel_lcdc.h>
 
 struct atmel_lcdfb_config {
diff --git a/drivers/video/fbdev/omap/lcd_h3.c b/drivers/video/fbdev/omap/lcd_h3.c
index a0729d0..21512b0 100644
--- a/drivers/video/fbdev/omap/lcd_h3.c
+++ b/drivers/video/fbdev/omap/lcd_h3.c
@@ -22,8 +22,8 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/i2c/tps65010.h>
+#include <linux/gpio.h>
 
-#include <asm/gpio.h>
 #include "omapfb.h"
 
 #define MODULE_NAME	"omapfb-lcd_h3"
diff --git a/drivers/video/fbdev/omap/lcd_osk.c b/drivers/video/fbdev/omap/lcd_osk.c
index c3ddebf..b56886c 100644
--- a/drivers/video/fbdev/omap/lcd_osk.c
+++ b/drivers/video/fbdev/omap/lcd_osk.c
@@ -22,8 +22,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
-
-#include <asm/gpio.h>
+#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 #include <mach/mux.h>
diff --git a/drivers/video/fbdev/omap/lcd_palmtt.c b/drivers/video/fbdev/omap/lcd_palmtt.c
index 3d0ea04..1a936d5 100644
--- a/drivers/video/fbdev/omap/lcd_palmtt.c
+++ b/drivers/video/fbdev/omap/lcd_palmtt.c
@@ -28,8 +28,8 @@ GPIO13 - screen blanking
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 
-#include <asm/gpio.h>
 #include "omapfb.h"
 
 static int palmtt_panel_init(struct lcd_panel *panel,
