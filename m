From: Nick Piggin <npiggin@suse.de>
Subject: [patch] mm: vmalloc fix lazy unmapping cache aliasing
Date: Wed, 19 Nov 2008 05:53:38 +0100
Message-ID: <20081119045338.GA18697@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:33997 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbYKSExn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 18 Nov 2008 23:53:43 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, rmk@arm.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>


Jim Radford has reported that the vmap subsystem rewrite was sometimes causing
his VIVT ARM system to behave strangely (seemed like going into infinite loops
trying to fault in pages to userspace).

We determined that the problem was most likely due to a cache aliasing issue.
flush_cache_vunmap was only being called at the moment the page tables were
to be taken down, however with lazy unmapping, this can happen after the page
has subsequently been freed and allocated for something else. The dangling
alias may still have dirty data attached to it.

The fix for this problem is to do the cache flushing when the caller has
called vunmap -- it would be a bug for them to write anything else to the
mapping at that point.

That appeared to solve Jim's problems.

Reported-by: Jim Radford <radford@blackbean.org>
Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/mm/vmalloc.c
===================================================================
--- linux-2.6.orig/mm/vmalloc.c
+++ linux-2.6/mm/vmalloc.c
@@ -77,7 +77,6 @@ static void vunmap_page_range(unsigned l
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset_k(addr);
-	flush_cache_vunmap(addr, end);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
@@ -543,9 +542,10 @@ static void purge_vmap_area_lazy(void)
 }
 
 /*
- * Free and unmap a vmap area
+ * Free and unmap a vmap area, caller ensuring flush_cache_vunmap had been
+ * called for the correct range previously.
  */
-static void free_unmap_vmap_area(struct vmap_area *va)
+static void free_unmap_vmap_area_noflush(struct vmap_area *va)
 {
 	va->flags |= VM_LAZY_FREE;
 	atomic_add((va->va_end - va->va_start) >> PAGE_SHIFT, &vmap_lazy_nr);
@@ -553,6 +553,15 @@ static void free_unmap_vmap_area(struct 
 		try_purge_vmap_area_lazy();
 }
 
+/*
+ * Free and unmap a vmap area
+ */
+static void free_unmap_vmap_area(struct vmap_area *va)
+{
+	flush_cache_vunmap(va->va_start, va->va_end);
+	free_unmap_vmap_area_noflush(va);
+}
+
 static struct vmap_area *find_vmap_area(unsigned long addr)
 {
 	struct vmap_area *va;
@@ -734,7 +743,7 @@ static void free_vmap_block(struct vmap_
 	spin_unlock(&vmap_block_tree_lock);
 	BUG_ON(tmp != vb);
 
-	free_unmap_vmap_area(vb->va);
+	free_unmap_vmap_area_noflush(vb->va);
 	call_rcu(&vb->rcu_head, rcu_free_vb);
 }
 
@@ -820,6 +829,8 @@ static void vb_free(const void *addr, un
 		free_vmap_block(vb);
 	} else
 		spin_unlock(&vb->lock);
+
+	flush_cache_vunmap((unsigned long)addr, (unsigned long)addr + size);
 }
 
 /**
