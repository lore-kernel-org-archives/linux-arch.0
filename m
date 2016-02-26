From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 02/20] cpu/hotplug: Restructure FROZEN state handling
Date: Fri, 26 Feb 2016 18:43:23 -0000
Message-ID: <20160226182340.334912357@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33345 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422790AbcBZSow (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Feb 2016 13:44:52 -0500
Content-Disposition: inline;
 filename=cpu-Restructure-FROZEN-state-handling.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

There are only a few callbacks which really care about FROZEN
vs. !FROZEN. No need to have extra states for this.

Publish the frozen state in an extra variable which is updated under
the hotplug lock and let the users interested deal with it w/o
imposing that extra state checks on everyone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cpu.h |    2 +
 kernel/cpu.c        |   69 +++++++++++++++++++++-------------------------------
 2 files changed, 31 insertions(+), 40 deletions(-)

--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -118,6 +118,7 @@ enum {
 
 
 #ifdef CONFIG_SMP
+extern bool cpuhp_tasks_frozen;
 /* Need to know about CPUs going up/down? */
 #if defined(CONFIG_HOTPLUG_CPU) || !defined(MODULE)
 #define cpu_notifier(fn, pri) {					\
@@ -177,6 +178,7 @@ extern void cpu_maps_update_done(void);
 #define cpu_notifier_register_done	cpu_maps_update_done
 
 #else	/* CONFIG_SMP */
+#define cpuhp_tasks_frozen	0
 
 #define cpu_notifier(fn, pri)	do { (void)(fn); } while (0)
 #define __cpu_notifier(fn, pri)	do { (void)(fn); } while (0)
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -29,6 +29,8 @@
 #ifdef CONFIG_SMP
 /* Serializes the updates to cpu_online_mask, cpu_present_mask */
 static DEFINE_MUTEX(cpu_add_remove_lock);
+bool cpuhp_tasks_frozen;
+EXPORT_SYMBOL_GPL(cpuhp_tasks_frozen);
 
 /*
  * The following two APIs (cpu_maps_update_begin/done) must be used when
@@ -207,27 +209,30 @@ int __register_cpu_notifier(struct notif
 	return raw_notifier_chain_register(&cpu_chain, nb);
 }
 
-static int __cpu_notify(unsigned long val, void *v, int nr_to_call,
+static int __cpu_notify(unsigned long val, unsigned int cpu, int nr_to_call,
 			int *nr_calls)
 {
+	unsigned long mod = cpuhp_tasks_frozen ? CPU_TASKS_FROZEN : 0;
+	void *hcpu = (void *)(long)cpu;
+
 	int ret;
 
-	ret = __raw_notifier_call_chain(&cpu_chain, val, v, nr_to_call,
+	ret = __raw_notifier_call_chain(&cpu_chain, val | mod, hcpu, nr_to_call,
 					nr_calls);
 
 	return notifier_to_errno(ret);
 }
 
-static int cpu_notify(unsigned long val, void *v)
+static int cpu_notify(unsigned long val, unsigned int cpu)
 {
-	return __cpu_notify(val, v, -1, NULL);
+	return __cpu_notify(val, cpu, -1, NULL);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-static void cpu_notify_nofail(unsigned long val, void *v)
+static void cpu_notify_nofail(unsigned long val, unsigned int cpu)
 {
-	BUG_ON(cpu_notify(val, v));
+	BUG_ON(cpu_notify(val, cpu));
 }
 EXPORT_SYMBOL(register_cpu_notifier);
 EXPORT_SYMBOL(__register_cpu_notifier);
@@ -311,27 +316,21 @@ static inline void check_for_tasks(int d
 	read_unlock(&tasklist_lock);
 }
 
-struct take_cpu_down_param {
-	unsigned long mod;
-	void *hcpu;
-};
-
 /* Take this CPU down. */
 static int take_cpu_down(void *_param)
 {
-	struct take_cpu_down_param *param = _param;
-	int err;
+	int err, cpu = smp_processor_id();
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err = __cpu_disable();
 	if (err < 0)
 		return err;
 
-	cpu_notify(CPU_DYING | param->mod, param->hcpu);
+	cpu_notify(CPU_DYING, cpu);
 	/* Give up timekeeping duties */
 	tick_handover_do_timer();
 	/* Park the stopper thread */
-	stop_machine_park((long)param->hcpu);
+	stop_machine_park(cpu);
 	return 0;
 }
 
@@ -339,12 +338,6 @@ static int take_cpu_down(void *_param)
 static int _cpu_down(unsigned int cpu, int tasks_frozen)
 {
 	int err, nr_calls = 0;
-	void *hcpu = (void *)(long)cpu;
-	unsigned long mod = tasks_frozen ? CPU_TASKS_FROZEN : 0;
-	struct take_cpu_down_param tcd_param = {
-		.mod = mod,
-		.hcpu = hcpu,
-	};
 
 	if (num_online_cpus() == 1)
 		return -EBUSY;
@@ -354,10 +347,12 @@ static int _cpu_down(unsigned int cpu, i
 
 	cpu_hotplug_begin();
 
-	err = __cpu_notify(CPU_DOWN_PREPARE | mod, hcpu, -1, &nr_calls);
+	cpuhp_tasks_frozen = tasks_frozen;
+
+	err = __cpu_notify(CPU_DOWN_PREPARE, cpu, -1, &nr_calls);
 	if (err) {
 		nr_calls--;
-		__cpu_notify(CPU_DOWN_FAILED | mod, hcpu, nr_calls, NULL);
+		__cpu_notify(CPU_DOWN_FAILED, cpu, nr_calls, NULL);
 		pr_warn("%s: attempt to take down CPU %u failed\n",
 			__func__, cpu);
 		goto out_release;
@@ -389,10 +384,10 @@ static int _cpu_down(unsigned int cpu, i
 	/*
 	 * So now all preempt/rcu users must observe !cpu_active().
 	 */
-	err = stop_machine(take_cpu_down, &tcd_param, cpumask_of(cpu));
+	err = stop_machine(take_cpu_down, NULL, cpumask_of(cpu));
 	if (err) {
 		/* CPU didn't die: tell everyone.  Can't complain. */
-		cpu_notify_nofail(CPU_DOWN_FAILED | mod, hcpu);
+		cpu_notify_nofail(CPU_DOWN_FAILED, cpu);
 		irq_unlock_sparse();
 		goto out_release;
 	}
@@ -419,14 +414,14 @@ static int _cpu_down(unsigned int cpu, i
 
 	/* CPU is completely dead: tell everyone.  Too late to complain. */
 	tick_cleanup_dead_cpu(cpu);
-	cpu_notify_nofail(CPU_DEAD | mod, hcpu);
+	cpu_notify_nofail(CPU_DEAD, cpu);
 
 	check_for_tasks(cpu);
 
 out_release:
 	cpu_hotplug_done();
 	if (!err)
-		cpu_notify_nofail(CPU_POST_DEAD | mod, hcpu);
+		cpu_notify_nofail(CPU_POST_DEAD, cpu);
 	return err;
 }
 
@@ -485,10 +480,8 @@ void smpboot_thread_init(void)
 /* Requires cpu_add_remove_lock to be held */
 static int _cpu_up(unsigned int cpu, int tasks_frozen)
 {
-	int ret, nr_calls = 0;
-	void *hcpu = (void *)(long)cpu;
-	unsigned long mod = tasks_frozen ? CPU_TASKS_FROZEN : 0;
 	struct task_struct *idle;
+	int ret, nr_calls = 0;
 
 	cpu_hotplug_begin();
 
@@ -507,7 +500,9 @@ static int _cpu_up(unsigned int cpu, int
 	if (ret)
 		goto out;
 
-	ret = __cpu_notify(CPU_UP_PREPARE | mod, hcpu, -1, &nr_calls);
+	cpuhp_tasks_frozen = tasks_frozen;
+
+	ret = __cpu_notify(CPU_UP_PREPARE, cpu, -1, &nr_calls);
 	if (ret) {
 		nr_calls--;
 		pr_warn("%s: attempt to bring up CPU %u failed\n",
@@ -523,11 +518,11 @@ static int _cpu_up(unsigned int cpu, int
 	BUG_ON(!cpu_online(cpu));
 
 	/* Now call notifier in preparation. */
-	cpu_notify(CPU_ONLINE | mod, hcpu);
+	cpu_notify(CPU_ONLINE, cpu);
 
 out_notify:
 	if (ret != 0)
-		__cpu_notify(CPU_UP_CANCELED | mod, hcpu, nr_calls, NULL);
+		__cpu_notify(CPU_UP_CANCELED, cpu, nr_calls, NULL);
 out:
 	cpu_hotplug_done();
 
@@ -719,13 +714,7 @@ core_initcall(cpu_hotplug_pm_sync_init);
  */
 void notify_cpu_starting(unsigned int cpu)
 {
-	unsigned long val = CPU_STARTING;
-
-#ifdef CONFIG_PM_SLEEP_SMP
-	if (frozen_cpus != NULL && cpumask_test_cpu(cpu, frozen_cpus))
-		val = CPU_STARTING_FROZEN;
-#endif /* CONFIG_PM_SLEEP_SMP */
-	cpu_notify(val, (void *)(long)cpu);
+	cpu_notify(CPU_STARTING, cpu);
 }
 
 #endif /* CONFIG_SMP */
