From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 11/15] tracepoint: Remove smp_read_barrier_depends() from comment
Date: Mon,  9 Oct 2017 17:22:45 -0700
Message-ID: <1507594969-8347-11-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-arch.vger.kernel.org

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
