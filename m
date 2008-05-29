From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 26/37] gfs2: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:53 -0700
Message-ID: <1212092333.28403.128.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:43494 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbYE2USz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:55 -0400
Received: by yx-out-2324.google.com with SMTP id 31so392319yxl.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:54 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Steven Whitehouse <swhiteho@redhat.com>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 fs/gfs2/bmap.c  |    2 +-
 fs/gfs2/inode.c |    7 ++-----
 fs/gfs2/lops.c  |    6 +++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index c19184f..3f029e8 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -160,7 +160,7 @@ int gfs2_unstuff_dinode(struct gfs2_inode *ip, struct page *page)
 	gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
 
 	if (ip->i_di.di_size) {
-		*(__be64 *)(di + 1) = cpu_to_be64(block);
+		put_be64(block, (__be64 *)(di + 1));
 		gfs2_add_inode_blocks(&ip->i_inode, 1);
 		di->di_blocks = cpu_to_be64(gfs2_get_inode_blocks(&ip->i_inode));
 	}
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 09453d0..5c82ce4 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -604,22 +604,19 @@ static int pick_formal_ino_2(struct gfs2_sbd *sdp, u64 *formal_ino)
 	if (!ir.ir_length) {
 		struct buffer_head *m_bh;
 		u64 x, y;
-		__be64 z;
 
 		error = gfs2_meta_inode_buffer(m_ip, &m_bh);
 		if (error)
 			goto out_brelse;
 
-		z = *(__be64 *)(m_bh->b_data + sizeof(struct gfs2_dinode));
-		x = y = be64_to_cpu(z);
+		x = y = get_be64((__be64 *)(m_bh->b_data + sizeof(struct gfs2_dinode)));
 		ir.ir_start = x;
 		ir.ir_length = GFS2_INUM_QUANTUM;
 		x += GFS2_INUM_QUANTUM;
 		if (x < y)
 			gfs2_consist_inode(m_ip);
-		z = cpu_to_be64(x);
 		gfs2_trans_add_bh(m_ip->i_gl, m_bh, 1);
-		*(__be64 *)(m_bh->b_data + sizeof(struct gfs2_dinode)) = z;
+		put_be64(x, (__be64 *)(m_bh->b_data + sizeof(struct gfs2_dinode)));
 
 		brelse(m_bh);
 	}
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 4390f6f..83d420b 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -352,7 +352,7 @@ static void revoke_lo_before_commit(struct gfs2_sbd *sdp)
 			offset = sizeof(struct gfs2_meta_header);
 		}
 
-		*(__be64 *)(bh->b_data + offset) = cpu_to_be64(bd->bd_blkno);
+		put_be64(bd->bd_blkno, (__be64 *)(bh->b_data + offset));
 		kmem_cache_free(gfs2_bufdata_cachep, bd);
 
 		offset += sizeof(u64);
@@ -401,7 +401,7 @@ static int revoke_lo_scan_elements(struct gfs2_jdesc *jd, unsigned int start,
 			gfs2_metatype_check(sdp, bh, GFS2_METATYPE_LB);
 
 		while (offset + sizeof(u64) <= sdp->sd_sb.sb_bsize) {
-			blkno = be64_to_cpu(*(__be64 *)(bh->b_data + offset));
+			blkno = get_be64((__be64 *)(bh->b_data + offset));
 
 			error = gfs2_revoke_add(sdp, blkno, start);
 			if (error < 0) {
@@ -580,7 +580,7 @@ static void gfs2_write_blocks(struct gfs2_sbd *sdp, struct buffer_head *bh,
 			memcpy(bh1->b_data, kaddr + bh_offset(bd->bd_bh),
 			       bh1->b_size);
 			kunmap_atomic(kaddr, KM_USER0);
-			*(__be32 *)bh1->b_data = 0;
+			*(__be32 *)bh1->b_data = cpu_to_be32(0);
 			clear_buffer_escaped(bd->bd_bh);
 			unlock_buffer(bd->bd_bh);
 			brelse(bd->bd_bh);
-- 
1.5.6.rc0.277.g804cf
