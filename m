From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 12/37] input: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:20 -0700
Message-ID: <1212092300.28403.114.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:43327 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757856AbYE2USW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:22 -0400
Received: by yx-out-2324.google.com with SMTP id 31so392252yxl.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:22 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arch <linux-arch@vger.kernel.org>

Replace wacom private endian helpers.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/input/joystick/xpad.c    |   16 ++++++++--------
 drivers/input/tablet/wacom.h     |    2 --
 drivers/input/tablet/wacom_sys.c |   14 --------------
 drivers/input/tablet/wacom_wac.c |   23 ++++++++++++-----------
 4 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index b29e3af..a1b9b10 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -258,15 +258,15 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 
 	/* left stick */
 	input_report_abs(dev, ABS_X,
-			 (__s16) le16_to_cpup((__le16 *)(data + 12)));
+			 (__s16)get_le16((__le16 *)(data + 12)));
 	input_report_abs(dev, ABS_Y,
-			 ~(__s16) le16_to_cpup((__le16 *)(data + 14)));
+			 ~(__s16)get_le16((__le16 *)(data + 14)));
 
 	/* right stick */
 	input_report_abs(dev, ABS_RX,
-			 (__s16) le16_to_cpup((__le16 *)(data + 16)));
+			 (__s16)get_le16((__le16 *)(data + 16)));
 	input_report_abs(dev, ABS_RY,
-			 ~(__s16) le16_to_cpup((__le16 *)(data + 18)));
+			 ~(__s16)get_le16((__le16 *)(data + 18)));
 
 	/* triggers left/right */
 	input_report_abs(dev, ABS_Z, data[10]);
@@ -352,15 +352,15 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
 
 	/* left stick */
 	input_report_abs(dev, ABS_X,
-			 (__s16) le16_to_cpup((__le16 *)(data + 6)));
+			 (__s16)get_le16((__le16 *)(data + 6)));
 	input_report_abs(dev, ABS_Y,
-			 ~(__s16) le16_to_cpup((__le16 *)(data + 8)));
+			 ~(__s16)get_le16((__le16 *)(data + 8)));
 
 	/* right stick */
 	input_report_abs(dev, ABS_RX,
-			 (__s16) le16_to_cpup((__le16 *)(data + 10)));
+			 (__s16)get_le16((__le16 *)(data + 10)));
 	input_report_abs(dev, ABS_RY,
-			 ~(__s16) le16_to_cpup((__le16 *)(data + 12)));
+			 ~(__s16)get_le16((__le16 *)(data + 12)));
 
 	/* triggers left/right */
 	input_report_abs(dev, ABS_Z, data[4]);
diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/wacom.h
index 706619d..29de74b 100644
--- a/drivers/input/tablet/wacom.h
+++ b/drivers/input/tablet/wacom.h
@@ -130,8 +130,6 @@ extern void input_dev_pl(struct input_dev *input_dev, struct wacom_wac *wacom_wa
 extern void input_dev_pt(struct input_dev *input_dev, struct wacom_wac *wacom_wac);
 extern void input_dev_mo(struct input_dev *input_dev, struct wacom_wac *wacom_wac);
 extern void input_dev_bee(struct input_dev *input_dev, struct wacom_wac *wacom_wac);
-extern __u16 wacom_le16_to_cpu(unsigned char *data);
-extern __u16 wacom_be16_to_cpu(unsigned char *data);
 extern struct wacom_features * get_wacom_feature(const struct usb_device_id *id);
 extern const struct usb_device_id * get_device_table(void);
 
diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 71cc0c1..0d0a488 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -101,20 +101,6 @@ void wacom_input_event(void *wcombo, unsigned int type, unsigned int code, int v
 	return;
 }
 
-__u16 wacom_be16_to_cpu(unsigned char *data)
-{
-	__u16 value;
-	value = be16_to_cpu(*(__be16 *) data);
-	return value;
-}
-
-__u16 wacom_le16_to_cpu(unsigned char *data)
-{
-	__u16 value;
-	value = le16_to_cpu(*(__le16 *) data);
-	return value;
-}
-
 void wacom_input_sync(void *wcombo)
 {
 	input_sync(get_input_dev((struct wacom_combo *)wcombo));
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 192513e..6f46390 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -11,6 +11,7 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
+#include <asm/byteorder.h>
 #include "wacom.h"
 #include "wacom_wac.h"
 
@@ -25,8 +26,8 @@ static int wacom_penpartner_irq(struct wacom_wac *wacom, void *wcombo)
 				wacom->id[0] = (data[5] & 0x20) ? ERASER_DEVICE_ID : STYLUS_DEVICE_ID;
 				wacom_report_key(wcombo, wacom->tool[0], 1);
 				wacom_report_abs(wcombo, ABS_MISC, wacom->id[0]); /* report tool id */
-				wacom_report_abs(wcombo, ABS_X, wacom_le16_to_cpu(&data[1]));
-				wacom_report_abs(wcombo, ABS_Y, wacom_le16_to_cpu(&data[3]));
+				wacom_report_abs(wcombo, ABS_X, get_le16(&data[1]));
+				wacom_report_abs(wcombo, ABS_Y, get_le16(&data[3]));
 				wacom_report_abs(wcombo, ABS_PRESSURE, (signed char)data[6] + 127);
 				wacom_report_key(wcombo, BTN_TOUCH, ((signed char)data[6] > -127));
 				wacom_report_key(wcombo, BTN_STYLUS, (data[5] & 0x40));
@@ -40,8 +41,8 @@ static int wacom_penpartner_irq(struct wacom_wac *wacom, void *wcombo)
 		case 2:
 			wacom_report_key(wcombo, BTN_TOOL_PEN, 1);
 			wacom_report_abs(wcombo, ABS_MISC, STYLUS_DEVICE_ID); /* report tool id */
-			wacom_report_abs(wcombo, ABS_X, wacom_le16_to_cpu(&data[1]));
-			wacom_report_abs(wcombo, ABS_Y, wacom_le16_to_cpu(&data[3]));
+			wacom_report_abs(wcombo, ABS_X, get_le16(&data[1]));
+			wacom_report_abs(wcombo, ABS_Y, get_le16(&data[3]));
 			wacom_report_abs(wcombo, ABS_PRESSURE, (signed char)data[6] + 127);
 			wacom_report_key(wcombo, BTN_TOUCH, ((signed char)data[6] > -80) && !(data[5] & 0x20));
 			wacom_report_key(wcombo, BTN_STYLUS, (data[5] & 0x40));
@@ -144,9 +145,9 @@ static int wacom_ptu_irq(struct wacom_wac *wacom, void *wcombo)
 		id = STYLUS_DEVICE_ID;
 	}
 	wacom_report_abs(wcombo, ABS_MISC, id); /* report tool id */
-	wacom_report_abs(wcombo, ABS_X, wacom_le16_to_cpu(&data[2]));
-	wacom_report_abs(wcombo, ABS_Y, wacom_le16_to_cpu(&data[4]));
-	wacom_report_abs(wcombo, ABS_PRESSURE, wacom_le16_to_cpu(&data[6]));
+	wacom_report_abs(wcombo, ABS_X, get_le16(&data[2]));
+	wacom_report_abs(wcombo, ABS_Y, get_le16(&data[4]));
+	wacom_report_abs(wcombo, ABS_PRESSURE, get_le16(&data[6]));
 	wacom_report_key(wcombo, BTN_STYLUS, data[1] & 0x02);
 	wacom_report_key(wcombo, BTN_STYLUS2, data[1] & 0x10);
 	return 1;
@@ -200,8 +201,8 @@ static int wacom_graphire_irq(struct wacom_wac *wacom, void *wcombo)
 					wacom_report_abs(wcombo, ABS_DISTANCE, data[7] & 0x3f);
 				break;
 		}
-		x = wacom_le16_to_cpu(&data[2]);
-		y = wacom_le16_to_cpu(&data[4]);
+		x = get_le16(&data[2]);
+		y = get_le16(&data[4]);
 		wacom_report_abs(wcombo, ABS_X, x);
 		wacom_report_abs(wcombo, ABS_Y, y);
 		if (wacom->tool[0] != BTN_TOOL_MOUSE) {
@@ -469,8 +470,8 @@ static int wacom_intuos_irq(struct wacom_wac *wacom, void *wcombo)
 		wacom_report_abs(wcombo, ABS_Y, (data[4] << 9) | (data[5] << 1) | (data[9] & 1));
 		wacom_report_abs(wcombo, ABS_DISTANCE, ((data[9] >> 2) & 0x3f));
 	} else {
-		wacom_report_abs(wcombo, ABS_X, wacom_be16_to_cpu(&data[2]));
-		wacom_report_abs(wcombo, ABS_Y, wacom_be16_to_cpu(&data[4]));
+		wacom_report_abs(wcombo, ABS_X, get_be16(&data[2]));
+		wacom_report_abs(wcombo, ABS_Y, get_be16(&data[4]));
 		wacom_report_abs(wcombo, ABS_DISTANCE, ((data[9] >> 3) & 0x1f));
 	}
 
-- 
1.5.6.rc0.277.g804cf
