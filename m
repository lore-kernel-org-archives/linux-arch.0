From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH v2 3/5] pio-mapping: Use the PIO mapping API in
	libata-sff.c
Date: Thu, 11 Feb 2010 17:55:27 +0000
Message-ID: <20100211175527.7848.1017.stgit@pc1117.cambridge.arm.com>
References: <20100211175417.7848.41807.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43014 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756251Ab0BKRzh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Feb 2010 12:55:37 -0500
In-Reply-To: <20100211175417.7848.41807.stgit@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Russell King <rmk@arm.linux.org.uk>

This patch shows an example of PIO API usage for non-highmem pages. It
currently only modifies the !highmem case. While it is indicated to no
longer differentiate between these, there is a benefit for the !highmem
case to use the non-atomic kmap API.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Russell King <rmk@arm.linux.org.uk>
---
 drivers/ata/libata-sff.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 741065c..02a3be9 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -36,6 +36,7 @@
 #include <linux/pci.h>
 #include <linux/libata.h>
 #include <linux/highmem.h>
+#include <linux/pio-mapping.h>
 
 #include "libata.h"
 
@@ -888,9 +889,13 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 		kunmap_atomic(buf, KM_IRQ0);
 		local_irq_restore(flags);
 	} else {
-		buf = page_address(page);
+		enum dma_data_direction dir = do_write ?
+			DMA_TO_DEVICE : DMA_FROM_DEVICE;
+
+		buf = pio_kmap(page, dir);
 		ap->ops->sff_data_xfer(qc->dev, buf + offset, qc->sect_size,
 				       do_write);
+		pio_kunmap(page, dir);
 	}
 
 	qc->curbytes += qc->sect_size;
