From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 08/20] cpu/hotplug: Hand in target state to _cpu_up/down
Date: Fri, 26 Feb 2016 18:43:30 -0000
Message-ID: <20160226182340.862113133@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=hotplug--Hand-in-target-state-to-_cpu_up-down.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>
List-Id: linux-arch.vger.kernel.org

We want to be able to bringup/teardown the cpu to a particular state. Add a
target argument to _cpu_up/down.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/cpu.c |   31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

Index: b/kernel/cpu.c
===================================================================
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -547,7 +547,8 @@ static void undo_cpu_down(unsigned int c
 }
 
 /* Requires cpu_add_remove_lock to be held */
-static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
+static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
+			   enum cpuhp_state target)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	int prev_state, ret = 0;
@@ -564,7 +565,7 @@ static int __ref _cpu_down(unsigned int
 	cpuhp_tasks_frozen = tasks_frozen;
 
 	prev_state = st->state;
-	st->target = CPUHP_OFFLINE;
+	st->target = target;
 	for (; st->state > st->target; st->state--) {
 		struct cpuhp_step *step = cpuhp_bp_states + st->state;
 
@@ -584,7 +585,7 @@ static int __ref _cpu_down(unsigned int
 	return ret;
 }
 
-int cpu_down(unsigned int cpu)
+static int do_cpu_down(unsigned int cpu, enum cpuhp_state target)
 {
 	int err;
 
@@ -595,12 +596,16 @@ int cpu_down(unsigned int cpu)
 		goto out;
 	}
 
-	err = _cpu_down(cpu, 0);
+	err = _cpu_down(cpu, 0, target);
 
 out:
 	cpu_maps_update_done();
 	return err;
 }
+int cpu_down(unsigned int cpu)
+{
+	return do_cpu_down(cpu, CPUHP_OFFLINE);
+}
 EXPORT_SYMBOL(cpu_down);
 #endif /*CONFIG_HOTPLUG_CPU*/
 
@@ -669,7 +674,7 @@ static void undo_cpu_up(unsigned int cpu
 }
 
 /* Requires cpu_add_remove_lock to be held */
-static int _cpu_up(unsigned int cpu, int tasks_frozen)
+static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	struct task_struct *idle;
@@ -692,7 +697,7 @@ static int _cpu_up(unsigned int cpu, int
 	cpuhp_tasks_frozen = tasks_frozen;
 
 	prev_state = st->state;
-	st->target = CPUHP_ONLINE;
+	st->target = target;
 	while (st->state < st->target) {
 		struct cpuhp_step *step;
 
@@ -710,7 +715,7 @@ static int _cpu_up(unsigned int cpu, int
 	return ret;
 }
 
-int cpu_up(unsigned int cpu)
+static int do_cpu_up(unsigned int cpu, enum cpuhp_state target)
 {
 	int err = 0;
 
@@ -734,12 +739,16 @@ int cpu_up(unsigned int cpu)
 		goto out;
 	}
 
-	err = _cpu_up(cpu, 0);
-
+	err = _cpu_up(cpu, 0, target);
 out:
 	cpu_maps_update_done();
 	return err;
 }
+
+int cpu_up(unsigned int cpu)
+{
+	return do_cpu_up(cpu, CPUHP_ONLINE);
+}
 EXPORT_SYMBOL_GPL(cpu_up);
 
 #ifdef CONFIG_PM_SLEEP_SMP
@@ -762,7 +771,7 @@ int disable_nonboot_cpus(void)
 		if (cpu == first_cpu)
 			continue;
 		trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
-		error = _cpu_down(cpu, 1);
+		error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
 		trace_suspend_resume(TPS("CPU_OFF"), cpu, false);
 		if (!error)
 			cpumask_set_cpu(cpu, frozen_cpus);
@@ -812,7 +821,7 @@ void enable_nonboot_cpus(void)
 
 	for_each_cpu(cpu, frozen_cpus) {
 		trace_suspend_resume(TPS("CPU_ON"), cpu, true);
-		error = _cpu_up(cpu, 1);
+		error = _cpu_up(cpu, 1, CPUHP_ONLINE);
 		trace_suspend_resume(TPS("CPU_ON"), cpu, false);
 		if (!error) {
 			pr_info("CPU%d is up\n", cpu);
