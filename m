From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 15/20] cpu/hotplug: Create hotplug threads
Date: Fri, 26 Feb 2016 18:43:38 -0000
Message-ID: <20160226182341.454541272@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=hotplug--Create-hotplug-threads.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>
List-Id: linux-arch.vger.kernel.org

In order to let the hotplugged cpu take care of the setup/teardown, we need a
seperate hotplug thread.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/cpu.c     |  145 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/smp.c     |    1 
 kernel/smpboot.h |    2 
 3 files changed, 147 insertions(+), 1 deletion(-)

Index: b/kernel/cpu.c
===================================================================
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -22,6 +22,7 @@
 #include <linux/lockdep.h>
 #include <linux/tick.h>
 #include <linux/irq.h>
+#include <linux/smpboot.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -33,10 +34,24 @@
  * cpuhp_cpu_state - Per cpu hotplug state storage
  * @state:	The current cpu state
  * @target:	The target state
+ * @thread:	Pointer to the hotplug thread
+ * @should_run:	Thread should execute
+ * @cb_stat:	The state for a single callback (install/uninstall)
+ * @cb:		Single callback function (install/uninstall)
+ * @result:	Result of the operation
+ * @done:	Signal completion to the issuer of the task
  */
 struct cpuhp_cpu_state {
 	enum cpuhp_state	state;
 	enum cpuhp_state	target;
+#ifdef CONFIG_SMP
+	struct task_struct	*thread;
+	bool			should_run;
+	enum cpuhp_state	cb_state;
+	int			(*cb)(unsigned int cpu);
+	int			result;
+	struct completion	done;
+#endif
 };
 
 static DEFINE_PER_CPU(struct cpuhp_cpu_state, cpuhp_state);
@@ -394,6 +409,134 @@ static int cpuhp_up_callbacks(unsigned i
 	return ret;
 }
 
+/*
+ * The cpu hotplug threads manage the bringup and teardown of the cpus
+ */
+static void cpuhp_create(unsigned int cpu)
+{
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
+
+	init_completion(&st->done);
+}
+
+static int cpuhp_should_run(unsigned int cpu)
+{
+	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
+
+	return st->should_run;
+}
+
+/* Execute the teardown callbacks. Used to be CPU_DOWN_PREPARE */
+static int cpuhp_ap_offline(unsigned int cpu, struct cpuhp_cpu_state *st)
+{
+	enum cpuhp_state target = max((int)st->target, CPUHP_AP_ONLINE);
+
+	return cpuhp_down_callbacks(cpu, st, cpuhp_ap_states, target);
+}
+
+/* Execute the online startup callbacks. Used to be CPU_ONLINE */
+static int cpuhp_ap_online(unsigned int cpu, struct cpuhp_cpu_state *st)
+{
+	return cpuhp_up_callbacks(cpu, st, cpuhp_ap_states, st->target);
+}
+
+/*
+ * Execute teardown/startup callbacks on the plugged cpu. Also used to invoke
+ * callbacks when a state gets [un]installed at runtime.
+ */
+static void cpuhp_thread_fun(unsigned int cpu)
+{
+	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
+	int ret = 0;
+
+	/*
+	 * Paired with the mb() in cpuhp_kick_ap_work and
+	 * cpuhp_invoke_ap_callback, so the work set is consistent visible.
+	 */
+	smp_mb();
+	if (!st->should_run)
+		return;
+
+	st->should_run = false;
+
+	/* Single callback invocation for [un]install ? */
+	if (st->cb) {
+		if (st->cb_state < CPUHP_AP_ONLINE) {
+			local_irq_disable();
+			ret = cpuhp_invoke_callback(cpu, st->cb_state, st->cb);
+			local_irq_enable();
+		} else {
+			ret = cpuhp_invoke_callback(cpu, st->cb_state, st->cb);
+		}
+	} else {
+		/* Regular hotplug work */
+		if (st->state < st->target)
+			ret = cpuhp_ap_online(cpu, st);
+		else if (st->state > st->target)
+			ret = cpuhp_ap_offline(cpu, st);
+	}
+	st->result = ret;
+	complete(&st->done);
+}
+
+/* Invoke a single callback on a remote cpu */
+static int cpuhp_invoke_ap_callback(int cpu, enum cpuhp_state state,
+				    int (*cb)(unsigned int))
+{
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
+
+	if (!cpu_online(cpu))
+		return 0;
+
+	st->cb_state = state;
+	st->cb = cb;
+	/*
+	 * Make sure the above stores are visible before should_run becomes
+	 * true. Paired with the mb() above in cpuhp_thread_fun()
+	 */
+	smp_mb();
+	st->should_run = true;
+	wake_up_process(st->thread);
+	wait_for_completion(&st->done);
+	return st->result;
+}
+
+/* Regular hotplug invocation of the AP hotplug thread */
+static int cpuhp_kick_ap_work(unsigned int cpu)
+{
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
+	enum cpuhp_state state = st->state;
+
+	trace_cpuhp_enter(cpu, st->target, state, cpuhp_kick_ap_work);
+	st->result = 0;
+	st->cb = NULL;
+	/*
+	 * Make sure the above stores are visible before should_run becomes
+	 * true. Paired with the mb() above in cpuhp_thread_fun()
+	 */
+	smp_mb();
+	st->should_run = true;
+	wake_up_process(st->thread);
+	wait_for_completion(&st->done);
+	trace_cpuhp_exit(cpu, st->state, state, st->result);
+	return st->result;
+}
+
+static struct smp_hotplug_thread cpuhp_threads = {
+	.store			= &cpuhp_state.thread,
+	.create			= &cpuhp_create,
+	.thread_should_run	= cpuhp_should_run,
+	.thread_fn		= cpuhp_thread_fun,
+	.thread_comm		= "cpuhp/%u",
+	.selfparking		= true,
+};
+
+void __init cpuhp_threads_init(void)
+{
+	BUG_ON(smpboot_register_percpu_thread(&cpuhp_threads));
+	kthread_unpark(this_cpu_read(cpuhp_state.thread));
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 EXPORT_SYMBOL(register_cpu_notifier);
 EXPORT_SYMBOL(__register_cpu_notifier);
@@ -997,7 +1140,7 @@ static int cpuhp_cb_check(enum cpuhp_sta
 
 static bool cpuhp_is_ap_state(enum cpuhp_state state)
 {
-	return (state > CPUHP_AP_OFFLINE && state < CPUHP_AP_ONLINE);
+	return (state >= CPUHP_AP_OFFLINE && state <= CPUHP_AP_ONLINE);
 }
 
 static struct cpuhp_step *cpuhp_get_step(enum cpuhp_state state)
Index: b/kernel/smp.c
===================================================================
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -569,6 +569,7 @@ void __init smp_init(void)
 	unsigned int cpu;
 
 	idle_threads_init();
+	cpuhp_threads_init();
 
 	/* FIXME: This should be done in userspace --RR */
 	for_each_present_cpu(cpu) {
Index: b/kernel/smpboot.h
===================================================================
--- a/kernel/smpboot.h
+++ b/kernel/smpboot.h
@@ -17,4 +17,6 @@ int smpboot_create_threads(unsigned int
 int smpboot_park_threads(unsigned int cpu);
 int smpboot_unpark_threads(unsigned int cpu);
 
+void __init cpuhp_threads_init(void);
+
 #endif
