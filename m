Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:37656 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbbBKMxV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Feb 2015 07:53:21 -0500
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 2/2] include/dma-mapping: Clarify output of  dma_map_sg
Date: Wed, 11 Feb 2015 13:53:15 +0100
Message-ID: <1423659195-23265-2-git-send-email-ricardo.ribalda@gmail.com>
In-Reply-To: <1423659195-23265-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1423659195-23265-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Marek Szyprowski <m.szyprowski@samsung.com>, James Bottomley <jbottomley@Parallels.com>, Will Deacon <will.deacon@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <treding@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Message-ID: <20150211125315.Dj6rKnr-LVLBvSpx5rQgJzinvNbVasWCF4dYSb_H8Ak@z>

Although dma_map_sg returns 0 on error and it cannot return a
value < 0, the function returns a signed integer.

Most of the time, this function is used with a scatterlist structure.
This structure uses an unsigned integer for the number of memory.

A dma developer that has not read in detail DMA-API.txt, can wrongly
return a value < 0 on error.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 include/linux/dma-mapping.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index c3007cb..ac07ff0 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -34,6 +34,10 @@ struct dma_map_ops {
 	void (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
 			   size_t size, enum dma_data_direction dir,
 			   struct dma_attrs *attrs);
+	/*
+	 * map_sg returns 0 on error and a value > 0 on success.
+	 * It should never return a value < 0.
+	 */
 	int (*map_sg)(struct device *dev, struct scatterlist *sg,
 		      int nents, enum dma_data_direction dir,
 		      struct dma_attrs *attrs);
-- 
2.1.4

