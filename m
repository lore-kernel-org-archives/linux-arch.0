From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH 3/4] pio-mapping: Use the PIO mapping API in libata-sff.c
Date: Fri, 05 Feb 2010 16:32:00 +0000
Message-ID: <20100205163200.30827.51929.stgit@pc1117.cambridge.arm.com>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:51917 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754090Ab0BEQcB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2010 11:32:01 -0500
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id o15GW0eI005087
	for <linux-arch@vger.kernel.org>; Fri, 5 Feb 2010 16:32:00 GMT
In-Reply-To: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

This patch shows an example of PIO API usage for non-highmem pages. It
is assumed that kunmap_atomic() performs cache flushing though this may
not always be the case (needs checking with architecture people).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 drivers/ata/libata-sff.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 741065c..5b72a92 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -36,6 +36,7 @@
 #include <linux/pci.h>
 #include <linux/libata.h>
 #include <linux/highmem.h>
+#include <linux/pio-mapping.h>
 
 #include "libata.h"
 
@@ -888,9 +889,12 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 		kunmap_atomic(buf, KM_IRQ0);
 		local_irq_restore(flags);
 	} else {
-		buf = page_address(page);
-		ap->ops->sff_data_xfer(qc->dev, buf + offset, qc->sect_size,
-				       do_write);
+		enum pio_data_direction dir = do_write ?
+			PIO_TO_DEVICE : PIO_FROM_DEVICE;
+
+		buf = pio_map_page(page, offset, qc->sect_size, dir);
+		ap->ops->sff_data_xfer(qc->dev, buf, qc->sect_size, do_write);
+		pio_unmap_page(buf, qc->sect_size, dir);
 	}
 
 	qc->curbytes += qc->sect_size;
