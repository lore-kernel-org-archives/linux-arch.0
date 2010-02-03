From: <gregkh@suse.de>
Subject: patch mm-flush-dcache-before-writing-into-page-to-avoid-alias.patch added to 2.6.32-stable tree
Date: Tue, 02 Feb 2010 20:50:01 -0800
Message-ID: <1265172601829@site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:42165 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757184Ab0BCEvd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 2 Feb 2010 23:51:33 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: anfei.zhou@gmail.com, akpm@linux-foundation.org, gregkh@suse.de, linux-arch@vger.kernel.org, miklos@szeredi.hu, nickpiggin@yahoo.com.au, rmk@arm.linux.org.uk, torvalds@linux-foundation.org
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

    Subject: mm: flush dcache before writing into page to avoid alias

to the 2.6.32-stable tree.  Its filename is

    mm-flush-dcache-before-writing-into-page-to-avoid-alias.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


From 931e80e4b3263db75c8e34f078d22f11bbabd3a3 Mon Sep 17 00:00:00 2001
From: anfei zhou <anfei.zhou@gmail.com>
Date: Tue, 2 Feb 2010 13:44:02 -0800
Subject: mm: flush dcache before writing into page to avoid alias

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


Patches currently in stable-queue which might be from anfei.zhou@gmail.com are
