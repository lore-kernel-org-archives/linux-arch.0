From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 04/10] radio: Use get/put_unaligned_* helpers
Date: Mon, 14 Apr 2008 09:37:55 -0700
Message-ID: <1208191075.5721.26.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763053AbYDNQjQ@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/media/radio/radio-si470x.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/media/radio/radio-si470x.c b/drivers/media/radio/radio-si470x.c
index 649f14d..1e9678e 100644
--- a/drivers/media/radio/radio-si470x.c
+++ b/drivers/media/radio/radio-si470x.c
@@ -513,8 +513,7 @@ static int si470x_get_register(struct si470x_device *radio, int regnr)
 	retval = si470x_get_report(radio, (void *) &buf, sizeof(buf));
 
 	if (retval >= 0)
-		radio->registers[regnr] = be16_to_cpu(get_unaligned(
-			(unsigned short *) &buf[1]));
+		radio->registers[regnr] = get_unaligned_be16(&buf[1]);
 
 	return (retval < 0) ? -EINVAL : 0;
 }
@@ -529,8 +528,7 @@ static int si470x_set_register(struct si470x_device *radio, int regnr)
 	int retval;
 
 	buf[0] = REGISTER_REPORT(regnr);
-	put_unaligned(cpu_to_be16(radio->registers[regnr]),
-		(unsigned short *) &buf[1]);
+	put_unaligned_be16(radio->registers[regnr], &buf[1]);
 
 	retval = si470x_set_report(radio, (void *) &buf, sizeof(buf));
 
@@ -553,9 +551,8 @@ static int si470x_get_all_registers(struct si470x_device *radio)
 
 	if (retval >= 0)
 		for (regnr = 0; regnr < RADIO_REGISTER_NUM; regnr++)
-			radio->registers[regnr] = be16_to_cpu(get_unaligned(
-				(unsigned short *)
-				&buf[regnr * RADIO_REGISTER_SIZE + 1]));
+			radio->registers[regnr] = get_unaligned_be16(
+				&buf[regnr * RADIO_REGISTER_SIZE + 1]);
 
 	return (retval < 0) ? -EINVAL : 0;
 }
@@ -586,8 +583,7 @@ static int si470x_get_rds_registers(struct si470x_device *radio)
 	if (retval >= 0)
 		for (regnr = 0; regnr < RDS_REGISTER_NUM; regnr++)
 			radio->registers[STATUSRSSI + regnr] =
-				be16_to_cpu(get_unaligned((unsigned short *)
-				&buf[regnr * RADIO_REGISTER_SIZE + 1]));
+				get_unaligned_be16(&buf[regnr * RADIO_REGISTER_SIZE + 1]);
 
 	return (retval < 0) ? -EINVAL : 0;
 }
@@ -835,7 +831,7 @@ static void si470x_rds(struct si470x_device *radio)
 		};
 
 		/* Fill the V4L2 RDS buffer */
-		put_unaligned(cpu_to_le16(rds), (unsigned short *) &tmpbuf);
+		put_unaligned_le16(rds, &tmpbuf);
 		tmpbuf[2] = blocknum;		/* offset name */
 		tmpbuf[2] |= blocknum << 3;	/* received offset */
 		if (bler > max_rds_errors)
-- 
1.5.5.144.g3e42
