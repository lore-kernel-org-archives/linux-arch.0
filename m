From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 25/41] cpu alloc: scheduler: Convert cpuusage to cpu_alloc.
Date: Thu, 29 May 2008 20:56:45 -0700
Message-ID: <20080530040019.473812921@sgi.com>
References: <20080530035620.587204923@sgi.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:40495 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750856AbYE3EAW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 00:00:22 -0400
Content-Disposition: inline; filename=cpu_alloc_scheduler_usage_conversion
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

Convert scheduler handling of cpuusage to cpu alloc.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

---
 arch/x86/kernel/setup.c |    2 +-
 kernel/sched.c          |   10 +++++-----
 mm/cpu_alloc.c          |   25 +++++++++++++++++++------
 3 files changed, 25 insertions(+), 12 deletions(-)

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2008-05-26 20:38:49.000000000 -0700
+++ linux-2.6/kernel/sched.c	2008-05-26 20:38:53.000000000 -0700
@@ -9090,7 +9090,7 @@
 	if (!ca)
 		return ERR_PTR(-ENOMEM);
 
-	ca->cpuusage = alloc_percpu(u64);
+	ca->cpuusage = CPU_ALLOC(u64, GFP_KERNEL|__GFP_ZERO);
 	if (!ca->cpuusage) {
 		kfree(ca);
 		return ERR_PTR(-ENOMEM);
@@ -9105,7 +9105,7 @@
 {
 	struct cpuacct *ca = cgroup_ca(cgrp);
 
-	free_percpu(ca->cpuusage);
+	CPU_FREE(ca->cpuusage);
 	kfree(ca);
 }
 
@@ -9117,7 +9117,7 @@
 	int i;
 
 	for_each_possible_cpu(i) {
-		u64 *cpuusage = percpu_ptr(ca->cpuusage, i);
+		u64 *cpuusage = CPU_PTR(cpuusage, i);
 
 		/*
 		 * Take rq->lock to make 64-bit addition safe on 32-bit
@@ -9144,7 +9144,7 @@
 	}
 
 	for_each_possible_cpu(i) {
-		u64 *cpuusage = percpu_ptr(ca->cpuusage, i);
+		u64 *cpuusage = CPU_PTR(ca->cpuusage, i);
 
 		spin_lock_irq(&cpu_rq(i)->lock);
 		*cpuusage = 0;
@@ -9181,7 +9181,7 @@
 
 	ca = task_ca(tsk);
 	if (ca) {
-		u64 *cpuusage = percpu_ptr(ca->cpuusage, task_cpu(tsk));
+		u64 *cpuusage = CPU_PTR(ca->cpuusage, task_cpu(tsk));
 
 		*cpuusage += cputime;
 	}

-- 
