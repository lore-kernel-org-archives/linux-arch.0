From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 8/9] tracing: Remove regular RCU context for _rcuidle tracepoints (again)
Date: Wed, 12 Feb 2020 22:01:47 +0100
Message-ID: <20200212210750.255616631@infradead.org>
References: <20200212210139.382424693@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbgBLVOE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 16:14:04 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
taught perf how to deal with not having an RCU context provided.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/tracepoint.h |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo
 		 * For rcuidle callers, use srcu since sched-rcu	\
 		 * doesn't work from the idle path.			\
 		 */							\
-		if (rcuidle) {						\
+		if (rcuidle)						\
 			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
-			rcu_irq_enter_irqsave();			\
-		}							\
 									\
 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
 									\
@@ -194,10 +192,8 @@ static inline struct tracepoint *tracepo
 			} while ((++it_func_ptr)->func);		\
 		}							\
 									\
-		if (rcuidle) {						\
-			rcu_irq_exit_irqsave();				\
+		if (rcuidle)						\
 			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
-		}							\
 									\
 		preempt_enable_notrace();				\
 	} while (0)
