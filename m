From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 21:35:04 +0200
Message-ID: <1212176104.24826.53.camel@lappy.programming.kicks-ass.net>
References: <20080530035620.587204923@sgi.com>
	 <1212138752.12349.227.camel@twins>
	 <Pine.LNX.4.64.0805301101490.14564@schroedinger.engr.sgi.com>
	 <1212171574.24826.12.camel@lappy.programming.kicks-ass.net>
	 <Pine.LNX.4.64.0805301126130.14781@schroedinger.engr.sgi.com>
	 <1212173236.24826.29.camel@lappy.programming.kicks-ass.net>
	 <Pine.LNX.4.64.0805301156530.16253@schroedinger.engr.sgi.com>
	 <1212175315.24826.49.camel@lappy.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:59332 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbYE3Tf4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 15:35:56 -0400
In-Reply-To: <1212175315.24826.49.camel@lappy.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 2008-05-30 at 21:21 +0200, Peter Zijlstra wrote:
> On Fri, 2008-05-30 at 12:10 -0700, Christoph Lameter wrote:

> > Ahh. Okay. This would make the lockless preemptless fastpath impossible 
> > because it would have to use some sort of locking to avoid access to the 
> > same percpu data from multiple processor?
> 
> TBH its been a while since I attempted slub-rt, but yes that got hairy.
> I think it can be done using cmpxchg and speculative page refs, but I
> can't quite recall.

This is the last version I could find on my disks (2007-11-17) - it does
indeed have a severely handicapped fast-path.

Never got around to testing it properly - so it might be utter bollocks.

---
Subject: rt: make SLUB usable

Spurred by John Corbet's harsh words that SLUB is not available for -rt
I made a quick fix for this.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Christoph Lameter <clameter@sgi.com>
---
 include/linux/slub_def.h |    3 +
 init/Kconfig             |    1 
 mm/slub.c                |  108 ++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 88 insertions(+), 24 deletions(-)

Index: linux-2.6/init/Kconfig
===================================================================
--- linux-2.6.orig/init/Kconfig
+++ linux-2.6/init/Kconfig
@@ -635,7 +635,6 @@ config SLAB
 
 config SLUB
 	bool "SLUB (Unqueued Allocator)"
-	depends on !PREEMPT_RT
 	help
 	   SLUB is a slab allocator that minimizes cache line usage
 	   instead of managing queues of cached objects (SLAB approach).
Index: linux-2.6/include/linux/slub_def.h
===================================================================
--- linux-2.6.orig/include/linux/slub_def.h
+++ linux-2.6/include/linux/slub_def.h
@@ -17,6 +17,9 @@ struct kmem_cache_cpu {
 	int node;
 	unsigned int offset;
 	unsigned int objsize;
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t lock;
+#endif
 };
 
 struct kmem_cache_node {
Index: linux-2.6/mm/slub.c
===================================================================
--- linux-2.6.orig/mm/slub.c
+++ linux-2.6/mm/slub.c
@@ -21,11 +21,13 @@
 #include <linux/ctype.h>
 #include <linux/kallsyms.h>
 #include <linux/memory.h>
+#include <linux/pagemap.h>
 
 /*
  * Lock order:
- *   1. slab_lock(page)
- *   2. slab->list_lock
+ *   1. IRQ disable / c->lock
+ *   2. slab_lock(page)
+ *   3. node->list_lock
  *
  *   The slab_lock protects operations on the object of a particular
  *   slab and its metadata in the page struct. If the slab lock
@@ -270,10 +272,25 @@ static inline struct kmem_cache_node *ge
 
 static inline struct kmem_cache_cpu *get_cpu_slab(struct kmem_cache *s, int cpu)
 {
+	struct kmem_cache_cpu *c;
+
 #ifdef CONFIG_SMP
-	return s->cpu_slab[cpu];
+	c = s->cpu_slab[cpu];
 #else
-	return &s->cpu_slab;
+	c = &s->cpu_slab;
+#endif
+#ifdef CONFIG_PREEMPT_RT
+	if (c)
+		spin_lock(&c->lock);
+#endif
+	return c;
+}
+
+static inline void put_cpu_slab(struct kmem_cache_cpu *c)
+{
+#ifdef CONFIG_PREEMPT_RT
+	if (likely(c))
+		spin_unlock(&c->lock);
 #endif
 }
 
@@ -399,7 +416,7 @@ static void set_track(struct kmem_cache 
 	p += alloc;
 	if (addr) {
 		p->addr = addr;
-		p->cpu = smp_processor_id();
+		p->cpu = raw_smp_processor_id();
 		p->pid = current ? current->pid : -1;
 		p->when = jiffies;
 	} else
@@ -1176,6 +1193,7 @@ static void discard_slab(struct kmem_cac
 /*
  * Per slab locking using the pagelock
  */
+#ifndef CONFIG_PREEMPT_RT
 static __always_inline void slab_lock(struct page *page)
 {
 	bit_spin_lock(PG_locked, &page->flags);
@@ -1193,6 +1211,22 @@ static __always_inline int slab_trylock(
 	rc = bit_spin_trylock(PG_locked, &page->flags);
 	return rc;
 }
+#else
+static __always_inline void slab_lock(struct page *page)
+{
+	lock_page_nosync(page);
+}
+
+static __always_inline void slab_unlock(struct page *page)
+{
+	unlock_page(page);
+}
+
+static __always_inline int slab_trylock(struct page *page)
+{
+	return !TestSetPageLocked(page);
+}
+#endif
 
 /*
  * Management of partially allocated slabs
@@ -1412,25 +1446,31 @@ static inline void __flush_cpu_slab(stru
 
 	if (likely(c && c->page))
 		flush_slab(s, c);
+
+	put_cpu_slab(c);
 }
 
 static void flush_cpu_slab(void *d)
 {
 	struct kmem_cache *s = d;
 
-	__flush_cpu_slab(s, smp_processor_id());
+	__flush_cpu_slab(s, raw_smp_processor_id());
 }
 
 static void flush_all(struct kmem_cache *s)
 {
 #ifdef CONFIG_SMP
+#ifndef CONFIG_PREEMPT_RT
 	on_each_cpu(flush_cpu_slab, s, 1, 1);
 #else
+	schedule_on_each_cpu(flush_cpu_slab, s, 1, 1);
+#endif
+#else
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	flush_cpu_slab(s);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 #endif
 }
 
@@ -1489,6 +1529,7 @@ load_freelist:
 	c->page->freelist = NULL;
 	c->node = page_to_nid(c->page);
 	slab_unlock(c->page);
+	put_cpu_slab(c);
 	return object;
 
 another_slab:
@@ -1502,15 +1543,16 @@ new_slab:
 	}
 
 	if (gfpflags & __GFP_WAIT)
-		local_irq_enable();
+		local_irq_enable_nort();
 
 	new = new_slab(s, gfpflags, node);
 
 	if (gfpflags & __GFP_WAIT)
-		local_irq_disable();
+		local_irq_disable_nort();
 
 	if (new) {
-		c = get_cpu_slab(s, smp_processor_id());
+		put_cpu_slab(c);
+		c = get_cpu_slab(s, raw_smp_processor_id());
 		if (c->page)
 			flush_slab(s, c);
 		slab_lock(new);
@@ -1518,6 +1560,7 @@ new_slab:
 		c->page = new;
 		goto load_freelist;
 	}
+	put_cpu_slab(c);
 	return NULL;
 debug:
 	object = c->page->freelist;
@@ -1528,6 +1571,7 @@ debug:
 	c->page->freelist = object[c->offset];
 	c->node = -1;
 	slab_unlock(c->page);
+	put_cpu_slab(c);
 	return object;
 }
 
@@ -1548,8 +1592,8 @@ static void __always_inline *slab_alloc(
 	unsigned long flags;
 	struct kmem_cache_cpu *c;
 
-	local_irq_save(flags);
-	c = get_cpu_slab(s, smp_processor_id());
+	local_irq_save_nort(flags);
+	c = get_cpu_slab(s, raw_smp_processor_id());
 	if (unlikely(!c->freelist || !node_match(c, node)))
 
 		object = __slab_alloc(s, gfpflags, node, addr, c);
@@ -1557,8 +1601,9 @@ static void __always_inline *slab_alloc(
 	else {
 		object = c->freelist;
 		c->freelist = object[c->offset];
+		put_cpu_slab(c);
 	}
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 
 	if (unlikely((gfpflags & __GFP_ZERO) && object))
 		memset(object, 0, c->objsize);
@@ -1656,16 +1701,16 @@ static void __always_inline slab_free(st
 	unsigned long flags;
 	struct kmem_cache_cpu *c;
 
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	debug_check_no_locks_freed(object, s->objsize);
-	c = get_cpu_slab(s, smp_processor_id());
+	c = get_cpu_slab(s, raw_smp_processor_id());
 	if (likely(page == c->page && c->node >= 0)) {
 		object[c->offset] = c->freelist;
 		c->freelist = object;
 	} else
 		__slab_free(s, page, x, addr, c->offset);
-
-	local_irq_restore(flags);
+	put_cpu_slab(c);
+	local_irq_restore_nort(flags);
 }
 
 void kmem_cache_free(struct kmem_cache *s, void *x)
@@ -1846,6 +1891,9 @@ static void init_kmem_cache_cpu(struct k
 	c->node = 0;
 	c->offset = s->offset / sizeof(void *);
 	c->objsize = s->objsize;
+#ifdef CONFIG_PREEMPT_RT
+	spin_lock_init(&c->lock);
+#endif
 }
 
 static void init_kmem_cache_node(struct kmem_cache_node *n)
@@ -1925,6 +1973,7 @@ static void free_kmem_cache_cpus(struct 
 		if (c) {
 			s->cpu_slab[cpu] = NULL;
 			free_kmem_cache_cpu(c, cpu);
+			put_cpu_slab(c);
 		}
 	}
 }
@@ -1936,8 +1985,10 @@ static int alloc_kmem_cache_cpus(struct 
 	for_each_online_cpu(cpu) {
 		struct kmem_cache_cpu *c = get_cpu_slab(s, cpu);
 
-		if (c)
+		if (c) {
+			put_cpu_slab(c);
 			continue;
+		}
 
 		c = alloc_kmem_cache_cpu(s, cpu, flags);
 		if (!c) {
@@ -2962,8 +3013,12 @@ struct kmem_cache *kmem_cache_create(con
 		 * And then we need to update the object size in the
 		 * per cpu structures
 		 */
-		for_each_online_cpu(cpu)
-			get_cpu_slab(s, cpu)->objsize = s->objsize;
+		for_each_online_cpu(cpu) {
+			struct kmem_cache_cpu *c = get_cpu_slab(s, cpu);
+
+			c->objsize = s->objsize;
+			put_cpu_slab(c);
+		}
 		s->inuse = max_t(int, s->inuse, ALIGN(size, sizeof(void *)));
 		up_write(&slub_lock);
 		if (sysfs_slab_alias(s, name))
@@ -3024,11 +3079,13 @@ static int __cpuinit slab_cpuup_callback
 		list_for_each_entry(s, &slab_caches, list) {
 			struct kmem_cache_cpu *c = get_cpu_slab(s, cpu);
 
-			local_irq_save(flags);
+			local_irq_save_nort(flags);
 			__flush_cpu_slab(s, cpu);
-			local_irq_restore(flags);
+			local_irq_restore_nort(flags);
 			free_kmem_cache_cpu(c, cpu);
 			s->cpu_slab[cpu] = NULL;
+
+			put_cpu_slab(c);
 		}
 		up_read(&slub_lock);
 		break;
@@ -3519,6 +3576,7 @@ static unsigned long slab_objects(struct
 			}
 			per_cpu[node]++;
 		}
+		put_cpu_slab(c);
 	}
 
 	for_each_node_state(node, N_NORMAL_MEMORY) {
@@ -3564,9 +3622,13 @@ static int any_slab_objects(struct kmem_
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
+		int ret = 0;
 		struct kmem_cache_cpu *c = get_cpu_slab(s, cpu);
 
 		if (c && c->page)
+			ret = 1;
+		put_cpu_slab(c);
+		if (ret)
 			return 1;
 	}
 
