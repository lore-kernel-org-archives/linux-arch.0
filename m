From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH v2 5/5] pio-mapping: Use the PIO mapping API in the MMCI
	PL18x driver
Date: Thu, 11 Feb 2010 17:55:38 +0000
Message-ID: <20100211175538.7848.1886.stgit@pc1117.cambridge.arm.com>
References: <20100211175417.7848.41807.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43035 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756399Ab0BKRzs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Feb 2010 12:55:48 -0500
In-Reply-To: <20100211175417.7848.41807.stgit@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Russell King <rmk@arm.linux.org.uk>

This driver currently uses kmap + flush_dcache_page. This patch changes
the code to the pio_kmap/pio_kunmap without the additional
flush_dcache_page call.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Russell King <rmk@arm.linux.org.uk>
---
 drivers/mmc/host/mmci.c |   17 ++++++++---------
 drivers/mmc/host/mmci.h |   13 +++++++++----
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 90d168a..a72aa80 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -313,6 +313,7 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 		unsigned long flags;
 		unsigned int remain, len;
 		char *buffer;
+		enum dma_data_direction dir = DMA_NONE;
 
 		/*
 		 * For write, we only need to test the half-empty flag
@@ -324,10 +325,15 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 		if (!(status & (MCI_TXFIFOHALFEMPTY|MCI_RXDATAAVLBL)))
 			break;
 
+		if (status & MCI_RXACTIVE)
+			dir = DMA_FROM_DEVICE;
+		if (status & MCI_TXACTIVE)
+			dir = DMA_TO_DEVICE;
+
 		/*
 		 * Map the current scatter buffer.
 		 */
-		buffer = mmci_kmap_atomic(host, &flags) + host->sg_off;
+		buffer = mmci_kmap_atomic(host, &flags, dir) + host->sg_off;
 		remain = host->sg_ptr->length - host->sg_off;
 
 		len = 0;
@@ -339,7 +345,7 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 		/*
 		 * Unmap the buffer.
 		 */
-		mmci_kunmap_atomic(host, buffer, &flags);
+		mmci_kunmap_atomic(host, buffer, &flags, dir);
 
 		host->sg_off += len;
 		host->size -= len;
@@ -348,13 +354,6 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 		if (remain)
 			break;
 
-		/*
-		 * If we were reading, and we have completed this
-		 * page, ensure that the data cache is coherent.
-		 */
-		if (status & MCI_RXACTIVE)
-			flush_dcache_page(sg_page(host->sg_ptr));
-
 		if (!mmci_next_sg(host))
 			break;
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 1ceb9a9..0f19e18 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -7,6 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
+#include <linux/pio-mapping.h>
+
 #define MMCIPOWER		0x000
 #define MCI_PWR_OFF		0x00
 #define MCI_PWR_UP		0x02
@@ -195,16 +198,18 @@ static inline int mmci_next_sg(struct mmci_host *host)
 	return --host->sg_len;
 }
 
-static inline char *mmci_kmap_atomic(struct mmci_host *host, unsigned long *flags)
+static inline char *mmci_kmap_atomic(struct mmci_host *host, unsigned long *flags,
+				     enum dma_data_direction dir)
 {
 	struct scatterlist *sg = host->sg_ptr;
 
 	local_irq_save(*flags);
-	return kmap_atomic(sg_page(sg), KM_BIO_SRC_IRQ) + sg->offset;
+	return pio_kmap_atomic(sg_page(sg), KM_BIO_SRC_IRQ, dir) + sg->offset;
 }
 
-static inline void mmci_kunmap_atomic(struct mmci_host *host, void *buffer, unsigned long *flags)
+static inline void mmci_kunmap_atomic(struct mmci_host *host, void *buffer, unsigned long *flags,
+				      enum dma_data_direction dir)
 {
-	kunmap_atomic(buffer, KM_BIO_SRC_IRQ);
+	pio_kunmap_atomic(buffer, KM_BIO_SRC_IRQ, dir);
 	local_irq_restore(*flags);
 }
