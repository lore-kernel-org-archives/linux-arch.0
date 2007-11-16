Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:39569 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761687AbXKPXLG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Nov 2007 18:11:06 -0500
Message-Id: <20071116231106.174532533@sgi.com>
References: <20071116230920.278761667@sgi.com>
Date: Fri, 16 Nov 2007 15:09:37 -0800
From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 17/30] cpu alloc: NFS statistics
Content-Disposition: inline; filename=0027-cpu-alloc-NFS-statistics.patch
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-arch.vger.kernel.org>

Signed-off-by: Christoph Lameter <clameter@sgi.com>
---
 fs/nfs/iostat.h |    8 ++++----
 fs/nfs/super.c  |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/fs/nfs/iostat.h
===================================================================
--- linux-2.6.orig/fs/nfs/iostat.h	2007-11-15 21:17:24.391404458 -0800
+++ linux-2.6/fs/nfs/iostat.h	2007-11-15 21:25:33.167654066 -0800
@@ -123,7 +123,7 @@ static inline void nfs_inc_server_stats(
 	int cpu;
 
 	cpu = get_cpu();
-	iostats = per_cpu_ptr(server->io_stats, cpu);
+	iostats = CPU_PTR(server->io_stats, cpu);
 	iostats->events[stat] ++;
 	put_cpu_no_resched();
 }
@@ -139,7 +139,7 @@ static inline void nfs_add_server_stats(
 	int cpu;
 
 	cpu = get_cpu();
-	iostats = per_cpu_ptr(server->io_stats, cpu);
+	iostats = CPU_PTR(server->io_stats, cpu);
 	iostats->bytes[stat] += addend;
 	put_cpu_no_resched();
 }
@@ -151,13 +151,13 @@ static inline void nfs_add_stats(struct 
 
 static inline struct nfs_iostats *nfs_alloc_iostats(void)
 {
-	return alloc_percpu(struct nfs_iostats);
+	return CPU_ALLOC(struct nfs_iostats, GFP_KERNEL | __GFP_ZERO);
 }
 
 static inline void nfs_free_iostats(struct nfs_iostats *stats)
 {
 	if (stats != NULL)
-		free_percpu(stats);
+		CPU_FREE(stats);
 }
 
 #endif
Index: linux-2.6/fs/nfs/super.c
===================================================================
--- linux-2.6.orig/fs/nfs/super.c	2007-11-15 21:17:24.399404478 -0800
+++ linux-2.6/fs/nfs/super.c	2007-11-15 21:25:33.171654143 -0800
@@ -529,7 +529,7 @@ static int nfs_show_stats(struct seq_fil
 		struct nfs_iostats *stats;
 
 		preempt_disable();
-		stats = per_cpu_ptr(nfss->io_stats, cpu);
+		stats = CPU_PTR(nfss->io_stats, cpu);
 
 		for (i = 0; i < __NFSIOS_COUNTSMAX; i++)
 			totals.events[i] += stats->events[i];

-- 
