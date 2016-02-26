From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 11/20] cpu/hotplug: Implement setup/removal interface
Date: Fri, 26 Feb 2016 18:43:33 -0000
Message-ID: <20160226182341.103464877@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=cpu-hotplug-Implement-setup-removal-interface.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>
List-Id: linux-arch.vger.kernel.org

Implement function which allow to setup/remove hotplug state callbacks.

The default behaviour for setup is to call the startup function for this state
for (or on) all cpus which have a hotplug state >= the installed state.

The default behaviour for removal is to call the teardown function for this
state for (or on) all cpus which have a hotplug state >= the installed state.

This includes rollback to the previous state in case of failure.

A special state is CPUHP_ONLINE_DYN. Its for dynamically registering a hotplug
callback pair. This is for drivers which have no dependencies to avoid that we
need to allocate CPUHP states for each of them

For both setup and remove helper functions are provided, which prevent the
core to issue the callbacks. This simplifies the conversion of existing
hotplug notifiers.

[ Dynamic registering implemented by Sebastian Siewior ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cpuhotplug.h |   67 +++++++++++++
 kernel/cpu.c               |  224 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 291 insertions(+)

Index: b/include/linux/cpuhotplug.h
===================================================================
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -11,7 +11,74 @@ enum cpuhp_state {
 	CPUHP_AP_ONLINE,
 	CPUHP_TEARDOWN_CPU,
 	CPUHP_NOTIFY_ONLINE,
+	CPUHP_ONLINE_DYN,
+	CPUHP_ONLINE_DYN_END		= CPUHP_ONLINE_DYN + 30,
 	CPUHP_ONLINE,
 };
 
+int __cpuhp_setup_state(enum cpuhp_state state,	const char *name, bool invoke,
+			int (*startup)(unsigned int cpu),
+			int (*teardown)(unsigned int cpu));
+
+/**
+ * cpuhp_setup_state - Setup hotplug state callbacks with calling the callbacks
+ * @state:	The state for which the calls are installed
+ * @name:	Name of the callback (will be used in debug output)
+ * @startup:	startup callback function
+ * @teardown:	teardown callback function
+ *
+ * Installs the callback functions and invokes the startup callback on
+ * the present cpus which have already reached the @state.
+ */
+static inline int cpuhp_setup_state(enum cpuhp_state state,
+				    const char *name,
+				    int (*startup)(unsigned int cpu),
+				    int (*teardown)(unsigned int cpu))
+{
+	return __cpuhp_setup_state(state, name, true, startup, teardown);
+}
+
+/**
+ * cpuhp_setup_state_nocalls - Setup hotplug state callbacks without calling the
+ *			       callbacks
+ * @state:	The state for which the calls are installed
+ * @name:	Name of the callback.
+ * @startup:	startup callback function
+ * @teardown:	teardown callback function
+ *
+ * Same as @cpuhp_setup_state except that no calls are executed are invoked
+ * during installation of this callback. NOP if SMP=n or HOTPLUG_CPU=n.
+ */
+static inline int cpuhp_setup_state_nocalls(enum cpuhp_state state,
+					    const char *name,
+					    int (*startup)(unsigned int cpu),
+					    int (*teardown)(unsigned int cpu))
+{
+	return __cpuhp_setup_state(state, name, false, startup, teardown);
+}
+
+void __cpuhp_remove_state(enum cpuhp_state state, bool invoke);
+
+/**
+ * cpuhp_remove_state - Remove hotplug state callbacks and invoke the teardown
+ * @state:	The state for which the calls are removed
+ *
+ * Removes the callback functions and invokes the teardown callback on
+ * the present cpus which have already reached the @state.
+ */
+static inline void cpuhp_remove_state(enum cpuhp_state state)
+{
+	__cpuhp_remove_state(state, true);
+}
+
+/**
+ * cpuhp_remove_state_nocalls - Remove hotplug state callbacks without invoking
+ *				teardown
+ * @state:	The state for which the calls are removed
+ */
+static inline void cpuhp_remove_state_nocalls(enum cpuhp_state state)
+{
+	__cpuhp_remove_state(state, false);
+}
+
 #endif
Index: b/kernel/cpu.c
===================================================================
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -973,6 +973,14 @@ static struct cpuhp_step cpuhp_ap_states
 	},
 };
 
+/* Sanity check for callbacks */
+static int cpuhp_cb_check(enum cpuhp_state state)
+{
+	if (state <= CPUHP_OFFLINE || state >= CPUHP_ONLINE)
+		return -EINVAL;
+	return 0;
+}
+
 static bool cpuhp_is_ap_state(enum cpuhp_state state)
 {
 	return (state > CPUHP_AP_OFFLINE && state < CPUHP_AP_ONLINE);
@@ -986,6 +994,222 @@ static struct cpuhp_step *cpuhp_get_step
 	return sp + state;
 }
 
+static void cpuhp_store_callbacks(enum cpuhp_state state,
+				  const char *name,
+				  int (*startup)(unsigned int cpu),
+				  int (*teardown)(unsigned int cpu))
+{
+	/* (Un)Install the callbacks for further cpu hotplug operations */
+	struct cpuhp_step *sp;
+
+	mutex_lock(&cpuhp_state_mutex);
+	sp = cpuhp_get_step(state);
+	sp->startup = startup;
+	sp->teardown = teardown;
+	sp->name = name;
+	mutex_unlock(&cpuhp_state_mutex);
+}
+
+static void *cpuhp_get_teardown_cb(enum cpuhp_state state)
+{
+	return cpuhp_get_step(state)->teardown;
+}
+
+/* Helper function to run callback on the target cpu */
+static void cpuhp_on_cpu_cb(void *__cb)
+{
+	int (*cb)(unsigned int cpu) = __cb;
+
+	BUG_ON(cb(smp_processor_id()));
+}
+
+/*
+ * Call the startup/teardown function for a step either on the AP or
+ * on the current CPU.
+ */
+static int cpuhp_issue_call(int cpu, enum cpuhp_state state,
+			    int (*cb)(unsigned int), bool bringup)
+{
+	int ret;
+
+	if (!cb)
+		return 0;
+
+	/*
+	 * This invokes the callback directly for now. In a later step we
+	 * convert that to use cpuhp_invoke_callback().
+	 */
+	if (cpuhp_is_ap_state(state)) {
+		/*
+		 * Note, that a function called on the AP is not
+		 * allowed to fail.
+		 */
+		if (cpu_online(cpu))
+			smp_call_function_single(cpu, cpuhp_on_cpu_cb, cb, 1);
+		return 0;
+	}
+
+	/*
+	 * The non AP bound callbacks can fail on bringup. On teardown
+	 * e.g. module removal we crash for now.
+	 */
+	ret = cb(cpu);
+	BUG_ON(ret && !bringup);
+	return ret;
+}
+
+/*
+ * Called from __cpuhp_setup_state on a recoverable failure.
+ *
+ * Note: The teardown callbacks for rollback are not allowed to fail!
+ */
+static void cpuhp_rollback_install(int failedcpu, enum cpuhp_state state,
+				   int (*teardown)(unsigned int cpu))
+{
+	int cpu;
+
+	if (!teardown)
+		return;
+
+	/* Roll back the already executed steps on the other cpus */
+	for_each_present_cpu(cpu) {
+		struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
+		int cpustate = st->state;
+
+		if (cpu >= failedcpu)
+			break;
+
+		/* Did we invoke the startup call on that cpu ? */
+		if (cpustate >= state)
+			cpuhp_issue_call(cpu, state, teardown, false);
+	}
+}
+
+/*
+ * Returns a free for dynamic slot assignment of the Online state. The states
+ * are protected by the cpuhp_slot_states mutex and an empty slot is identified
+ * by having no name assigned.
+ */
+static int cpuhp_reserve_state(enum cpuhp_state state)
+{
+	enum cpuhp_state i;
+
+	mutex_lock(&cpuhp_state_mutex);
+	for (i = CPUHP_ONLINE_DYN; i <= CPUHP_ONLINE_DYN_END; i++) {
+		if (cpuhp_bp_states[i].name)
+			continue;
+
+		cpuhp_bp_states[i].name = "Reserved";
+		mutex_unlock(&cpuhp_state_mutex);
+		return i;
+	}
+	mutex_unlock(&cpuhp_state_mutex);
+	WARN(1, "No more dynamic states available for CPU hotplug\n");
+	return -ENOSPC;
+}
+
+/**
+ * __cpuhp_setup_state - Setup the callbacks for an hotplug machine state
+ * @state:	The state to setup
+ * @invoke:	If true, the startup function is invoked for cpus where
+ *		cpu state >= @state
+ * @startup:	startup callback function
+ * @teardown:	teardown callback function
+ *
+ * Returns 0 if successful, otherwise a proper error code
+ */
+int __cpuhp_setup_state(enum cpuhp_state state,
+			const char *name, bool invoke,
+			int (*startup)(unsigned int cpu),
+			int (*teardown)(unsigned int cpu))
+{
+	int cpu, ret = 0;
+	int dyn_state = 0;
+
+	if (cpuhp_cb_check(state) || !name)
+		return -EINVAL;
+
+	get_online_cpus();
+
+	/* currently assignments for the ONLINE state are possible */
+	if (state == CPUHP_ONLINE_DYN) {
+		dyn_state = 1;
+		ret = cpuhp_reserve_state(state);
+		if (ret < 0)
+			goto out;
+		state = ret;
+	}
+
+	cpuhp_store_callbacks(state, name, startup, teardown);
+
+	if (!invoke || !startup)
+		goto out;
+
+	/*
+	 * Try to call the startup callback for each present cpu
+	 * depending on the hotplug state of the cpu.
+	 */
+	for_each_present_cpu(cpu) {
+		struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
+		int cpustate = st->state;
+
+		if (cpustate < state)
+			continue;
+
+		ret = cpuhp_issue_call(cpu, state, startup, true);
+		if (ret) {
+			cpuhp_rollback_install(cpu, state, teardown);
+			cpuhp_store_callbacks(state, NULL, NULL, NULL);
+			goto out;
+		}
+	}
+out:
+	put_online_cpus();
+	if (!ret && dyn_state)
+		return state;
+	return ret;
+}
+EXPORT_SYMBOL(__cpuhp_setup_state);
+
+/**
+ * __cpuhp_remove_state - Remove the callbacks for an hotplug machine state
+ * @state:	The state to remove
+ * @invoke:	If true, the teardown function is invoked for cpus where
+ *		cpu state >= @state
+ *
+ * The teardown callback is currently not allowed to fail. Think
+ * about module removal!
+ */
+void __cpuhp_remove_state(enum cpuhp_state state, bool invoke)
+{
+	int (*teardown)(unsigned int cpu) = cpuhp_get_teardown_cb(state);
+	int cpu;
+
+	BUG_ON(cpuhp_cb_check(state));
+
+	get_online_cpus();
+
+	if (!invoke || !teardown)
+		goto remove;
+
+	/*
+	 * Call the teardown callback for each present cpu depending
+	 * on the hotplug state of the cpu. This function is not
+	 * allowed to fail currently!
+	 */
+	for_each_present_cpu(cpu) {
+		struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
+		int cpustate = st->state;
+
+		if (cpustate >= state)
+			cpuhp_issue_call(cpu, state, teardown, false);
+	}
+remove:
+	cpuhp_store_callbacks(state, NULL, NULL, NULL);
+	put_online_cpus();
+}
+EXPORT_SYMBOL(__cpuhp_remove_state);
+
 #if defined(CONFIG_SYSFS) && defined(CONFIG_HOTPLUG_CPU)
 static ssize_t show_cpuhp_state(struct device *dev,
 				struct device_attribute *attr, char *buf)
