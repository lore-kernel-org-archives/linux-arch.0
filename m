From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH 6/6] xfs: fix xfs to work with Virtually Indexed
 architectures
Date: Fri, 11 Sep 2009 21:57:15 +0000
Message-ID: <1252706235.13282.104.camel@mulgrave.site>
References: <1252511536-22066-1-git-send-email-James.Bottomley@suse.de>
	 <1252511536-22066-2-git-send-email-James.Bottomley@suse.de>
	 <1252511536-22066-3-git-send-email-James.Bottomley@suse.de>
	 <1252511536-22066-4-git-send-email-James.Bottomley@suse.de>
	 <1252511536-22066-5-git-send-email-James.Bottomley@suse.de>
	 <1252511536-22066-6-git-send-email-James.Bottomley@suse.de>
	 <1252511536-22066-7-git-send-email-James.Bottomley@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1252511536-22066-7-git-send-email-James.Bottomley@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 2009-09-09 at 10:52 -0500, James Bottomley wrote:
> xfs_buf.c includes what is essentially a hand rolled version of
> blk_rq_map_kern().  In order to work properly with the vmalloc buffers
> that xfs uses, this hand rolled routine must also implement the flushing
> API for vmap/vmalloc areas.
> 
> Signed-off-by: James Bottomley <James.Bottomley@suse.de>
> ---
>  fs/xfs/linux-2.6/xfs_buf.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/xfs/linux-2.6/xfs_buf.c b/fs/xfs/linux-2.6/xfs_buf.c
> index 965df12..62ae977 100644
> --- a/fs/xfs/linux-2.6/xfs_buf.c
> +++ b/fs/xfs/linux-2.6/xfs_buf.c
> @@ -1138,6 +1138,10 @@ xfs_buf_bio_end_io(
>  	do {
>  		struct page	*page = bvec->bv_page;
>  
> +		if (is_vmalloc_addr(bp->b_addr))
> +			invalidate_kernel_dcache_addr(bp->b_addr +
> +						      bvec->bv_offset);

OK, so this invalidation logic is completely wrong.  For large vmalloc
buffers, xfs will split them up over several bios.  The only way I can
think to fix this is below ... comments?

If everyone is OK, I'll reroll the patches with this built in.

James

---

diff --git a/fs/xfs/linux-2.6/xfs_buf.c b/fs/xfs/linux-2.6/xfs_buf.c
index 62ae977..320a6e4 100644
--- a/fs/xfs/linux-2.6/xfs_buf.c
+++ b/fs/xfs/linux-2.6/xfs_buf.c
@@ -1132,15 +1132,25 @@ xfs_buf_bio_end_io(
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
 
-		if (is_vmalloc_addr(bp->b_addr))
-			invalidate_kernel_dcache_addr(bp->b_addr +
-						      bvec->bv_offset);
+		if (is_vmalloc_addr(bp->b_addr)) {
+			invalidate_kernel_dcache_addr(vaddr);
+			vaddr -= PAGE_SIZE;
+		}
 
 		ASSERT(!PagePrivate(page));
 		if (unlikely(bp->b_error)) {


