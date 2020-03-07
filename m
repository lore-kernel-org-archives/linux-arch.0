From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] x86/kprobes: Prohibit probing on rcu_nmi_exit() and ist_exit()
Date: Sat,  7 Mar 2020 12:02:12 +0900
Message-ID: <158355013189.14191.9105069890402942867.stgit@devnote2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCGDCS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 22:02:18 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, stable@vger.kernel.org

Prohibit probing on rcu_nmi_exit() and ist_exit() which
are called from do_int3()'s kprobe path after kprobe_int3_handler().

The commit c13324a505c7 ("x86/kprobes: Prohibit probing on
functions before kprobe_int3_handler()") tried to fix similar
issue, but it only marks the functions before kprobe_int3_handler()
in do_int3().

If we put a kprobe on rcu_nmi_exit() or ist_exit(), the kprobes
will detect reentrance. However, it only skips the kprobe handler,
exits from do_int3() and hits ist_exit() and rcu_nmi_exit() again.
Thus, it causes another int3 exception and finally we will get
the kernel panic with "Unrecoverable kprobe detected." error message.

This is reproducible by the following commands.

/ # echo 0 > /proc/sys/debug/kprobes-optimization
/ # echo p vfs_read > /sys/kernel/debug/tracing/kprobe_events
/ # echo p rcu_nmi_exit >> /sys/kernel/debug/tracing/kprobe_events
/ # echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable

Fixes: c13324a505c7 ("x86/kprobes: Prohibit probing on functions before kprobe_int3_handler()")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/traps.c |    1 +
 kernel/rcu/tree.c       |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6ef00eb6fbb9..c63fb7697794 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -115,6 +115,7 @@ void ist_exit(struct pt_regs *regs)
 	if (!user_mode(regs))
 		rcu_nmi_exit();
 }
+NOKPROBE_SYMBOL(ist_exit);
 
 /**
  * ist_begin_non_atomic() - begin a non-atomic section in an IST exception
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d91c9156fab2..c49ea0e919f9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -670,6 +670,7 @@ void rcu_nmi_exit(void)
 {
 	rcu_nmi_exit_common(false);
 }
+NOKPROBE_SYMBOL(rcu_nmi_exit);
 
 /**
  * rcu_irq_exit - inform RCU that current CPU is exiting irq towards idle
