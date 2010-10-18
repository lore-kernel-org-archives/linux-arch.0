From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 06/20] mm: Use refcounts for page_lock_anon_vma()
Date: Mon, 18 Oct 2010 13:24:39 +0200
Message-ID: <20101018112950.570732815@chello.nl>
References: <20101018112433.556591568@chello.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=mm-ref-page_lock_anon_vma.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-fou
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

Convert page_lock_anon_vma() over to use refcounts. This is
done for each of convertion of anon_vma from spinlock to mutex.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 mm/rmap.c |   34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -332,9 +332,9 @@ void __init anon_vma_init(void)
  * that the anon_vma pointer from page->mapping is valid if there is a
  * mapcount, we can dereference the anon_vma after observing those.
  */
-struct anon_vma *page_lock_anon_vma(struct page *page)
+struct anon_vma *page_get_anon_vma(struct page *page)
 {
-	struct anon_vma *anon_vma, *root_anon_vma;
+	struct anon_vma *anon_vma = NULL;
 	unsigned long anon_mapping;
 
 	rcu_read_lock();
@@ -345,8 +345,10 @@ struct anon_vma *page_lock_anon_vma(stru
 		goto out;
 
 	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
-	root_anon_vma = ACCESS_ONCE(anon_vma->root);
-	spin_lock(&root_anon_vma->lock);
+	if (!atomic_inc_not_zero(&anon_vma->refcount)) {
+		anon_vma = NULL;
+		goto out;
+	}
 
 	/*
 	 * If this page is still mapped, then its anon_vma cannot have been
@@ -356,19 +358,31 @@ struct anon_vma *page_lock_anon_vma(stru
 	 * corrupt): with anon_vma_prepare() or anon_vma_fork() redirecting
 	 * anon_vma->root before page_unlock_anon_vma() is called to unlock.
 	 */
-	if (page_mapped(page))
-		return anon_vma;
-
-	spin_unlock(&root_anon_vma->lock);
+	if (!page_mapped(page)) {
+		put_anon_vma(anon_vma);
+		anon_vma = NULL;
+		goto out;
+	}
 out:
 	rcu_read_unlock();
-	return NULL;
+
+	return anon_vma;
+}
+
+struct anon_vma *page_lock_anon_vma(struct page *page)
+{
+	struct anon_vma *anon_vma = page_get_anon_vma(page);
+
+	if (anon_vma)
+		anon_vma_lock(anon_vma);
+
+	return anon_vma;
 }
 
 void page_unlock_anon_vma(struct anon_vma *anon_vma)
 {
 	anon_vma_unlock(anon_vma);
-	rcu_read_unlock();
+	put_anon_vma(anon_vma);
 }
 
 /*
