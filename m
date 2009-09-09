From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 6/6] xfs: fix xfs to work with Virtually Indexed architectures
Date: Wed,  9 Sep 2009 10:52:16 -0500
Message-ID: <1252511536-22066-7-git-send-email-James.Bottomley@suse.de>
References: <1252511536-22066-1-git-send-email-James.Bottomley@suse.de>
 <1252511536-22066-2-git-send-email-James.Bottomley@suse.de>
 <1252511536-22066-3-git-send-email-James.Bottomley@suse.de>
 <1252511536-22066-4-git-send-email-James.Bottomley@suse.de>
 <1252511536-22066-5-git-send-email-James.Bottomley@suse.de>
 <1252511536-22066-6-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47992 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753044AbZIIPwh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 9 Sep 2009 11:52:37 -0400
In-Reply-To: <1252511536-22066-6-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <James.Bottomley@suse.de>

xfs_buf.c includes what is essentially a hand rolled version of
blk_rq_map_kern().  In order to work properly with the vmalloc buffers
that xfs uses, this hand rolled routine must also implement the flushing
API for vmap/vmalloc areas.

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 fs/xfs/linux-2.6/xfs_buf.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/fs/xfs/linux-2.6/xfs_buf.c b/fs/xfs/linux-2.6/xfs_buf.c
index 965df12..62ae977 100644
--- a/fs/xfs/linux-2.6/xfs_buf.c
+++ b/fs/xfs/linux-2.6/xfs_buf.c
@@ -1138,6 +1138,10 @@ xfs_buf_bio_end_io(
 	do {
 		struct page	*page = bvec->bv_page;
 
+		if (is_vmalloc_addr(bp->b_addr))
+			invalidate_kernel_dcache_addr(bp->b_addr +
+						      bvec->bv_offset);
+
 		ASSERT(!PagePrivate(page));
 		if (unlikely(bp->b_error)) {
 			if (bp->b_flags & XBF_READ)
@@ -1202,6 +1206,9 @@ _xfs_buf_ioapply(
 		bio->bi_end_io = xfs_buf_bio_end_io;
 		bio->bi_private = bp;
 
+		if (is_vmalloc_addr(bp->b_addr))
+			flush_kernel_dcache_addr(bp->b_addr);
+
 		bio_add_page(bio, bp->b_pages[0], PAGE_CACHE_SIZE, 0);
 		size = 0;
 
@@ -1228,6 +1235,9 @@ next_chunk:
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
