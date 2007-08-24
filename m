Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:51991 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbXHXD0r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Aug 2007 23:26:47 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id A476C13005
	for <linux-arch@vger.kernel.org>; Fri, 24 Aug 2007 05:26:46 +0200 (CEST)
Date: Fri, 24 Aug 2007 05:26:46 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: [rfc] vmalloc: lazy, batched vunmapping
Message-ID: <20070824032646.GE6989@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi,

I'm working on a bit of code that vmaps/vunmaps a bit more often than
I'd like. I've implemented a frontend to cache commonly used mappings,
which solves most of the problem, but in looking various other ways to
get the last bit of performance, I thought might be generally helpful
to batch up vunmap driven TLB flushes. So I'll just throw the idea
out there (is anyone else doing a lot of vmapping? I'd like to hear
from you!).

Anyway, the idea is just that we don't free up the virtual address space
immediately but wait until we've collected a batch of them, and free
them all at once and only flush the TLBs once per batch.

We are able to free the pages at vfree-time, because although we may
still have TLBs pointing to them, it would be a kernel bug to access
those TLBs at this stage (AFAIKS, we still do need to flush the cache
at vunmap-time, however).

And we are able to flush at vmap-time if we run out of virtual area.

So the cost is pretty small -- with 128 deferred regions sitting there,
it's maybe like 8K worth of struct vm_structs.

Here is a rough hack. Comments?

--

Index: linux-2.6/mm/vmalloc.c
===================================================================
--- linux-2.6.orig/mm/vmalloc.c
+++ linux-2.6/mm/vmalloc.c
@@ -24,8 +24,13 @@
 DEFINE_RWLOCK(vmlist_lock);
 struct vm_struct *vmlist;
 
+#define LAZY_MAX 128
+static unsigned long lazy_start = -1UL, lazy_end = 0;
+static unsigned int lazy_nr;
+
 static void *__vmalloc_node(unsigned long size, gfp_t gfp_mask, pgprot_t prot,
 			    int node);
+static void __purge_vm_area_lazy(void);
 
 static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end)
 {
@@ -68,23 +73,33 @@ static inline void vunmap_pud_range(pgd_
 	} while (pud++, addr = next, addr != end);
 }
 
-void unmap_kernel_range(unsigned long addr, unsigned long size)
+/*
+ * This function does not flush pagetables itself.
+ */
+static void __unmap_kernel_range(unsigned long addr, unsigned long end)
 {
 	pgd_t *pgd;
 	unsigned long next;
-	unsigned long start = addr;
-	unsigned long end = addr + size;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset_k(addr);
-	flush_cache_vunmap(addr, end);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		vunmap_pud_range(pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
-	flush_tlb_kernel_range(start, end);
+}
+
+void unmap_kernel_range(unsigned long addr, unsigned long size)
+{
+	unsigned long end = addr + size;
+
+	BUG_ON(addr >= end);
+
+	flush_cache_vunmap(addr, end);
+	__unmap_kernel_range(addr, end);
+	flush_tlb_kernel_range(addr, end);
 }
 
 static void unmap_vm_area(struct vm_struct *area)
@@ -200,6 +215,7 @@ static struct vm_struct *__get_vm_area_n
 	size += PAGE_SIZE;
 
 	write_lock(&vmlist_lock);
+retry:
 	for (p = &vmlist; (tmp = *p) != NULL ;p = &tmp->next) {
 		if ((unsigned long)tmp->addr < addr) {
 			if((unsigned long)tmp->addr + tmp->size >= addr)
@@ -215,7 +231,7 @@ static struct vm_struct *__get_vm_area_n
 		if (addr > end - size)
 			goto out;
 	}
-
+	/* XXX: should have addr > end - size check here */
 found:
 	area->next = *p;
 	*p = area;
@@ -231,6 +247,11 @@ found:
 	return area;
 
 out:
+	if (lazy_nr) {
+		__purge_vm_area_lazy();
+		addr = ALIGN(start, align);
+		goto retry;
+	}
 	write_unlock(&vmlist_lock);
 	kfree(area);
 	if (printk_ratelimit())
@@ -291,13 +312,64 @@ static struct vm_struct *__remove_vm_are
 	return NULL;
 
 found:
+	BUG_ON(tmp->flags & VM_LAZYFREE);
 	unmap_vm_area(tmp);
 	*p = tmp->next;
 
-	/*
-	 * Remove the guard page.
-	 */
-	tmp->size -= PAGE_SIZE;
+	return tmp;
+}
+
+static void __purge_vm_area_lazy(void)
+{
+	struct vm_struct **p, *tmp;
+
+	p = &vmlist;
+	while ((tmp = *p) != NULL) {
+		if (tmp->flags & VM_LAZYFREE) {
+			unsigned long start = (unsigned long)tmp->addr;
+			unsigned long end = start + tmp->size;
+
+			BUG_ON(start < lazy_start);
+			BUG_ON(end > lazy_end);
+
+			*p = tmp->next;
+			__unmap_kernel_range(start, end);
+			kfree(tmp);
+			lazy_nr--;
+		} else
+			p = &tmp->next;
+	}
+	flush_tlb_kernel_range(lazy_start, lazy_end);
+	BUG_ON(lazy_nr != 0);
+
+	lazy_end = 0;
+	lazy_start = -1UL;
+}
+
+static struct vm_struct *__remove_vm_area_lazy(void *addr)
+{
+	struct vm_struct *tmp;
+
+	tmp = __find_vm_area(addr);
+	if (tmp) {
+		unsigned long start, end;
+
+		if (tmp->flags & VM_LAZYFREE)
+			return NULL; /* shouldn't happen */
+
+		start = (unsigned long)tmp->addr;
+		end = start + tmp->size;
+
+		flush_cache_vunmap(start, end);
+
+		tmp->flags |= VM_LAZYFREE;
+		if (start < lazy_start)
+			lazy_start = start;
+		if (end > lazy_end)
+			lazy_end = end;
+		lazy_nr++;
+	}
+
 	return tmp;
 }
 
@@ -321,6 +393,8 @@ struct vm_struct *remove_vm_area(void *a
 static void __vunmap(void *addr, int deallocate_pages)
 {
 	struct vm_struct *area;
+	struct page **pages;
+	int nrpages, vpages;
 
 	if (!addr)
 		return;
@@ -331,32 +405,40 @@ static void __vunmap(void *addr, int dea
 		return;
 	}
 
-	area = remove_vm_area(addr);
+	write_lock(&vmlist_lock);
+	area = __remove_vm_area_lazy(addr);
 	if (unlikely(!area)) {
+		write_unlock(&vmlist_lock);
 		printk(KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
 				addr);
 		WARN_ON(1);
 		return;
 	}
 
-	debug_check_no_locks_freed(addr, area->size);
+	debug_check_no_locks_freed(addr, area->size - PAGE_SIZE);
+
+	pages = area->pages;
+	nrpages = area->nr_pages;
+	vpages = area->flags & VM_VPAGES;
+
+	if (lazy_nr > LAZY_MAX)
+		__purge_vm_area_lazy();
+
+	write_unlock(&vmlist_lock);
 
 	if (deallocate_pages) {
 		int i;
 
-		for (i = 0; i < area->nr_pages; i++) {
-			BUG_ON(!area->pages[i]);
-			__free_page(area->pages[i]);
+		for (i = 0; i < nrpages; i++) {
+			BUG_ON(!pages[i]);
+			__free_page(pages[i]);
 		}
 
-		if (area->flags & VM_VPAGES)
-			vfree(area->pages);
+		if (vpages)
+			vfree(pages);
 		else
-			kfree(area->pages);
+			kfree(pages);
 	}
-
-	kfree(area);
-	return;
 }
 
 /**
Index: linux-2.6/include/linux/vmalloc.h
===================================================================
--- linux-2.6.orig/include/linux/vmalloc.h
+++ linux-2.6/include/linux/vmalloc.h
@@ -12,6 +12,7 @@ struct vm_area_struct;
 #define VM_MAP		0x00000004	/* vmap()ed pages */
 #define VM_USERMAP	0x00000008	/* suitable for remap_vmalloc_range */
 #define VM_VPAGES	0x00000010	/* buffer for pages was vmalloc'ed */
+#define VM_LAZYFREE	0x00000020	/* area is unmapped lazily */
 /* bits [20..32] reserved for arch specific ioremap internals */
 
 /*
