From: akpm@linux-foundation.org
Subject: [patch 198/203] numa: ia64: use generic percpu var numa_node_id() implementation
Date: Wed, 26 May 2010 14:44:59 -0700
Message-ID: <201005262144.o4QLixNv016253@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36905 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753741Ab0EZVsZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 May 2010 17:48:25 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, lee.schermerhorn@hp.com, cl@linux-foundation.org, eric.whitney@hp.com, hpa@zytor.com, kamezawa.hiroyu@jp.fujitsu.com, linux-arch@vger.kernel.org, mel@csn.ul.ie, mingo@elte.hu, npiggin@suse.de, penberg@cs.helsinki.fi, rientjes@google.com, tglx@linutronix.de, tj@kernel.org, tony.luck@intel.com

From: Lee Schermerhorn <lee.schermerhorn@hp.com>

ia64:  Use generic percpu implementation of numa_node_id()
   + intialize per cpu 'numa_node'
   + remove ia64 cpu_to_node() macro;  use generic
   + define CONFIG_USE_PERCPU_NUMA_NODE_ID when NUMA configured

Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>
Reviewed-by: Christoph Lameter <cl@linux-foundation.org>
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

 arch/ia64/Kconfig                |    4 ++++
 arch/ia64/include/asm/topology.h |    5 -----
 arch/ia64/kernel/smpboot.c       |    6 ++++++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff -puN arch/ia64/Kconfig~numa-ia64-use-generic-percpu-var-numa_node_id-implementation arch/ia64/Kconfig
--- a/arch/ia64/Kconfig~numa-ia64-use-generic-percpu-var-numa_node_id-implementation
+++ a/arch/ia64/Kconfig
@@ -498,6 +498,10 @@ config HAVE_ARCH_NODEDATA_EXTENSION
 	def_bool y
 	depends on NUMA
 
+config USE_PERCPU_NUMA_NODE_ID
+	def_bool y
+	depends on NUMA
+
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 	depends on PROC_KCORE
diff -puN arch/ia64/include/asm/topology.h~numa-ia64-use-generic-percpu-var-numa_node_id-implementation arch/ia64/include/asm/topology.h
--- a/arch/ia64/include/asm/topology.h~numa-ia64-use-generic-percpu-var-numa_node_id-implementation
+++ a/arch/ia64/include/asm/topology.h
@@ -26,11 +26,6 @@
 #define RECLAIM_DISTANCE 15
 
 /*
- * Returns the number of the node containing CPU 'cpu'
- */
-#define cpu_to_node(cpu) (int)(cpu_to_node_map[cpu])
-
-/*
  * Returns a bitmask of CPUs on Node 'node'.
  */
 #define cpumask_of_node(node) ((node) == -1 ?				\
diff -puN arch/ia64/kernel/smpboot.c~numa-ia64-use-generic-percpu-var-numa_node_id-implementation arch/ia64/kernel/smpboot.c
--- a/arch/ia64/kernel/smpboot.c~numa-ia64-use-generic-percpu-var-numa_node_id-implementation
+++ a/arch/ia64/kernel/smpboot.c
@@ -390,6 +390,11 @@ smp_callin (void)
 
 	fix_b0_for_bsp();
 
+	/*
+	 * numa_node_id() works after this.
+	 */
+	set_numa_node(cpu_to_node_map[cpuid]);
+
 	ipi_call_lock_irq();
 	spin_lock(&vector_lock);
 	/* Setup the per cpu irq handling data structures */
@@ -632,6 +637,7 @@ void __devinit smp_prepare_boot_cpu(void
 {
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_callin_map);
+	set_numa_node(cpu_to_node_map[smp_processor_id()]);
 	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
 	paravirt_post_smp_prepare_boot_cpu();
 }
_
