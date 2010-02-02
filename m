From: akpm@linux-foundation.org
Subject: [patch 05/16] mm: flush dcache before writing into page to avoid alias
Date: Tue, 02 Feb 2010 13:44:02 -0800
Message-ID: <201002022144.o12Li2wj015711@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40225 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754223Ab0BBVpp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2010 16:45:45 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, anfei.zhou@gmail.com, linux-arch@vger.kernel.org, miklos@szeredi.hu, nickpiggin@yahoo.com.au, rmk@arm.linux.org.uk, stable@kernel.org

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
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-arch@vger.kernel.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/fuse/file.c |    3 +++
 mm/filemap.c   |    3 +++
 2 files changed, 6 insertions(+)

diff -puN fs/fuse/file.c~mm-flush-dcache-before-writing-into-page-to-avoid-alias fs/fuse/file.c
--- a/fs/fuse/file.c~mm-flush-dcache-before-writing-into-page-to-avoid-alias
+++ a/fs/fuse/file.c
@@ -828,6 +828,9 @@ static ssize_t fuse_fill_write_pages(str
 		if (!page)
 			break;
 
+		if (mapping_writably_mapped(mapping))
+			flush_dcache_page(page);
+
 		pagefault_disable();
 		tmp = iov_iter_copy_from_user_atomic(page, ii, offset, bytes);
 		pagefault_enable();
diff -puN mm/filemap.c~mm-flush-dcache-before-writing-into-page-to-avoid-alias mm/filemap.c
--- a/mm/filemap.c~mm-flush-dcache-before-writing-into-page-to-avoid-alias
+++ a/mm/filemap.c
@@ -2232,6 +2232,9 @@ again:
 		if (unlikely(status))
 			break;
 
+		if (mapping_writably_mapped(mapping))
+			flush_dcache_page(page);
+
 		pagefault_disable();
 		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
 		pagefault_enable();
_
