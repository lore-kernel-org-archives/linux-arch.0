From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Subject: [PATCH 4/7] numa-x86_64-use-generic-percpu-var-numa_node_id-implementation-fix2
Date: Mon, 03 May 2010 11:06:12 -0400
Message-ID: <20100503150612.15039.8351.sendpatchset@localhost.localdomain>
References: <20100503150455.15039.10178.sendpatchset@localhost.localdomain>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:27228 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932590Ab0ECPGP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2010 11:06:15 -0400
In-Reply-To: <20100503150455.15039.10178.sendpatchset@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Valdis.Kletnieks@vt.edu, Randy Dunlap <randy.dunlap@oracle.com>, Christoph Lameter <cl@linux-foundation.org>, eric.whitney@hp.com, Andrew Morton <akpm@linux-foundation.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Incremental patch 2 to
numa-x86_64-use-generic-percpu-var-numa_node_id-implementation.patch
in 28apr10 mmotm.

Use generic function to set numa_node for a specified cpu as
suggested by Christoph Lameter and seconded by Tejun Heo.

Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>

 arch/x86/kernel/setup_percpu.c |    2 +-
 arch/x86/mm/numa_64.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.34-rc5-mmotm-100428-1653/arch/x86/mm/numa_64.c
===================================================================
--- linux-2.6.34-rc5-mmotm-100428-1653.orig/arch/x86/mm/numa_64.c
+++ linux-2.6.34-rc5-mmotm-100428-1653/arch/x86/mm/numa_64.c
@@ -806,7 +806,7 @@ void __cpuinit numa_set_node(int cpu, in
 	per_cpu(x86_cpu_to_node_map, cpu) = node;
 
 	if (node != NUMA_NO_NODE)
-		per_cpu(numa_node, cpu) = node;
+		set_cpu_numa_node(cpu, node);
 }
 
 void __cpuinit numa_clear_node(int cpu)
Index: linux-2.6.34-rc5-mmotm-100428-1653/arch/x86/kernel/setup_percpu.c
===================================================================
--- linux-2.6.34-rc5-mmotm-100428-1653.orig/arch/x86/kernel/setup_percpu.c
+++ linux-2.6.34-rc5-mmotm-100428-1653/arch/x86/kernel/setup_percpu.c
@@ -268,7 +268,7 @@ void __init setup_per_cpu_areas(void)
 	 * make sure boot cpu numa_node is right, when boot cpu is on the
 	 * node that doesn't have mem installed
 	 */
-	per_cpu(numa_node, boot_cpu_id) = early_cpu_to_node(boot_cpu_id);
+	set_cpu_numa_node(boot_cpu_id, early_cpu_to_node(boot_cpu_id));
 #endif
 
 	/* Setup node to cpumask map */
