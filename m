From: akpm@linux-foundation.org
Subject: [patch 197/203] numa: x86_64: use generic percpu var numa_node_id() implementation
Date: Wed, 26 May 2010 14:44:58 -0700
Message-ID: <201005262144.o4QLiwoq016248@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38626 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754176Ab0EZVs3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 May 2010 17:48:29 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, lee.schermerhorn@hp.com, cl@linux-foundation.org, eric.whitney@hp.com, hpa@zytor.com, kamezawa.hiroyu@jp.fujitsu.com, linux-arch@vger.kernel.org, mel@csn.ul.ie, mingo@elte.hu, npiggin@suse.de, penberg@cs.helsinki.fi, rientjes@google.com, tglx@linutronix.de, tj@kernel.org, tony.luck@intel.com

From: Lee Schermerhorn <lee.schermerhorn@hp.com>

x86 arch specific changes to use generic numa_node_id() based on generic
percpu variable infrastructure.  Back out x86's custom version of
numa_node_id()

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

 arch/x86/Kconfig                |    4 ++++
 arch/x86/include/asm/topology.h |   22 +++++++++-------------
 arch/x86/kernel/cpu/common.c    |    6 +++---
 arch/x86/kernel/setup_percpu.c  |    4 ++--
 arch/x86/mm/numa_64.c           |    9 +++------
 5 files changed, 21 insertions(+), 24 deletions(-)

diff -puN arch/x86/Kconfig~numa-x86_64-use-generic-percpu-var-numa_node_id-implementation arch/x86/Kconfig
--- a/arch/x86/Kconfig~numa-x86_64-use-generic-percpu-var-numa_node_id-implementation
+++ a/arch/x86/Kconfig
@@ -1706,6 +1706,10 @@ config HAVE_ARCH_EARLY_PFN_TO_NID
 	def_bool X86_64
 	depends on NUMA
 
+config USE_PERCPU_NUMA_NODE_ID
+	def_bool X86_64
+	depends on NUMA
+
 menu "Power management and ACPI options"
 
 config ARCH_HIBERNATION_HEADER
diff -puN arch/x86/include/asm/topology.h~numa-x86_64-use-generic-percpu-var-numa_node_id-implementation arch/x86/include/asm/topology.h
--- a/arch/x86/include/asm/topology.h~numa-x86_64-use-generic-percpu-var-numa_node_id-implementation
+++ a/arch/x86/include/asm/topology.h
@@ -53,33 +53,29 @@
 extern int cpu_to_node_map[];
 
 /* Returns the number of the node containing CPU 'cpu' */
-static inline int cpu_to_node(int cpu)
+static inline int __cpu_to_node(int cpu)
 {
 	return cpu_to_node_map[cpu];
 }
-#define early_cpu_to_node(cpu)	cpu_to_node(cpu)
+#define early_cpu_to_node __cpu_to_node
+#define cpu_to_node __cpu_to_node
 
 #else /* CONFIG_X86_64 */
 
 /* Mappings between logical cpu number and node number */
 DECLARE_EARLY_PER_CPU(int, x86_cpu_to_node_map);
 
-/* Returns the number of the current Node. */
-DECLARE_PER_CPU(int, node_number);
-#define numa_node_id()		percpu_read(node_number)
-
 #ifdef CONFIG_DEBUG_PER_CPU_MAPS
-extern int cpu_to_node(int cpu);
+/*
+ * override generic percpu implementation of cpu_to_node
+ */
+extern int __cpu_to_node(int cpu);
+#define cpu_to_node __cpu_to_node
+
 extern int early_cpu_to_node(int cpu);
 
 #else	/* !CONFIG_DEBUG_PER_CPU_MAPS */
 
-/* Returns the number of the node containing CPU 'cpu' */
-static inline int cpu_to_node(int cpu)
-{
-	return per_cpu(x86_cpu_to_node_map, cpu);
-}
-
 /* Same function but used if called before per_cpu areas are setup */
 static inline int early_cpu_to_node(int cpu)
 {
diff -puN arch/x86/kernel/cpu/common.c~numa-x86_64-use-generic-percpu-var-numa_node_id-implementation arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~numa-x86_64-use-generic-percpu-var-numa_node_id-implementation
+++ a/arch/x86/kernel/cpu/common.c
@@ -1121,9 +1121,9 @@ void __cpuinit cpu_init(void)
 	oist = &per_cpu(orig_ist, cpu);
 
 #ifdef CONFIG_NUMA
-	if (cpu != 0 && percpu_read(node_number) == 0 &&
-	    cpu_to_node(cpu) != NUMA_NO_NODE)
-		percpu_write(node_number, cpu_to_node(cpu));
+	if (cpu != 0 && percpu_read(numa_node) == 0 &&
+	    early_cpu_to_node(cpu) != NUMA_NO_NODE)
+		set_numa_node(early_cpu_to_node(cpu));
 #endif
 
 	me = current;
diff -puN arch/x86/kernel/setup_percpu.c~numa-x86_64-use-generic-percpu-var-numa_node_id-implementation arch/x86/kernel/setup_percpu.c
--- a/arch/x86/kernel/setup_percpu.c~numa-x86_64-use-generic-percpu-var-numa_node_id-implementation
+++ a/arch/x86/kernel/setup_percpu.c
@@ -265,10 +265,10 @@ void __init setup_per_cpu_areas(void)
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_NUMA)
 	/*
-	 * make sure boot cpu node_number is right, when boot cpu is on the
+	 * make sure boot cpu numa_node is right, when boot cpu is on the
 	 * node that doesn't have mem installed
 	 */
-	per_cpu(node_number, boot_cpu_id) = cpu_to_node(boot_cpu_id);
+	set_cpu_numa_node(boot_cpu_id, early_cpu_to_node(boot_cpu_id));
 #endif
 
 	/* Setup node to cpumask map */
diff -puN arch/x86/mm/numa_64.c~numa-x86_64-use-generic-percpu-var-numa_node_id-implementation arch/x86/mm/numa_64.c
--- a/arch/x86/mm/numa_64.c~numa-x86_64-use-generic-percpu-var-numa_node_id-implementation
+++ a/arch/x86/mm/numa_64.c
@@ -33,9 +33,6 @@ int numa_off __initdata;
 static unsigned long __initdata nodemap_addr;
 static unsigned long __initdata nodemap_size;
 
-DEFINE_PER_CPU(int, node_number) = 0;
-EXPORT_PER_CPU_SYMBOL(node_number);
-
 /*
  * Map cpu index to node index
  */
@@ -809,7 +806,7 @@ void __cpuinit numa_set_node(int cpu, in
 	per_cpu(x86_cpu_to_node_map, cpu) = node;
 
 	if (node != NUMA_NO_NODE)
-		per_cpu(node_number, cpu) = node;
+		set_cpu_numa_node(cpu, node);
 }
 
 void __cpuinit numa_clear_node(int cpu)
@@ -867,7 +864,7 @@ void __cpuinit numa_remove_cpu(int cpu)
 	numa_set_cpumask(cpu, 0);
 }
 
-int cpu_to_node(int cpu)
+int __cpu_to_node(int cpu)
 {
 	if (early_per_cpu_ptr(x86_cpu_to_node_map)) {
 		printk(KERN_WARNING
@@ -877,7 +874,7 @@ int cpu_to_node(int cpu)
 	}
 	return per_cpu(x86_cpu_to_node_map, cpu);
 }
-EXPORT_SYMBOL(cpu_to_node);
+EXPORT_SYMBOL(__cpu_to_node);
 
 /*
  * Same function as cpu_to_node() but used if called before the
_
