Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:51810 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761575AbXKPXLF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2007 18:11:05 -0500
Message-Id: <20071116231105.230572764@sgi.com>
References: <20071116230920.278761667@sgi.com>
Date: Fri, 16 Nov 2007 15:09:33 -0800
From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 13/30] cpu alloc: genhd statistics conversion
Content-Disposition: inline; filename=0023-cpu-alloc-genhd-statistics-conversion.patch
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-arch.vger.kernel.org>

Signed-off-by: Christoph Lameter <clameter@sgi.com>
---
 include/linux/genhd.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/include/linux/genhd.h
===================================================================
--- linux-2.6.orig/include/linux/genhd.h	2007-11-15 21:18:07.967654575 -0800
+++ linux-2.6/include/linux/genhd.h	2007-11-15 21:25:31.066904143 -0800
@@ -158,21 +158,21 @@ struct disk_attribute {
  */
 #ifdef	CONFIG_SMP
 #define __disk_stat_add(gendiskp, field, addnd) 	\
-	(per_cpu_ptr(gendiskp->dkstats, smp_processor_id())->field += addnd)
+	(THIS_CPU(gendiskp->dkstats)->field += addnd)
 
 #define disk_stat_read(gendiskp, field)					\
 ({									\
 	typeof(gendiskp->dkstats->field) res = 0;			\
 	int i;								\
 	for_each_possible_cpu(i)					\
-		res += per_cpu_ptr(gendiskp->dkstats, i)->field;	\
+		res += CPU_PTR(gendiskp->dkstats, i)->field;	\
 	res;								\
 })
 
 static inline void disk_stat_set_all(struct gendisk *gendiskp, int value)	{
 	int i;
 	for_each_possible_cpu(i)
-		memset(per_cpu_ptr(gendiskp->dkstats, i), value,
+		memset(CPU_PTR(gendiskp->dkstats, i), value,
 				sizeof (struct disk_stats));
 }		
 				
@@ -209,7 +209,7 @@ static inline void disk_stat_set_all(str
 #ifdef  CONFIG_SMP
 static inline int init_disk_stats(struct gendisk *disk)
 {
-	disk->dkstats = alloc_percpu(struct disk_stats);
+	disk->dkstats = CPU_ALLOC(struct disk_stats, GFP_KERNEL | __GFP_ZERO);
 	if (!disk->dkstats)
 		return 0;
 	return 1;
@@ -217,7 +217,7 @@ static inline int init_disk_stats(struct
 
 static inline void free_disk_stats(struct gendisk *disk)
 {
-	free_percpu(disk->dkstats);
+	CPU_FREE(disk->dkstats);
 }
 #else	/* CONFIG_SMP */
 static inline int init_disk_stats(struct gendisk *disk)

-- 
