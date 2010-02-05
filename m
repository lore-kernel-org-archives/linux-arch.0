From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH 4/4] pio-mapping: Use the PIO mapping API in the ISP1760
	HCD driver
Date: Fri, 05 Feb 2010 16:32:05 +0000
Message-ID: <20100205163205.30827.22815.stgit@pc1117.cambridge.arm.com>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:51922 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756992Ab0BEQcH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2010 11:32:07 -0500
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id o15GW6eI005093
	for <linux-arch@vger.kernel.org>; Fri, 5 Feb 2010 16:32:06 GMT
In-Reply-To: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

This patch provides another example of PIO API usage. In this case,
there is no struct page information in the HCD driver and the
pio_*_single() functions are used.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 drivers/usb/host/isp1760-hcd.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/isp1760-hcd.c b/drivers/usb/host/isp1760-hcd.c
index 27b8f7c..e55cb90 100644
--- a/drivers/usb/host/isp1760-hcd.c
+++ b/drivers/usb/host/isp1760-hcd.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/pio-mapping.h>
 #include <asm/unaligned.h>
 
 #include "../core/hcd.h"
@@ -904,6 +905,10 @@ __acquires(priv->lock)
 			status = 0;
 	}
 
+	pio_unmap_single(urb->transfer_buffer, urb->transfer_buffer_length,
+			 usb_pipein(urb->pipe) ?
+			 PIO_FROM_DEVICE : PIO_TO_DEVICE);
+
 	/* complete() can reenter this HCD */
 	usb_hcd_unlink_urb_from_ep(priv_to_hcd(priv), urb);
 	spin_unlock(&priv->lock);
@@ -1536,7 +1541,9 @@ static struct list_head *qh_urb_transaction(struct isp1760_hcd *priv,
 	/*
 	 * data transfer stage:  buffer setup
 	 */
-	buf = urb->transfer_buffer;
+	buf = pio_map_single(urb->transfer_buffer, urb->transfer_buffer_length,
+			     usb_pipein(urb->pipe) ?
+			     PIO_FROM_DEVICE : PIO_TO_DEVICE);
 
 	if (is_input)
 		token |= IN_PID;
