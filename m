Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:45488 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbeBFKPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Feb 2018 05:15:03 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFC 3/6] usb: gadget: Add NO_DMA dummies for DMA mapping API
Date: Tue,  6 Feb 2018 11:14:49 +0100
Message-ID: <1517912092-15470-4-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>
Cc: Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20180206101449.DyJkwmOhvIeSyfUOF8eK3AHr2Xq9pbV0RfbWULNKxPw@z>

Add dummies for usb_gadget_{,un}map_request{,_by_dev}(), to allow
compile-testing if NO_DMA=y.

This prevents the following from showing up later:

    ERROR: "usb_gadget_unmap_request_by_dev" [drivers/usb/renesas_usbhs/renesas_usbhs.ko] undefined!
    ERROR: "usb_gadget_map_request_by_dev" [drivers/usb/renesas_usbhs/renesas_usbhs.ko] undefined!
    ERROR: "usb_gadget_map_request" [drivers/usb/mtu3/mtu3.ko] undefined!
    ERROR: "usb_gadget_unmap_request" [drivers/usb/mtu3/mtu3.ko] undefined!
    ERROR: "usb_gadget_map_request" [drivers/usb/gadget/udc/renesas_usb3.ko] undefined!
    ERROR: "usb_gadget_unmap_request" [drivers/usb/gadget/udc/renesas_usb3.ko] undefined!

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/usb/gadget.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 66a5cff7ee142d6a..b68e7f9b210be122 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -805,6 +805,7 @@ int usb_otg_descriptor_init(struct usb_gadget *gadget,
 
 /* utility to simplify map/unmap of usb_requests to/from DMA */
 
+#ifdef	CONFIG_HAS_DMA
 extern int usb_gadget_map_request_by_dev(struct device *dev,
 		struct usb_request *req, int is_in);
 extern int usb_gadget_map_request(struct usb_gadget *gadget,
@@ -814,6 +815,17 @@ extern void usb_gadget_unmap_request_by_dev(struct device *dev,
 		struct usb_request *req, int is_in);
 extern void usb_gadget_unmap_request(struct usb_gadget *gadget,
 		struct usb_request *req, int is_in);
+#else /* !CONFIG_HAS_DMA */
+static inline int usb_gadget_map_request_by_dev(struct device *dev,
+		struct usb_request *req, int is_in) { return -ENOSYS; }
+static inline int usb_gadget_map_request(struct usb_gadget *gadget,
+		struct usb_request *req, int is_in) { return -ENOSYS; }
+
+static inline void usb_gadget_unmap_request_by_dev(struct device *dev,
+		struct usb_request *req, int is_in) { }
+static inline void usb_gadget_unmap_request(struct usb_gadget *gadget,
+		struct usb_request *req, int is_in) { }
+#endif /* !CONFIG_HAS_DMA */
 
 /*-------------------------------------------------------------------------*/
 
-- 
2.7.4
