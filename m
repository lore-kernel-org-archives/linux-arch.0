From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Subject: [PATCH/RFC 6/8] numa: ia64: support numa_mem_id() for memoryless nodes
Date: Thu, 04 Mar 2010 12:08:24 -0500
Message-ID: <20100304170824.10606.87151.sendpatchset@localhost.localdomain>
References: <20100304170654.10606.32225.sendpatchset@localhost.localdomain>
Return-path: <linux-numa-owner@vger.kernel.org>
In-Reply-To: <20100304170654.10606.32225.sendpatchset@localhost.localdomain>
Sender: linux-numa-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Mel Gorman <mel@csn.ul.ie>, Andi Kleen <andi@firstfloor.org>, Christoph Lameter <cl@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, akpm@linux-foundation.org, eric.whitney@hp.com
List-Id: linux-arch.vger.kernel.org

PATCH/RFC numa: ia64:  support memoryless nodes

Against:  2.6.33-mmotm-100302-1838

Enable 'HAVE_MEMORYLESS_NODES' by default when NUMA configured
on ia64.  Initialize percpu 'numa_mem' variable when starting
secondary cpus.  Generic initialization will handle the boot
cpu.

Nothing uses 'numa_mem_id()' yet.  Subsequent patch with modify
slab to use this.

Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>

New in V2

 arch/ia64/Kconfig          |    4 ++++
 arch/ia64/kernel/smpboot.c |    1 +
 2 files changed, 5 insertions(+)

Index: linux-2.6.33-mmotm-100302-1838/arch/ia64/Kconfig
===================================================================
--- linux-2.6.33-mmotm-100302-1838.orig/arch/ia64/Kconfig
+++ linux-2.6.33-mmotm-100302-1838/arch/ia64/Kconfig
@@ -502,6 +502,10 @@ config USE_PERCPU_NUMA_NODE_ID
 	def_bool y
 	depends on NUMA
 
+config HAVE_MEMORYLESS_NODES
+	def_bool y
+	depends on NUMA
+
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 	depends on PROC_KCORE
Index: linux-2.6.33-mmotm-100302-1838/arch/ia64/kernel/smpboot.c
===================================================================
--- linux-2.6.33-mmotm-100302-1838.orig/arch/ia64/kernel/smpboot.c
+++ linux-2.6.33-mmotm-100302-1838/arch/ia64/kernel/smpboot.c
@@ -394,6 +394,7 @@ smp_callin (void)
 	 * numa_node_id() works after this.
 	 */
 	set_numa_node(cpu_to_node_map[cpuid]);
+	set_numa_mem(local_memory_node(cpu_to_node_map[cpuid]));
 
 	ipi_call_lock_irq();
 	spin_lock(&vector_lock);
