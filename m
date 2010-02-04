From: Greg KH <gregkh@suse.de>
Subject: [64/74] mm: flush dcache before writing into page to avoid alias
Date: Thu, 04 Feb 2010 09:12:35 -0800
Message-ID: <20100204171524.332399752@linux.site>
References: <20100204171850.GA16539@kroah.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100204171850.GA16539@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: stable-review@kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Anfei <anfei.zhou@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-arch.vger.kernel.org

2.6.32-stable review patch.  If anyone has any objections, please let us know.

------------------

From: anfei zhou <anfei.zhou@gmail.com>

commit 931e80e4b3263db75c8e34f078d22f11bbabd3a3 upstream.

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
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/fuse/file.c |    3 +++
 mm/filemap.c   |    3 +++
 2 files changed, 6 insertions(+)

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -828,6 +828,9 @@ static ssize_t fuse_fill_write_pages(str
 		if (!page)
 			break;
 
+		if (mapping_writably_mapped(mapping))
+			flush_dcache_page(page);
+
 		pagefault_disable();
 		tmp = iov_iter_copy_from_user_atomic(page, ii, offset, bytes);
 		pagefault_enable();
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2253,6 +2253,9 @@ again:
 		if (unlikely(status))
 			break;
 
+		if (mapping_writably_mapped(mapping))
+			flush_dcache_page(page);
+
 		pagefault_disable();
 		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
 		pagefault_enable();
