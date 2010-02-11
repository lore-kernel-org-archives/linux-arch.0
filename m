From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH v2 4/5] pio-mapping: Use the PIO mapping API in the
	ISP1760 HCD driver
Date: Thu, 11 Feb 2010 17:55:33 +0000
Message-ID: <20100211175532.7848.22247.stgit@pc1117.cambridge.arm.com>
References: <20100211175417.7848.41807.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43018 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756374Ab0BKRzk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Feb 2010 12:55:40 -0500
In-Reply-To: <20100211175417.7848.41807.stgit@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Russell King <rmk@arm.linux.org.uk>

This patch provides another example of PIO API usage. In this case,
there is no struct page information in the HCD driver and the
pio_begin()/pio_end() functions are used.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Russell King <rmk@arm.linux.org.uk>
---
 drivers/usb/host/isp1760-hcd.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/isp1760-hcd.c b/drivers/usb/host/isp1760-hcd.c
index 27b8f7c..402f676 100644
--- a/drivers/usb/host/isp1760-hcd.c
+++ b/drivers/usb/host/isp1760-hcd.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/pio-mapping.h>
 #include <asm/unaligned.h>
 
 #include "../core/hcd.h"
@@ -904,6 +905,9 @@ __acquires(priv->lock)
 			status = 0;
 	}
 
+	pio_end(urb->transfer_buffer, urb->transfer_buffer_length,
+		usb_pipein(urb->pipe) ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+
 	/* complete() can reenter this HCD */
 	usb_hcd_unlink_urb_from_ep(priv_to_hcd(priv), urb);
 	spin_unlock(&priv->lock);
@@ -1538,6 +1542,9 @@ static struct list_head *qh_urb_transaction(struct isp1760_hcd *priv,
 	 */
 	buf = urb->transfer_buffer;
 
+	pio_begin(buf, urb->transfer_buffer_length,
+		  usb_pipein(urb->pipe) ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+
 	if (is_input)
 		token |= IN_PID;
 	else
