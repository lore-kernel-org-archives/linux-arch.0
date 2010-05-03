From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Subject: [PATCH 1/7] numa-add-generic-percpu-var-numa_node_id-implementation-fix1
Date: Mon, 03 May 2010 11:05:04 -0400
Message-ID: <20100503150504.15039.7493.sendpatchset@localhost.localdomain>
References: <20100503150455.15039.10178.sendpatchset@localhost.localdomain>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:9801 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759541Ab0ECPFH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2010 11:05:07 -0400
In-Reply-To: <20100503150455.15039.10178.sendpatchset@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Valdis.Kletnieks@vt.edu, Randy Dunlap <randy.dunlap@oracle.com>, Christoph Lameter <cl@linux-foundation.org>, eric.whitney@hp.com, Andrew Morton <akpm@linux-foundation.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Incremental patch 1 to
numa-add-generic-percpu-var-numa_node_id-implementation.patch
in 28apri10 mmotm.

If any of the numa topology functions--numa_node_id() et al--have not
been overridden by the arch, we can define them as static inline
functions.

Note that this means that cpu_to_node() can no longer be used as an
lvalue.  However, the tree contains no such usage currently, and
a subsequent patch will add a function to set the 'numa_node' for
a specified cpu.

x86 defines numa_node_id() as a static inline function when
CONFIG_NUMA is not set.  Add #define of numa_node_id to itself
to indicate this override of the default definition, so we can
build !NUMA with this patch applied.

   Maybe we should move the default definitions to
   asm-generic/topology.h?  Or remove it altogether?
   x86_64 !NUMA seems to build without it.

Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>

 arch/x86/include/asm/topology.h |    4 ++++
 include/linux/topology.h        |   21 ++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

Index: linux-2.6.34-rc5-mmotm-100428-1653/include/linux/topology.h
===================================================================
--- linux-2.6.34-rc5-mmotm-100428-1653.orig/include/linux/topology.h
+++ linux-2.6.34-rc5-mmotm-100428-1653/include/linux/topology.h
@@ -212,23 +212,34 @@ DECLARE_PER_CPU(int, numa_node);
 
 #ifndef numa_node_id
 /* Returns the number of the current Node. */
-#define numa_node_id()		__this_cpu_read(numa_node)
+static inline int numa_node_id(void)
+{
+	return __this_cpu_read(numa_node);
+}
 #endif
 
 #ifndef cpu_to_node
-#define cpu_to_node(__cpu)	per_cpu(numa_node, (__cpu))
+static inline int cpu_to_node(int cpu)
+{
+	return per_cpu(numa_node, cpu);
+}
 #endif
 
 #ifndef set_numa_node
-#define set_numa_node(__node) percpu_write(numa_node, __node)
+static inline void set_numa_node(int node)
+{
+	percpu_write(numa_node, node);
+}
 #endif
 
 #else	/* !CONFIG_USE_PERCPU_NUMA_NODE_ID */
 
 /* Returns the number of the current Node. */
 #ifndef numa_node_id
-#define numa_node_id()		(cpu_to_node(raw_smp_processor_id()))
-
+static inline int numa_node_id(void)
+{
+	return cpu_to_node(raw_smp_processor_id());
+}
 #endif
 
 #endif	/* [!]CONFIG_USE_PERCPU_NUMA_NODE_ID */
Index: linux-2.6.34-rc5-mmotm-100428-1653/arch/x86/include/asm/topology.h
===================================================================
--- linux-2.6.34-rc5-mmotm-100428-1653.orig/arch/x86/include/asm/topology.h
+++ linux-2.6.34-rc5-mmotm-100428-1653/arch/x86/include/asm/topology.h
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
