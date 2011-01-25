From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 17/25] mm: Improve page_lock_anon_vma() comment
Date: Tue, 25 Jan 2011 18:31:28 +0100
Message-ID: <20110125174908.101902158@chello.nl>
References: <20110125173111.720927511@chello.nl>
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline; filename=peter_zijlstra-mm-improve_page_lock_anon_vma_comment.patch
Sender: owner-linux-mm@kvack.org
To: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-fo
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Hugh Dickins <hughd@google.com>
List-Id: linux-arch.vger.kernel.org

A slightly more verbose comment to go along with the trickery in
page_lock_anon_vma().

Reviewed-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Acked-by: Mel Gorman <mel@csn.ul.ie>
Acked-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 mm/rmap.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -315,8 +315,22 @@ void __init anon_vma_init(void)
 }
 
 /*
- * Getting a lock on a stable anon_vma from a page off the LRU is
- * tricky: page_lock_anon_vma rely on RCU to guard against the races.
+ * Getting a lock on a stable anon_vma from a page off the LRU is tricky!
+ *
+ * Since there is no serialization what so ever against page_remove_rmap()
+ * the best this function can do is return a locked anon_vma that might
+ * have been relevant to this page.
+ *
+ * The page might have been remapped to a different anon_vma or the anon_vma
+ * returned may already be freed (and even reused).
+ *
+ * All users of this function must be very careful when walking the anon_vma
+ * chain and verify that the page in question is indeed mapped in it
+ * [ something equivalent to page_mapped_in_vma() ].
+ *
+ * Since anon_vma's slab is DESTROY_BY_RCU and we know from page_remove_rmap()
+ * that the anon_vma pointer from page->mapping is valid if there is a
+ * mapcount, we can dereference the anon_vma after observing those.
  */
 struct anon_vma *page_lock_anon_vma(struct page *page)
 {


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom policy in Canada: sign http://dissolvethecrtc.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
