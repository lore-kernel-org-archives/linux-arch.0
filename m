From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 33/37] udf: use get/put_endian helpers
Date: Thu, 29 May 2008 13:19:07 -0700
Message-ID: <1212092347.28403.135.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:44045 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbYE2UTI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:19:08 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3083761wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:19:08 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 fs/udf/namei.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index d323194..247694a 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -572,8 +572,8 @@ static int udf_create(struct inode *dir, struct dentry *dentry, int mode,
 	}
 	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
 	cfi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
-		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
+	put_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL,
+		(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse);
 	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
 	if (UDF_I(dir)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
 		mark_inode_dirty(dir);
@@ -617,8 +617,8 @@ static int udf_mknod(struct inode *dir, struct dentry *dentry, int mode,
 	}
 	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
 	cfi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
-		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
+	put_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL,
+		(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse);
 	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
 	if (UDF_I(dir)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
 		mark_inode_dirty(dir);
@@ -667,8 +667,8 @@ static int udf_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 	inode->i_nlink = 2;
 	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
 	cfi.icb.extLocation = cpu_to_lelb(dinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
-		cpu_to_le32(dinfo->i_unique & 0x00000000FFFFFFFFUL);
+	put_le32(dinfo->i_unique & 0x00000000FFFFFFFFUL,
+		(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse);
 	cfi.fileCharacteristics =
 			FID_FILE_CHAR_DIRECTORY | FID_FILE_CHAR_PARENT;
 	udf_write_fi(inode, &cfi, fi, &fibh, NULL, NULL);
@@ -687,8 +687,8 @@ static int udf_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 	}
 	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
 	cfi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
-		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
+	put_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL,
+		(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse);
 	cfi.fileCharacteristics |= FID_FILE_CHAR_DIRECTORY;
 	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
 	inc_nlink(dir);
@@ -1014,8 +1014,8 @@ static int udf_symlink(struct inode *dir, struct dentry *dentry,
 		lvhd = (struct logicalVolHeaderDesc *)
 				lvid->logicalVolContentsUse;
 		uniqueID = le64_to_cpu(lvhd->uniqueID);
-		*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
-			cpu_to_le32(uniqueID & 0x00000000FFFFFFFFUL);
+		put_le32(uniqueID & 0x00000000FFFFFFFFUL,
+			(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse);
 		if (!(++uniqueID & 0x00000000FFFFFFFFUL))
 			uniqueID += 16;
 		lvhd->uniqueID = cpu_to_le64(uniqueID);
@@ -1072,8 +1072,8 @@ static int udf_link(struct dentry *old_dentry, struct inode *dir,
 		lvhd = (struct logicalVolHeaderDesc *)
 				(lvid->logicalVolContentsUse);
 		uniqueID = le64_to_cpu(lvhd->uniqueID);
-		*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
-			cpu_to_le32(uniqueID & 0x00000000FFFFFFFFUL);
+		put_le32(uniqueID & 0x00000000FFFFFFFFUL,
+			(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse);
 		if (!(++uniqueID & 0x00000000FFFFFFFFUL))
 			uniqueID += 16;
 		lvhd->uniqueID = cpu_to_le64(uniqueID);
-- 
1.5.6.rc0.277.g804cf
