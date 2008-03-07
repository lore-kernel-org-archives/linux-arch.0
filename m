Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:50052 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840AbYCGKr3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Mar 2008 05:47:29 -0500
Date: Fri, 7 Mar 2008 11:23:10 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 6/7] sata_mv: mbus decode window support
Message-ID: <20080307102310.GF11977@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080307101913.GA11918@xi.wantstofly.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Saeed Bishara <saeed@marvell.com>, Dale Farnsworth <dale@farnsworth.org>, Russell King <linux@arm.linux.org.uk>, Tzachi Perelstein <tzachi@marvell.com>, Nicolas Pitre <nico@cam.org>
Message-ID: <20080307102310.Lj_IqlgJ8xqnEgeyNy2P3l2BfK-SQw-X4Yr0F9dDFjg@z>

Make it possible to pass mbus_dram_target_info to the sata_mv
driver via the platform data, and make the sata_mv driver program
the window registers based on this data if it is passed in.

Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>

Index: linux-2.6.25-rc4/drivers/ata/sata_mv.c
===================================================================
--- linux-2.6.25-rc4.orig/drivers/ata/sata_mv.c
+++ linux-2.6.25-rc4/drivers/ata/sata_mv.c
@@ -74,6 +74,7 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
+#include <linux/mbus.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
@@ -352,6 +353,9 @@ enum {
 #define IS_GEN_IIE(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_IIE)
 #define HAS_PCI(host) (!((host)->ports[0]->flags & MV_FLAG_SOC))
 
+#define WINDOW_CTRL(i)		(0x20030 + ((i) << 4))
+#define WINDOW_BASE(i)		(0x20034 + ((i) << 4))
+
 enum {
 	/* DMA boundary 0xffff is required by the s/g splitting
 	 * we need on /length/ in mv_fill-sg().
@@ -2897,6 +2901,27 @@ static int mv_create_dma_pools(struct mv
 	return 0;
 }
 
+static void mv_conf_mbus_windows(struct mv_host_priv *hpriv,
+				 struct mbus_dram_target_info *dram)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		writel(0, hpriv->base + WINDOW_CTRL(i));
+		writel(0, hpriv->base + WINDOW_BASE(i));
+	}
+
+	for (i = 0; i < dram->num_cs; i++) {
+		struct mbus_dram_window *cs = dram->cs + i;
+
+		writel(((cs->size - 1) & 0xffff0000) |
+			(cs->mbus_attr << 8) |
+			(dram->mbus_dram_target_id << 4) | 1,
+			hpriv->base + WINDOW_CTRL(i));
+		writel(cs->base, hpriv->base + WINDOW_BASE(i));
+	}
+}
+
 /**
  *      mv_platform_probe - handle a positive probe of an soc Marvell
  *      host
@@ -2951,6 +2976,12 @@ static int mv_platform_probe(struct plat
 				   res->end - res->start + 1);
 	hpriv->base -= MV_SATAHC0_REG_BASE;
 
+	/*
+	 * (Re-)program MBUS remapping windows if we are asked to.
+	 */
+	if (mv_platform_data->dram != NULL)
+		mv_conf_mbus_windows(hpriv, mv_platform_data->dram);
+
 	rc = mv_create_dma_pools(hpriv, &pdev->dev);
 	if (rc)
 		return rc;
Index: linux-2.6.25-rc4/include/linux/ata_platform.h
===================================================================
--- linux-2.6.25-rc4.orig/include/linux/ata_platform.h
+++ linux-2.6.25-rc4/include/linux/ata_platform.h
@@ -27,7 +27,10 @@ extern int __devexit __pata_platform_rem
 /*
  * Marvell SATA private data
  */
+struct mbus_dram_target_info;
+
 struct mv_sata_platform_data {
+	struct mbus_dram_target_info	*dram;
 	int	n_ports; /* number of sata ports */
 };
