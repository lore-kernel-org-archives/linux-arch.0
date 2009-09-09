From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 5/6] block: permit I/O to vmalloc/vmap kernel pages
Date: Wed,  9 Sep 2009 10:52:15 -0500
Message-ID: <1252511536-22066-6-git-send-email-James.Bottomley@suse.de>
References: <1252511536-22066-1-git-send-email-James.Bottomley@suse.de>
 <1252511536-22066-2-git-send-email-James.Bottomley@suse.de>
 <1252511536-22066-3-git-send-email-James.Bottomley@suse.de>
 <1252511536-22066-4-git-send-email-James.Bottomley@suse.de>
 <1252511536-22066-5-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:57691 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815AbZIIPwg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 9 Sep 2009 11:52:36 -0400
In-Reply-To: <1252511536-22066-5-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <James.Bottomley@suse.de>

This updates bio_map_kern() to check for pages in the vmalloc address
range and call the new kernel flushing APIs if the are.  This should
allow any kernel user to pass a vmalloc/vmap area to block.

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 fs/bio.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/bio.c b/fs/bio.c
index 7673800..ea346b4 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -1120,6 +1120,13 @@ void bio_unmap_user(struct bio *bio)
 
 static void bio_map_kern_endio(struct bio *bio, int err)
 {
+	void *kaddr = bio->bi_private;
+	if (is_vmalloc_addr(kaddr)) {
+		void *addr;
+		for (addr = kaddr; addr < kaddr + bio->bi_size;
+		     addr += PAGE_SIZE)
+			invalidate_kernel_dcache_addr(addr);
+	}
 	bio_put(bio);
 }
 
@@ -1138,9 +1145,12 @@ static struct bio *__bio_map_kern(struct request_queue *q, void *data,
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
@@ -1148,8 +1158,13 @@ static struct bio *__bio_map_kern(struct request_queue *q, void *data,
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
