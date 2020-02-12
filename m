Return-Path: <SRS0=bqXs=4A=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbgBLJnp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 04:43:45 -0500
Message-ID: <20200212094107.838108888@infradead.org>
Date: Wed, 12 Feb 2020 10:32:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/8] sched,rcu,tracing: Mark preempt_count_{add,sub}() notrace
References: <20200212093210.468391728@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Message-ID: <20200212093214.fvCkZIz5iETXwBADjiXnEQyT3dwh41gO10sFPbkyZIQ@z>

Because of the requirement that no tracing happens until after we've
incremented preempt_count, see nmi_enter() / trace_rcu_enter(), mark
these functions as notrace.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3781,7 +3781,7 @@ static inline void preempt_latency_start
 	}
 }
 
-void preempt_count_add(int val)
+void notrace preempt_count_add(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
@@ -3813,7 +3813,7 @@ static inline void preempt_latency_stop(
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 }
 
-void preempt_count_sub(int val)
+void notrace preempt_count_sub(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
