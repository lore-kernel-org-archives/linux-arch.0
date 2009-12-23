From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCHv2 5/5] xfs: fix xfs to work with Virtually Indexed architectures
Date: Wed, 23 Dec 2009 15:22:25 -0600
Message-ID: <1261603345-2494-6-git-send-email-James.Bottomley@suse.de>
References: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de>
 <1261603345-2494-2-git-send-email-James.Bottomley@suse.de>
 <1261603345-2494-3-git-send-email-James.Bottomley@suse.de>
 <1261603345-2494-4-git-send-email-James.Bottomley@suse.de>
 <1261603345-2494-5-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58599 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757231AbZLWVW7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 23 Dec 2009 16:22:59 -0500
In-Reply-To: <1261603345-2494-5-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <James.Bottomley@suse.de>

xfs_buf.c includes what is essentially a hand rolled version of
blk_rq_map_kern().  In order to work properly with the vmalloc buffers
that xfs uses, this hand rolled routine must also implement the flushing
API for vmap/vmalloc areas.

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 fs/xfs/linux-2.6/xfs_buf.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/fs/xfs/linux-2.6/xfs_buf.c b/fs/xfs/linux-2.6/xfs_buf.c
index 77b8be8..4c77d96 100644
--- a/fs/xfs/linux-2.6/xfs_buf.c
+++ b/fs/xfs/linux-2.6/xfs_buf.c
@@ -76,6 +76,19 @@ struct workqueue_struct *xfsconvertd_workqueue;
 #define xfs_buf_deallocate(bp) \
 	kmem_zone_free(xfs_buf_zone, (bp));
 
+STATIC int
+xfs_bp_is_vmapped(
+	xfs_buf_t	*bp)
+{
+	/* return true if the buffer is vmapped. The XBF_MAPPED flag
+	 * is set if the buffer should be mapped, but the code is
+	 * clever enough to know it doesn't have to map a single page,
+	 * so the check has to be both for XBF_MAPPED and
+	 * bp->b_page_count > 1 */
+	return (bp->b_flags & XBF_MAPPED) && bp->b_page_count > 1;
+}
+
+
 /*
  *	Page Region interfaces.
  *
@@ -314,7 +327,7 @@ xfs_buf_free(
 	if (bp->b_flags & (_XBF_PAGE_CACHE|_XBF_PAGES)) {
 		uint		i;
 
-		if ((bp->b_flags & XBF_MAPPED) && (bp->b_page_count > 1))
+		if (xfs_bp_is_vmapped(bp))
 			free_address(bp->b_addr - bp->b_offset);
 
 		for (i = 0; i < bp->b_page_count; i++) {
@@ -1107,6 +1120,9 @@ xfs_buf_bio_end_io(
 
 	xfs_buf_ioerror(bp, -error);
 
+	if (!error && xfs_bp_is_vmapped(bp))
+		invalidate_kernel_vmap_range(bp->b_addr, (bp->b_page_count * PAGE_SIZE) - bp->b_offset);
+
 	do {
 		struct page	*page = bvec->bv_page;
 
@@ -1216,6 +1232,8 @@ next_chunk:
 
 submit_io:
 	if (likely(bio->bi_size)) {
+		if (xfs_bp_is_vmapped(bp))
+			flush_kernel_vmap_range(bp->b_addr, (bp->b_page_count * PAGE_SIZE) - bp->b_offset);
 		submit_bio(rw, bio);
 		if (size)
 			goto next_chunk;
-- 
1.6.5
