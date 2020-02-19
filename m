From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] rcu/kprobes: Comment why rcu_nmi_enter() is marked NOKPROBE
Date: Wed, 19 Feb 2020 12:16:09 -0500
Message-ID: <20200219121609.45548925@gandalf.local.home>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.661923520@infradead.org>
        <20200219163156.GY2935@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgBSRQN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 12:16:13 -0500
In-Reply-To: <20200219163156.GY2935@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

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

Link: https://lore.kernel.org/r/20200213163800.5c51a5f1@gandalf.local.home
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1694a6b57ad8..ada7b2b638fb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -846,6 +846,14 @@ void rcu_nmi_enter(void)
 {
 	rcu_nmi_enter_common(false);
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
