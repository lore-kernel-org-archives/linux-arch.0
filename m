Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0058.outbound.protection.outlook.com ([104.47.33.58]:6112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751701AbeCOLBt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Mar 2018 07:01:49 -0400
From: Aaron Wu <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 21/28] pcmcia: Remove Blackfin PCMCIA support
Date: Thu, 15 Mar 2018 18:50:21 +0800
Message-ID: <1521111028-19856-21-git-send-email-aaron.wu@analog.com>
In-Reply-To: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
References: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, f.fainelli@gmail.com, linux-arch@vger.kernel.org, kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, liqin.linux@gmail.com, lennox.wu@gmail.com, gxt@mprc.pku.edu.cn, linux@roeck-us.net
Cc: viro@zeniv.linux.org.uk, jhogan@kernel.org, linux-metag@vger.kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, openrisc@lists.librecores.org, dhowells@redhat.com, peterz@infradead.org, aaron.wu@analog.com

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin PCMCIA support
---
 drivers/pcmcia/Kconfig          |   7 -
 drivers/pcmcia/Makefile         |   1 -
 drivers/pcmcia/bfin_cf_pcmcia.c | 316 ----------------------------------------
 3 files changed, 324 deletions(-)
 delete mode 100644 drivers/pcmcia/bfin_cf_pcmcia.c

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index d3c378b..9f63c66 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -266,13 +266,6 @@ config OMAP_CF
 	  Say Y here to support the CompactFlash controller on OMAP.
 	  Note that this doesn't support "True IDE" mode.
 
-config BFIN_CFPCMCIA
-	tristate "Blackfin CompactFlash PCMCIA Driver"
-	depends on PCMCIA && BLACKFIN
-	help
-	  Say Y here to support the CompactFlash PCMCIA driver for Blackfin.
-
-
 config AT91_CF
 	tristate "AT91 CompactFlash Controller"
 	depends on PCI
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index e7dae16..55a2268 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -34,7 +34,6 @@ obj-$(CONFIG_PCMCIA_BCM63XX)			+= bcm63xx_pcmcia.o
 obj-$(CONFIG_PCMCIA_VRC4171)			+= vrc4171_card.o
 obj-$(CONFIG_PCMCIA_VRC4173)			+= vrc4173_cardu.o
 obj-$(CONFIG_OMAP_CF)				+= omap_cf.o
-obj-$(CONFIG_BFIN_CFPCMCIA)			+= bfin_cf_pcmcia.o
 obj-$(CONFIG_AT91_CF)				+= at91_cf.o
 obj-$(CONFIG_ELECTRA_CF)			+= electra_cf.o
 obj-$(CONFIG_PCMCIA_ALCHEMY_DEVBOARD)		+= db1xxx_ss.o
diff --git a/drivers/pcmcia/bfin_cf_pcmcia.c b/drivers/pcmcia/bfin_cf_pcmcia.c
deleted file mode 100644
index 00a296d..0000000
--- a/drivers/pcmcia/bfin_cf_pcmcia.c
+++ /dev/null
@@ -1,316 +0,0 @@
-/*
- * file: drivers/pcmcia/bfin_cf.c
- *
- * based on: drivers/pcmcia/omap_cf.c
- * omap_cf.c -- OMAP 16xx CompactFlash controller driver
- *
- * Copyright (c) 2005 David Brownell
- * Copyright (c) 2006-2008 Michael Hennerich Analog Devices Inc.
- *
- * bugs:         enter bugs at http://blackfin.uclinux.org/
- *
- * this program is free software; you can redistribute it and/or modify
- * it under the terms of the gnu general public license as published by
- * the free software foundation; either version 2, or (at your option)
- * any later version.
- *
- * this program is distributed in the hope that it will be useful,
- * but without any warranty; without even the implied warranty of
- * merchantability or fitness for a particular purpose.  see the
- * gnu general public license for more details.
- *
- * you should have received a copy of the gnu general public license
- * along with this program; see the file copying.
- * if not, write to the free software foundation,
- * 59 temple place - suite 330, boston, ma 02111-1307, usa.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/platform_device.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/gpio.h>
-
-#include <pcmcia/ss.h>
-#include <pcmcia/cisreg.h>
-
-#define	SZ_1K	0x00000400
-#define	SZ_8K	0x00002000
-#define	SZ_2K	(2 * SZ_1K)
-
-#define	POLL_INTERVAL	(2 * HZ)
-
-#define	CF_ATASEL_ENA 	0x20311802	/* Inverts RESET */
-#define	CF_ATASEL_DIS 	0x20311800
-
-#define bfin_cf_present(pfx) (gpio_get_value(pfx))
-
-/*--------------------------------------------------------------------------*/
-
-static const char driver_name[] = "bfin_cf_pcmcia";
-
-struct bfin_cf_socket {
-	struct pcmcia_socket socket;
-
-	struct timer_list timer;
-	unsigned present:1;
-	unsigned active:1;
-
-	struct platform_device *pdev;
-	unsigned long phys_cf_io;
-	unsigned long phys_cf_attr;
-	u_int irq;
-	u_short cd_pfx;
-};
-
-/*--------------------------------------------------------------------------*/
-static int bfin_cf_reset(void)
-{
-	outw(0, CF_ATASEL_ENA);
-	mdelay(200);
-	outw(0, CF_ATASEL_DIS);
-
-	return 0;
-}
-
-static int bfin_cf_ss_init(struct pcmcia_socket *s)
-{
-	return 0;
-}
-
-/* the timer is primarily to kick this socket's pccardd */
-static void bfin_cf_timer(struct timer_list *t)
-{
-	struct bfin_cf_socket *cf = from_timer(cf, t, timer);
-	unsigned short present = bfin_cf_present(cf->cd_pfx);
-
-	if (present != cf->present) {
-		cf->present = present;
-		dev_dbg(&cf->pdev->dev, ": card %s\n",
-			 present ? "present" : "gone");
-		pcmcia_parse_events(&cf->socket, SS_DETECT);
-	}
-
-	if (cf->active)
-		mod_timer(&cf->timer, jiffies + POLL_INTERVAL);
-}
-
-static int bfin_cf_get_status(struct pcmcia_socket *s, u_int *sp)
-{
-	struct bfin_cf_socket *cf;
-
-	if (!sp)
-		return -EINVAL;
-
-	cf = container_of(s, struct bfin_cf_socket, socket);
-
-	if (bfin_cf_present(cf->cd_pfx)) {
-		*sp = SS_READY | SS_DETECT | SS_POWERON | SS_3VCARD;
-		s->pcmcia_irq = 0;
-		s->pci_irq = cf->irq;
-
-	} else
-		*sp = 0;
-	return 0;
-}
-
-static int
-bfin_cf_set_socket(struct pcmcia_socket *sock, struct socket_state_t *s)
-{
-
-	struct bfin_cf_socket *cf;
-	cf = container_of(sock, struct bfin_cf_socket, socket);
-
-	switch (s->Vcc) {
-	case 0:
-	case 33:
-		break;
-	case 50:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (s->flags & SS_RESET) {
-		disable_irq(cf->irq);
-		bfin_cf_reset();
-		enable_irq(cf->irq);
-	}
-
-	dev_dbg(&cf->pdev->dev, ": Vcc %d, io_irq %d, flags %04x csc %04x\n",
-		 s->Vcc, s->io_irq, s->flags, s->csc_mask);
-
-	return 0;
-}
-
-static int bfin_cf_ss_suspend(struct pcmcia_socket *s)
-{
-	return bfin_cf_set_socket(s, &dead_socket);
-}
-
-/* regions are 2K each:  mem, attrib, io (and reserved-for-ide) */
-
-static int bfin_cf_set_io_map(struct pcmcia_socket *s, struct pccard_io_map *io)
-{
-	struct bfin_cf_socket *cf;
-
-	cf = container_of(s, struct bfin_cf_socket, socket);
-	io->flags &= MAP_ACTIVE | MAP_ATTRIB | MAP_16BIT;
-	io->start = cf->phys_cf_io;
-	io->stop = io->start + SZ_2K - 1;
-	return 0;
-}
-
-static int
-bfin_cf_set_mem_map(struct pcmcia_socket *s, struct pccard_mem_map *map)
-{
-	struct bfin_cf_socket *cf;
-
-	if (map->card_start)
-		return -EINVAL;
-	cf = container_of(s, struct bfin_cf_socket, socket);
-	map->static_start = cf->phys_cf_io;
-	map->flags &= MAP_ACTIVE | MAP_ATTRIB | MAP_16BIT;
-	if (map->flags & MAP_ATTRIB)
-		map->static_start = cf->phys_cf_attr;
-
-	return 0;
-}
-
-static struct pccard_operations bfin_cf_ops = {
-	.init = bfin_cf_ss_init,
-	.suspend = bfin_cf_ss_suspend,
-	.get_status = bfin_cf_get_status,
-	.set_socket = bfin_cf_set_socket,
-	.set_io_map = bfin_cf_set_io_map,
-	.set_mem_map = bfin_cf_set_mem_map,
-};
-
-/*--------------------------------------------------------------------------*/
-
-static int bfin_cf_probe(struct platform_device *pdev)
-{
-	struct bfin_cf_socket *cf;
-	struct resource *io_mem, *attr_mem;
-	int irq;
-	unsigned short cd_pfx;
-	int status = 0;
-
-	dev_info(&pdev->dev, "Blackfin CompactFlash/PCMCIA Socket Driver\n");
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -EINVAL;
-
-	cd_pfx = platform_get_irq(pdev, 1);	/*Card Detect GPIO PIN */
-
-	if (gpio_request(cd_pfx, "pcmcia: CD")) {
-		dev_err(&pdev->dev,
-		       "Failed ro request Card Detect GPIO_%d\n",
-		       cd_pfx);
-		return -EBUSY;
-	}
-	gpio_direction_input(cd_pfx);
-
-	cf = kzalloc(sizeof *cf, GFP_KERNEL);
-	if (!cf) {
-		gpio_free(cd_pfx);
-		return -ENOMEM;
-	}
-
-	cf->cd_pfx = cd_pfx;
-
-	timer_setup(&cf->timer, bfin_cf_timer, 0);
-
-	cf->pdev = pdev;
-	platform_set_drvdata(pdev, cf);
-
-	cf->irq = irq;
-	cf->socket.pci_irq = irq;
-
-	irq_set_irq_type(irq, IRQF_TRIGGER_LOW);
-
-	io_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	attr_mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-
-	if (!io_mem || !attr_mem)
-		goto fail0;
-
-	cf->phys_cf_io = io_mem->start;
-	cf->phys_cf_attr = attr_mem->start;
-
-	/* pcmcia layer only remaps "real" memory */
-	cf->socket.io_offset = (unsigned long)
-	    ioremap(cf->phys_cf_io, SZ_2K);
-
-	if (!cf->socket.io_offset)
-		goto fail0;
-
-	dev_err(&pdev->dev, ": on irq %d\n", irq);
-
-	dev_dbg(&pdev->dev, ": %s\n",
-		 bfin_cf_present(cf->cd_pfx) ? "present" : "(not present)");
-
-	cf->socket.owner = THIS_MODULE;
-	cf->socket.dev.parent = &pdev->dev;
-	cf->socket.ops = &bfin_cf_ops;
-	cf->socket.resource_ops = &pccard_static_ops;
-	cf->socket.features = SS_CAP_PCCARD | SS_CAP_STATIC_MAP
-	    | SS_CAP_MEM_ALIGN;
-	cf->socket.map_size = SZ_2K;
-
-	status = pcmcia_register_socket(&cf->socket);
-	if (status < 0)
-		goto fail2;
-
-	cf->active = 1;
-	mod_timer(&cf->timer, jiffies + POLL_INTERVAL);
-	return 0;
-
-fail2:
-	iounmap((void __iomem *)cf->socket.io_offset);
-	release_mem_region(cf->phys_cf_io, SZ_8K);
-
-fail0:
-	gpio_free(cf->cd_pfx);
-	kfree(cf);
-	platform_set_drvdata(pdev, NULL);
-
-	return status;
-}
-
-static int bfin_cf_remove(struct platform_device *pdev)
-{
-	struct bfin_cf_socket *cf = platform_get_drvdata(pdev);
-
-	gpio_free(cf->cd_pfx);
-	cf->active = 0;
-	pcmcia_unregister_socket(&cf->socket);
-	del_timer_sync(&cf->timer);
-	iounmap((void __iomem *)cf->socket.io_offset);
-	release_mem_region(cf->phys_cf_io, SZ_8K);
-	platform_set_drvdata(pdev, NULL);
-	kfree(cf);
-	return 0;
-}
-
-static struct platform_driver bfin_cf_driver = {
-	.driver = {
-		   .name = driver_name,
-		   },
-	.probe = bfin_cf_probe,
-	.remove = bfin_cf_remove,
-};
-
-module_platform_driver(bfin_cf_driver);
-
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("BFIN CF/PCMCIA Driver");
-MODULE_LICENSE("GPL");
-- 
2.7.4
