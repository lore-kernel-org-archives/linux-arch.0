Return-Path: <manfred@colorfullife.com>
Received: from dbl.q-ag.de ([213.172.117.3]:2273 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262382AbUEOMWc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 15 May 2004 08:22:32 -0400
Message-ID: <40A60B82.7070901@colorfullife.com>
Date: Sat, 15 May 2004 14:22:26 +0200
From: Manfred Spraul <manfred@colorfullife.com>
MIME-Version: 1.0
Subject: [PATCH] add kmem_cache_alloc_node
Content-Type: multipart/mixed;
 boundary="------------010009030103060602060103"
To: Andrew Morton <akpm@digeo.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010009030103060602060103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

the attached patch adds a simple kmem_cache_alloc_node function: 
allocate memory on a given node. The function is intended for cpu bound 
structures. It's used for alloc_percpu and for the slab-internal per-cpu 
structures. Jack Steiner reported a ~3% performance increase for AIM7 on 
a 64-way Itanium 2.

Andrew, could you add it to your -mm tree?

Port maintainers: The patch could cause problems if CPU_UP_PREPARE is 
called for a cpu on a node before the corresponding memory is attached 
and/or if alloc_pages_node doesn't fall back to memory from another node 
if there is no memory in the requested node. I think noone does that, 
but I'm not sure.

--
    Manfred

--------------010009030103060602060103
Content-Type: text/plain;
 name="patch-slab-mm-03-nodelink"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-mm-03-nodelink"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 6
//  EXTRAVERSION = -mm2
--- 2.6/include/linux/slab.h	2004-05-15 11:38:21.000000000 +0200
+++ build-2.6/include/linux/slab.h	2004-05-15 13:06:21.000000000 +0200
@@ -61,6 +61,7 @@
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
+extern void *kmem_cache_alloc_node(kmem_cache_t *, int);
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
 
--- 2.6/mm/slab.c	2004-05-15 13:06:53.000000000 +0200
+++ build-2.6/mm/slab.c	2004-05-15 13:06:21.000000000 +0200
@@ -612,6 +612,26 @@
 }
 #endif
 
+static struct array_cache *alloc_arraycache(int cpu, int entries, int batchcount)
+{
+	int memsize = sizeof(void*)*entries+sizeof(struct array_cache);
+	struct array_cache *nc = NULL;
+
+	if (cpu != -1) {
+		nc = kmem_cache_alloc_node(kmem_find_general_cachep(memsize, GFP_KERNEL),
+					cpu_to_node(cpu));
+	}
+	if (!nc)
+		nc = kmalloc(memsize, GFP_KERNEL);
+	if (nc) {
+		nc->avail = 0;
+		nc->limit = entries;
+		nc->batchcount = batchcount;
+		nc->touched = 0;
+	}
+	return nc;
+}
+
 static int __devinit cpuup_callback(struct notifier_block *nfb,
 				  unsigned long action,
 				  void *hcpu)
@@ -623,17 +643,11 @@
 	case CPU_UP_PREPARE:
 		down(&cache_chain_sem);
 		list_for_each_entry(cachep, &cache_chain, next) {
-			int memsize;
 			struct array_cache *nc;
 
-			memsize = sizeof(void*)*cachep->limit+sizeof(struct array_cache);
-			nc = kmalloc(memsize, GFP_KERNEL);
+			nc = alloc_arraycache(cpu, cachep->limit, cachep->batchcount);
 			if (!nc)
 				goto bad;
-			nc->avail = 0;
-			nc->limit = cachep->limit;
-			nc->batchcount = cachep->batchcount;
-			nc->touched = 0;
 
 			spin_lock_irq(&cachep->spinlock);
 			cachep->array[cpu] = nc;
@@ -829,23 +843,32 @@
  * did not request dmaable memory, we might get it, but that
  * would be relatively rare and ignorable.
  */
-static inline void *kmem_getpages(kmem_cache_t *cachep, unsigned long flags)
+static void *kmem_getpages(kmem_cache_t *cachep, int flags, int nodeid)
 {
+	struct page *page;
 	void *addr;
+	int i;
 
 	flags |= cachep->gfpflags;
-	addr = (void*)__get_free_pages(flags, cachep->gfporder);
-	if (addr) {
-		int i = (1 << cachep->gfporder);
-		struct page *page = virt_to_page(addr);
-
-		if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
-			atomic_add(i, &slab_reclaim_pages);
-		add_page_state(nr_slab, i);
-		while (i--) {
-			SetPageSlab(page);
-			page++;
-		}
+	if (likely(nodeid == -1)) {
+		addr = (void*)__get_free_pages(flags, cachep->gfporder);
+		if (!addr)
+			return NULL;
+		page = virt_to_page(addr);
+	} else {
+		page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+		if (!page)
+			return NULL;
+		addr = page_address(page);
+	}
+
+	i = (1 << cachep->gfporder);
+	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
+		atomic_add(i, &slab_reclaim_pages);
+	add_page_state(nr_slab, i);
+	while (i--) {
+		SetPageSlab(page);
+		page++;
 	}
 	return addr;
 }
@@ -1652,6 +1675,21 @@
 	}
 }
 
+static void set_slab_attr(kmem_cache_t *cachep, struct slab *slabp, void *objp)
+{
+	int i;
+	struct page *page;
+
+	/* Nasty!!!!!! I hope this is OK. */
+	i = 1 << cachep->gfporder;
+	page = virt_to_page(objp);
+	do {
+		SET_PAGE_CACHE(page, cachep);
+		SET_PAGE_SLAB(page, slabp);
+		page++;
+	} while (--i);
+}
+
 /*
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
@@ -1659,10 +1697,9 @@
 static int cache_grow (kmem_cache_t * cachep, int flags)
 {
 	struct slab	*slabp;
-	struct page	*page;
 	void		*objp;
 	size_t		 offset;
-	unsigned int	 i, local_flags;
+	int		 local_flags;
 	unsigned long	 ctor_flags;
 
 	/* Be lazy and only check for valid flags here,
@@ -1708,21 +1745,14 @@
 
 
 	/* Get mem for the objs. */
-	if (!(objp = kmem_getpages(cachep, flags)))
+	if (!(objp = kmem_getpages(cachep, flags, -1)))
 		goto failed;
 
 	/* Get slab management. */
 	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, local_flags)))
 		goto opps1;
 
-	/* Nasty!!!!!! I hope this is OK. */
-	i = 1 << cachep->gfporder;
-	page = virt_to_page(objp);
-	do {
-		SET_PAGE_CACHE(page, cachep);
-		SET_PAGE_SLAB(page, slabp);
-		page++;
-	} while (--i);
+	set_slab_attr(cachep, slabp, objp);
 
 	cache_init_objs(cachep, slabp, ctor_flags);
 
@@ -2239,6 +2269,80 @@
 }
 
 /**
+ * kmem_cache_alloc_node - Allocate an object on the specified node
+ * @cachep: The cache to allocate from.
+ * @flags: See kmalloc().
+ * @nodeid: node number of the target node.
+ *
+ * Identical to kmem_cache_alloc, except that this function is slow
+ * and can sleep. And it will allocate memory on the given node, which
+ * can improve the performance for cpu bound structures.
+ */
+void *kmem_cache_alloc_node(kmem_cache_t *cachep, int nodeid)
+{
+	size_t offset;
+	void *objp;
+	struct slab *slabp;
+	kmem_bufctl_t next;
+
+	/* The main algorithms are not node aware, thus we have to cheat:
+	 * We bypass all caches and allocate a new slab.
+	 * The following code is a streamlined copy of cache_grow().
+	 */
+
+	/* Get colour for the slab, and update the next value. */
+	spin_lock_irq(&cachep->spinlock);
+	offset = cachep->colour_next;
+	cachep->colour_next++;
+	if (cachep->colour_next >= cachep->colour)
+		cachep->colour_next = 0;
+	offset *= cachep->colour_off;
+	spin_unlock_irq(&cachep->spinlock);
+
+	/* Get mem for the objs. */
+	if (!(objp = kmem_getpages(cachep, GFP_KERNEL, nodeid)))
+		goto failed;
+
+	/* Get slab management. */
+	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, GFP_KERNEL)))
+		goto opps1;
+
+	set_slab_attr(cachep, slabp, objp);
+	cache_init_objs(cachep, slabp, SLAB_CTOR_CONSTRUCTOR);
+
+	/* The first object is ours: */
+	objp = slabp->s_mem + slabp->free*cachep->objsize;
+	slabp->inuse++;
+	next = slab_bufctl(slabp)[slabp->free];
+#if DEBUG
+	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
+#endif
+	slabp->free = next;
+
+	/* add the remaining objects into the cache */
+	spin_lock_irq(&cachep->spinlock);
+	check_slabp(cachep, slabp);
+	STATS_INC_GROWN(cachep);
+	/* Make slab active. */
+	if (slabp->free == BUFCTL_END) {
+		list_add_tail(&slabp->list, &(list3_data(cachep)->slabs_full));
+	} else {
+		list_add_tail(&slabp->list, &(list3_data(cachep)->slabs_partial));
+		list3_data(cachep)->free_objects += cachep->num-1;
+	}
+	spin_unlock_irq(&cachep->spinlock);
+	objp = cache_alloc_debugcheck_after(cachep, GFP_KERNEL, objp, __builtin_return_address(0));
+	return objp;
+opps1:
+	kmem_freepages(cachep, objp);
+failed:
+	return NULL;
+
+}
+
+EXPORT_SYMBOL(kmem_cache_alloc_node);
+
+/**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
  * @flags: the type of memory to allocate.
@@ -2302,7 +2406,9 @@
 	for (i = 0; i < NR_CPUS; i++) {
 		if (!cpu_possible(i))
 			continue;
-		pdata->ptrs[i] = kmalloc(size, GFP_KERNEL);
+		pdata->ptrs[i] = kmem_cache_alloc_node(kmem_find_general_cachep(size, GFP_KERNEL),
+					cpu_to_node(i));
+
 		if (!pdata->ptrs[i])
 			goto unwind_oom;
 		memset(pdata->ptrs[i], 0, size);
@@ -2441,19 +2547,15 @@
 
 	memset(&new.new,0,sizeof(new.new));
 	for (i = 0; i < NR_CPUS; i++) {
-		struct array_cache *ccnew;
-
-		ccnew = kmalloc(sizeof(void*)*limit+
-				sizeof(struct array_cache), GFP_KERNEL);
-		if (!ccnew) {
-			for (i--; i >= 0; i--) kfree(new.new[i]);
-			return -ENOMEM;
-		}
-		ccnew->avail = 0;
-		ccnew->limit = limit;
-		ccnew->batchcount = batchcount;
-		ccnew->touched = 0;
-		new.new[i] = ccnew;
+		if (cpu_online(i)) {
+			new.new[i] = alloc_arraycache(i, limit, batchcount);
+			if (!new.new[i]) {
+				for (i--; i >= 0; i--) kfree(new.new[i]);
+				return -ENOMEM;
+			}
+		} else {
+			new.new[i] = NULL;
+		}
 	}
 	new.cachep = cachep;
 
@@ -2475,14 +2577,9 @@
 		spin_unlock_irq(&cachep->spinlock);
 		kfree(ccold);
 	}
-	new_shared = kmalloc(sizeof(void*)*batchcount*shared+
-				sizeof(struct array_cache), GFP_KERNEL);
+	new_shared = alloc_arraycache(-1, batchcount*shared, 0xbaadf00d);
 	if (new_shared) {
 		struct array_cache *old;
-		new_shared->avail = 0;
-		new_shared->limit = batchcount*shared;
-		new_shared->batchcount = 0xbaadf00d;
-		new_shared->touched = 0;
 
 		spin_lock_irq(&cachep->spinlock);
 		old = cachep->lists.shared;

--------------010009030103060602060103--
