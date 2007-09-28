Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:51136 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755278AbXI1ICE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 28 Sep 2007 04:02:04 -0400
Message-Id: <20070928080042.298523000@chello.nl>
References: <20070928074200.436463000@chello.nl>
Date: Fri, 28 Sep 2007 09:42:08 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 08/12] lockdep: increase MAX_LOCK_DEPTH
Content-Disposition: inline; filename=lockdep-depth.patch
Sender: linux-arch-owner@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Cc: Zach Brown <zach.brown@oracle.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-ID: <linux-arch.vger.kernel.org>

we can easily hold PAGE_VEC (and more in places) page locks.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 include/linux/sched.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -1246,7 +1246,7 @@ struct task_struct {
 	int softirq_context;
 #endif
 #ifdef CONFIG_LOCKDEP
-# define MAX_LOCK_DEPTH 30UL
+# define MAX_LOCK_DEPTH 48UL
 	u64 curr_chain_key;
 	int lockdep_depth;
 	struct held_lock held_locks[MAX_LOCK_DEPTH];

--

