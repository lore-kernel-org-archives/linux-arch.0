From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 4/5] block: permit I/O to vmalloc/vmap kernel pages
Date: Tue, 08 Sep 2009 22:21:04 -0500
Message-ID: <1252466464.13003.372.camel@mulgrave.site>
References: <1252434469.13003.3.camel@mulgrave.site>
	 <20090908190031.GF6538@flint.arm.linux.org.uk>
	 <1252437112.13003.39.camel@mulgrave.site>
	 <20090908201619.GG6538@flint.arm.linux.org.uk>
	 <1252442352.13003.132.camel@mulgrave.site>
	 <20090908213910.GH6538@flint.arm.linux.org.uk>
	 <1252466070.13003.365.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1252466070.13003.365.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Parisc List <linux-parisc@vger.kernel.org>, Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

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



