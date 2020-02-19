Return-Path: <SRS0=LzcT=4H=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52044 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgBSPOi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:38 -0500
Message-ID: <20200219150744.488895196@infradead.org>
Date: Wed, 19 Feb 2020 15:47:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
References: <20200219144724.800607165@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
Message-ID: <20200219144726.7c-P3x6R6bdApsbu3Wkrw1zHeQc35juUgmzYGWtCdk0@z>

It is an abomination; and in prepration of removing the whole
ist_enter() thing, it needs to go.

Convert #MC over to using task_work_add() instead; it will run the
same code slightly later, on the return to user path of the same
exception.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/traps.h   |    2 -
 arch/x86/kernel/cpu/mce/core.c |   53 +++++++++++++++++++++++------------------
 arch/x86/kernel/traps.c        |   37 ----------------------------
 include/linux/sched.h          |    6 ++++
 4 files changed, 36 insertions(+), 62 deletions(-)

--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -123,8 +123,6 @@ asmlinkage void smp_irq_move_cleanup_int
 
 extern void ist_enter(struct pt_regs *regs);
 extern void ist_exit(struct pt_regs *regs);
-extern void ist_begin_non_atomic(struct pt_regs *regs);
-extern void ist_end_non_atomic(void);
 
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -42,6 +42,7 @@
 #include <linux/export.h>
 #include <linux/jump_label.h>
 #include <linux/set_memory.h>
+#include <linux/task_work.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -1084,23 +1085,6 @@ static void mce_clear_state(unsigned lon
 	}
 }
 
-static int do_memory_failure(struct mce *m)
-{
-	int flags = MF_ACTION_REQUIRED;
-	int ret;
-
-	pr_err("Uncorrected hardware memory error in user-access at %llx", m->addr);
-	if (!(m->mcgstatus & MCG_STATUS_RIPV))
-		flags |= MF_MUST_KILL;
-	ret = memory_failure(m->addr >> PAGE_SHIFT, flags);
-	if (ret)
-		pr_err("Memory error not recovered");
-	else
-		set_mce_nospec(m->addr >> PAGE_SHIFT);
-	return ret;
-}
-
-
 /*
  * Cases where we avoid rendezvous handler timeout:
  * 1) If this CPU is offline.
@@ -1202,6 +1186,29 @@ static void __mc_scan_banks(struct mce *
 	*m = *final;
 }
 
+static void mce_kill_me_now(struct callback_head *ch)
+{
+	force_sig(SIGBUS);
+}
+
+static void mce_kill_me_maybe(struct callback_head *cb)
+{
+	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
+	int flags = MF_ACTION_REQUIRED;
+
+	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
+	if (!(p->mce_status & MCG_STATUS_RIPV))
+		flags |= MF_MUST_KILL;
+
+	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags)) {
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
+		return;
+	}
+
+	pr_err("Memory error not recovered");
+	mce_kill_me_now(cb);
+}
+
 /*
  * The actual machine check handler. This only handles real
  * exceptions when something got corrupted coming in through int 18.
@@ -1344,13 +1351,13 @@ void do_machine_check(struct pt_regs *re
 
 	/* Fault was in user mode and we need to take some action */
 	if ((m.cs & 3) == 3) {
-		ist_begin_non_atomic(regs);
-		local_irq_enable();
+		current->mce_addr = m.addr;
+		current->mce_status = m.mcgstatus;
+		current->mce_kill_me.func = mce_kill_me_maybe;
+		if (kill_it)
+			current->mce_kill_me.func = mce_kill_me_now;
 
-		if (kill_it || do_memory_failure(&m))
-			force_sig(SIGBUS);
-		local_irq_disable();
-		ist_end_non_atomic();
+		task_work_add(current, &current->mce_kill_me, true);
 	} else {
 		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
 			mce_panic("Failed kernel mode recovery", &m, msg);
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -117,43 +117,6 @@ void ist_exit(struct pt_regs *regs)
 		rcu_nmi_exit();
 }
 
-/**
- * ist_begin_non_atomic() - begin a non-atomic section in an IST exception
- * @regs:	regs passed to the IST exception handler
- *
- * IST exception handlers normally cannot schedule.  As a special
- * exception, if the exception interrupted userspace code (i.e.
- * user_mode(regs) would return true) and the exception was not
- * a double fault, it can be safe to schedule.  ist_begin_non_atomic()
- * begins a non-atomic section within an ist_enter()/ist_exit() region.
- * Callers are responsible for enabling interrupts themselves inside
- * the non-atomic section, and callers must call ist_end_non_atomic()
- * before ist_exit().
- */
-void ist_begin_non_atomic(struct pt_regs *regs)
-{
-	BUG_ON(!user_mode(regs));
-
-	/*
-	 * Sanity check: we need to be on the normal thread stack.  This
-	 * will catch asm bugs and any attempt to use ist_preempt_enable
-	 * from double_fault.
-	 */
-	BUG_ON(!on_thread_stack());
-
-	preempt_enable_no_resched();
-}
-
-/**
- * ist_end_non_atomic() - begin a non-atomic section in an IST exception
- *
- * Ends a non-atomic section started with ist_begin_non_atomic().
- */
-void ist_end_non_atomic(void)
-{
-	preempt_disable();
-}
-
 int is_valid_bugaddr(unsigned long addr)
 {
 	unsigned short ud;
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1285,6 +1285,12 @@ struct task_struct {
 	unsigned long			prev_lowest_stack;
 #endif
 
+#ifdef CONFIG_X86_MCE
+	u64				mce_addr;
+	u64				mce_status;
+	struct callback_head		mce_kill_me;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
