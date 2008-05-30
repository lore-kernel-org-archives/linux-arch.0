From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 14/41] cpu alloc: Neigbour statistics
Date: Thu, 29 May 2008 20:56:34 -0700
Message-ID: <20080530040014.715491933@sgi.com>
References: <20080530035620.587204923@sgi.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:45446 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751672AbYE3EAS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 00:00:18 -0400
Content-Disposition: inline; filename=cpu_alloc_neighbor_statistics_conversion
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

Convert neighbor stats to cpu alloc.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
---
 include/net/neighbour.h |    6 +-----
 net/core/neighbour.c    |   11 ++++++-----
 2 files changed, 7 insertions(+), 10 deletions(-)

Index: linux-2.6/include/net/neighbour.h
===================================================================
--- linux-2.6.orig/include/net/neighbour.h	2008-05-21 23:59:14.000000000 -0700
+++ linux-2.6/include/net/neighbour.h	2008-05-22 07:40:37.000000000 -0700
@@ -87,12 +87,7 @@
 	unsigned long forced_gc_runs;	/* number of forced GC runs */
 };
 
-#define NEIGH_CACHE_STAT_INC(tbl, field)				\
-	do {								\
-		preempt_disable();					\
-		(per_cpu_ptr((tbl)->stats, smp_processor_id())->field)++; \
-		preempt_enable();					\
-	} while (0)
+#define NEIGH_CACHE_STAT_INC(tbl, field) _CPU_INC((tbl)->stats->field)
 
 struct neighbour
 {
Index: linux-2.6/net/core/neighbour.c
===================================================================
--- linux-2.6.orig/net/core/neighbour.c	2008-05-21 23:59:14.000000000 -0700
+++ linux-2.6/net/core/neighbour.c	2008-05-22 00:00:06.000000000 -0700
@@ -1425,7 +1425,8 @@
 			kmem_cache_create(tbl->id, tbl->entry_size, 0,
 					  SLAB_HWCACHE_ALIGN|SLAB_PANIC,
 					  NULL);
-	tbl->stats = alloc_percpu(struct neigh_statistics);
+	tbl->stats = CPU_ALLOC(struct neigh_statistics,
+					GFP_KERNEL | __GFP_ZERO);
 	if (!tbl->stats)
 		panic("cannot create neighbour cache statistics");
 
@@ -1511,7 +1512,7 @@
 
 	remove_proc_entry(tbl->id, init_net.proc_net_stat);
 
-	free_percpu(tbl->stats);
+	CPU_FREE(tbl->stats);
 	tbl->stats = NULL;
 
 	kmem_cache_destroy(tbl->kmem_cachep);
@@ -1769,7 +1770,7 @@
 		for_each_possible_cpu(cpu) {
 			struct neigh_statistics	*st;
 
-			st = per_cpu_ptr(tbl->stats, cpu);
+			st = CPU_PTR(tbl->stats, cpu);
 			ndst.ndts_allocs		+= st->allocs;
 			ndst.ndts_destroys		+= st->destroys;
 			ndst.ndts_hash_grows		+= st->hash_grows;
@@ -2429,7 +2430,7 @@
 		if (!cpu_possible(cpu))
 			continue;
 		*pos = cpu+1;
-		return per_cpu_ptr(tbl->stats, cpu);
+		return CPU_PTR(tbl->stats, cpu);
 	}
 	return NULL;
 }
@@ -2444,7 +2445,7 @@
 		if (!cpu_possible(cpu))
 			continue;
 		*pos = cpu+1;
-		return per_cpu_ptr(tbl->stats, cpu);
+		return CPU_PTR(tbl->stats, cpu);
 	}
 	return NULL;
 }

-- 
