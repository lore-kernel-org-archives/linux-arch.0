From: akpm@linux-foundation.org
Subject: [patch 202/203] numa: in-kernel profiling: use cpu_to_mem() for per cpu allocations
Date: Wed, 26 May 2010 14:45:04 -0700
Message-ID: <201005262145.o4QLj4cI016279@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47210 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753798Ab0EZVsZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 May 2010 17:48:25 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, lee.schermerhorn@hp.com, cl@linux-foundation.org, eric.whitney@hp.com, hpa@zytor.com, kamezawa.hiroyu@jp.fujitsu.com, linux-arch@vger.kernel.org, mel@csn.ul.ie, mingo@elte.hu, npiggin@suse.de, penberg@cs.helsinki.fi, rientjes@google.com, tglx@linutronix.de, tj@kernel.org, tony.luck@intel.com

From: Lee Schermerhorn <lee.schermerhorn@hp.com>

In kernel profiling requires that we be able to allocate "local" memory
for each cpu.  Use "cpu_to_mem()" instead of "cpu_to_node()" to support
memoryless nodes.

Depends on the "numa_mem_id()" patch.

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

 kernel/profile.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN kernel/profile.c~numa-in-kernel-profiling-use-cpu_to_mem-for-per-cpu-allocations kernel/profile.c
--- a/kernel/profile.c~numa-in-kernel-profiling-use-cpu_to_mem-for-per-cpu-allocations
+++ a/kernel/profile.c
@@ -365,7 +365,7 @@ static int __cpuinit profile_cpu_callbac
 	switch (action) {
 	case CPU_UP_PREPARE:
 	case CPU_UP_PREPARE_FROZEN:
-		node = cpu_to_node(cpu);
+		node = cpu_to_mem(cpu);
 		per_cpu(cpu_profile_flip, cpu) = 0;
 		if (!per_cpu(cpu_profile_hits, cpu)[1]) {
 			page = alloc_pages_exact_node(node,
@@ -567,7 +567,7 @@ static int create_hash_tables(void)
 	int cpu;
 
 	for_each_online_cpu(cpu) {
-		int node = cpu_to_node(cpu);
+		int node = cpu_to_mem(cpu);
 		struct page *page;
 
 		page = alloc_pages_exact_node(node,
_
