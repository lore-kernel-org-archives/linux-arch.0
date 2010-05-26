From: akpm@linux-foundation.org
Subject: [patch 200/203] numa: ia64: support numa_mem_id() for memoryless nodes
Date: Wed, 26 May 2010 14:45:01 -0700
Message-ID: <201005262145.o4QLj1R3016268@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42283 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753076Ab0EZVsY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 May 2010 17:48:24 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, lee.schermerhorn@hp.com, cl@linux-foundation.org, eric.whitney@hp.com, hpa@zytor.com, kamezawa.hiroyu@jp.fujitsu.com, linux-arch@vger.kernel.org, mel@csn.ul.ie, mingo@elte.hu, npiggin@suse.de, penberg@cs.helsinki.fi, rientjes@google.com, tglx@linutronix.de, tj@kernel.org, tony.luck@intel.com

From: Lee Schermerhorn <lee.schermerhorn@hp.com>

Enable 'HAVE_MEMORYLESS_NODES' by default when NUMA configured on ia64. 
Initialize percpu 'numa_mem' variable when starting secondary cpus. 
Generic initialization will handle the boot cpu.

Nothing uses 'numa_mem_id()' yet.  Subsequent patch with modify slab to
use this.

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

 arch/ia64/Kconfig          |    4 ++++
 arch/ia64/kernel/smpboot.c |    1 +
 2 files changed, 5 insertions(+)

diff -puN arch/ia64/Kconfig~numa-ia64-support-numa_mem_id-for-memoryless-nodes arch/ia64/Kconfig
--- a/arch/ia64/Kconfig~numa-ia64-support-numa_mem_id-for-memoryless-nodes
+++ a/arch/ia64/Kconfig
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
diff -puN arch/ia64/kernel/smpboot.c~numa-ia64-support-numa_mem_id-for-memoryless-nodes arch/ia64/kernel/smpboot.c
--- a/arch/ia64/kernel/smpboot.c~numa-ia64-support-numa_mem_id-for-memoryless-nodes
+++ a/arch/ia64/kernel/smpboot.c
@@ -394,6 +394,7 @@ smp_callin (void)
 	 * numa_node_id() works after this.
 	 */
 	set_numa_node(cpu_to_node_map[cpuid]);
+	set_numa_mem(local_memory_node(cpu_to_node_map[cpuid]));
 
 	ipi_call_lock_irq();
 	spin_lock(&vector_lock);
_
