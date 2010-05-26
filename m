From: akpm@linux-foundation.org
Subject: [patch 196/203] numa: add generic percpu var numa_node_id() implementation
Date: Wed, 26 May 2010 14:44:56 -0700
Message-ID: <201005262144.o4QLiul1016243@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39991 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753163Ab0EZVsY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 May 2010 17:48:24 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, lee.schermerhorn@hp.com, cl@linux-foundation.org, eric.whitney@hp.com, hpa@zytor.com, kamezawa.hiroyu@jp.fujitsu.com, linux-arch@vger.kernel.org, mel@csn.ul.ie, mingo@elte.hu, npiggin@suse.de, penberg@cs.helsinki.fi, rientjes@google.com, tglx@linutronix.de, tj@kernel.org, tony.luck@intel.com

From: Lee Schermerhorn <lee.schermerhorn@hp.com>

Rework the generic version of the numa_node_id() function to use the new
generic percpu variable infrastructure.

Guard the new implementation with a new config option:

        CONFIG_USE_PERCPU_NUMA_NODE_ID.

Archs which support this new implemention will default this option to 'y'
when NUMA is configured.  This config option could be removed if/when all
archs switch over to the generic percpu implementation of numa_node_id(). 
Arch support involves:

  1) converting any existing per cpu variable implementations to use
     this implementation.  x86_64 is an instance of such an arch.
  2) archs that don't use a per cpu variable for numa_node_id() will
     need to initialize the new per cpu variable "numa_node" as cpus
     are brought on-line.  ia64 is an example.
  3) Defining USE_PERCPU_NUMA_NODE_ID in arch dependent Kconfig--e.g.,
     when NUMA is configured.  This is required because I have
     retained the old implementation by default to allow archs to
     be modified incrementally, as desired.

Subsequent patches will convert x86_64 and ia64 to use this implemenation.

Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Mel Gorman <mel@csn.ul.ie>
Reviewed-by: Christoph Lameter <cl@linux-foundation.org>
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

 arch/x86/include/asm/topology.h |    4 ++
 include/linux/topology.h        |   51 +++++++++++++++++++++++++++---
 mm/page_alloc.c                 |    5 ++
 3 files changed, 55 insertions(+), 5 deletions(-)

diff -puN arch/x86/include/asm/topology.h~numa-add-generic-percpu-var-numa_node_id-implementation arch/x86/include/asm/topology.h
--- a/arch/x86/include/asm/topology.h~numa-add-generic-percpu-var-numa_node_id-implementation
+++ a/arch/x86/include/asm/topology.h
@@ -170,6 +170,10 @@ static inline int numa_node_id(void)
 {
 	return 0;
 }
+/*
+ * indicate override:
+ */
+#define numa_node_id numa_node_id
 
 static inline int early_cpu_to_node(int cpu)
 {
diff -puN include/linux/topology.h~numa-add-generic-percpu-var-numa_node_id-implementation include/linux/topology.h
--- a/include/linux/topology.h~numa-add-generic-percpu-var-numa_node_id-implementation
+++ a/include/linux/topology.h
@@ -31,6 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/mmzone.h>
 #include <linux/smp.h>
+#include <linux/percpu.h>
 #include <asm/topology.h>
 
 #ifndef node_has_online_mem
@@ -203,8 +204,53 @@ int arch_update_cpu_topology(void);
 #ifndef SD_NODE_INIT
 #error Please define an appropriate SD_NODE_INIT in include/asm/topology.h!!!
 #endif
+
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
+DECLARE_PER_CPU(int, numa_node);
+
+#ifndef numa_node_id
+/* Returns the number of the current Node. */
+static inline int numa_node_id(void)
+{
+	return __this_cpu_read(numa_node);
+}
+#endif
+
+#ifndef cpu_to_node
+static inline int cpu_to_node(int cpu)
+{
+	return per_cpu(numa_node, cpu);
+}
+#endif
+
+#ifndef set_numa_node
+static inline void set_numa_node(int node)
+{
+	percpu_write(numa_node, node);
+}
+#endif
+
+#ifndef set_cpu_numa_node
+static inline void set_cpu_numa_node(int cpu, int node)
+{
+	per_cpu(numa_node, cpu) = node;
+}
+#endif
+
+#else	/* !CONFIG_USE_PERCPU_NUMA_NODE_ID */
+
+/* Returns the number of the current Node. */
+#ifndef numa_node_id
+static inline int numa_node_id(void)
+{
+	return cpu_to_node(raw_smp_processor_id());
+}
+#endif
+
+#endif	/* [!]CONFIG_USE_PERCPU_NUMA_NODE_ID */
+
 #ifndef topology_physical_package_id
 #define topology_physical_package_id(cpu)	((void)(cpu), -1)
 #endif
@@ -218,9 +264,4 @@ int arch_update_cpu_topology(void);
 #define topology_core_cpumask(cpu)		cpumask_of(cpu)
 #endif
 
-/* Returns the number of the current Node. */
-#ifndef numa_node_id
-#define numa_node_id()		(cpu_to_node(raw_smp_processor_id()))
-#endif
-
 #endif /* _LINUX_TOPOLOGY_H */
diff -puN mm/page_alloc.c~numa-add-generic-percpu-var-numa_node_id-implementation mm/page_alloc.c
--- a/mm/page_alloc.c~numa-add-generic-percpu-var-numa_node_id-implementation
+++ a/mm/page_alloc.c
@@ -57,6 +57,11 @@
 #include <asm/div64.h>
 #include "internal.h"
 
+#ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
+DEFINE_PER_CPU(int, numa_node);
+EXPORT_PER_CPU_SYMBOL(numa_node);
+#endif
+
 /*
  * Array of node states.
  */
_
