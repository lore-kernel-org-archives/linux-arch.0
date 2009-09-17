From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 5/6] block: permit I/O to vmalloc/vmap kernel pages
Date: Thu, 17 Sep 2009 18:07:00 -0500
Message-ID: <1253228821-4700-6-git-send-email-James.Bottomley@suse.de>
References: <1253228821-4700-1-git-send-email-James.Bottomley@suse.de>
 <1253228821-4700-2-git-send-email-James.Bottomley@suse.de>
 <1253228821-4700-3-git-send-email-James.Bottomley@suse.de>
 <1253228821-4700-4-git-send-email-James.Bottomley@suse.de>
 <1253228821-4700-5-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1253228821-4700-5-git-send-email-James.Bottomley@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <jejb@external.hp.com>, James Bottomley <James.Bottomley@suse.de>
List-Id: linux-arch.vger.kernel.org

From: James Bottomley <jejb@external.hp.com>

This updates bio_map_kern() to check for pages in the vmalloc address
range and call the new kernel flushing APIs if the are.  This should
allow any kernel user to pass a vmalloc/vmap area to block.

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 fs/bio.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/bio.c b/fs/bio.c
index 7673800..0cf7b79 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -1120,6 +1120,14 @@ void bio_unmap_user(struct bio *bio)
 
 static void bio_map_kern_endio(struct bio *bio, int err)
 {
+	void *kaddr = bio->bi_private;
+
+	if (is_vmalloc_addr(kaddr)) {
+		int i;
+
+		for (i = 0; i < bio->bi_vcnt; i++)
+			invalidate_kernel_dcache_addr(kaddr + i * PAGE_SIZE);
+	}
 	bio_put(bio);
 }
 
@@ -1138,9 +1146,12 @@ static struct bio *__bio_map_kern(struct request_queue *q, void *data,
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
 
+	bio->bi_private = data;
+
 	offset = offset_in_page(kaddr);
 	for (i = 0; i < nr_pages; i++) {
 		unsigned int bytes = PAGE_SIZE - offset;
+		struct page *page;
 
 		if (len <= 0)
 			break;
@@ -1148,8 +1159,13 @@ static struct bio *__bio_map_kern(struct request_queue *q, void *data,
 		if (bytes > len)
 			bytes = len;
 
-		if (bio_add_pc_page(q, bio, virt_to_page(data), bytes,
-				    offset) < bytes)
+		if (is_vmalloc_addr(data)) {
+			flush_kernel_dcache_addr(data);
+			page = vmalloc_to_page(data);
+		} else
+			page = virt_to_page(data);
+
+		if (bio_add_pc_page(q, bio, page, bytes, offset) < bytes)
 			break;
 
 		data += bytes;
-- 
1.6.3.3

