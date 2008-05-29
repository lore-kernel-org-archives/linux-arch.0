From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 14/37] media: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:26 -0700
Message-ID: <1212092306.28403.116.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:43046 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbYE2US1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:27 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3083458wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:27 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, v4l-maintainer <v4l-dvb-maintainer@linuxtv.org>, linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/media/dvb/frontends/or51132.c             |    2 +-
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    5 +++--
 drivers/media/video/bt8xx/bttv-cards.c            |    4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb/frontends/or51132.c b/drivers/media/dvb/frontends/or51132.c
index c7b5785..e45905d 100644
--- a/drivers/media/dvb/frontends/or51132.c
+++ b/drivers/media/dvb/frontends/or51132.c
@@ -126,7 +126,7 @@ static int or51132_readreg(struct or51132_state *state, u8 reg)
 		       reg, err);
 		return -EREMOTEIO;
 	}
-	return le16_to_cpup((u16*)buf);
+	return get_le16((__le16 *)buf);
 }
 
 static int or51132_load_firmware (struct dvb_frontend* fe, const struct firmware *fw)
diff --git a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
index 732ce4d..68a4056 100644
--- a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
+++ b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/jiffies.h>
 #include <linux/mutex.h>
+#include <asm/unaligned.h>
 
 #include "dvb_frontend.h"
 #include "dmxdev.h"
@@ -552,7 +553,7 @@ static void ttusb_process_muxpack(struct ttusb *ttusb, const u8 * muxpack,
 	u16 csum = 0, cc;
 	int i;
 	for (i = 0; i < len; i += 2)
-		csum ^= le16_to_cpup((u16 *) (muxpack + i));
+		csum ^= get_le16((__le16 *)(muxpack + i));
 	if (csum) {
 		printk("%s: muxpack with incorrect checksum, ignoring\n",
 		       __func__);
@@ -560,7 +561,7 @@ static void ttusb_process_muxpack(struct ttusb *ttusb, const u8 * muxpack,
 		return;
 	}
 
-	cc = (muxpack[len - 4] << 8) | muxpack[len - 3];
+	cc = get_unaligned_be16(muxpack + len - 4);
 	cc &= 0x7FFF;
 	if ((cc != ttusb->cc) && (ttusb->cc != -1))
 		printk("%s: cc discontinuity (%d frames missing)\n",
diff --git a/drivers/media/video/bt8xx/bttv-cards.c b/drivers/media/video/bt8xx/bttv-cards.c
index f20a01c..128daa2 100644
--- a/drivers/media/video/bt8xx/bttv-cards.c
+++ b/drivers/media/video/bt8xx/bttv-cards.c
@@ -3858,7 +3858,7 @@ static void __devinit osprey_eeprom(struct bttv *btv, const u8 ee[256])
 		ee += i;
 
 		/* found a valid descriptor */
-		type = be16_to_cpup((u16*)(ee+4));
+		type = get_be16((__be16 *)(ee + 4));
 
 		switch(type) {
 		/* 848 based */
@@ -3918,7 +3918,7 @@ static void __devinit osprey_eeprom(struct bttv *btv, const u8 ee[256])
 			       btv->c.nr, type);
 			break;
 		}
-		serial = be32_to_cpup((u32*)(ee+6));
+		serial = get_be32((__be32 *)(ee + 6));
 	}
 
 	printk(KERN_INFO "bttv%d: osprey eeprom: card=%d '%s' serial=%u\n",
-- 
1.5.6.rc0.277.g804cf
