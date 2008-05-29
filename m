From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 29/37] ntfs: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:58 -0700
Message-ID: <1212092338.28403.131.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:42423 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbYE2UTB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:19:01 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3083607wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:19:01 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Anton Altaparmakov <aia21@cantab.net>, linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 fs/ntfs/collate.c  |    4 ++--
 fs/ntfs/compress.c |    8 ++++----
 fs/ntfs/mst.c      |    2 +-
 fs/ntfs/super.c    |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/collate.c b/fs/ntfs/collate.c
index 4a28ab3..d370931 100644
--- a/fs/ntfs/collate.c
+++ b/fs/ntfs/collate.c
@@ -52,8 +52,8 @@ static int ntfs_collate_ntofs_ulong(ntfs_volume *vol,
 	// FIXME:  We don't really want to bug here.
 	BUG_ON(data1_len != data2_len);
 	BUG_ON(data1_len != 4);
-	d1 = le32_to_cpup(data1);
-	d2 = le32_to_cpup(data2);
+	d1 = get_le32(data1);
+	d2 = get_le32(data2);
 	if (d1 < d2)
 		rc = -1;
 	else {
diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index 33ff314..5889609 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -211,7 +211,7 @@ do_next_sb:
 	 * position in the compression block is one byte before its end so the
 	 * first two checks do not detect it.
 	 */
-	if (cb == cb_end || !le16_to_cpup((le16*)cb) ||
+	if (cb == cb_end || !get_le16((le16 *)cb) ||
 			(*dest_index == dest_max_index &&
 			*dest_ofs == dest_max_ofs)) {
 		int i;
@@ -261,7 +261,7 @@ return_error:
 
 	/* Setup the current sub-block source pointers and validate range. */
 	cb_sb_start = cb;
-	cb_sb_end = cb_sb_start + (le16_to_cpup((le16*)cb) & NTFS_SB_SIZE_MASK)
+	cb_sb_end = cb_sb_start + (get_le16((le16 *)cb) & NTFS_SB_SIZE_MASK)
 			+ 3;
 	if (cb_sb_end > cb_end)
 		goto return_overflow;
@@ -283,7 +283,7 @@ return_error:
 	dp_addr = (u8*)page_address(dp) + do_sb_start;
 
 	/* Now, we are ready to process the current sub-block (sb). */
-	if (!(le16_to_cpup((le16*)cb) & NTFS_SB_IS_COMPRESSED)) {
+	if (!(get_le16((le16 *)cb) & NTFS_SB_IS_COMPRESSED)) {
 		ntfs_debug("Found uncompressed sub-block.");
 		/* This sb is not compressed, just copy it into destination. */
 
@@ -388,7 +388,7 @@ do_next_tag:
 			lg++;
 
 		/* Get the phrase token into i. */
-		pt = le16_to_cpup((le16*)cb);
+		pt = get_le16((le16 *)cb);
 
 		/*
 		 * Calculate starting position of the byte sequence in
diff --git a/fs/ntfs/mst.c b/fs/ntfs/mst.c
index 5a858d8..c565d82 100644
--- a/fs/ntfs/mst.c
+++ b/fs/ntfs/mst.c
@@ -146,7 +146,7 @@ int pre_write_mst_fixup(NTFS_RECORD *b, const u32 size)
 	 * Cyclically increment the update sequence number
 	 * (skipping 0 and -1, i.e. 0xffff).
 	 */
-	usn = le16_to_cpup(usa_pos) + 1;
+	usn = get_le16(usa_pos) + 1;
 	if (usn == 0xffff || !usn)
 		usn = 1;
 	le_usn = cpu_to_le16(usn);
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 3e76f3b..21680bc 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -566,7 +566,7 @@ static bool is_boot_sector_ntfs(const struct super_block *sb,
 		u32 i;
 
 		for (i = 0, u = (le32*)b; u < (le32*)(&b->checksum); ++u)
-			i += le32_to_cpup(u);
+			i += get_le32(u);
 		if (le32_to_cpu(b->checksum) != i)
 			ntfs_warning(sb, "Invalid boot sector checksum.");
 	}
-- 
1.5.6.rc0.277.g804cf
