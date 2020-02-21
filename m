From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 08/27] rcu/kprobes: Comment why rcu_nmi_enter() is marked NOKPROBE
Date: Fri, 21 Feb 2020 14:34:24 +0100
Message-ID: <20200221134215.501225981@infradead.org>
References: <20200221133416.777099322@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45510 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgBUNui (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:38 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

It's confusing that rcu_nmi_enter() is marked NOKPROBE and
rcu_nmi_exit() is not. One may think that the exit needs to be marked
for the same reason the enter is, as rcu_nmi_exit() reverts the RCU
state back to what it was before rcu_nmi_enter(). But the reason has
nothing to do with the state of RCU.

The breakpoint handler (int3 on x86) must not have any kprobe on it
until the kprobe handler is called. Otherwise, it can cause an infinite
recursion and crash the machine. It just so happens that
rcu_nmi_enter() is called by the int3 handler before the kprobe handler
can run, and therefore needs to be marked as NOKPROBE.

Comment this to remove the confusion to why rcu_nmi_enter() is marked
NOKPROBE but rcu_nmi_exit() is not.

Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Link: https://lore.kernel.org/r/20200213163800.5c51a5f1@gandalf.local.home
---
 kernel/rcu/tree.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -825,6 +825,14 @@ void rcu_nmi_enter(void)
 		   rdp->dynticks_nmi_nesting + incby);
 	barrier();
 }
+/*
+ * All functions called in the breakpoint trap handler (e.g. do_int3()
+ * on x86), must not allow kprobes until the kprobe breakpoint handler
+ * is called, otherwise it can cause an infinite recursion.
+ * On some archs, rcu_nmi_enter() is called in the breakpoint handler
+ * before the kprobe breakpoint handler is called, thus it must be
+ * marked as NOKPROBE.
+ */
 NOKPROBE_SYMBOL(rcu_nmi_enter);
 
 /**
