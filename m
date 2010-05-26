From: akpm@linux-foundation.org
Subject: [patch 199/203] numa: introduce numa_mem_id()- effective local memory node id
Date: Wed, 26 May 2010 14:45:00 -0700
Message-ID: <201005262145.o4QLj0W4016258@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35920 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753778Ab0EZVsZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 May 2010 17:48:25 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, lee.schermerhorn@hp.com, cl@linux-foundation.org, eric.whitney@hp.com, hpa@zytor.com, kamezawa.hiroyu@jp.fujitsu.com, linux-arch@vger.kernel.org, mel@csn.ul.ie, mingo@elte.hu, npiggin@suse.de, penberg@cs.helsinki.fi, rientjes@google.com, tglx@linutronix.de, tj@kernel.org, tony.luck@intel.com

From: Lee Schermerhorn <lee.schermerhorn@hp.com>

Introduce numa_mem_id(), based on generic percpu variable infrastructure
to track "nearest node with memory" for archs that support memoryless
nodes.

Define API in <linux/topology.h> when CONFIG_HAVE_MEMORYLESS_NODES
defined, else stubs.  Architectures will define HAVE_MEMORYLESS_NODES
if/when they support them.

Archs can override definitions of:

numa_mem_id() - returns node number of "local memory" node
set_numa_mem() - initialize [this cpus'] per cpu variable 'numa_mem'
cpu_to_mem()  - return numa_mem for specified cpu; may be used as lvalue

Generic initialization of 'numa_mem' occurs in __build_all_zonelists(). 
This will initialize the boot cpu at boot time, and all cpus on change of
numa_zonelist_order, or when node or memory hot-plug requires zonelist
rebuild.  Archs that support memoryless nodes will need to initialize
'numa_mem' for secondary cpus as they're brought on-line.

[akpm@linux-foundation.org: fix build]
Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>
Signed-off-by: Christoph Lameter <cl@linux-foundation.org>
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

 include/asm-generic/topology.h |    3 +
 include/linux/mmzone.h         |    6 +++
 include/linux/topology.h       |   61 +++++++++++++++++++++++++++++++
 mm/page_alloc.c                |   45 ++++++++++++++++++++++
 4 files changed, 114 insertions(+), 1 deletion(-)

diff -puN include/asm-generic/topology.h~numa-introduce-numa_mem_id-effective-local-memory-node-id include/asm-generic/topology.h
--- a/include/asm-generic/topology.h~numa-introduce-numa_mem_id-effective-local-memory-node-id
+++ a/include/asm-generic/topology.h
@@ -34,6 +34,9 @@
 #ifndef cpu_to_node
 #define cpu_to_node(cpu)	((void)(cpu),0)
 #endif
+#ifndef cpu_to_mem
+#define cpu_to_mem(cpu)		((void)(cpu),0)
+#endif
 #ifndef parent_node
 #define parent_node(node)	((void)(node),0)
 #endif
diff -puN include/linux/mmzone.h~numa-introduce-numa_mem_id-effective-local-memory-node-id include/linux/mmzone.h
--- a/include/linux/mmzone.h~numa-introduce-numa_mem_id-effective-local-memory-node-id
+++ a/include/linux/mmzone.h
@@ -671,6 +671,12 @@ void memory_present(int nid, unsigned lo
 static inline void memory_present(int nid, unsigned long start, unsigned long end) {}
 #endif
 
+#ifdef CONFIG_HAVE_MEMORYLESS_NODES
+int local_memory_node(int node_id);
+#else
+static inline int local_memory_node(int node_id) { return node_id; };
+#endif
+
 #ifdef CONFIG_NEED_NODE_MEMMAP_SIZE
 unsigned long __init node_memmap_size_bytes(int, unsigned long, unsigned long);
 #endif
diff -puN include/linux/topology.h~numa-introduce-numa_mem_id-effective-local-memory-node-id include/linux/topology.h
--- a/include/linux/topology.h~numa-introduce-numa_mem_id-effective-local-memory-node-id
+++ a/include/linux/topology.h
@@ -251,6 +251,67 @@ static inline int numa_node_id(void)
 
 #endif	/* [!]CONFIG_USE_PERCPU_NUMA_NODE_ID */
 
+#ifdef CONFIG_HAVE_MEMORYLESS_NODES
+
+/*
+ * N.B., Do NOT reference the '_numa_mem_' per cpu variable directly.
+ * It will not be defined when CONFIG_HAVE_MEMORYLESS_NODES is not defined.
+ * Use the accessor functions set_numa_mem(), numa_mem_id() and cpu_to_mem().
+ */
+DECLARE_PER_CPU(int, _numa_mem_);
+
+#ifndef set_numa_mem
+static inline void set_numa_mem(int node)
+{
+	percpu_write(_numa_mem_, node);
+}
+#endif
+
+#ifndef numa_mem_id
+/* Returns the number of the nearest Node with memory */
+static inline int numa_mem_id(void)
+{
+	return __this_cpu_read(_numa_mem_);
+}
+#endif
+
+#ifndef cpu_to_mem
+static inline int cpu_to_mem(int cpu)
+{
+	return per_cpu(_numa_mem_, cpu);
+}
+#endif
+
+#ifndef set_cpu_numa_mem
+static inline void set_cpu_numa_mem(int cpu, int node)
+{
+	per_cpu(_numa_mem_, cpu) = node;
+}
+#endif
+
+#else	/* !CONFIG_HAVE_MEMORYLESS_NODES */
+
+static inline void set_numa_mem(int node) {}
+
+static inline void set_cpu_numa_mem(int cpu, int node) {}
+
+#ifndef numa_mem_id
+/* Returns the number of the nearest Node with memory */
+static inline int numa_mem_id(void)
+{
+	return numa_node_id();
+}
+#endif
+
+#ifndef cpu_to_mem
+static inline int cpu_to_mem(int cpu)
+{
+	return cpu_to_node(cpu);
+}
+#endif
+
+#endif	/* [!]CONFIG_HAVE_MEMORYLESS_NODES */
+
 #ifndef topology_physical_package_id
 #define topology_physical_package_id(cpu)	((void)(cpu), -1)
 #endif
diff -puN mm/page_alloc.c~numa-introduce-numa_mem_id-effective-local-memory-node-id mm/page_alloc.c
--- a/mm/page_alloc.c~numa-introduce-numa_mem_id-effective-local-memory-node-id
+++ a/mm/page_alloc.c
@@ -62,6 +62,17 @@ DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
 #endif
 
+#ifdef CONFIG_HAVE_MEMORYLESS_NODES
+/*
+ * N.B., Do NOT reference the '_numa_mem_' per cpu variable directly.
+ * It will not be defined when CONFIG_HAVE_MEMORYLESS_NODES is not defined.
+ * Use the accessor functions set_numa_mem(), numa_mem_id() and cpu_to_mem()
+ * defined in <linux/topology.h>.
+ */
+DEFINE_PER_CPU(int, _numa_mem_);		/* Kernel "local memory" node */
+EXPORT_PER_CPU_SYMBOL(_numa_mem_);
+#endif
+
 /*
  * Array of node states.
  */
@@ -2861,6 +2872,24 @@ static void build_zonelist_cache(pg_data
 		zlc->z_to_n[z - zonelist->_zonerefs] = zonelist_node_idx(z);
 }
 
+#ifdef CONFIG_HAVE_MEMORYLESS_NODES
+/*
+ * Return node id of node used for "local" allocations.
+ * I.e., first node id of first zone in arg node's generic zonelist.
+ * Used for initializing percpu 'numa_mem', which is used primarily
+ * for kernel allocations, so use GFP_KERNEL flags to locate zonelist.
+ */
+int local_memory_node(int node)
+{
+	struct zone *zone;
+
+	(void)first_zones_zonelist(node_zonelist(node, GFP_KERNEL),
+				   gfp_zone(GFP_KERNEL),
+				   NULL,
+				   &zone);
+	return zone->node;
+}
+#endif
 
 #else	/* CONFIG_NUMA */
 
@@ -2975,9 +3004,23 @@ static __init_refok int __build_all_zone
 	 * needs the percpu allocator in order to allocate its pagesets
 	 * (a chicken-egg dilemma).
 	 */
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		setup_pageset(&per_cpu(boot_pageset, cpu), 0);
 
+#ifdef CONFIG_HAVE_MEMORYLESS_NODES
+		/*
+		 * We now know the "local memory node" for each node--
+		 * i.e., the node of the first zone in the generic zonelist.
+		 * Set up numa_mem percpu variable for on-line cpus.  During
+		 * boot, only the boot cpu should be on-line;  we'll init the
+		 * secondary cpus' numa_mem as they come on-line.  During
+		 * node/memory hotplug, we'll fixup all on-line cpus.
+		 */
+		if (cpu_online(cpu))
+			set_cpu_numa_mem(cpu, local_memory_node(cpu_to_node(cpu)));
+#endif
+	}
+
 	return 0;
 }
 
_
