From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 06/20] cpu/hotplug: Convert to a state machine for the control
 processor
Date: Fri, 26 Feb 2016 18:43:28 -0000
Message-ID: <20160226182340.671816690@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=cpu-hotplug-Convert-to-a-state-machine-for-the-contr.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>
List-Id: linux-arch.vger.kernel.org

Move the split out steps into a callback array and let the cpu_up/down
code iterate through the array functions. For now most of the
callbacks are asymmetric to resemble the current hotplug maze.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cpu.h        |    9 -
 include/linux/cpuhotplug.h |   13 ++
 init/main.c                |   15 ---
 kernel/cpu.c               |  204 +++++++++++++++++++++++++++++++++++++++------
 4 files changed, 195 insertions(+), 46 deletions(-)
 create mode 100644 include/linux/cpuhotplug.h

Index: b/include/linux/cpu.h
===================================================================
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -16,6 +16,7 @@
 #include <linux/node.h>
 #include <linux/compiler.h>
 #include <linux/cpumask.h>
+#include <linux/cpuhotplug.h>
 
 struct device;
 struct device_node;
@@ -27,6 +28,9 @@ struct cpu {
 	struct device dev;
 };
 
+extern void boot_cpu_init(void);
+extern void boot_cpu_state_init(void);
+
 extern int register_cpu(struct cpu *cpu, int num);
 extern struct device *get_cpu_device(unsigned cpu);
 extern bool cpu_is_hotpluggable(unsigned cpu);
@@ -267,11 +271,6 @@ static inline int disable_nonboot_cpus(v
 static inline void enable_nonboot_cpus(void) {}
 #endif /* !CONFIG_PM_SLEEP_SMP */
 
-enum cpuhp_state {
-	CPUHP_OFFLINE,
-	CPUHP_ONLINE,
-};
-
 void cpu_startup_entry(enum cpuhp_state state);
 
 void cpu_idle_poll_ctrl(bool enable);
Index: b/include/linux/cpuhotplug.h
===================================================================
--- /dev/null
+++ b/include/linux/cpuhotplug.h
@@ -0,0 +1,13 @@
+#ifndef __CPUHOTPLUG_H
+#define __CPUHOTPLUG_H
+
+enum cpuhp_state {
+	CPUHP_OFFLINE,
+	CPUHP_CREATE_THREADS,
+	CPUHP_NOTIFY_PREPARE,
+	CPUHP_BRINGUP_CPU,
+	CPUHP_NOTIFY_ONLINE,
+	CPUHP_ONLINE,
+};
+
+#endif
Index: b/init/main.c
===================================================================
--- a/init/main.c
+++ b/init/main.c
@@ -452,20 +452,6 @@ void __init parse_early_param(void)
 	done = 1;
 }
 
-/*
- *	Activate the first processor.
- */
-
-static void __init boot_cpu_init(void)
-{
-	int cpu = smp_processor_id();
-	/* Mark the boot cpu "present", "online" etc for SMP and UP case */
-	set_cpu_online(cpu, true);
-	set_cpu_active(cpu, true);
-	set_cpu_present(cpu, true);
-	set_cpu_possible(cpu, true);
-}
-
 void __init __weak smp_setup_processor_id(void)
 {
 }
@@ -530,6 +516,7 @@ asmlinkage __visible void __init start_k
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
 	setup_per_cpu_areas();
+	boot_cpu_state_init();
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
 
 	build_all_zonelists(NULL, NULL);
Index: b/kernel/cpu.c
===================================================================
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -22,10 +22,64 @@
 #include <linux/lockdep.h>
 #include <linux/tick.h>
 #include <linux/irq.h>
+
 #include <trace/events/power.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/cpuhp.h>
 
 #include "smpboot.h"
 
+/**
+ * cpuhp_cpu_state - Per cpu hotplug state storage
+ * @state:	The current cpu state
+ * @target:	The target state
+ */
+struct cpuhp_cpu_state {
+	enum cpuhp_state	state;
+	enum cpuhp_state	target;
+};
+
+static DEFINE_PER_CPU(struct cpuhp_cpu_state, cpuhp_state);
+
+/**
+ * cpuhp_step - Hotplug state machine step
+ * @name:	Name of the step
+ * @startup:	Startup function of the step
+ * @teardown:	Teardown function of the step
+ * @skip_onerr:	Do not invoke the functions on error rollback
+ *		Will go away once the notifiers	are gone
+ */
+struct cpuhp_step {
+	const char	*name;
+	int		(*startup)(unsigned int cpu);
+	int		(*teardown)(unsigned int cpu);
+	bool		skip_onerr;
+};
+
+static struct cpuhp_step cpuhp_bp_states[];
+
+/**
+ * cpuhp_invoke_callback _ Invoke the callbacks for a given state
+ * @cpu:	The cpu for which the callback should be invoked
+ * @step:	The step in the state machine
+ * @cb:		The callback function to invoke
+ *
+ * Called from cpu hotplug and from the state register machinery
+ */
+static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state step,
+				 int (*cb)(unsigned int))
+{
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
+	int ret = 0;
+
+	if (cb) {
+		trace_cpuhp_enter(cpu, st->target, step, cb);
+		ret = cb(cpu);
+		trace_cpuhp_exit(cpu, st->state, step, ret);
+	}
+	return ret;
+}
+
 #ifdef CONFIG_SMP
 /* Serializes the updates to cpu_online_mask, cpu_present_mask */
 static DEFINE_MUTEX(cpu_add_remove_lock);
@@ -454,10 +508,29 @@ static int notify_dead(unsigned int cpu)
 	return 0;
 }
 
+#else
+#define notify_down_prepare	NULL
+#define takedown_cpu		NULL
+#define notify_dead		NULL
+#endif
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void undo_cpu_down(unsigned int cpu, struct cpuhp_cpu_state *st)
+{
+	for (st->state++; st->state < st->target; st->state++) {
+		struct cpuhp_step *step = cpuhp_bp_states + st->state;
+
+		if (!step->skip_onerr)
+			cpuhp_invoke_callback(cpu, st->state, step->startup);
+	}
+}
+
 /* Requires cpu_add_remove_lock to be held */
 static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
 {
-	int err;
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
+	int prev_state, ret = 0;
+	bool hasdied = false;
 
 	if (num_online_cpus() == 1)
 		return -EBUSY;
@@ -469,20 +542,25 @@ static int __ref _cpu_down(unsigned int
 
 	cpuhp_tasks_frozen = tasks_frozen;
 
-	err = notify_down_prepare(cpu);
-	if (err)
-		goto out_release;
-	err = takedown_cpu(cpu);
-	if (err)
-		goto out_release;
-
-	notify_dead(cpu);
+	prev_state = st->state;
+	st->target = CPUHP_OFFLINE;
+	for (; st->state > st->target; st->state--) {
+		struct cpuhp_step *step = cpuhp_bp_states + st->state;
+
+		ret = cpuhp_invoke_callback(cpu, st->state, step->teardown);
+		if (ret) {
+			st->target = prev_state;
+			undo_cpu_down(cpu, st);
+			break;
+		}
+	}
+	hasdied = prev_state != st->state && st->state == CPUHP_OFFLINE;
 
-out_release:
 	cpu_hotplug_done();
-	if (!err)
+	/* This post dead nonsense must die */
+	if (!ret && hasdied)
 		cpu_notify_nofail(CPU_POST_DEAD, cpu);
-	return err;
+	return ret;
 }
 
 int cpu_down(unsigned int cpu)
@@ -537,11 +615,22 @@ void smpboot_thread_init(void)
 	register_cpu_notifier(&smpboot_thread_notifier);
 }
 
+static void undo_cpu_up(unsigned int cpu, struct cpuhp_cpu_state *st)
+{
+	for (st->state--; st->state > st->target; st->state--) {
+		struct cpuhp_step *step = cpuhp_bp_states + st->state;
+
+		if (!step->skip_onerr)
+			cpuhp_invoke_callback(cpu, st->state, step->teardown);
+	}
+}
+
 /* Requires cpu_add_remove_lock to be held */
 static int _cpu_up(unsigned int cpu, int tasks_frozen)
 {
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	struct task_struct *idle;
-	int ret;
+	int prev_state, ret = 0;
 
 	cpu_hotplug_begin();
 
@@ -550,6 +639,7 @@ static int _cpu_up(unsigned int cpu, int
 		goto out;
 	}
 
+	/* Let it fail before we try to bring the cpu up */
 	idle = idle_thread_get(cpu);
 	if (IS_ERR(idle)) {
 		ret = PTR_ERR(idle);
@@ -558,22 +648,22 @@ static int _cpu_up(unsigned int cpu, int
 
 	cpuhp_tasks_frozen = tasks_frozen;
 
-	ret = smpboot_create_threads(cpu);
-	if (ret)
-		goto out;
-
-	ret = notify_prepare(cpu);
-	if (ret)
-		goto out;
-
-	ret = bringup_cpu(cpu);
-	if (ret)
-		goto out;
-
-	notify_online(cpu);
+	prev_state = st->state;
+	st->target = CPUHP_ONLINE;
+	while (st->state < st->target) {
+		struct cpuhp_step *step;
+
+		st->state++;
+		step = cpuhp_bp_states + st->state;
+		ret = cpuhp_invoke_callback(cpu, st->state, step->startup);
+		if (ret) {
+			st->target = prev_state;
+			undo_cpu_up(cpu, st);
+			break;
+		}
+	}
 out:
 	cpu_hotplug_done();
-
 	return ret;
 }
 
@@ -767,6 +857,44 @@ void notify_cpu_starting(unsigned int cp
 
 #endif /* CONFIG_SMP */
 
+/* Boot processor state steps */
+static struct cpuhp_step cpuhp_bp_states[] = {
+	[CPUHP_OFFLINE] = {
+		.name			= "offline",
+		.startup		= NULL,
+		.teardown		= NULL,
+	},
+#ifdef CONFIG_SMP
+	[CPUHP_CREATE_THREADS]= {
+		.name			= "threads:create",
+		.startup		= smpboot_create_threads,
+		.teardown		= NULL,
+	},
+	[CPUHP_NOTIFY_PREPARE] = {
+		.name			= "notify:prepare",
+		.startup		= notify_prepare,
+		.teardown		= notify_dead,
+		.skip_onerr		= true,
+	},
+	[CPUHP_BRINGUP_CPU] = {
+		.name			= "cpu:bringup",
+		.startup		= bringup_cpu,
+		.teardown		= takedown_cpu,
+		.skip_onerr		= true,
+	},
+	[CPUHP_NOTIFY_ONLINE] = {
+		.name			= "notify:online",
+		.startup		= notify_online,
+		.teardown		= notify_down_prepare,
+	},
+#endif
+	[CPUHP_ONLINE] = {
+		.name			= "online",
+		.startup		= NULL,
+		.teardown		= NULL,
+	},
+};
+
 /*
  * cpu_bit_bitmap[] is a special, "compressed" data structure that
  * represents all NR_CPUS bits binary values of 1<<nr.
@@ -826,3 +954,25 @@ void init_cpu_online(const struct cpumas
 {
 	cpumask_copy(&__cpu_online_mask, src);
 }
+
+/*
+ * Activate the first processor.
+ */
+void __init boot_cpu_init(void)
+{
+	int cpu = smp_processor_id();
+
+	/* Mark the boot cpu "present", "online" etc for SMP and UP case */
+	set_cpu_online(cpu, true);
+	set_cpu_active(cpu, true);
+	set_cpu_present(cpu, true);
+	set_cpu_possible(cpu, true);
+}
+
+/*
+ * Must be called _AFTER_ setting up the per_cpu areas
+ */
+void __init boot_cpu_state_init(void)
+{
+	per_cpu_ptr(&cpuhp_state, smp_processor_id())->state = CPUHP_ONLINE;
+}
