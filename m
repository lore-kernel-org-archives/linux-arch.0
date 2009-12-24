From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 5/5] xfs: fix xfs to work with Virtually Indexed architectures
Date: Thu, 24 Dec 2009 12:03:14 +0100
Message-ID: <20091224110314.GA21653@lst.de>
References: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de> <1261603345-2494-2-git-send-email-James.Bottomley@suse.de> <1261603345-2494-3-git-send-email-James.Bottomley@suse.de> <1261603345-2494-4-git-send-email-James.Bottomley@suse.de> <1261603345-2494-5-git-send-email-James.Bottomley@suse.de> <1261603345-2494-6-git-send-email-James.Bottomley@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1261603345-2494-6-git-send-email-James.Bottomley@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 23, 2009 at 03:22:25PM -0600, James Bottomley wrote:
> xfs_buf.c includes what is essentially a hand rolled version of
> blk_rq_map_kern().  In order to work properly with the vmalloc buffers
> that xfs uses, this hand rolled routine must also implement the flushing
> API for vmap/vmalloc areas.
> 
> Signed-off-by: James Bottomley <James.Bottomley@suse.de>

Looks good except some minor style issues.  Fix in the version below
which also adds a helper to calculate the length of the vmap area
instead of calculating it twice.

---

From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCHv2 5/5] xfs: fix xfs to work with Virtually Indexed architectures

xfs_buf.c includes what is essentially a hand rolled version of
blk_rq_map_kern().  In order to work properly with the vmalloc buffers
that xfs uses, this hand rolled routine must also implement the flushing
API for vmap/vmalloc areas.

Signed-off-by: James Bottomley <James.Bottomley@suse.de>

Index: linux-2.6/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.orig/fs/xfs/linux-2.6/xfs_buf.c	2009-12-17 08:05:53.962275389 +0100
+++ linux-2.6/fs/xfs/linux-2.6/xfs_buf.c	2009-12-24 11:59:02.031073134 +0100
@@ -76,6 +76,27 @@ struct workqueue_struct *xfsconvertd_wor
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
 
+	if (!error && xfs_buf_is_vmapped(bp))
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
