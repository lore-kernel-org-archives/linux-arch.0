From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 07/20] cpu/hotplug: Convert the hotplugged cpu work to a state
 machine
Date: Fri, 26 Feb 2016 18:43:29 -0000
Message-ID: <20160226182340.770651526@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=cpu-hotplug-Convert-the-hotplugged-processor-work-to.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>
List-Id: linux-arch.vger.kernel.org

Move the functions which need to run on the hotplugged processor into
a state machine array and let the code iterate through these functions.

In a later state, this will grow synchronization points between the
control processor and the hotplugged processor, so we can move the
various architecture implementations of the synchronizations to the
core.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cpuhotplug.h |    4 ++
 kernel/cpu.c               |   81 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 70 insertions(+), 15 deletions(-)

Index: b/include/linux/cpuhotplug.h
===================================================================
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -6,6 +6,10 @@ enum cpuhp_state {
 	CPUHP_CREATE_THREADS,
 	CPUHP_NOTIFY_PREPARE,
 	CPUHP_BRINGUP_CPU,
+	CPUHP_AP_OFFLINE,
+	CPUHP_AP_NOTIFY_STARTING,
+	CPUHP_AP_ONLINE,
+	CPUHP_TEARDOWN_CPU,
 	CPUHP_NOTIFY_ONLINE,
 	CPUHP_ONLINE,
 };
Index: b/kernel/cpu.c
===================================================================
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -57,6 +57,7 @@ struct cpuhp_step {
 };
 
 static struct cpuhp_step cpuhp_bp_states[];
+static struct cpuhp_step cpuhp_ap_states[];
 
 /**
  * cpuhp_invoke_callback _ Invoke the callbacks for a given state
@@ -304,6 +305,12 @@ static int notify_online(unsigned int cp
 	return 0;
 }
 
+static int notify_starting(unsigned int cpu)
+{
+	cpu_notify(CPU_STARTING, cpu);
+	return 0;
+}
+
 static int bringup_cpu(unsigned int cpu)
 {
 	struct task_struct *idle = idle_thread_get(cpu);
@@ -421,9 +428,17 @@ static int notify_down_prepare(unsigned
 	return err;
 }
 
+static int notify_dying(unsigned int cpu)
+{
+	cpu_notify(CPU_DYING, cpu);
+	return 0;
+}
+
 /* Take this CPU down. */
 static int take_cpu_down(void *_param)
 {
+	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
+	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int err, cpu = smp_processor_id();
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
@@ -431,7 +446,12 @@ static int take_cpu_down(void *_param)
 	if (err < 0)
 		return err;
 
-	cpu_notify(CPU_DYING, cpu);
+	/* Invoke the former CPU_DYING callbacks */
+	for (; st->state > target; st->state--) {
+		struct cpuhp_step *step = cpuhp_ap_states + st->state;
+
+		cpuhp_invoke_callback(cpu, st->state, step->teardown);
+	}
 	/* Give up timekeeping duties */
 	tick_handover_do_timer();
 	/* Park the stopper thread */
@@ -512,6 +532,7 @@ static int notify_dead(unsigned int cpu)
 #define notify_down_prepare	NULL
 #define takedown_cpu		NULL
 #define notify_dead		NULL
+#define notify_dying		NULL
 #endif
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -615,6 +636,28 @@ void smpboot_thread_init(void)
 	register_cpu_notifier(&smpboot_thread_notifier);
 }
 
+/**
+ * notify_cpu_starting(cpu) - call the CPU_STARTING notifiers
+ * @cpu: cpu that just started
+ *
+ * This function calls the cpu_chain notifiers with CPU_STARTING.
+ * It must be called by the arch code on the new cpu, before the new cpu
+ * enables interrupts and before the "boot" cpu returns from __cpu_up().
+ */
+void notify_cpu_starting(unsigned int cpu)
+{
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
+	enum cpuhp_state target = min((int)st->target, CPUHP_AP_ONLINE);
+
+	while (st->state < target) {
+		struct cpuhp_step *step;
+
+		st->state++;
+		step = cpuhp_ap_states + st->state;
+		cpuhp_invoke_callback(cpu, st->state, step->startup);
+	}
+}
+
 static void undo_cpu_up(unsigned int cpu, struct cpuhp_cpu_state *st)
 {
 	for (st->state--; st->state > st->target; st->state--) {
@@ -842,19 +885,6 @@ core_initcall(cpu_hotplug_pm_sync_init);
 
 #endif /* CONFIG_PM_SLEEP_SMP */
 
-/**
- * notify_cpu_starting(cpu) - call the CPU_STARTING notifiers
- * @cpu: cpu that just started
- *
- * This function calls the cpu_chain notifiers with CPU_STARTING.
- * It must be called by the arch code on the new cpu, before the new cpu
- * enables interrupts and before the "boot" cpu returns from __cpu_up().
- */
-void notify_cpu_starting(unsigned int cpu)
-{
-	cpu_notify(CPU_STARTING, cpu);
-}
-
 #endif /* CONFIG_SMP */
 
 /* Boot processor state steps */
@@ -879,8 +909,12 @@ static struct cpuhp_step cpuhp_bp_states
 	[CPUHP_BRINGUP_CPU] = {
 		.name			= "cpu:bringup",
 		.startup		= bringup_cpu,
+		.teardown		= NULL,
+	},
+	[CPUHP_TEARDOWN_CPU] = {
+		.name			= "cpu:teardown",
+		.startup		= NULL,
 		.teardown		= takedown_cpu,
-		.skip_onerr		= true,
 	},
 	[CPUHP_NOTIFY_ONLINE] = {
 		.name			= "notify:online",
@@ -889,6 +923,23 @@ static struct cpuhp_step cpuhp_bp_states
 	},
 #endif
 	[CPUHP_ONLINE] = {
+		.name			= "online",
+		.startup		= NULL,
+		.teardown		= NULL,
+	},
+};
+
+/* Application processor state steps */
+static struct cpuhp_step cpuhp_ap_states[] = {
+#ifdef CONFIG_SMP
+	[CPUHP_AP_NOTIFY_STARTING] = {
+		.name			= "notify:starting",
+		.startup		= notify_starting,
+		.teardown		= notify_dying,
+		.skip_onerr		= true,
+	},
+#endif
+	[CPUHP_ONLINE] = {
 		.name			= "online",
 		.startup		= NULL,
 		.teardown		= NULL,
