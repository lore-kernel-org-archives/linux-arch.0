Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:19593 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264551AbUEMUfh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 May 2004 16:35:37 -0400
Message-Id: <200405132035.i4DKZYJ11445@mail.osdl.org>
Subject: [patch 2/4] Fix page double-freeing race
From: akpm@osdl.org
Date: Thu, 13 May 2004 13:38:11 -0700
To: linux-arch@vger.kernel.org
Cc: akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>



This has been there for nearly two years.  See bugzilla #1403

vmscan.c does, in two places:

	spin_lock(zone->lru_lock)
	page = lru_to_page(&zone->inactive_list);
	if (page_count(page) == 0) {
		/* erk, it's being freed by __page_cache_release() or
		 * release_pages()
		 */
		put_it_back_on_the_lru();
		
	} else {

	--> window 1 <--

		page_cache_get(page);
		put_in_on_private_list();
	}
	spin_unlock(zone->lru_lock)

	use_the_private_list();

	page_cache_release(page);



whereas __page_cache_release() and release_pages() do:

	if (put_page_testzero(page)) {

	--> window 2 <--

		spin_lock(lru->lock);
		if (page_count(page) == 0) {
			remove_it_from_the_lru();
			really_free_the_page()
		}
		spin_unlock(zone->lru_lock)
	}


The race occurs if the vmscan.c path sees page_count()==1 and then the
page_cache_release() path happens in that few-instruction "window 1" before
vmscan's page_cache_get().

The page_cache_release() path does put_page_testzero(), which returns true. 
Then this CPU takes an interrupt...

The vmscan.c path then does page_cache_get(), taking the refcount to one. 
Then it uses the page and does page_cache_release(), taking the refcount to
zero and the page is really freed.

Now, the CPU running page_cache_release() returns from the interrupt, takes
the LRU lock, sees the page still has a refcount of zero and frees it again. 
Boom.


The patch fixes this by closing "window 1".  We provide a
"get_page_testone()" which grabs a ref on the page and returns true if the
refcount was previously zero.  If that happens the vmscan.c code simply drops
the page's refcount again and leaves the page on the LRU.

All this happens under the zone->lru_lock, which is also taken by
__page_cache_release() and release_pages(), so the vmscan code knows that the
page has not been returned to the page allocator yet.


In terms of implementation, the page counts are now offset by one: a free page
has page->_count of -1.  This is so that we can use atomic_add_negative() and
atomic_inc_and_test() to provide get_page_testone() and put_page_testzero().

The macros hide all of this so the public interpretation of page_count() and
set_page_count() remains unaltered.

The compiler can usually constant-fold the offsetting of page->count.  This
patch increases an x86 SMP kernel's text by 32 bytes.

The patch renames page->count to page->_count to break callers who aren't
using the macros.

This patch requires that the architecture implement atomic_add_negative().  It
is currently present on

	arm
	arm26
	i386
	ia64
	mips
	ppc
	s390
	v850
	x86_64

ppc implements this as

#define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)

and atomic_add_return() is implemented on

	alpha
	cris
	h8300
	ia64
	m68knommu
	mips
	parisc
	ppc
	ppc
	ppc64
	s390
	sh
	sparc
	v850

so we're looking pretty good.


---

 25-akpm/include/linux/mm.h |   48 +++++++++++++++++++++++++++++++--------------
 25-akpm/mm/vmscan.c        |   21 +++++++++++++------
 2 files changed, 48 insertions(+), 21 deletions(-)

diff -puN include/linux/mm.h~page-freeing-race-fix include/linux/mm.h
--- 25/include/linux/mm.h~page-freeing-race-fix	Thu May 13 13:36:09 2004
+++ 25-akpm/include/linux/mm.h	Thu May 13 13:36:09 2004
@@ -179,7 +179,7 @@ typedef unsigned long page_flags_t;
 struct page {
 	page_flags_t flags;		/* atomic flags, some possibly
 					   updated asynchronously */
-	atomic_t count;			/* Usage count, see below. */
+	atomic_t _count;		/* Usage count, see below. */
 	struct address_space *mapping;	/* The inode (or ...) we belong to. */
 	pgoff_t index;			/* Our offset within mapping. */
 	struct list_head lru;		/* Pageout list, eg. active_list;
@@ -227,15 +227,35 @@ struct page {
  *
  * Also, many kernel routines increase the page count before a critical
  * routine so they can be sure the page doesn't go away from under them.
+ *
+ * Since 2.6.6 (approx), a free page has ->_count = -1.  This is so that we
+ * can use atomic_add_negative(-1, page->_count) to detect when the page
+ * becomes free and so that we can also use atomic_inc_and_test to atomically
+ * detect when we just tried to grab a ref on a page which some other CPU has
+ * already deemed to be freeable.
+ *
+ * NO code should make assumptions about this internal detail!  Use the provided
+ * macros which retain the old rules: page_count(page) == 0 is a free page.
+ */
+
+/*
+ * Drop a ref, return true if the logical refcount fell to zero (the page has
+ * no users)
  */
 #define put_page_testzero(p)				\
 	({						\
 		BUG_ON(page_count(p) == 0);		\
-		atomic_dec_and_test(&(p)->count);	\
+		atomic_add_negative(-1, &(p)->_count);	\
 	})
 
-#define set_page_count(p,v) 	atomic_set(&(p)->count, v)
-#define __put_page(p)		atomic_dec(&(p)->count)
+/*
+ * Grab a ref, return true if the page previously had a logical refcount of
+ * zero.  ie: returns true if we just grabbed an already-deemed-to-be-free page
+ */
+#define get_page_testone(p)	atomic_inc_and_test(&(p)->_count)
+
+#define set_page_count(p,v) 	atomic_set(&(p)->_count, v - 1)
+#define __put_page(p)		atomic_dec(&(p)->_count)
 
 extern void FASTCALL(__page_cache_release(struct page *));
 
@@ -245,25 +265,25 @@ static inline int page_count(struct page
 {
 	if (PageCompound(p))
 		p = (struct page *)p->private;
-	return atomic_read(&(p)->count);
+	return atomic_read(&(p)->_count) + 1;
 }
 
 static inline void get_page(struct page *page)
 {
 	if (unlikely(PageCompound(page)))
 		page = (struct page *)page->private;
-	atomic_inc(&page->count);
+	atomic_inc(&page->_count);
 }
 
 void put_page(struct page *page);
 
 #else		/* CONFIG_HUGETLB_PAGE */
 
-#define page_count(p)		atomic_read(&(p)->count)
+#define page_count(p)		(atomic_read(&(p)->_count) + 1)
 
 static inline void get_page(struct page *page)
 {
-	atomic_inc(&page->count);
+	atomic_inc(&page->_count);
 }
 
 static inline void put_page(struct page *page)
@@ -280,13 +300,13 @@ static inline void put_page(struct page 
  * zeroes, and text pages of executables and shared libraries have
  * only one copy in memory, at most, normally.
  *
- * For the non-reserved pages, page->count denotes a reference count.
- *   page->count == 0 means the page is free.
- *   page->count == 1 means the page is used for exactly one purpose
+ * For the non-reserved pages, page_count(page) denotes a reference count.
+ *   page_count() == 0 means the page is free.
+ *   page_count() == 1 means the page is used for exactly one purpose
  *   (e.g. a private data page of one process).
  *
  * A page may be used for kmalloc() or anyone else who does a
- * __get_free_page(). In this case the page->count is at least 1, and
+ * __get_free_page(). In this case the page_count() is at least 1, and
  * all other fields are unused but should be 0 or NULL. The
  * management of this page is the responsibility of the one who uses
  * it.
@@ -303,14 +323,14 @@ static inline void put_page(struct page 
  * page's address_space.  Usually, this is the address of a circular
  * list of the page's disk buffers.
  *
- * For pages belonging to inodes, the page->count is the number of
+ * For pages belonging to inodes, the page_count() is the number of
  * attaches, plus 1 if `private' contains something, plus one for
  * the page cache itself.
  *
  * All pages belonging to an inode are in these doubly linked lists:
  * mapping->clean_pages, mapping->dirty_pages and mapping->locked_pages;
  * using the page->list list_head. These fields are also used for
- * freelist managemet (when page->count==0).
+ * freelist managemet (when page_count()==0).
  *
  * There is also a per-mapping radix tree mapping index to the page
  * in memory if present. The tree is rooted at mapping->root.  
diff -puN mm/vmscan.c~page-freeing-race-fix mm/vmscan.c
--- 25/mm/vmscan.c~page-freeing-race-fix	Thu May 13 13:36:09 2004
+++ 25-akpm/mm/vmscan.c	Thu May 13 13:36:09 2004
@@ -501,14 +501,16 @@ shrink_cache(struct zone *zone, unsigned
 			if (!TestClearPageLRU(page))
 				BUG();
 			list_del(&page->lru);
-			if (page_count(page) == 0) {
-				/* It is currently in pagevec_release() */
+			if (get_page_testone(page)) {
+				/*
+				 * It is being freed elsewhere
+				 */
+				__put_page(page);
 				SetPageLRU(page);
 				list_add(&page->lru, &zone->inactive_list);
 				continue;
 			}
 			list_add(&page->lru, &page_list);
-			page_cache_get(page);
 			nr_taken++;
 		}
 		zone->nr_inactive -= nr_taken;
@@ -574,7 +576,7 @@ done:
  * It is safe to rely on PG_active against the non-LRU pages in here because
  * nobody will play with that bit on a non-LRU page.
  *
- * The downside is that we have to touch page->count against each page.
+ * The downside is that we have to touch page->_count against each page.
  * But we had to alter page->flags anyway.
  */
 static void
@@ -603,12 +605,17 @@ refill_inactive_zone(struct zone *zone, 
 		if (!TestClearPageLRU(page))
 			BUG();
 		list_del(&page->lru);
-		if (page_count(page) == 0) {
-			/* It is currently in pagevec_release() */
+		if (get_page_testone(page)) {
+			/*
+			 * It was already free!  release_pages() or put_page()
+			 * are about to remove it from the LRU and free it. So
+			 * put the refcount back and put the page back on the
+			 * LRU
+			 */
+			__put_page(page);
 			SetPageLRU(page);
 			list_add(&page->lru, &zone->active_list);
 		} else {
-			page_cache_get(page);
 			list_add(&page->lru, &l_hold);
 			pgmoved++;
 		}

_
