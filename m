From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCHv3 5/5] xfs: fix xfs to work with Virtually Indexed architectures
Date: Fri,  5 Feb 2010 09:50:57 -0600
Message-ID: <1265385057-2575-6-git-send-email-James.Bottomley@suse.de>
References: <1265385057-2575-1-git-send-email-James.Bottomley@suse.de>
 <1265385057-2575-2-git-send-email-James.Bottomley@suse.de>
 <1265385057-2575-3-git-send-email-James.Bottomley@suse.de>
 <1265385057-2575-4-git-send-email-James.Bottomley@suse.de>
 <1265385057-2575-5-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52436 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754107Ab0BEPvV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 5 Feb 2010 10:51:21 -0500
In-Reply-To: <1265385057-2575-5-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-parisc@vger.kernel.org, rmk@arm.linux.org.uk, lethal@linux-sh.org, torvalds@linux-foundation.org, hch@lst.de, James Bottomley <James.Bottomley@suse.de>

xfs_buf.c includes what is essentially a hand rolled version of
blk_rq_map_kern().  In order to work properly with the vmalloc buffers
that xfs uses, this hand rolled routine must also implement the flushing
API for vmap/vmalloc areas.

[style updates from hch@lst.de]
Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 fs/xfs/linux-2.6/xfs_buf.c |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/fs/xfs/linux-2.6/xfs_buf.c b/fs/xfs/linux-2.6/xfs_buf.c
index 77b8be8..6f3ebb6 100644
--- a/fs/xfs/linux-2.6/xfs_buf.c
+++ b/fs/xfs/linux-2.6/xfs_buf.c
@@ -76,6 +76,27 @@ struct workqueue_struct *xfsconvertd_workqueue;
 #define xfs_buf_deallocate(bp) \
 	kmem_zone_free(xfs_buf_zone, (bp));
 
+static inline int
+xfs_buf_is_vmapped(
+	struct xfs_buf	*bp)
+{
+	/*
+	 * Return true if the buffer is vmapped.
+	 *
+	 * The XBF_MAPPED flag is set if the buffer should be mapped, but the
+	 * code is clever enough to know it doesn't have to map a single page,
+	 * so the check has to be both for XBF_MAPPED and bp->b_page_count > 1.
+	 */
+	return (bp->b_flags & XBF_MAPPED) && bp->b_page_count > 1;
+}
+
+static inline int
+xfs_buf_vmap_len(
+	struct xfs_buf	*bp)
+{
+	return (bp->b_page_count * PAGE_SIZE) - bp->b_offset;
+}
+
 /*
  *	Page Region interfaces.
  *
@@ -314,7 +335,7 @@ xfs_buf_free(
 	if (bp->b_flags & (_XBF_PAGE_CACHE|_XBF_PAGES)) {
 		uint		i;
 
-		if ((bp->b_flags & XBF_MAPPED) && (bp->b_page_count > 1))
+		if (xfs_buf_is_vmapped(bp))
 			free_address(bp->b_addr - bp->b_offset);
 
 		for (i = 0; i < bp->b_page_count; i++) {
@@ -1107,6 +1128,9 @@ xfs_buf_bio_end_io(
 
 	xfs_buf_ioerror(bp, -error);
 
+	if (!error && xfs_buf_is_vmapped(bp) && (bp->b_flags & XBF_READ))
+		invalidate_kernel_vmap_range(bp->b_addr, xfs_buf_vmap_len(bp));
+
 	do {
 		struct page	*page = bvec->bv_page;
 
@@ -1216,6 +1240,10 @@ next_chunk:
 
 submit_io:
 	if (likely(bio->bi_size)) {
+		if (xfs_buf_is_vmapped(bp)) {
+			flush_kernel_vmap_range(bp->b_addr,
+						xfs_buf_vmap_len(bp));
+		}
 		submit_bio(rw, bio);
 		if (size)
 			goto next_chunk;
-- 
1.6.5
