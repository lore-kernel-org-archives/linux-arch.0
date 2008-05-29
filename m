From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 07/37] block: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:07 -0700
Message-ID: <1212092287.28403.109.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:49470 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595AbYE2USL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:11 -0400
Received: by ug-out-1314.google.com with SMTP id h2so181697ugf.16
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:09 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/block/cciss.c     |   11 +++++------
 drivers/block/paride/pd.c |    8 ++++----
 drivers/block/ub.c        |    4 ++--
 drivers/cdrom/cdrom.c     |    2 +-
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index e336b05..a7926b6 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -1513,8 +1513,7 @@ static int rebuild_lun_table(ctlr_info_t *h, struct gendisk *del_disk)
 					      0, 0, TYPE_CMD);
 
 		if (return_code == IO_OK) {
-			listlength =
-				be32_to_cpu(*(__be32 *) ld_buff->LUNListLength);
+			listlength = get_be32((__be32 *)ld_buff->LUNListLength);
 		} else {	/* reading number of logical volumes failed */
 			printk(KERN_WARNING "cciss: report logical volume"
 			       " command failed\n");
@@ -2036,8 +2035,8 @@ cciss_read_capacity(int ctlr, int logvol, int withirq, sector_t *total_size,
 				ctlr, buf, sizeof(ReadCapdata_struct),
 					1, logvol, 0, NULL, TYPE_CMD);
 	if (return_code == IO_OK) {
-		*total_size = be32_to_cpu(*(__be32 *) buf->total_size);
-		*block_size = be32_to_cpu(*(__be32 *) buf->block_size);
+		*total_size = get_be32((__be32 *)buf->total_size);
+		*block_size = get_be32((__be32 *)buf->block_size);
 	} else {		/* read capacity command failed */
 		printk(KERN_WARNING "cciss: read capacity failed\n");
 		*total_size = 0;
@@ -2072,8 +2071,8 @@ cciss_read_capacity_16(int ctlr, int logvol, int withirq, sector_t *total_size,
 				1, logvol, 0, NULL, TYPE_CMD);
 	}
 	if (return_code == IO_OK) {
-		*total_size = be64_to_cpu(*(__be64 *) buf->total_size);
-		*block_size = be32_to_cpu(*(__be32 *) buf->block_size);
+		*total_size = get_be64((__be64 *)buf->total_size);
+		*block_size = get_be32((__be32 *)buf->block_size);
 	} else {		/* read capacity command failed */
 		printk(KERN_WARNING "cciss: read capacity failed\n");
 		*total_size = 0;
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 570f3b7..9d8d848 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -663,11 +663,11 @@ static enum action pd_identify(struct pd_unit *disk)
 		return Fail;
 	pi_read_block(disk->pi, pd_scratch, 512);
 	disk->can_lba = pd_scratch[99] & 2;
-	disk->sectors = le16_to_cpu(*(__le16 *) (pd_scratch + 12));
-	disk->heads = le16_to_cpu(*(__le16 *) (pd_scratch + 6));
-	disk->cylinders = le16_to_cpu(*(__le16 *) (pd_scratch + 2));
+	disk->sectors = get_le16((__le16 *)(pd_scratch + 12));
+	disk->heads = get_le16((__le16 *)(pd_scratch + 6));
+	disk->cylinders = get_le16((__le16 *)(pd_scratch + 2));
 	if (disk->can_lba)
-		disk->capacity = le32_to_cpu(*(__le32 *) (pd_scratch + 120));
+		disk->capacity = get_le32((__le32 *)(pd_scratch + 120));
 	else
 		disk->capacity = disk->sectors * disk->heads * disk->cylinders;
 
diff --git a/drivers/block/ub.c b/drivers/block/ub.c
index 3a281ef..41476ce 100644
--- a/drivers/block/ub.c
+++ b/drivers/block/ub.c
@@ -1914,8 +1914,8 @@ static int ub_sync_read_cap(struct ub_dev *sc, struct ub_lun *lun,
 	}
 
 	/* sd.c special-cases sector size of 0 to mean 512. Needed? Safe? */
-	nsec = be32_to_cpu(*(__be32 *)p) + 1;
-	bsize = be32_to_cpu(*(__be32 *)(p + 4));
+	nsec = get_be32((__be32 *)p) + 1;
+	bsize = get_be32((__be32 *)(p + 4));
 	switch (bsize) {
 	case 512:	shift = 0;	break;
 	case 1024:	shift = 1;	break;
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 69f26eb..4830d32 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3032,7 +3032,7 @@ static int mmc_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
 		   how much data is available for transfer. buffer[1] is
 		   unfortunately ambigious and the only reliable way seem
 		   to be to simply skip over the block descriptor... */
-		offset = 8 + be16_to_cpu(*(__be16 *)(buffer+6));
+		offset = 8 + get_be16((__be16 *)(buffer + 6));
 
 		if (offset + 16 > sizeof(buffer))
 			return -E2BIG;
-- 
1.5.6.rc0.277.g804cf
