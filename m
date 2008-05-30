From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 12/41] cpu alloc: XFS counter conversion.
Date: Thu, 29 May 2008 20:56:32 -0700
Message-ID: <20080530040014.102721466@sgi.com>
References: <20080530035620.587204923@sgi.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.171.30]:56584 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751592AbYE3EAS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 00:00:18 -0400
Content-Disposition: inline; filename=cpu_alloc_xfs_counter_conversion
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

Also remove the useless zeroing after allocation. Even allocpercpu() already
zeroed the objects on alloc.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
---
 fs/xfs/xfs_mount.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

Index: linux-2.6/fs/xfs/xfs_mount.c
===================================================================
--- linux-2.6.orig/fs/xfs/xfs_mount.c	2008-05-08 22:10:42.000000000 -0700
+++ linux-2.6/fs/xfs/xfs_mount.c	2008-05-21 21:46:27.000000000 -0700
@@ -2016,7 +2016,7 @@
 
 	mp = (xfs_mount_t *)container_of(nfb, xfs_mount_t, m_icsb_notifier);
 	cntp = (xfs_icsb_cnts_t *)
-			per_cpu_ptr(mp->m_sb_cnts, (unsigned long)hcpu);
+			CPU_PTR(mp->m_sb_cnts, (unsigned long)hcpu);
 	switch (action) {
 	case CPU_UP_PREPARE:
 	case CPU_UP_PREPARE_FROZEN:
@@ -2065,10 +2065,7 @@
 xfs_icsb_init_counters(
 	xfs_mount_t	*mp)
 {
-	xfs_icsb_cnts_t *cntp;
-	int		i;
-
-	mp->m_sb_cnts = alloc_percpu(xfs_icsb_cnts_t);
+	mp->m_sb_cnts = CPU_ALLOC(xfs_icsb_cnts_t, GFP_KERNEL | __GFP_ZERO);
 	if (mp->m_sb_cnts == NULL)
 		return -ENOMEM;
 
@@ -2078,11 +2075,6 @@
 	register_hotcpu_notifier(&mp->m_icsb_notifier);
 #endif /* CONFIG_HOTPLUG_CPU */
 
-	for_each_online_cpu(i) {
-		cntp = (xfs_icsb_cnts_t *)per_cpu_ptr(mp->m_sb_cnts, i);
-		memset(cntp, 0, sizeof(xfs_icsb_cnts_t));
-	}
-
 	mutex_init(&mp->m_icsb_mutex);
 
 	/*
@@ -2115,7 +2107,7 @@
 {
 	if (mp->m_sb_cnts) {
 		unregister_hotcpu_notifier(&mp->m_icsb_notifier);
-		free_percpu(mp->m_sb_cnts);
+		CPU_FREE(mp->m_sb_cnts);
 	}
 	mutex_destroy(&mp->m_icsb_mutex);
 }
@@ -2145,7 +2137,7 @@
 	int		i;
 
 	for_each_online_cpu(i) {
-		cntp = (xfs_icsb_cnts_t *)per_cpu_ptr(mp->m_sb_cnts, i);
+		cntp = (xfs_icsb_cnts_t *)CPU_PTR(mp->m_sb_cnts, i);
 		xfs_icsb_lock_cntr(cntp);
 	}
 }
@@ -2158,7 +2150,7 @@
 	int		i;
 
 	for_each_online_cpu(i) {
-		cntp = (xfs_icsb_cnts_t *)per_cpu_ptr(mp->m_sb_cnts, i);
+		cntp = (xfs_icsb_cnts_t *)CPU_PTR(mp->m_sb_cnts, i);
 		xfs_icsb_unlock_cntr(cntp);
 	}
 }
@@ -2178,7 +2170,7 @@
 		xfs_icsb_lock_all_counters(mp);
 
 	for_each_online_cpu(i) {
-		cntp = (xfs_icsb_cnts_t *)per_cpu_ptr(mp->m_sb_cnts, i);
+		cntp = (xfs_icsb_cnts_t *)CPU_PTR(mp->m_sb_cnts, i);
 		cnt->icsb_icount += cntp->icsb_icount;
 		cnt->icsb_ifree += cntp->icsb_ifree;
 		cnt->icsb_fdblocks += cntp->icsb_fdblocks;
@@ -2254,7 +2246,7 @@
 
 	xfs_icsb_lock_all_counters(mp);
 	for_each_online_cpu(i) {
-		cntp = per_cpu_ptr(mp->m_sb_cnts, i);
+		cntp = CPU_PTR(mp->m_sb_cnts, i);
 		switch (field) {
 		case XFS_SBS_ICOUNT:
 			cntp->icsb_icount = count + resid;
@@ -2391,7 +2383,7 @@
 	might_sleep();
 again:
 	cpu = get_cpu();
-	icsbp = (xfs_icsb_cnts_t *)per_cpu_ptr(mp->m_sb_cnts, cpu);
+	icsbp = (xfs_icsb_cnts_t *)CPU_PTR(mp->m_sb_cnts, cpu);
 
 	/*
 	 * if the counter is disabled, go to slow path

-- 
