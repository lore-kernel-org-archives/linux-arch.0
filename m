From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 14/20] cpu/hotplug: Split out the state walk into functions
Date: Fri, 26 Feb 2016 18:43:37 -0000
Message-ID: <20160226182341.374946234@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=hotplug--Create-state-walk-functions.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>
List-Id: linux-arch.vger.kernel.org

We need that for running callbacks on the AP and the BP.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/cpu.c |  111 ++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 68 insertions(+), 43 deletions(-)

Index: b/kernel/cpu.c
===================================================================
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -329,10 +329,74 @@ static int bringup_cpu(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * Hotplug state machine related functions
+ */
+static void undo_cpu_down(unsigned int cpu, struct cpuhp_cpu_state *st,
+			  struct cpuhp_step *steps)
+{
+	for (st->state++; st->state < st->target; st->state++) {
+		struct cpuhp_step *step = steps + st->state;
+
+		if (!step->skip_onerr)
+			cpuhp_invoke_callback(cpu, st->state, step->startup);
+	}
+}
+
+static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
+				struct cpuhp_step *steps, enum cpuhp_state target)
+{
+	enum cpuhp_state prev_state = st->state;
+	int ret = 0;
+
+	for (; st->state > target; st->state--) {
+		struct cpuhp_step *step = steps + st->state;
+
+		ret = cpuhp_invoke_callback(cpu, st->state, step->teardown);
+		if (ret) {
+			st->target = prev_state;
+			undo_cpu_down(cpu, st, steps);
+			break;
+		}
+	}
+	return ret;
+}
+
+static void undo_cpu_up(unsigned int cpu, struct cpuhp_cpu_state *st,
+			struct cpuhp_step *steps)
+{
+	for (st->state--; st->state > st->target; st->state--) {
+		struct cpuhp_step *step = steps + st->state;
+
+		if (!step->skip_onerr)
+			cpuhp_invoke_callback(cpu, st->state, step->teardown);
+	}
+}
+
+static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
+			      struct cpuhp_step *steps, enum cpuhp_state target)
+{
+	enum cpuhp_state prev_state = st->state;
+	int ret = 0;
+
+	while (st->state < target) {
+		struct cpuhp_step *step;
+
+		st->state++;
+		step = steps + st->state;
+		ret = cpuhp_invoke_callback(cpu, st->state, step->startup);
+		if (ret) {
+			st->target = prev_state;
+			undo_cpu_up(cpu, st, steps);
+			break;
+		}
+	}
+	return ret;
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 EXPORT_SYMBOL(register_cpu_notifier);
 EXPORT_SYMBOL(__register_cpu_notifier);
-
 void unregister_cpu_notifier(struct notifier_block *nb)
 {
 	cpu_maps_update_begin();
@@ -537,15 +601,6 @@ static int notify_dead(unsigned int cpu)
 #endif
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void undo_cpu_down(unsigned int cpu, struct cpuhp_cpu_state *st)
-{
-	for (st->state++; st->state < st->target; st->state++) {
-		struct cpuhp_step *step = cpuhp_bp_states + st->state;
-
-		if (!step->skip_onerr)
-			cpuhp_invoke_callback(cpu, st->state, step->startup);
-	}
-}
 
 /* Requires cpu_add_remove_lock to be held */
 static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
@@ -567,16 +622,8 @@ static int __ref _cpu_down(unsigned int
 
 	prev_state = st->state;
 	st->target = target;
-	for (; st->state > st->target; st->state--) {
-		struct cpuhp_step *step = cpuhp_bp_states + st->state;
+	ret = cpuhp_down_callbacks(cpu, st, cpuhp_bp_states, target);
 
-		ret = cpuhp_invoke_callback(cpu, st->state, step->teardown);
-		if (ret) {
-			st->target = prev_state;
-			undo_cpu_down(cpu, st);
-			break;
-		}
-	}
 	hasdied = prev_state != st->state && st->state == CPUHP_OFFLINE;
 
 	cpu_hotplug_done();
@@ -645,22 +692,12 @@ static int cpuhp_set_cpu_active(unsigned
 	return 0;
 }
 
-static void undo_cpu_up(unsigned int cpu, struct cpuhp_cpu_state *st)
-{
-	for (st->state--; st->state > st->target; st->state--) {
-		struct cpuhp_step *step = cpuhp_bp_states + st->state;
-
-		if (!step->skip_onerr)
-			cpuhp_invoke_callback(cpu, st->state, step->teardown);
-	}
-}
-
 /* Requires cpu_add_remove_lock to be held */
 static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	struct task_struct *idle;
-	int prev_state, ret = 0;
+	int ret = 0;
 
 	cpu_hotplug_begin();
 
@@ -687,20 +724,8 @@ static int _cpu_up(unsigned int cpu, int
 
 	cpuhp_tasks_frozen = tasks_frozen;
 
-	prev_state = st->state;
 	st->target = target;
-	while (st->state < st->target) {
-		struct cpuhp_step *step;
-
-		st->state++;
-		step = cpuhp_bp_states + st->state;
-		ret = cpuhp_invoke_callback(cpu, st->state, step->startup);
-		if (ret) {
-			st->target = prev_state;
-			undo_cpu_up(cpu, st);
-			break;
-		}
-	}
+	ret = cpuhp_up_callbacks(cpu, st, cpuhp_bp_states, target);
 out:
 	cpu_hotplug_done();
 	return ret;
