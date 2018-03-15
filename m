Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:31520
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751600AbeCOLBS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Mar 2018 07:01:18 -0400
From: Aaron Wu <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 17/28] usb: Remove Blackfin USB support
Date: Thu, 15 Mar 2018 18:50:17 +0800
Message-ID: <1521111028-19856-17-git-send-email-aaron.wu@analog.com>
In-Reply-To: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
References: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, f.fainelli@gmail.com, linux-arch@vger.kernel.org, kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, liqin.linux@gmail.com, lennox.wu@gmail.com, gxt@mprc.pku.edu.cn, linux@roeck-us.net
Cc: viro@zeniv.linux.org.uk, jhogan@kernel.org, linux-metag@vger.kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, openrisc@lists.librecores.org, dhowells@redhat.com, peterz@infradead.org, aaron.wu@analog.com

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin USB support
---
 drivers/usb/gadget/function/f_uac1_legacy.c |   2 -
 drivers/usb/gadget/function/u_uac1_legacy.c |   2 -
 drivers/usb/gadget/function/u_uac1_legacy.h |   2 -
 drivers/usb/gadget/legacy/audio.c           |   2 -
 drivers/usb/host/isp1362.h                  |  45 --
 drivers/usb/musb/Kconfig                    |  12 +-
 drivers/usb/musb/Makefile                   |   1 -
 drivers/usb/musb/blackfin.c                 | 623 ----------------------------
 drivers/usb/musb/blackfin.h                 |  81 ----
 drivers/usb/musb/musb_core.c                |   7 +-
 drivers/usb/musb/musb_core.h                |  42 --
 drivers/usb/musb/musb_debugfs.c             |   2 -
 drivers/usb/musb/musb_dma.h                 |  11 -
 drivers/usb/musb/musb_gadget.c              |  32 --
 drivers/usb/musb/musb_regs.h                | 182 --------
 drivers/usb/musb/musbhsdma.c                |   5 -
 drivers/usb/musb/musbhsdma.h                |  90 ----
 drivers/usb/serial/ftdi_sio_ids.h           |   8 -
 include/linux/usb/musb.h                    |   7 -
 19 files changed, 3 insertions(+), 1153 deletions(-)
 delete mode 100644 drivers/usb/musb/blackfin.c
 delete mode 100644 drivers/usb/musb/blackfin.h

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 04f4b28..24c086b 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -4,8 +4,6 @@
   *
  * Copyright (C) 2008 Bryan Wu <cooloney@kernel.org>
  * Copyright (C) 2008 Analog Devices, Inc
- *
- * Enter bugs at http://blackfin.uclinux.org/
  */
 
 #include <linux/slab.h>
diff --git a/drivers/usb/gadget/function/u_uac1_legacy.c b/drivers/usb/gadget/function/u_uac1_legacy.c
index cbc868d..5393e5c 100644
--- a/drivers/usb/gadget/function/u_uac1_legacy.c
+++ b/drivers/usb/gadget/function/u_uac1_legacy.c
@@ -4,8 +4,6 @@
  *
  * Copyright (C) 2008 Bryan Wu <cooloney@kernel.org>
  * Copyright (C) 2008 Analog Devices, Inc
- *
- * Enter bugs at http://blackfin.uclinux.org/
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/usb/gadget/function/u_uac1_legacy.h b/drivers/usb/gadget/function/u_uac1_legacy.h
index dd69e40..5c1bdf4 100644
--- a/drivers/usb/gadget/function/u_uac1_legacy.h
+++ b/drivers/usb/gadget/function/u_uac1_legacy.h
@@ -4,8 +4,6 @@
  *
  * Copyright (C) 2008 Bryan Wu <cooloney@kernel.org>
  * Copyright (C) 2008 Analog Devices, Inc
- *
- * Enter bugs at http://blackfin.uclinux.org/
  */
 
 #ifndef __U_UAC1_LEGACY_H
diff --git a/drivers/usb/gadget/legacy/audio.c b/drivers/usb/gadget/legacy/audio.c
index 7b11dce..dd81fd5 100644
--- a/drivers/usb/gadget/legacy/audio.c
+++ b/drivers/usb/gadget/legacy/audio.c
@@ -4,8 +4,6 @@
  *
  * Copyright (C) 2008 Bryan Wu <cooloney@kernel.org>
  * Copyright (C) 2008 Analog Devices, Inc
- *
- * Enter bugs at http://blackfin.uclinux.org/
  */
 
 /* #define VERBOSE_DEBUG */
diff --git a/drivers/usb/host/isp1362.h b/drivers/usb/host/isp1362.h
index da79e36..891402a 100644
--- a/drivers/usb/host/isp1362.h
+++ b/drivers/usb/host/isp1362.h
@@ -6,49 +6,6 @@
  */
 
 /* ------------------------------------------------------------------------- */
-/*
- * Platform specific compile time options
- */
-#if defined(CONFIG_BLACKFIN)
-
-#include <linux/io.h>
-#define USE_32BIT		0
-#define MAX_ROOT_PORTS		2
-#define USE_PLATFORM_DELAY	0
-#define USE_NDELAY		1
-
-#define DUMMY_DELAY_ACCESS \
-	do { \
-		bfin_read16(ASYNC_BANK0_BASE); \
-		bfin_read16(ASYNC_BANK0_BASE); \
-		bfin_read16(ASYNC_BANK0_BASE); \
-	} while (0)
-
-#undef insw
-#undef outsw
-
-#define insw  delayed_insw
-#define outsw  delayed_outsw
-
-static inline void delayed_outsw(unsigned int addr, void *buf, int len)
-{
-	unsigned short *bp = (unsigned short *)buf;
-	while (len--) {
-		DUMMY_DELAY_ACCESS;
-		outw(*bp++, addr);
-	}
-}
-
-static inline void delayed_insw(unsigned int addr, void *buf, int len)
-{
-	unsigned short *bp = (unsigned short *)buf;
-	while (len--) {
-		DUMMY_DELAY_ACCESS;
-		*bp++ = inw(addr);
-	}
-}
-
-#else
 
 #define MAX_ROOT_PORTS		2
 
@@ -60,8 +17,6 @@ static inline void delayed_insw(unsigned int addr, void *buf, int len)
 
 #define DUMMY_DELAY_ACCESS do {} while (0)
 
-#endif
-
 
 /* ------------------------------------------------------------------------- */
 
diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 5506a9c..a424cc5 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -18,9 +18,6 @@ config USB_MUSB_HDRC
 	  Texas Instruments families using this IP include DaVinci
 	  (35x, 644x ...), OMAP 243x, OMAP 3, and TUSB 6010.
 
-	  Analog Devices parts using this IP include Blackfin BF54x,
-	  BF525 and BF527.
-
 	  Allwinner SoCs using this IP include A10, A13, A20, ...
 
 	  If you do not know what this is, please say N.
@@ -87,7 +84,7 @@ config USB_MUSB_DA8XX
 config USB_MUSB_TUSB6010
 	tristate "TUSB6010"
 	depends on HAS_IOMEM
-	depends on (ARCH_OMAP2PLUS || COMPILE_TEST) && !BLACKFIN
+	depends on (ARCH_OMAP2PLUS || COMPILE_TEST)
 	depends on NOP_USB_XCEIV = USB_MUSB_HDRC # both built-in or both modules
 
 config USB_MUSB_OMAP2PLUS
@@ -107,11 +104,6 @@ config USB_MUSB_DSPS
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	depends on OF_IRQ
 
-config USB_MUSB_BLACKFIN
-	tristate "Blackfin"
-	depends on (BF54x && !BF544) || (BF52x && ! BF522 && !BF523)
-	depends on NOP_USB_XCEIV
-
 config USB_MUSB_UX500
 	tristate "Ux500 platforms"
 	depends on ARCH_U8500 || COMPILE_TEST
@@ -149,7 +141,7 @@ config USB_UX500_DMA
 
 config USB_INVENTRA_DMA
 	bool 'Inventra'
-	depends on USB_MUSB_OMAP2PLUS || USB_MUSB_BLACKFIN
+	depends on USB_MUSB_OMAP2PLUS
 	help
 	  Enable DMA transfers using Mentor's engine.
 
diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index 79d4d54..3a88c79 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_USB_MUSB_DSPS)			+= musb_dsps.o
 obj-$(CONFIG_USB_MUSB_TUSB6010)			+= tusb6010.o
 obj-$(CONFIG_USB_MUSB_DAVINCI)			+= davinci.o
 obj-$(CONFIG_USB_MUSB_DA8XX)			+= da8xx.o
-obj-$(CONFIG_USB_MUSB_BLACKFIN)			+= blackfin.o
 obj-$(CONFIG_USB_MUSB_UX500)			+= ux500.o
 obj-$(CONFIG_USB_MUSB_JZ4740)			+= jz4740.o
 obj-$(CONFIG_USB_MUSB_SUNXI)			+= sunxi.o
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
deleted file mode 100644
index 0a98dcd..0000000
--- a/drivers/usb/musb/blackfin.c
+++ /dev/null
@@ -1,623 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * MUSB OTG controller driver for Blackfin Processors
- *
- * Copyright 2006-2008 Analog Devices Inc.
- *
- * Enter bugs at http://blackfin.uclinux.org/
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/list.h>
-#include <linux/gpio.h>
-#include <linux/io.h>
-#include <linux/err.h>
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/prefetch.h>
-#include <linux/usb/usb_phy_generic.h>
-
-#include <asm/cacheflush.h>
-
-#include "musb_core.h"
-#include "musbhsdma.h"
-#include "blackfin.h"
-
-struct bfin_glue {
-	struct device		*dev;
-	struct platform_device	*musb;
-	struct platform_device	*phy;
-};
-#define glue_to_musb(g)		platform_get_drvdata(g->musb)
-
-static u32 bfin_fifo_offset(u8 epnum)
-{
-	return USB_OFFSET(USB_EP0_FIFO) + (epnum * 8);
-}
-
-static u8 bfin_readb(const void __iomem *addr, unsigned offset)
-{
-	return (u8)(bfin_read16(addr + offset));
-}
-
-static u16 bfin_readw(const void __iomem *addr, unsigned offset)
-{
-	return bfin_read16(addr + offset);
-}
-
-static u32 bfin_readl(const void __iomem *addr, unsigned offset)
-{
-	return (u32)(bfin_read16(addr + offset));
-}
-
-static void bfin_writeb(void __iomem *addr, unsigned offset, u8 data)
-{
-	bfin_write16(addr + offset, (u16)data);
-}
-
-static void bfin_writew(void __iomem *addr, unsigned offset, u16 data)
-{
-	bfin_write16(addr + offset, data);
-}
-
-static void bfin_writel(void __iomem *addr, unsigned offset, u32 data)
-{
-	bfin_write16(addr + offset, (u16)data);
-}
-
-/*
- * Load an endpoint's FIFO
- */
-static void bfin_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
-{
-	struct musb *musb = hw_ep->musb;
-	void __iomem *fifo = hw_ep->fifo;
-	void __iomem *epio = hw_ep->regs;
-	u8 epnum = hw_ep->epnum;
-
-	prefetch((u8 *)src);
-
-	musb_writew(epio, MUSB_TXCOUNT, len);
-
-	dev_dbg(musb->controller, "TX ep%d fifo %p count %d buf %p, epio %p\n",
-			hw_ep->epnum, fifo, len, src, epio);
-
-	dump_fifo_data(src, len);
-
-	if (!ANOMALY_05000380 && epnum != 0) {
-		u16 dma_reg;
-
-		flush_dcache_range((unsigned long)src,
-			(unsigned long)(src + len));
-
-		/* Setup DMA address register */
-		dma_reg = (u32)src;
-		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_ADDR_LOW), dma_reg);
-		SSYNC();
-
-		dma_reg = (u32)src >> 16;
-		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_ADDR_HIGH), dma_reg);
-		SSYNC();
-
-		/* Setup DMA count register */
-		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_COUNT_LOW), len);
-		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_COUNT_HIGH), 0);
-		SSYNC();
-
-		/* Enable the DMA */
-		dma_reg = (epnum << 4) | DMA_ENA | INT_ENA | DIRECTION;
-		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_CTRL), dma_reg);
-		SSYNC();
-
-		/* Wait for complete */
-		while (!(bfin_read_USB_DMA_INTERRUPT() & (1 << epnum)))
-			cpu_relax();
-
-		/* acknowledge dma interrupt */
-		bfin_write_USB_DMA_INTERRUPT(1 << epnum);
-		SSYNC();
-
-		/* Reset DMA */
-		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_CTRL), 0);
-		SSYNC();
-	} else {
-		SSYNC();
-
-		if (unlikely((unsigned long)src & 0x01))
-			outsw_8((unsigned long)fifo, src, (len + 1) >> 1);
-		else
-			outsw((unsigned long)fifo, src, (len + 1) >> 1);
-	}
-}
-/*
- * Unload an endpoint's FIFO
- */
-static void bfin_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
-{
-	struct musb *musb = hw_ep->musb;
-	void __iomem *fifo = hw_ep->fifo;
-	u8 epnum = hw_ep->epnum;
-
-	if (ANOMALY_05000467 && epnum != 0) {
-		u16 dma_reg;
-
-		invalidate_dcache_range((unsigned long)dst,
-			(unsigned long)(dst + len));
-
-		/* Setup DMA address register */
-		dma_reg = (u32)dst;
-		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_ADDR_LOW), dma_reg);
-		SSYNC();
-
-		dma_reg = (u32)dst >> 16;
-		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_ADDR_HIGH), dma_reg);
-		SSYNC();
-
-		/* Setup DMA count register */
-		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_COUNT_LOW), len);
-		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_COUNT_HIGH), 0);
-		SSYNC();
-
-		/* Enable the DMA */
-		dma_reg = (epnum << 4) | DMA_ENA | INT_ENA;
-		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_CTRL), dma_reg);
-		SSYNC();
-
-		/* Wait for complete */
-		while (!(bfin_read_USB_DMA_INTERRUPT() & (1 << epnum)))
-			cpu_relax();
-
-		/* acknowledge dma interrupt */
-		bfin_write_USB_DMA_INTERRUPT(1 << epnum);
-		SSYNC();
-
-		/* Reset DMA */
-		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_CTRL), 0);
-		SSYNC();
-	} else {
-		SSYNC();
-		/* Read the last byte of packet with odd size from address fifo + 4
-		 * to trigger 1 byte access to EP0 FIFO.
-		 */
-		if (len == 1)
-			*dst = (u8)inw((unsigned long)fifo + 4);
-		else {
-			if (unlikely((unsigned long)dst & 0x01))
-				insw_8((unsigned long)fifo, dst, len >> 1);
-			else
-				insw((unsigned long)fifo, dst, len >> 1);
-
-			if (len & 0x01)
-				*(dst + len - 1) = (u8)inw((unsigned long)fifo + 4);
-		}
-	}
-	dev_dbg(musb->controller, "%cX ep%d fifo %p count %d buf %p\n",
-			'R', hw_ep->epnum, fifo, len, dst);
-
-	dump_fifo_data(dst, len);
-}
-
-static irqreturn_t blackfin_interrupt(int irq, void *__hci)
-{
-	unsigned long	flags;
-	irqreturn_t	retval = IRQ_NONE;
-	struct musb	*musb = __hci;
-
-	spin_lock_irqsave(&musb->lock, flags);
-
-	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
-	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
-	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
-
-	if (musb->int_usb || musb->int_tx || musb->int_rx) {
-		musb_writeb(musb->mregs, MUSB_INTRUSB, musb->int_usb);
-		musb_writew(musb->mregs, MUSB_INTRTX, musb->int_tx);
-		musb_writew(musb->mregs, MUSB_INTRRX, musb->int_rx);
-		retval = musb_interrupt(musb);
-	}
-
-	/* Start sampling ID pin, when plug is removed from MUSB */
-	if ((musb->xceiv->otg->state == OTG_STATE_B_IDLE
-		|| musb->xceiv->otg->state == OTG_STATE_A_WAIT_BCON) ||
-		(musb->int_usb & MUSB_INTR_DISCONNECT && is_host_active(musb))) {
-		mod_timer(&musb->dev_timer, jiffies + TIMER_DELAY);
-		musb->a_wait_bcon = TIMER_DELAY;
-	}
-
-	spin_unlock_irqrestore(&musb->lock, flags);
-
-	return retval;
-}
-
-static void musb_conn_timer_handler(struct timer_list *t)
-{
-	struct musb *musb = from_timer(musb, t, dev_timer);
-	unsigned long flags;
-	u16 val;
-	static u8 toggle;
-
-	spin_lock_irqsave(&musb->lock, flags);
-	switch (musb->xceiv->otg->state) {
-	case OTG_STATE_A_IDLE:
-	case OTG_STATE_A_WAIT_BCON:
-		/* Start a new session */
-		val = musb_readw(musb->mregs, MUSB_DEVCTL);
-		val &= ~MUSB_DEVCTL_SESSION;
-		musb_writew(musb->mregs, MUSB_DEVCTL, val);
-		val |= MUSB_DEVCTL_SESSION;
-		musb_writew(musb->mregs, MUSB_DEVCTL, val);
-		/* Check if musb is host or peripheral. */
-		val = musb_readw(musb->mregs, MUSB_DEVCTL);
-
-		if (!(val & MUSB_DEVCTL_BDEVICE)) {
-			gpio_set_value(musb->config->gpio_vrsel, 1);
-			musb->xceiv->otg->state = OTG_STATE_A_WAIT_BCON;
-		} else {
-			gpio_set_value(musb->config->gpio_vrsel, 0);
-			/* Ignore VBUSERROR and SUSPEND IRQ */
-			val = musb_readb(musb->mregs, MUSB_INTRUSBE);
-			val &= ~MUSB_INTR_VBUSERROR;
-			musb_writeb(musb->mregs, MUSB_INTRUSBE, val);
-
-			val = MUSB_INTR_SUSPEND | MUSB_INTR_VBUSERROR;
-			musb_writeb(musb->mregs, MUSB_INTRUSB, val);
-			musb->xceiv->otg->state = OTG_STATE_B_IDLE;
-		}
-		mod_timer(&musb->dev_timer, jiffies + TIMER_DELAY);
-		break;
-	case OTG_STATE_B_IDLE:
-		/*
-		 * Start a new session.  It seems that MUSB needs taking
-		 * some time to recognize the type of the plug inserted?
-		 */
-		val = musb_readw(musb->mregs, MUSB_DEVCTL);
-		val |= MUSB_DEVCTL_SESSION;
-		musb_writew(musb->mregs, MUSB_DEVCTL, val);
-		val = musb_readw(musb->mregs, MUSB_DEVCTL);
-
-		if (!(val & MUSB_DEVCTL_BDEVICE)) {
-			gpio_set_value(musb->config->gpio_vrsel, 1);
-			musb->xceiv->otg->state = OTG_STATE_A_WAIT_BCON;
-		} else {
-			gpio_set_value(musb->config->gpio_vrsel, 0);
-
-			/* Ignore VBUSERROR and SUSPEND IRQ */
-			val = musb_readb(musb->mregs, MUSB_INTRUSBE);
-			val &= ~MUSB_INTR_VBUSERROR;
-			musb_writeb(musb->mregs, MUSB_INTRUSBE, val);
-
-			val = MUSB_INTR_SUSPEND | MUSB_INTR_VBUSERROR;
-			musb_writeb(musb->mregs, MUSB_INTRUSB, val);
-
-			/* Toggle the Soft Conn bit, so that we can response to
-			 * the inserting of either A-plug or B-plug.
-			 */
-			if (toggle) {
-				val = musb_readb(musb->mregs, MUSB_POWER);
-				val &= ~MUSB_POWER_SOFTCONN;
-				musb_writeb(musb->mregs, MUSB_POWER, val);
-				toggle = 0;
-			} else {
-				val = musb_readb(musb->mregs, MUSB_POWER);
-				val |= MUSB_POWER_SOFTCONN;
-				musb_writeb(musb->mregs, MUSB_POWER, val);
-				toggle = 1;
-			}
-			/* The delay time is set to 1/4 second by default,
-			 * shortening it, if accelerating A-plug detection
-			 * is needed in OTG mode.
-			 */
-			mod_timer(&musb->dev_timer, jiffies + TIMER_DELAY / 4);
-		}
-		break;
-	default:
-		dev_dbg(musb->controller, "%s state not handled\n",
-			usb_otg_state_string(musb->xceiv->otg->state));
-		break;
-	}
-	spin_unlock_irqrestore(&musb->lock, flags);
-
-	dev_dbg(musb->controller, "state is %s\n",
-		usb_otg_state_string(musb->xceiv->otg->state));
-}
-
-static void bfin_musb_enable(struct musb *musb)
-{
-	/* REVISIT is this really correct ? */
-}
-
-static void bfin_musb_disable(struct musb *musb)
-{
-}
-
-static void bfin_musb_set_vbus(struct musb *musb, int is_on)
-{
-	int value = musb->config->gpio_vrsel_active;
-	if (!is_on)
-		value = !value;
-	gpio_set_value(musb->config->gpio_vrsel, value);
-
-	dev_dbg(musb->controller, "VBUS %s, devctl %02x "
-		/* otg %3x conf %08x prcm %08x */ "\n",
-		usb_otg_state_string(musb->xceiv->otg->state),
-		musb_readb(musb->mregs, MUSB_DEVCTL));
-}
-
-static int bfin_musb_set_power(struct usb_phy *x, unsigned mA)
-{
-	return 0;
-}
-
-static int bfin_musb_vbus_status(struct musb *musb)
-{
-	return 0;
-}
-
-static int bfin_musb_set_mode(struct musb *musb, u8 musb_mode)
-{
-	return -EIO;
-}
-
-static int bfin_musb_adjust_channel_params(struct dma_channel *channel,
-				u16 packet_sz, u8 *mode,
-				dma_addr_t *dma_addr, u32 *len)
-{
-	struct musb_dma_channel *musb_channel = channel->private_data;
-
-	/*
-	 * Anomaly 05000450 might cause data corruption when using DMA
-	 * MODE 1 transmits with short packet.  So to work around this,
-	 * we truncate all MODE 1 transfers down to a multiple of the
-	 * max packet size, and then do the last short packet transfer
-	 * (if there is any) using MODE 0.
-	 */
-	if (ANOMALY_05000450) {
-		if (musb_channel->transmit && *mode == 1)
-			*len = *len - (*len % packet_sz);
-	}
-
-	return 0;
-}
-
-static void bfin_musb_reg_init(struct musb *musb)
-{
-	if (ANOMALY_05000346) {
-		bfin_write_USB_APHY_CALIB(ANOMALY_05000346_value);
-		SSYNC();
-	}
-
-	if (ANOMALY_05000347) {
-		bfin_write_USB_APHY_CNTRL(0x0);
-		SSYNC();
-	}
-
-	/* Configure PLL oscillator register */
-	bfin_write_USB_PLLOSC_CTRL(0x3080 |
-			((480/musb->config->clkin) << 1));
-	SSYNC();
-
-	bfin_write_USB_SRP_CLKDIV((get_sclk()/1000) / 32 - 1);
-	SSYNC();
-
-	bfin_write_USB_EP_NI0_RXMAXP(64);
-	SSYNC();
-
-	bfin_write_USB_EP_NI0_TXMAXP(64);
-	SSYNC();
-
-	/* Route INTRUSB/INTR_RX/INTR_TX to USB_INT0*/
-	bfin_write_USB_GLOBINTR(0x7);
-	SSYNC();
-
-	bfin_write_USB_GLOBAL_CTL(GLOBAL_ENA | EP1_TX_ENA | EP2_TX_ENA |
-				EP3_TX_ENA | EP4_TX_ENA | EP5_TX_ENA |
-				EP6_TX_ENA | EP7_TX_ENA | EP1_RX_ENA |
-				EP2_RX_ENA | EP3_RX_ENA | EP4_RX_ENA |
-				EP5_RX_ENA | EP6_RX_ENA | EP7_RX_ENA);
-	SSYNC();
-}
-
-static int bfin_musb_init(struct musb *musb)
-{
-
-	/*
-	 * Rev 1.0 BF549 EZ-KITs require PE7 to be high for both DEVICE
-	 * and OTG HOST modes, while rev 1.1 and greater require PE7 to
-	 * be low for DEVICE mode and high for HOST mode. We set it high
-	 * here because we are in host mode
-	 */
-
-	if (gpio_request(musb->config->gpio_vrsel, "USB_VRSEL")) {
-		printk(KERN_ERR "Failed ro request USB_VRSEL GPIO_%d\n",
-			musb->config->gpio_vrsel);
-		return -ENODEV;
-	}
-	gpio_direction_output(musb->config->gpio_vrsel, 0);
-
-	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
-	if (IS_ERR_OR_NULL(musb->xceiv)) {
-		gpio_free(musb->config->gpio_vrsel);
-		return -EPROBE_DEFER;
-	}
-
-	bfin_musb_reg_init(musb);
-
-	timer_setup(&musb->dev_timer, musb_conn_timer_handler, 0);
-
-	musb->xceiv->set_power = bfin_musb_set_power;
-
-	musb->isr = blackfin_interrupt;
-	musb->double_buffer_not_ok = true;
-
-	return 0;
-}
-
-static int bfin_musb_exit(struct musb *musb)
-{
-	gpio_free(musb->config->gpio_vrsel);
-	usb_put_phy(musb->xceiv);
-
-	return 0;
-}
-
-static const struct musb_platform_ops bfin_ops = {
-	.quirks		= MUSB_DMA_INVENTRA,
-	.init		= bfin_musb_init,
-	.exit		= bfin_musb_exit,
-
-	.fifo_offset	= bfin_fifo_offset,
-	.readb		= bfin_readb,
-	.writeb		= bfin_writeb,
-	.readw		= bfin_readw,
-	.writew		= bfin_writew,
-	.readl		= bfin_readl,
-	.writel		= bfin_writel,
-	.fifo_mode	= 2,
-	.read_fifo	= bfin_read_fifo,
-	.write_fifo	= bfin_write_fifo,
-#ifdef CONFIG_USB_INVENTRA_DMA
-	.dma_init	= musbhs_dma_controller_create,
-	.dma_exit	= musbhs_dma_controller_destroy,
-#endif
-	.enable		= bfin_musb_enable,
-	.disable	= bfin_musb_disable,
-
-	.set_mode	= bfin_musb_set_mode,
-
-	.vbus_status	= bfin_musb_vbus_status,
-	.set_vbus	= bfin_musb_set_vbus,
-
-	.adjust_channel_params = bfin_musb_adjust_channel_params,
-};
-
-static u64 bfin_dmamask = DMA_BIT_MASK(32);
-
-static int bfin_probe(struct platform_device *pdev)
-{
-	struct resource musb_resources[2];
-	struct musb_hdrc_platform_data	*pdata = dev_get_platdata(&pdev->dev);
-	struct platform_device		*musb;
-	struct bfin_glue		*glue;
-
-	int				ret = -ENOMEM;
-
-	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
-	if (!glue)
-		goto err0;
-
-	musb = platform_device_alloc("musb-hdrc", PLATFORM_DEVID_AUTO);
-	if (!musb)
-		goto err0;
-
-	musb->dev.parent		= &pdev->dev;
-	musb->dev.dma_mask		= &bfin_dmamask;
-	musb->dev.coherent_dma_mask	= bfin_dmamask;
-
-	glue->dev			= &pdev->dev;
-	glue->musb			= musb;
-
-	pdata->platform_ops		= &bfin_ops;
-
-	glue->phy = usb_phy_generic_register();
-	if (IS_ERR(glue->phy))
-		goto err1;
-	platform_set_drvdata(pdev, glue);
-
-	memset(musb_resources, 0x00, sizeof(*musb_resources) *
-			ARRAY_SIZE(musb_resources));
-
-	musb_resources[0].name = pdev->resource[0].name;
-	musb_resources[0].start = pdev->resource[0].start;
-	musb_resources[0].end = pdev->resource[0].end;
-	musb_resources[0].flags = pdev->resource[0].flags;
-
-	musb_resources[1].name = pdev->resource[1].name;
-	musb_resources[1].start = pdev->resource[1].start;
-	musb_resources[1].end = pdev->resource[1].end;
-	musb_resources[1].flags = pdev->resource[1].flags;
-
-	ret = platform_device_add_resources(musb, musb_resources,
-			ARRAY_SIZE(musb_resources));
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err2;
-	}
-
-	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err2;
-	}
-
-	ret = platform_device_add(musb);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err2;
-	}
-
-	return 0;
-
-err2:
-	usb_phy_generic_unregister(glue->phy);
-
-err1:
-	platform_device_put(musb);
-
-err0:
-	return ret;
-}
-
-static int bfin_remove(struct platform_device *pdev)
-{
-	struct bfin_glue		*glue = platform_get_drvdata(pdev);
-
-	platform_device_unregister(glue->musb);
-	usb_phy_generic_unregister(glue->phy);
-
-	return 0;
-}
-
-static int __maybe_unused bfin_suspend(struct device *dev)
-{
-	struct bfin_glue	*glue = dev_get_drvdata(dev);
-	struct musb		*musb = glue_to_musb(glue);
-
-	if (is_host_active(musb))
-		/*
-		 * During hibernate gpio_vrsel will change from high to low
-		 * low which will generate wakeup event resume the system
-		 * immediately.  Set it to 0 before hibernate to avoid this
-		 * wakeup event.
-		 */
-		gpio_set_value(musb->config->gpio_vrsel, 0);
-
-	return 0;
-}
-
-static int __maybe_unused bfin_resume(struct device *dev)
-{
-	struct bfin_glue	*glue = dev_get_drvdata(dev);
-	struct musb		*musb = glue_to_musb(glue);
-
-	bfin_musb_reg_init(musb);
-
-	return 0;
-}
-
-static SIMPLE_DEV_PM_OPS(bfin_pm_ops, bfin_suspend, bfin_resume);
-
-static struct platform_driver bfin_driver = {
-	.probe		= bfin_probe,
-	.remove		= bfin_remove,
-	.driver		= {
-		.name	= "musb-blackfin",
-		.pm	= &bfin_pm_ops,
-	},
-};
-
-MODULE_DESCRIPTION("Blackfin MUSB Glue Layer");
-MODULE_AUTHOR("Bryan Wy <cooloney@kernel.org>");
-MODULE_LICENSE("GPL v2");
-module_platform_driver(bfin_driver);
diff --git a/drivers/usb/musb/blackfin.h b/drivers/usb/musb/blackfin.h
deleted file mode 100644
index 5b14991..0000000
--- a/drivers/usb/musb/blackfin.h
+++ /dev/null
@@ -1,81 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2007 by Analog Devices, Inc.
- */
-
-#ifndef __MUSB_BLACKFIN_H__
-#define __MUSB_BLACKFIN_H__
-
-/*
- * Blackfin specific definitions
- */
-
-/* Anomalies notes:
- *
- *  05000450 - USB DMA Mode 1 Short Packet Data Corruption:
- *             MUSB driver is designed to transfer buffer of N * maxpacket size
- *             in DMA mode 1 and leave the rest of the data to the next
- *             transfer in DMA mode 0, so we never transmit a short packet in
- *             DMA mode 1.
- *
- *  05000463 - This anomaly doesn't affect this driver since it
- *             never uses L1 or L2 memory as data destination.
- *
- *  05000464 - This anomaly doesn't affect this driver since it
- *             never uses L1 or L2 memory as data source.
- *
- *  05000465 - The anomaly can be seen when SCLK is over 100 MHz, and there is
- *             no way to workaround for bulk endpoints.  Since the wMaxPackSize
- *             of bulk is less than or equal to 512, while the fifo size of
- *             endpoint 5, 6, 7 is 1024, the double buffer mode is enabled
- *             automatically when these endpoints are used for bulk OUT.
- *
- *  05000466 - This anomaly doesn't affect this driver since it never mixes
- *             concurrent DMA and core accesses to the TX endpoint FIFOs.
- *
- *  05000467 - The workaround for this anomaly will introduce another
- *             anomaly - 05000465.
- */
-
-/* The Mentor USB DMA engine on BF52x (silicon v0.0 and v0.1) seems to be
- * unstable in host mode.  This may be caused by Anomaly 05000380.  After
- * digging out the root cause, we will change this number accordingly.
- * So, need to either use silicon v0.2+ or disable DMA mode in MUSB.
- */
-#if ANOMALY_05000380 && defined(CONFIG_BF52x) && \
-	!defined(CONFIG_MUSB_PIO_ONLY)
-# error "Please use PIO mode in MUSB driver on bf52x chip v0.0 and v0.1"
-#endif
-
-#undef DUMP_FIFO_DATA
-#ifdef DUMP_FIFO_DATA
-static void dump_fifo_data(u8 *buf, u16 len)
-{
-	u8 *tmp = buf;
-	int i;
-
-	for (i = 0; i < len; i++) {
-		if (!(i % 16) && i)
-			pr_debug("\n");
-		pr_debug("%02x ", *tmp++);
-	}
-	pr_debug("\n");
-}
-#else
-#define dump_fifo_data(buf, len)	do {} while (0)
-#endif
-
-
-#define USB_DMA_BASE		USB_DMA_INTERRUPT
-#define USB_DMAx_CTRL		0x04
-#define USB_DMAx_ADDR_LOW	0x08
-#define USB_DMAx_ADDR_HIGH	0x0C
-#define USB_DMAx_COUNT_LOW	0x10
-#define USB_DMAx_COUNT_HIGH	0x14
-
-#define USB_DMA_REG(ep, reg)	(USB_DMA_BASE + 0x20 * ep + reg)
-
-/* Almost 1 second */
-#define TIMER_DELAY	(1 * HZ)
-
-#endif	/* __MUSB_BLACKFIN_H__ */
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index eef4ad5..1348658 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -126,7 +126,6 @@ EXPORT_SYMBOL_GPL(musb_get_mode);
 
 /*-------------------------------------------------------------------------*/
 
-#ifndef CONFIG_BLACKFIN
 static int musb_ulpi_read(struct usb_phy *phy, u32 reg)
 {
 	void __iomem *addr = phy->io_priv;
@@ -208,10 +207,6 @@ static int musb_ulpi_write(struct usb_phy *phy, u32 val, u32 reg)
 
 	return ret;
 }
-#else
-#define musb_ulpi_read		NULL
-#define musb_ulpi_write		NULL
-#endif
 
 static struct usb_phy_io_ops musb_ulpi_access = {
 	.read = musb_ulpi_read,
@@ -2171,7 +2166,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	 *   - initializes musb->xceiv, usually by otg_get_phy()
 	 *   - stops powering VBUS
 	 *
-	 * There are various transceiver configurations.  Blackfin,
+	 * There are various transceiver configurations.
 	 * DaVinci, TUSB60x0, and others integrate them.  OMAP3 uses
 	 * external/discrete ones in various flavors (twl4030 family,
 	 * isp1504, non-OTG, etc) mostly hooking up through ULPI.
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 385841e..d91bb28 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -414,19 +414,6 @@ struct musb {
 	struct usb_gadget_driver *gadget_driver;	/* its driver */
 	struct usb_hcd		*hcd;			/* the usb hcd */
 
-	/*
-	 * FIXME: Remove this flag.
-	 *
-	 * This is only added to allow Blackfin to work
-	 * with current driver. For some unknown reason
-	 * Blackfin doesn't work with double buffering
-	 * and that's enabled by default.
-	 *
-	 * We added this flag to forcefully disable double
-	 * buffering until we get it working.
-	 */
-	unsigned                double_buffer_not_ok:1;
-
 	const struct musb_hdrc_config *config;
 
 	int			xceiv_old_state;
@@ -467,34 +454,6 @@ static inline char *musb_ep_xfertype_string(u8 type)
 	return s;
 }
 
-#ifdef CONFIG_BLACKFIN
-static inline int musb_read_fifosize(struct musb *musb,
-		struct musb_hw_ep *hw_ep, u8 epnum)
-{
-	musb->nr_endpoints++;
-	musb->epmask |= (1 << epnum);
-
-	if (epnum < 5) {
-		hw_ep->max_packet_sz_tx = 128;
-		hw_ep->max_packet_sz_rx = 128;
-	} else {
-		hw_ep->max_packet_sz_tx = 1024;
-		hw_ep->max_packet_sz_rx = 1024;
-	}
-	hw_ep->is_shared_fifo = false;
-
-	return 0;
-}
-
-static inline void musb_configure_ep0(struct musb *musb)
-{
-	musb->endpoints[0].max_packet_sz_tx = MUSB_EP0_FIFOSIZE;
-	musb->endpoints[0].max_packet_sz_rx = MUSB_EP0_FIFOSIZE;
-	musb->endpoints[0].is_shared_fifo = true;
-}
-
-#else
-
 static inline int musb_read_fifosize(struct musb *musb,
 		struct musb_hw_ep *hw_ep, u8 epnum)
 {
@@ -531,7 +490,6 @@ static inline void musb_configure_ep0(struct musb *musb)
 	musb->endpoints[0].max_packet_sz_rx = MUSB_EP0_FIFOSIZE;
 	musb->endpoints[0].is_shared_fifo = true;
 }
-#endif /* CONFIG_BLACKFIN */
 
 
 /***************************** Glue it together *****************************/
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 7cf5a1b..7dac456 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -70,7 +70,6 @@ static const struct musb_register_map musb_regmap[] = {
 	{ "DMA_CNTLch7",	0x274,	16 },
 	{ "DMA_ADDRch7",	0x278,	32 },
 	{ "DMA_COUNTch7",	0x27C,	32 },
-#ifndef CONFIG_BLACKFIN
 	{ "ConfigData",	MUSB_CONFIGDATA,8 },
 	{ "BabbleCtl",	MUSB_BABBLE_CTL,8 },
 	{ "TxFIFOsz",	MUSB_TXFIFOSZ,	8 },
@@ -79,7 +78,6 @@ static const struct musb_register_map musb_regmap[] = {
 	{ "RxFIFOadd",	MUSB_RXFIFOADD,	16 },
 	{ "EPInfo",	MUSB_EPINFO,	8 },
 	{ "RAMInfo",	MUSB_RAMINFO,	8 },
-#endif
 	{  }	/* Terminating Entry */
 };
 
diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
index a4241f4..0fc8cd0 100644
--- a/drivers/usb/musb/musb_dma.h
+++ b/drivers/usb/musb/musb_dma.h
@@ -80,17 +80,6 @@ struct musb_hw_ep;
 #define	is_cppi_enabled(musb)	0
 #endif
 
-/* Anomaly 05000456 - USB Receive Interrupt Is Not Generated in DMA Mode 1
- *	Only allow DMA mode 1 to be used when the USB will actually generate the
- *	interrupts we expect.
- */
-#ifdef CONFIG_BLACKFIN
-# undef USE_MODE1
-# if !ANOMALY_05000456
-#  define USE_MODE1
-# endif
-#endif
-
 /*
  * DMA channel status ... updated by the dma controller driver whenever that
  * status changes, and protected by the overall controller spinlock.
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 293e5b8..1e40a81 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1680,39 +1680,7 @@ static int musb_gadget_pullup(struct usb_gadget *gadget, int is_on)
 	return 0;
 }
 
-#ifdef CONFIG_BLACKFIN
-static struct usb_ep *musb_match_ep(struct usb_gadget *g,
-		struct usb_endpoint_descriptor *desc,
-		struct usb_ss_ep_comp_descriptor *ep_comp)
-{
-	struct usb_ep *ep = NULL;
-
-	switch (usb_endpoint_type(desc)) {
-	case USB_ENDPOINT_XFER_ISOC:
-	case USB_ENDPOINT_XFER_BULK:
-		if (usb_endpoint_dir_in(desc))
-			ep = gadget_find_ep_by_name(g, "ep5in");
-		else
-			ep = gadget_find_ep_by_name(g, "ep6out");
-		break;
-	case USB_ENDPOINT_XFER_INT:
-		if (usb_endpoint_dir_in(desc))
-			ep = gadget_find_ep_by_name(g, "ep1in");
-		else
-			ep = gadget_find_ep_by_name(g, "ep2out");
-		break;
-	default:
-		break;
-	}
-
-	if (ep && usb_gadget_ep_match_desc(g, ep, desc, ep_comp))
-		return ep;
-
-	return NULL;
-}
-#else
 #define musb_match_ep NULL
-#endif
 
 static int musb_gadget_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver);
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index a4beba1..8846662 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -195,8 +195,6 @@
 #define MUSB_HUBADDR_MULTI_TT		0x80
 
 
-#ifndef CONFIG_BLACKFIN
-
 /*
  * Common USB registers
  */
@@ -416,184 +414,4 @@ static inline u8 musb_read_txhubport(struct musb *musb, u8 epnum)
 			  musb->io.busctl_offset(epnum, MUSB_TXHUBPORT));
 }
 
-#else /* CONFIG_BLACKFIN */
-
-#define USB_BASE		USB_FADDR
-#define USB_OFFSET(reg)		(reg - USB_BASE)
-
-/*
- * Common USB registers
- */
-#define MUSB_FADDR		USB_OFFSET(USB_FADDR)	/* 8-bit */
-#define MUSB_POWER		USB_OFFSET(USB_POWER)	/* 8-bit */
-#define MUSB_INTRTX		USB_OFFSET(USB_INTRTX)	/* 16-bit */
-#define MUSB_INTRRX		USB_OFFSET(USB_INTRRX)
-#define MUSB_INTRTXE		USB_OFFSET(USB_INTRTXE)
-#define MUSB_INTRRXE		USB_OFFSET(USB_INTRRXE)
-#define MUSB_INTRUSB		USB_OFFSET(USB_INTRUSB)	/* 8 bit */
-#define MUSB_INTRUSBE		USB_OFFSET(USB_INTRUSBE)/* 8 bit */
-#define MUSB_FRAME		USB_OFFSET(USB_FRAME)
-#define MUSB_INDEX		USB_OFFSET(USB_INDEX)	/* 8 bit */
-#define MUSB_TESTMODE		USB_OFFSET(USB_TESTMODE)/* 8 bit */
-
-/*
- * Additional Control Registers
- */
-
-#define MUSB_DEVCTL		USB_OFFSET(USB_OTG_DEV_CTL)	/* 8 bit */
-
-#define MUSB_LINKINFO		USB_OFFSET(USB_LINKINFO)/* 8 bit */
-#define MUSB_VPLEN		USB_OFFSET(USB_VPLEN)	/* 8 bit */
-#define MUSB_HS_EOF1		USB_OFFSET(USB_HS_EOF1)	/* 8 bit */
-#define MUSB_FS_EOF1		USB_OFFSET(USB_FS_EOF1)	/* 8 bit */
-#define MUSB_LS_EOF1		USB_OFFSET(USB_LS_EOF1)	/* 8 bit */
-
-/* Offsets to endpoint registers */
-#define MUSB_TXMAXP		0x00
-#define MUSB_TXCSR		0x04
-#define MUSB_CSR0		MUSB_TXCSR	/* Re-used for EP0 */
-#define MUSB_RXMAXP		0x08
-#define MUSB_RXCSR		0x0C
-#define MUSB_RXCOUNT		0x10
-#define MUSB_COUNT0		MUSB_RXCOUNT	/* Re-used for EP0 */
-#define MUSB_TXTYPE		0x14
-#define MUSB_TYPE0		MUSB_TXTYPE	/* Re-used for EP0 */
-#define MUSB_TXINTERVAL		0x18
-#define MUSB_NAKLIMIT0		MUSB_TXINTERVAL	/* Re-used for EP0 */
-#define MUSB_RXTYPE		0x1C
-#define MUSB_RXINTERVAL		0x20
-#define MUSB_TXCOUNT		0x28
-
-/* Offsets to endpoint registers in indexed model (using INDEX register) */
-#define MUSB_INDEXED_OFFSET(_epnum, _offset)	\
-	(0x40 + (_offset))
-
-/* Offsets to endpoint registers in flat models */
-#define MUSB_FLAT_OFFSET(_epnum, _offset)	\
-	(USB_OFFSET(USB_EP_NI0_TXMAXP) + (0x40 * (_epnum)) + (_offset))
-
-/* Not implemented - HW has separate Tx/Rx FIFO */
-#define MUSB_TXCSR_MODE			0x0000
-
-static inline void musb_write_txfifosz(void __iomem *mbase, u8 c_size)
-{
-}
-
-static inline void musb_write_txfifoadd(void __iomem *mbase, u16 c_off)
-{
-}
-
-static inline void musb_write_rxfifosz(void __iomem *mbase, u8 c_size)
-{
-}
-
-static inline void  musb_write_rxfifoadd(void __iomem *mbase, u16 c_off)
-{
-}
-
-static inline void musb_write_ulpi_buscontrol(void __iomem *mbase, u8 val)
-{
-}
-
-static inline u8 musb_read_txfifosz(void __iomem *mbase)
-{
-	return 0;
-}
-
-static inline u16 musb_read_txfifoadd(void __iomem *mbase)
-{
-	return 0;
-}
-
-static inline u8 musb_read_rxfifosz(void __iomem *mbase)
-{
-	return 0;
-}
-
-static inline u16  musb_read_rxfifoadd(void __iomem *mbase)
-{
-	return 0;
-}
-
-static inline u8 musb_read_ulpi_buscontrol(void __iomem *mbase)
-{
-	return 0;
-}
-
-static inline u8 musb_read_configdata(void __iomem *mbase)
-{
-	return 0;
-}
-
-static inline u16 musb_read_hwvers(void __iomem *mbase)
-{
-	/*
-	 * This register is invisible on Blackfin, actually the MUSB
-	 * RTL version of Blackfin is 1.9, so just hardcode its value.
-	 */
-	return MUSB_HWVERS_1900;
-}
-
-static inline void musb_write_rxfunaddr(void __iomem *mbase, u8 epnum,
-		u8 qh_addr_req)
-{
-}
-
-static inline void musb_write_rxhubaddr(void __iomem *mbase, u8 epnum,
-		u8 qh_h_addr_reg)
-{
-}
-
-static inline void musb_write_rxhubport(void __iomem *mbase, u8 epnum,
-		u8 qh_h_port_reg)
-{
-}
-
-static inline void  musb_write_txfunaddr(void __iomem *mbase, u8 epnum,
-		u8 qh_addr_reg)
-{
-}
-
-static inline void  musb_write_txhubaddr(void __iomem *mbase, u8 epnum,
-		u8 qh_addr_reg)
-{
-}
-
-static inline void  musb_write_txhubport(void __iomem *mbase, u8 epnum,
-		u8 qh_h_port_reg)
-{
-}
-
-static inline u8 musb_read_rxfunaddr(void __iomem *mbase, u8 epnum)
-{
-	return 0;
-}
-
-static inline u8 musb_read_rxhubaddr(void __iomem *mbase, u8 epnum)
-{
-	return 0;
-}
-
-static inline u8 musb_read_rxhubport(void __iomem *mbase, u8 epnum)
-{
-	return 0;
-}
-
-static inline u8  musb_read_txfunaddr(void __iomem *mbase, u8 epnum)
-{
-	return 0;
-}
-
-static inline u8  musb_read_txhubaddr(void __iomem *mbase, u8 epnum)
-{
-	return 0;
-}
-
-static inline u8 musb_read_txhubport(void __iomem *mbase, u8 epnum)
-{
-	return 0;
-}
-
-#endif /* CONFIG_BLACKFIN */
-
 #endif	/* __MUSB_REGS_H__ */
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 21fb9e6..4389fc3 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -235,11 +235,6 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 
 	int_hsdma = musb_readb(mbase, MUSB_HSDMA_INTR);
 
-#ifdef CONFIG_BLACKFIN
-	/* Clear DMA interrupt flags */
-	musb_writeb(mbase, MUSB_HSDMA_INTR, int_hsdma);
-#endif
-
 	if (!int_hsdma) {
 		musb_dbg(musb, "spurious DMA irq");
 
diff --git a/drivers/usb/musb/musbhsdma.h b/drivers/usb/musb/musbhsdma.h
index 44f7983..51bc12f 100644
--- a/drivers/usb/musb/musbhsdma.h
+++ b/drivers/usb/musb/musbhsdma.h
@@ -6,8 +6,6 @@
  * Copyright (C) 2005-2007 by Texas Instruments
  */

-#ifndef CONFIG_BLACKFIN
-
 #define MUSB_HSDMA_BASE                0x200
 #define MUSB_HSDMA_INTR                (MUSB_HSDMA_BASE + 0)
 #define MUSB_HSDMA_CONTROL             0x4
@@ -34,68 +32,6 @@
        musb_writel(mbase, \
                    MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_COUNT), \
                    len)
-#else
-
-#define MUSB_HSDMA_BASE                0x400
-#define MUSB_HSDMA_INTR                (MUSB_HSDMA_BASE + 0)
-#define MUSB_HSDMA_CONTROL             0x04
-#define MUSB_HSDMA_ADDR_LOW            0x08
-#define MUSB_HSDMA_ADDR_HIGH           0x0C
-#define MUSB_HSDMA_COUNT_LOW           0x10
-#define MUSB_HSDMA_COUNT_HIGH          0x14
-
-#define MUSB_HSDMA_CHANNEL_OFFSET(_bchannel, _offset)          \
-               (MUSB_HSDMA_BASE + (_bchannel * 0x20) + _offset)
-
-static inline u32 musb_read_hsdma_addr(void __iomem *mbase, u8 bchannel)
-{
-       u32 addr = musb_readw(mbase,
-               MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_ADDR_HIGH));
-
-       addr = addr << 16;
-
-       addr |= musb_readw(mbase,
-               MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_ADDR_LOW));
-
-       return addr;
-}
-
-static inline void musb_write_hsdma_addr(void __iomem *mbase,
-                               u8 bchannel, dma_addr_t dma_addr)
-{
-       musb_writew(mbase,
-               MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_ADDR_LOW),
-               dma_addr);
-       musb_writew(mbase,
-               MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_ADDR_HIGH),
-               (dma_addr >> 16));
-}
-
-static inline u32 musb_read_hsdma_count(void __iomem *mbase, u8 bchannel)
-{
-       u32 count = musb_readw(mbase,
-               MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_COUNT_HIGH));
-
-       count = count << 16;
-
-       count |= musb_readw(mbase,
-               MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_COUNT_LOW));
-
-       return count;
-}
-
-static inline void musb_write_hsdma_count(void __iomem *mbase,
-                               u8 bchannel, u32 len)
-{
-       musb_writew(mbase,
-               MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_COUNT_LOW),len);
-       musb_writew(mbase,
-               MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_COUNT_HIGH),
-               (len >> 16));
-}
-
-#endif /* CONFIG_BLACKFIN */
-
 /* control register (16-bit): */
 #define MUSB_HSDMA_ENABLE_SHIFT                0
 #define MUSB_HSDMA_TRANSMIT_SHIFT      1
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index 5d19e67..9eb908a 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -89,13 +89,6 @@ struct musb_hdrc_config {
 	u8		ram_bits;	/* ram address size */
 
 	struct musb_hdrc_eps_bits *eps_bits __deprecated;
-#ifdef CONFIG_BLACKFIN
-	/* A GPIO controlling VRSEL in Blackfin */
-	unsigned int	gpio_vrsel;
-	unsigned int	gpio_vrsel_active;
-	/* musb CLKIN in Blackfin in MHZ */
-	unsigned char   clkin;
-#endif
 	u32		maximum_speed;
 };
 
-- 
2.7.4
