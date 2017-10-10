Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755818AbdJJAW4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 20:22:56 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9A0JQQK118126
        for <linux-arch@vger.kernel.org>; Mon, 9 Oct 2017 20:22:55 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dgcabvs74-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 20:22:55 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 20:22:54 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 11/15] tracepoint: Remove smp_read_barrier_depends() from comment
Date: Mon,  9 Oct 2017 17:22:45 -0700
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Message-ID: <1507594969-8347-11-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20171010002245.sapQAZ3WGkHFpMa2CfhYafcozIbKuYggyaiq4dOrTyI@z>

The comment in tracepoint_add_func() mentions smp_read_barrier_depends(),
whose use should be quite restricted.  This commit updates the comment
to instead mention the smp_store_release() and rcu_dereference_sched()
that the current code actually uses.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/tracepoint.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 685c50ae6300..671b13457387 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -212,11 +212,10 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	}
 
 	/*
-	 * rcu_assign_pointer has a smp_wmb() which makes sure that the new
-	 * probe callbacks array is consistent before setting a pointer to it.
-	 * This array is referenced by __DO_TRACE from
-	 * include/linux/tracepoints.h. A matching smp_read_barrier_depends()
-	 * is used.
+	 * rcu_assign_pointer has as smp_store_release() which makes sure
+	 * that the new probe callbacks array is consistent before setting
+	 * a pointer to it.  This array is referenced by __DO_TRACE from
+	 * include/linux/tracepoint.h using rcu_dereference_sched().
 	 */
 	rcu_assign_pointer(tp->funcs, tp_funcs);
 	if (!static_key_enabled(&tp->key))
-- 
2.5.2
