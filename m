From: akpm@linux-foundation.org
Subject: [patch 201/203] numa: slab: use numa_mem_id() for slab local memory node
Date: Wed, 26 May 2010 14:45:03 -0700
Message-ID: <201005262145.o4QLj3VC016274@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49119 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753163Ab0EZVs1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 May 2010 17:48:27 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, lee.schermerhorn@hp.com, cl@linux-foundation.org, eric.whitney@hp.com, hpa@zytor.com, kamezawa.hiroyu@jp.fujitsu.com, linux-arch@vger.kernel.org, mel@csn.ul.ie, mingo@elte.hu, npiggin@suse.de, penberg@cs.helsinki.fi, rientjes@google.com, tglx@linutronix.de, tj@kernel.org, tony.luck@intel.com

From: Lee Schermerhorn <lee.schermerhorn@hp.com>

Example usage of generic "numa_mem_id()":

The mainline slab code, since ~ 2.6.19, does not handle memoryless nodes
well.  Specifically, the "fast path"--____cache_alloc()--will never
succeed as slab doesn't cache offnode object on the per cpu queues, and
for memoryless nodes, all memory will be "off node" relative to
numa_node_id().  This adds significant overhead to all kmem cache
allocations, incurring a significant regression relative to earlier
kernels [from before slab.c was reorganized].

This patch uses the generic topology function "numa_mem_id()" to return
the "effective local memory node" for the calling context.  This is the
first node in the local node's generic fallback zonelist-- the same node
that "local" mempolicy-based allocations would use.  This lets slab cache
these "local" allocations and avoid fallback/refill on every allocation.

N.B.: Slab will need to handle node and memory hotplug events that could
change the value returned by numa_mem_id() for any given node if recent
changes to address memory hotplug don't already address this.  E.g., flush
all per cpu slab queues before rebuilding the zonelists while the
"machine" is held in the stopped state.

Performance impact on "hackbench 400 process 200"

2.6.34-rc3-mmotm-100405-1609		no-patch	this-patch
ia64 no memoryless nodes [avg of 10]:     11.713       11.637  ~0.65 diff
ia64 cpus all on memless nodes  [10]:    228.259       26.484  ~8.6x speedup

The slowdown of the patched kernel from ~12 sec to ~28 seconds when
configured with memoryless nodes is the result of all cpus allocating from
a single node's mm pagepool.  The cache lines of the single node are
distributed/interleaved over the memory of the real physical nodes, but
the zone lock, list heads, ...  of the single node with memory still each
live in a single cache line that is accessed from all processors.

x86_64 [8x6 AMD] [avg of 40]:		2.883	   2.845

Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Mel Gorman <mel@csn.ul.ie>
Cc: Christoph Lameter <cl@linux-foundation.org>
Cc: Nick Piggin <npiggin@suse.de>
Cc: David Rientjes <rientjes@google.com>
Cc: Eric Whitney <eric.whitney@hp.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/slab.c |   43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff -puN mm/slab.c~numa-slab-use-numa_mem_id-for-slab-local-memory-node mm/slab.c
--- a/mm/slab.c~numa-slab-use-numa_mem_id-for-slab-local-memory-node
+++ a/mm/slab.c
@@ -821,7 +821,7 @@ static void init_reap_node(int cpu)
 {
 	int node;
 
-	node = next_node(cpu_to_node(cpu), node_online_map);
+	node = next_node(cpu_to_mem(cpu), node_online_map);
 	if (node == MAX_NUMNODES)
 		node = first_node(node_online_map);
 
@@ -1050,7 +1050,7 @@ static inline int cache_free_alien(struc
 	struct array_cache *alien = NULL;
 	int node;
 
-	node = numa_node_id();
+	node = numa_mem_id();
 
 	/*
 	 * Make sure we are not freeing a object from another node to the array
@@ -1129,7 +1129,7 @@ static void __cpuinit cpuup_canceled(lon
 {
 	struct kmem_cache *cachep;
 	struct kmem_list3 *l3 = NULL;
-	int node = cpu_to_node(cpu);
+	int node = cpu_to_mem(cpu);
 	const struct cpumask *mask = cpumask_of_node(node);
 
 	list_for_each_entry(cachep, &cache_chain, next) {
@@ -1194,7 +1194,7 @@ static int __cpuinit cpuup_prepare(long 
 {
 	struct kmem_cache *cachep;
 	struct kmem_list3 *l3 = NULL;
-	int node = cpu_to_node(cpu);
+	int node = cpu_to_mem(cpu);
 	int err;
 
 	/*
@@ -1479,7 +1479,7 @@ void __init kmem_cache_init(void)
 	 * 6) Resize the head arrays of the kmalloc caches to their final sizes.
 	 */
 
-	node = numa_node_id();
+	node = numa_mem_id();
 
 	/* 1) create the cache_cache */
 	INIT_LIST_HEAD(&cache_chain);
@@ -2121,7 +2121,7 @@ static int __init_refok setup_cpu_cache(
 			}
 		}
 	}
-	cachep->nodelists[numa_node_id()]->next_reap =
+	cachep->nodelists[numa_mem_id()]->next_reap =
 			jiffies + REAPTIMEOUT_LIST3 +
 			((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 
@@ -2452,7 +2452,7 @@ static void check_spinlock_acquired(stru
 {
 #ifdef CONFIG_SMP
 	check_irq_off();
-	assert_spin_locked(&cachep->nodelists[numa_node_id()]->list_lock);
+	assert_spin_locked(&cachep->nodelists[numa_mem_id()]->list_lock);
 #endif
 }
 
@@ -2479,7 +2479,7 @@ static void do_drain(void *arg)
 {
 	struct kmem_cache *cachep = arg;
 	struct array_cache *ac;
-	int node = numa_node_id();
+	int node = numa_mem_id();
 
 	check_irq_off();
 	ac = cpu_cache_get(cachep);
@@ -3012,7 +3012,7 @@ static void *cache_alloc_refill(struct k
 
 retry:
 	check_irq_off();
-	node = numa_node_id();
+	node = numa_mem_id();
 	ac = cpu_cache_get(cachep);
 	batchcount = ac->batchcount;
 	if (!ac->touched && batchcount > BATCHREFILL_LIMIT) {
@@ -3216,7 +3216,7 @@ static void *alternate_node_alloc(struct
 
 	if (in_interrupt() || (flags & __GFP_THISNODE))
 		return NULL;
-	nid_alloc = nid_here = numa_node_id();
+	nid_alloc = nid_here = numa_mem_id();
 	get_mems_allowed();
 	if (cpuset_do_slab_mem_spread() && (cachep->flags & SLAB_MEM_SPREAD))
 		nid_alloc = cpuset_slab_spread_node();
@@ -3281,7 +3281,7 @@ retry:
 		if (local_flags & __GFP_WAIT)
 			local_irq_enable();
 		kmem_flagcheck(cache, flags);
-		obj = kmem_getpages(cache, local_flags, numa_node_id());
+		obj = kmem_getpages(cache, local_flags, numa_mem_id());
 		if (local_flags & __GFP_WAIT)
 			local_irq_disable();
 		if (obj) {
@@ -3389,6 +3389,7 @@ __cache_alloc_node(struct kmem_cache *ca
 {
 	unsigned long save_flags;
 	void *ptr;
+	int slab_node = numa_mem_id();
 
 	flags &= gfp_allowed_mask;
 
@@ -3401,7 +3402,7 @@ __cache_alloc_node(struct kmem_cache *ca
 	local_irq_save(save_flags);
 
 	if (nodeid == -1)
-		nodeid = numa_node_id();
+		nodeid = slab_node;
 
 	if (unlikely(!cachep->nodelists[nodeid])) {
 		/* Node not bootstrapped yet */
@@ -3409,7 +3410,7 @@ __cache_alloc_node(struct kmem_cache *ca
 		goto out;
 	}
 
-	if (nodeid == numa_node_id()) {
+	if (nodeid == slab_node) {
 		/*
 		 * Use the locally cached objects if possible.
 		 * However ____cache_alloc does not allow fallback
@@ -3453,8 +3454,8 @@ __do_cache_alloc(struct kmem_cache *cach
 	 * We may just have run out of memory on the local node.
 	 * ____cache_alloc_node() knows how to locate memory on other nodes
 	 */
- 	if (!objp)
- 		objp = ____cache_alloc_node(cache, flags, numa_node_id());
+	if (!objp)
+		objp = ____cache_alloc_node(cache, flags, numa_mem_id());
 
   out:
 	return objp;
@@ -3551,7 +3552,7 @@ static void cache_flusharray(struct kmem
 {
 	int batchcount;
 	struct kmem_list3 *l3;
-	int node = numa_node_id();
+	int node = numa_mem_id();
 
 	batchcount = ac->batchcount;
 #if DEBUG
@@ -3985,7 +3986,7 @@ static int do_tune_cpucache(struct kmem_
 		return -ENOMEM;
 
 	for_each_online_cpu(i) {
-		new->new[i] = alloc_arraycache(cpu_to_node(i), limit,
+		new->new[i] = alloc_arraycache(cpu_to_mem(i), limit,
 						batchcount, gfp);
 		if (!new->new[i]) {
 			for (i--; i >= 0; i--)
@@ -4007,9 +4008,9 @@ static int do_tune_cpucache(struct kmem_
 		struct array_cache *ccold = new->new[i];
 		if (!ccold)
 			continue;
-		spin_lock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
-		free_block(cachep, ccold->entry, ccold->avail, cpu_to_node(i));
-		spin_unlock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
+		spin_lock_irq(&cachep->nodelists[cpu_to_mem(i)]->list_lock);
+		free_block(cachep, ccold->entry, ccold->avail, cpu_to_mem(i));
+		spin_unlock_irq(&cachep->nodelists[cpu_to_mem(i)]->list_lock);
 		kfree(ccold);
 	}
 	kfree(new);
@@ -4115,7 +4116,7 @@ static void cache_reap(struct work_struc
 {
 	struct kmem_cache *searchp;
 	struct kmem_list3 *l3;
-	int node = numa_node_id();
+	int node = numa_mem_id();
 	struct delayed_work *work = to_delayed_work(w);
 
 	if (!mutex_trylock(&cache_chain_mutex))
_
