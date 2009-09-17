From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 6/6] xfs: fix xfs to work with Virtually Indexed architectures
Date: Thu, 17 Sep 2009 18:07:01 -0500
Message-ID: <1253228821-4700-7-git-send-email-James.Bottomley@suse.de>
References: <1253228821-4700-1-git-send-email-James.Bottomley@suse.de>
 <1253228821-4700-2-git-send-email-James.Bottomley@suse.de>
 <1253228821-4700-3-git-send-email-James.Bottomley@suse.de>
 <1253228821-4700-4-git-send-email-James.Bottomley@suse.de>
 <1253228821-4700-5-git-send-email-James.Bottomley@suse.de>
 <1253228821-4700-6-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40321 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753809AbZIQXH3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Sep 2009 19:07:29 -0400
In-Reply-To: <1253228821-4700-6-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <jejb@external.hp.com>, James Bottomley <James.Bottomley@suse.de>

From: James Bottomley <jejb@external.hp.com>

xfs_buf.c includes what is essentially a hand rolled version of
blk_rq_map_kern().  In order to work properly with the vmalloc buffers
that xfs uses, this hand rolled routine must also implement the flushing
API for vmap/vmalloc areas.

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 fs/xfs/linux-2.6/xfs_buf.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/fs/xfs/linux-2.6/xfs_buf.c b/fs/xfs/linux-2.6/xfs_buf.c
index 965df12..320a6e4 100644
--- a/fs/xfs/linux-2.6/xfs_buf.c
+++ b/fs/xfs/linux-2.6/xfs_buf.c
@@ -1132,12 +1132,26 @@ xfs_buf_bio_end_io(
 	xfs_buf_t		*bp = (xfs_buf_t *)bio->bi_private;
 	unsigned int		blocksize = bp->b_target->bt_bsize;
 	struct bio_vec		*bvec = bio->bi_io_vec + bio->bi_vcnt - 1;
+	void			*vaddr = NULL;
+	int			i;
 
 	xfs_buf_ioerror(bp, -error);
 
+	if (is_vmalloc_addr(bp->b_addr))
+		for (i = 0; i < bp->b_page_count; i++)
+			if (bvec->bv_page == bp->b_pages[i]) {
+				vaddr = bp->b_addr + i*PAGE_SIZE;
+				break;
+			}
+
 	do {
 		struct page	*page = bvec->bv_page;
 
+		if (is_vmalloc_addr(bp->b_addr)) {
+			invalidate_kernel_dcache_addr(vaddr);
+			vaddr -= PAGE_SIZE;
+		}
+
 		ASSERT(!PagePrivate(page));
 		if (unlikely(bp->b_error)) {
 			if (bp->b_flags & XBF_READ)
@@ -1202,6 +1216,9 @@ _xfs_buf_ioapply(
 		bio->bi_end_io = xfs_buf_bio_end_io;
 		bio->bi_private = bp;
 
+		if (is_vmalloc_addr(bp->b_addr))
+			flush_kernel_dcache_addr(bp->b_addr);
+
 		bio_add_page(bio, bp->b_pages[0], PAGE_CACHE_SIZE, 0);
 		size = 0;
 
@@ -1228,6 +1245,9 @@ next_chunk:
 		if (nbytes > size)
 			nbytes = size;
 
+		if (is_vmalloc_addr(bp->b_addr))
+			flush_kernel_dcache_addr(bp->b_addr + PAGE_SIZE*map_i);
+
 		rbytes = bio_add_page(bio, bp->b_pages[map_i], nbytes, offset);
 		if (rbytes < nbytes)
 			break;
-- 
1.6.3.3
