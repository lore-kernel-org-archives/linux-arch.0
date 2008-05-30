From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 13/41] cpu alloc: NFS statistics
Date: Thu, 29 May 2008 20:56:33 -0700
Message-ID: <20080530040014.412942030@sgi.com>
References: <20080530035620.587204923@sgi.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.171.30]:56592 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751354AbYE3EAS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 00:00:18 -0400
Content-Disposition: inline; filename=cpu_alloc_nfs_statistics_conversion
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

Convert NFS statistics to cpu alloc.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
---
 fs/nfs/iostat.h |   27 +++++++++++----------------
 fs/nfs/super.c  |    2 +-
 2 files changed, 12 insertions(+), 17 deletions(-)

Index: linux-2.6/fs/nfs/iostat.h
===================================================================
--- linux-2.6.orig/fs/nfs/iostat.h	2008-05-26 09:35:31.077736336 -0700
+++ linux-2.6/fs/nfs/iostat.h	2008-05-26 10:01:26.178776581 -0700
@@ -119,13 +119,7 @@ struct nfs_iostats {
 
 static inline void nfs_inc_server_stats(struct nfs_server *server, enum nfs_stat_eventcounters stat)
 {
-	struct nfs_iostats *iostats;
-	int cpu;
-
-	cpu = get_cpu();
-	iostats = per_cpu_ptr(server->io_stats, cpu);
-	iostats->events[stat] ++;
-	put_cpu_no_resched();
+	_CPU_INC(server->io_stats->events[stat]);
 }
 
 static inline void nfs_inc_stats(struct inode *inode, enum nfs_stat_eventcounters stat)
@@ -135,13 +129,14 @@ static inline void nfs_inc_stats(struct 
 
 static inline void nfs_add_server_stats(struct nfs_server *server, enum nfs_stat_bytecounters stat, unsigned long addend)
 {
-	struct nfs_iostats *iostats;
-	int cpu;
-
-	cpu = get_cpu();
-	iostats = per_cpu_ptr(server->io_stats, cpu);
-	iostats->bytes[stat] += addend;
-	put_cpu_no_resched();
+#ifdef CONFIG_64BIT
+	_CPU_ADD(server->io_stats->bytes[stat], addend);
+#else
+	/* 32bit cannot perform atomic 64 bit inc sodisable preemption */
+	preempt_disable();
+	THIS_CPU(server->io_stats)->bytes[stat] += addend;
+	preempt_enable_no_resched();
+#endif
 }
 
 static inline void nfs_add_stats(struct inode *inode, enum nfs_stat_bytecounters stat, unsigned long addend)
@@ -151,13 +146,13 @@ static inline void nfs_add_stats(struct 
 
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
--- linux-2.6.orig/fs/nfs/super.c	2008-05-26 09:35:31.097738734 -0700
+++ linux-2.6/fs/nfs/super.c	2008-05-26 09:36:15.900248119 -0700
@@ -620,7 +620,7 @@ static int nfs_show_stats(struct seq_fil
 		struct nfs_iostats *stats;
 
 		preempt_disable();
-		stats = per_cpu_ptr(nfss->io_stats, cpu);
+		stats = CPU_PTR(nfss->io_stats, cpu);
 
 		for (i = 0; i < __NFSIOS_COUNTSMAX; i++)
 			totals.events[i] += stats->events[i];

-- 
