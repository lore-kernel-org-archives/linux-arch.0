From: akpm@linux-foundation.org
Subject: [patch 050/176] mm: filemap_fault: unique path for locking page
Date: Tue, 26 Oct 2010 14:21:56 -0700
Message-ID: <201010262121.o9QLLuvu016509@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51215 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756814Ab0JZVd2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Oct 2010 17:33:28 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, walken@google.com, a.p.zijlstra@chello.nl, fengguang.wu@intel.com, hpa@zytor.com, linux-arch@vger.kernel.org, mingo@elte.hu, nickpiggin@yahoo.com.au, riel@redhat.com, tglx@linutronix.de, yinghan@google.com

From: Michel Lespinasse <walken@google.com>

Introduce a single location where filemap_fault() locks the desired page. 
There used to be two such places, depending if the initial find_get_page()
was successful or not.

Signed-off-by: Michel Lespinasse <walken@google.com>
Acked-by: Rik van Riel <riel@redhat.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Reviewed-by: Wu Fengguang <fengguang.wu@intel.com>
Cc: Ying Han <yinghan@google.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/filemap.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff -puN mm/filemap.c~mm-filemap_fault-unique-path-for-locking-page mm/filemap.c
--- a/mm/filemap.c~mm-filemap_fault-unique-path-for-locking-page
+++ a/mm/filemap.c
@@ -1539,25 +1539,27 @@ int filemap_fault(struct vm_area_struct 
 		 * waiting for the lock.
 		 */
 		do_async_mmap_readahead(vma, ra, file, page, offset);
-		lock_page(page);
-
-		/* Did it get truncated? */
-		if (unlikely(page->mapping != mapping)) {
-			unlock_page(page);
-			put_page(page);
-			goto no_cached_page;
-		}
 	} else {
 		/* No page in the page cache at all */
 		do_sync_mmap_readahead(vma, ra, file, offset);
 		count_vm_event(PGMAJFAULT);
 		ret = VM_FAULT_MAJOR;
 retry_find:
-		page = find_lock_page(mapping, offset);
+		page = find_get_page(mapping, offset);
 		if (!page)
 			goto no_cached_page;
 	}
 
+	lock_page(page);
+
+	/* Did it get truncated? */
+	if (unlikely(page->mapping != mapping)) {
+		unlock_page(page);
+		put_page(page);
+		goto retry_find;
+	}
+	VM_BUG_ON(page->index != offset);
+
 	/*
 	 * We have a locked page in the page cache, now we need to check
 	 * that it's up-to-date. If not, it is going to be due to an error.
_
