Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:44700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753950AbeDPIul (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Apr 2018 04:50:41 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/12] iscsi_tcp: don't set a bounce limit
Date: Mon, 16 Apr 2018 10:50:21 +0200
Message-ID: <20180416085032.7367-2-hch@lst.de>
In-Reply-To: <20180416085032.7367-1-hch@lst.de>
References: <20180416085032.7367-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <20180416085021.cX-qAR5OH5wELw9qxQpHRXl8XQCU_7CafAwK3330a6k@z>

The default already is to never bounce, so the call is a no-op.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/iscsi_tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 2ba4b68fdb73..b025a0b74341 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -962,7 +962,6 @@ static int iscsi_sw_tcp_slave_configure(struct scsi_device *sdev)
 	if (conn->datadgst_en)
 		sdev->request_queue->backing_dev_info->capabilities
 			|= BDI_CAP_STABLE_WRITES;
-	blk_queue_bounce_limit(sdev->request_queue, BLK_BOUNCE_ANY);
 	blk_queue_dma_alignment(sdev->request_queue, 0);
 	return 0;
 }
-- 
2.17.0
