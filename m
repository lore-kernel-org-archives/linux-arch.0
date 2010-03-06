From: Patch from anfei zhou <linuxtv-commits-bounces@linuxtv.org>
Subject: [git:v4l-dvb/master] mm: flush dcache before writing into page to avoid alias
Date: Sat, 06 Mar 2010 15:27:18 +0100
Message-ID: <E1NnuyM-0001G9-JH@www.linuxtv.org>
Reply-To: linux-media@vger.kernel.org
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linuxtv.org ([130.149.80.248]:57452 "EHLO www.linuxtv.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753620Ab0CFPDL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 6 Mar 2010 10:03:11 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxtv-commits@linuxtv.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Andrew Morton <akpm@linux-foundation.org>, Anfei <anfei.zhou@gmail.com>, linux-arch@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>

From: anfei zhou <anfei.zhou@gmail.com>

The cache alias problem will happen if the changes of user shared mapping
is not flushed before copying, then user and kernel mapping may be mapped
into two different cache line, it is impossible to guarantee the coherence
after iov_iter_copy_from_user_atomic.  So the right steps should be:

	flush_dcache_page(page);
	kmap_atomic(page);
	write to page;
	kunmap_atomic(page);
	flush_dcache_page(page);

More precisely, we might create two new APIs flush_dcache_user_page and
flush_dcache_kern_page to replace the two flush_dcache_page accordingly.

Here is a snippet tested on omap2430 with VIPT cache, and I think it is
not ARM-specific:

	int val = 0x11111111;
	fd = open("abc", O_RDWR);
	addr = mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	*(addr+0) = 0x44444444;
	tmp = *(addr+0);
	*(addr+1) = 0x77777777;
	write(fd, &val, sizeof(int));
	close(fd);

The results are not always 0x11111111 0x77777777 at the beginning as expected.  Sometimes we see 0x44444444 0x77777777.

Signed-off-by: Anfei <anfei.zhou@gmail.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: <linux-arch@vger.kernel.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

 fs/fuse/file.c |    3 +++
 mm/filemap.c   |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

---

http://git.linuxtv.org/v4l-dvb.git?a=commitdiff;h=931e80e4b3263db75c8e34f078d22f11bbabd3a3

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c18913a..a9f5e13 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -828,6 +828,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_req *req,
 		if (!page)
 			break;
 
+		if (mapping_writably_mapped(mapping))
+			flush_dcache_page(page);
+
 		pagefault_disable();
 		tmp = iov_iter_copy_from_user_atomic(page, ii, offset, bytes);
 		pagefault_enable();
diff --git a/mm/filemap.c b/mm/filemap.c
index e373692..698ea80 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2232,6 +2232,9 @@ again:
 		if (unlikely(status))
 			break;
 
+		if (mapping_writably_mapped(mapping))
+			flush_dcache_page(page);
+
 		pagefault_disable();
 		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
 		pagefault_enable();
