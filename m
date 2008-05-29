From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 19/37] usb: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:37 -0700
Message-ID: <1212092317.28403.121.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.179]:1048 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232AbYE2USl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:41 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1839930ika.5
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:39 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Greg KH <gregkh@suse.de>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/usb/c67x00/c67x00-hcd.c |    6 +++---
 drivers/usb/core/devio.c        |   12 ++++++------
 drivers/usb/gadget/dummy_hcd.c  |    2 +-
 drivers/usb/gadget/net2280.c    |    2 +-
 drivers/usb/host/ehci.h         |    6 +++---
 drivers/usb/host/isp116x-hcd.c  |    4 ++--
 drivers/usb/host/ohci.h         |   12 ++++++------
 drivers/usb/host/r8a66597-hcd.c |    2 +-
 drivers/usb/host/sl811-hcd.c    |    4 ++--
 drivers/usb/host/uhci-hub.c     |    6 +++---
 drivers/usb/misc/auerswald.c    |    2 +-
 drivers/usb/serial/garmin_gps.c |    8 ++++----
 12 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-hcd.c b/drivers/usb/c67x00/c67x00-hcd.c
index a22b887..35a06e2 100644
--- a/drivers/usb/c67x00/c67x00-hcd.c
+++ b/drivers/usb/c67x00/c67x00-hcd.c
@@ -90,7 +90,7 @@ static int c67x00_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	switch (typeReq) {
 
 	case GetHubStatus:
-		*(__le32 *) buf = cpu_to_le32(0);
+		put_le32(0, (__le32 *)buf);
 		len = 4;		/* hub power */
 		break;
 
@@ -117,8 +117,8 @@ static int c67x00_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		if (usb_status & SOF_EOP_EN(port))
 			wPortStatus |= USB_PORT_STAT_ENABLE;
 
-		*(__le16 *) buf = cpu_to_le16(wPortStatus);
-		*(__le16 *) (buf + 2) = cpu_to_le16(wPortChange);
+		put_le16(wPortStatus, (__le16 *)buf);
+		put_le16(wPortChange, (__le16 *)(buf + 2));
 		len = 4;
 		break;
 
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index de17738..5bf7286 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -993,18 +993,18 @@ static int proc_do_submiturb(struct dev_state *ps, struct usbdevfs_urb *uurb,
 			kfree(dr);
 			return -EFAULT;
 		}
-		if (uurb->buffer_length < (le16_to_cpup(&dr->wLength) + 8)) {
+		if (uurb->buffer_length < (get_le16(&dr->wLength) + 8)) {
 			kfree(dr);
 			return -EINVAL;
 		}
 		ret = check_ctrlrecip(ps, dr->bRequestType,
-				      le16_to_cpup(&dr->wIndex));
+				      get_le16(&dr->wIndex));
 		if (ret) {
 			kfree(dr);
 			return ret;
 		}
 		uurb->number_of_packets = 0;
-		uurb->buffer_length = le16_to_cpup(&dr->wLength);
+		uurb->buffer_length = get_le16(&dr->wLength);
 		uurb->buffer += 8;
 		if ((dr->bRequestType & USB_DIR_IN) && uurb->buffer_length) {
 			is_in = 1;
@@ -1022,9 +1022,9 @@ static int proc_do_submiturb(struct dev_state *ps, struct usbdevfs_urb *uurb,
 			"bRrequestType=%02x wValue=%04x "
 			"wIndex=%04x wLength=%04x\n",
 			dr->bRequest, dr->bRequestType,
-			__le16_to_cpup(&dr->wValue),
-			__le16_to_cpup(&dr->wIndex),
-			__le16_to_cpup(&dr->wLength));
+			get_le16(&dr->wValue),
+			get_le16(&dr->wIndex),
+			get_le16(&dr->wLength));
 		break;
 
 	case USBDEVFS_URB_TYPE_BULK:
diff --git a/drivers/usb/gadget/dummy_hcd.c b/drivers/usb/gadget/dummy_hcd.c
index 4203619..af016d0 100644
--- a/drivers/usb/gadget/dummy_hcd.c
+++ b/drivers/usb/gadget/dummy_hcd.c
@@ -1604,7 +1604,7 @@ static int dummy_hub_control (
 		hub_descriptor ((struct usb_hub_descriptor *) buf);
 		break;
 	case GetHubStatus:
-		*(__le32 *) buf = __constant_cpu_to_le32 (0);
+		put_le32(0, (__le32 *)buf);
 		break;
 	case GetPortStatus:
 		if (wIndex != 1)
diff --git a/drivers/usb/gadget/net2280.c b/drivers/usb/gadget/net2280.c
index e018623..cb8a3ab 100644
--- a/drivers/usb/gadget/net2280.c
+++ b/drivers/usb/gadget/net2280.c
@@ -982,7 +982,7 @@ static void scan_dma_completions (struct net2280_ep *ep)
 		if (!req->valid)
 			break;
 		rmb ();
-		tmp = le32_to_cpup (&req->td->dmacount);
+		tmp = get_le32(&req->td->dmacount);
 		if ((tmp & (1 << VALID_BIT)) != 0)
 			break;
 
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index bf92d20..01f7e36 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -805,8 +805,8 @@ static inline u32 hc32_to_cpu (const struct ehci_hcd *ehci, const __hc32 x)
 static inline u32 hc32_to_cpup (const struct ehci_hcd *ehci, const __hc32 *x)
 {
 	return ehci_big_endian_desc(ehci)
-		? be32_to_cpup((__force __be32 *)x)
-		: le32_to_cpup((__force __le32 *)x);
+		? get_be32((__force __be32 *)x)
+		: get_le32((__force __le32 *)x);
 }
 
 #else
@@ -825,7 +825,7 @@ static inline u32 hc32_to_cpu (const struct ehci_hcd *ehci, const __hc32 x)
 
 static inline u32 hc32_to_cpup (const struct ehci_hcd *ehci, const __hc32 *x)
 {
-	return le32_to_cpup(x);
+	return get_le32(x);
 }
 
 #endif
diff --git a/drivers/usb/host/isp116x-hcd.c b/drivers/usb/host/isp116x-hcd.c
index 20b9a0d..334a1f5 100644
--- a/drivers/usb/host/isp116x-hcd.c
+++ b/drivers/usb/host/isp116x-hcd.c
@@ -1024,7 +1024,7 @@ static int isp116x_hub_control(struct usb_hcd *hcd,
 		break;
 	case GetHubStatus:
 		DBG("GetHubStatus\n");
-		*(__le32 *) buf = 0;
+		put_le32(0, (__le32 *)buf);
 		break;
 	case GetPortStatus:
 		DBG("GetPortStatus\n");
@@ -1033,7 +1033,7 @@ static int isp116x_hub_control(struct usb_hcd *hcd,
 		spin_lock_irqsave(&isp116x->lock, flags);
 		tmp = isp116x_read_reg32(isp116x, (--wIndex) ? HCRHPORT2 : HCRHPORT1);
 		spin_unlock_irqrestore(&isp116x->lock, flags);
-		*(__le32 *) buf = cpu_to_le32(tmp);
+		put_le32(0, (__le32 *)buf);
 		DBG("GetPortStatus: port[%d]  %08x\n", wIndex + 1, tmp);
 		break;
 	case ClearPortFeature:
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index dc544dd..7a5ca82 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -618,8 +618,8 @@ static inline u16 hc16_to_cpu (const struct ohci_hcd *ohci, const __hc16 x)
 static inline u16 hc16_to_cpup (const struct ohci_hcd *ohci, const __hc16 *x)
 {
 	return big_endian_desc(ohci) ?
-		be16_to_cpup((__force __be16 *)x) :
-		le16_to_cpup((__force __le16 *)x);
+		get_be16((__force __be16 *)x) :
+		get_le16((__force __le16 *)x);
 }
 
 static inline u32 hc32_to_cpu (const struct ohci_hcd *ohci, const __hc32 x)
@@ -632,8 +632,8 @@ static inline u32 hc32_to_cpu (const struct ohci_hcd *ohci, const __hc32 x)
 static inline u32 hc32_to_cpup (const struct ohci_hcd *ohci, const __hc32 *x)
 {
 	return big_endian_desc(ohci) ?
-		be32_to_cpup((__force __be32 *)x) :
-		le32_to_cpup((__force __le32 *)x);
+		get_be32((__force __be32 *)x) :
+		get_le32((__force __le32 *)x);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -653,11 +653,11 @@ static inline u16 ohci_frame_no(const struct ohci_hcd *ohci)
 {
 	u32 tmp;
 	if (big_endian_desc(ohci)) {
-		tmp = be32_to_cpup((__force __be32 *)&ohci->hcca->frame_no);
+		tmp = get_be32((__force __be32 *)&ohci->hcca->frame_no);
 		if (!big_endian_frame_no_quirk(ohci))
 			tmp >>= 16;
 	} else
-		tmp = le32_to_cpup((__force __le32 *)&ohci->hcca->frame_no);
+		tmp = get_le32((__force __le32 *)&ohci->hcca->frame_no);
 
 	return (u16)tmp;
 }
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 1666734..132e68a 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -2131,7 +2131,7 @@ static int r8a66597_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	case GetPortStatus:
 		if (wIndex > R8A66597_MAX_ROOT_HUB)
 			goto error;
-		*(__le32 *)buf = cpu_to_le32(rh->port);
+		put_le32(rh->port, (__le32 *)buf);
 		break;
 	case SetPortFeature:
 		if (wIndex > R8A66597_MAX_ROOT_HUB)
diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 4265752..2137fbe 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1268,12 +1268,12 @@ sl811h_hub_control(
 		sl811h_hub_descriptor(sl811, (struct usb_hub_descriptor *) buf);
 		break;
 	case GetHubStatus:
-		*(__le32 *) buf = cpu_to_le32(0);
+		put_le32(0, (__le32 *)buf);
 		break;
 	case GetPortStatus:
 		if (wIndex != 1)
 			goto error;
-		*(__le32 *) buf = cpu_to_le32(sl811->port1);
+		put_le32(sl811->port1, (__le32 *)buf);
 
 #ifndef	VERBOSE
 	if (*(u16*)(buf+2))	/* only if wPortChange is interesting */
diff --git a/drivers/usb/host/uhci-hub.c b/drivers/usb/host/uhci-hub.c
index 8e4427a..ed3d978 100644
--- a/drivers/usb/host/uhci-hub.c
+++ b/drivers/usb/host/uhci-hub.c
@@ -253,7 +253,7 @@ static int uhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	switch (typeReq) {
 
 	case GetHubStatus:
-		*(__le32 *)buf = cpu_to_le32(0);
+		put_le32(0, (__le32 *)buf);
 		OK(4);		/* hub power */
 	case GetPortStatus:
 		if (port >= uhci->rh_numports)
@@ -306,8 +306,8 @@ static int uhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			dev_dbg(uhci_dev(uhci), "port %d portsc %04x,%02x\n",
 					wIndex, status, lstatus);
 
-		*(__le16 *)buf = cpu_to_le16(wPortStatus);
-		*(__le16 *)(buf + 2) = cpu_to_le16(wPortChange);
+		put_le16(wPortStatus, (__le16 *)buf);
+		put_le16(wPortChange, (__le16 *)(buf + 2));
 		OK(4);
 	case SetHubFeature:		/* We don't implement these */
 	case ClearHubFeature:
diff --git a/drivers/usb/misc/auerswald.c b/drivers/usb/misc/auerswald.c
index 0939386..3342dcb 100644
--- a/drivers/usb/misc/auerswald.c
+++ b/drivers/usb/misc/auerswald.c
@@ -1982,7 +1982,7 @@ static int auerswald_probe (struct usb_interface *intf,
                 2,                                  /* length of the buffer */
                 2000);                            /* time to wait for the message to complete before timing out */
         if (ret == 2) {
-	        cp->maxControlLength = le16_to_cpup(pbuf);
+	        cp->maxControlLength = get_le16(pbuf);
                 kfree(pbuf);
                 dbg("setup: max. allowed control transfersize is %d bytes", cp->maxControlLength);
         } else {
diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index 8ce5a56..7dc13c0 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -241,17 +241,17 @@ static inline int noResponseFromAppLayer(struct garmin_data * garmin_data_p)
 
 static inline int getLayerId(const __u8 *usbPacket)
 {
-	return __le32_to_cpup((__le32 *)(usbPacket));
+	return get_le32((__le32 *)usbPacket);
 }
 
 static inline int getPacketId(const __u8 *usbPacket)
 {
-	return __le32_to_cpup((__le32 *)(usbPacket+4));
+	return get_le32((__le32 *)(usbPacket + 4));
 }
 
 static inline int getDataLength(const __u8 *usbPacket)
 {
-	return __le32_to_cpup((__le32 *)(usbPacket+8));
+	return get_le32((__le32 *)(usbPacket + 8));
 }
 

@@ -1414,7 +1414,7 @@ static void garmin_read_int_callback (struct urb *urb)
 
 		/* save the serial number */
 		garmin_data_p->serial_num 
-			= __le32_to_cpup((__le32*)(data+GARMIN_PKTHDR_LENGTH));
+			= get_le32((__le32 *)(data + GARMIN_PKTHDR_LENGTH));
 
 		dbg("%s - start-of-session reply seen - serial %u.",
 			__func__, garmin_data_p->serial_num);
-- 
1.5.6.rc0.277.g804cf
