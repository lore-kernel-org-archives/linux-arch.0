From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 10/20] cpu/hotplug: Make target state writeable
Date: Fri, 26 Feb 2016 18:43:32 -0000
Message-ID: <20160226182341.022814799@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=hotplug--Make-target-state-writeable.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>
List-Id: linux-arch.vger.kernel.org

Make it possible to write a target state to the per cpu state file, so we can
switch between states.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/cpu.c      |   66 +++++++++++++++++++++++++++++++++++++++++++++++-------
 lib/Kconfig.debug |   13 ++++++++++
 2 files changed, 71 insertions(+), 8 deletions(-)

Index: b/kernel/cpu.c
===================================================================
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -48,12 +48,14 @@ static DEFINE_PER_CPU(struct cpuhp_cpu_s
  * @teardown:	Teardown function of the step
  * @skip_onerr:	Do not invoke the functions on error rollback
  *		Will go away once the notifiers	are gone
+ * @cant_stop:	Bringup/teardown can't be stopped at this step
  */
 struct cpuhp_step {
 	const char	*name;
 	int		(*startup)(unsigned int cpu);
 	int		(*teardown)(unsigned int cpu);
 	bool		skip_onerr;
+	bool		cant_stop;
 };
 
 static DEFINE_MUTEX(cpuhp_state_mutex);
@@ -558,7 +560,7 @@ static int __ref _cpu_down(unsigned int
 	if (num_online_cpus() == 1)
 		return -EBUSY;
 
-	if (!cpu_online(cpu))
+	if (!cpu_present(cpu))
 		return -EINVAL;
 
 	cpu_hotplug_begin();
@@ -683,16 +685,25 @@ static int _cpu_up(unsigned int cpu, int
 
 	cpu_hotplug_begin();
 
-	if (cpu_online(cpu) || !cpu_present(cpu)) {
+	if (!cpu_present(cpu)) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	/* Let it fail before we try to bring the cpu up */
-	idle = idle_thread_get(cpu);
-	if (IS_ERR(idle)) {
-		ret = PTR_ERR(idle);
+	/*
+	 * The caller of do_cpu_up might have raced with another
+	 * caller. Ignore it for now.
+	 */
+	if (st->state >= target)
 		goto out;
+
+	if (st->state == CPUHP_OFFLINE) {
+		/* Let it fail before we try to bring the cpu up */
+		idle = idle_thread_get(cpu);
+		if (IS_ERR(idle)) {
+			ret = PTR_ERR(idle);
+			goto out;
+		}
 	}
 
 	cpuhp_tasks_frozen = tasks_frozen;
@@ -909,27 +920,32 @@ static struct cpuhp_step cpuhp_bp_states
 		.name			= "threads:create",
 		.startup		= smpboot_create_threads,
 		.teardown		= NULL,
+		.cant_stop		= true,
 	},
 	[CPUHP_NOTIFY_PREPARE] = {
 		.name			= "notify:prepare",
 		.startup		= notify_prepare,
 		.teardown		= notify_dead,
 		.skip_onerr		= true,
+		.cant_stop		= true,
 	},
 	[CPUHP_BRINGUP_CPU] = {
 		.name			= "cpu:bringup",
 		.startup		= bringup_cpu,
 		.teardown		= NULL,
+		.cant_stop		= true,
 	},
 	[CPUHP_TEARDOWN_CPU] = {
 		.name			= "cpu:teardown",
 		.startup		= NULL,
 		.teardown		= takedown_cpu,
+		.cant_stop		= true,
 	},
 	[CPUHP_NOTIFY_ONLINE] = {
 		.name			= "notify:online",
 		.startup		= notify_online,
 		.teardown		= notify_down_prepare,
+		.cant_stop		= true,
 	},
 #endif
 	[CPUHP_ONLINE] = {
@@ -947,6 +963,7 @@ static struct cpuhp_step cpuhp_ap_states
 		.startup		= notify_starting,
 		.teardown		= notify_dying,
 		.skip_onerr		= true,
+		.cant_stop		= true,
 	},
 #endif
 	[CPUHP_ONLINE] = {
@@ -979,6 +996,39 @@ static ssize_t show_cpuhp_state(struct d
 }
 static DEVICE_ATTR(state, 0444, show_cpuhp_state, NULL);
 
+static ssize_t write_cpuhp_target(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
+	struct cpuhp_step *sp;
+	int target, ret;
+
+	ret = kstrtoint(buf, 10, &target);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_CPU_HOTPLUG_STATE_CONTROL
+	if (target < CPUHP_OFFLINE || target > CPUHP_ONLINE)
+		return -EINVAL;
+#else
+	if (target != CPUHP_OFFLINE && target != CPUHP_ONLINE)
+		return -EINVAL;
+#endif
+	mutex_lock(&cpuhp_state_mutex);
+	sp = cpuhp_get_step(target);
+	ret = !sp->name || sp->cant_stop ? -EINVAL : 0;
+	mutex_unlock(&cpuhp_state_mutex);
+	if (ret)
+		return ret;
+
+	if (st->state < target)
+		ret = do_cpu_up(dev->id, target);
+	else
+		ret = do_cpu_down(dev->id, target);
+	return ret ? ret : count;
+}
+
 static ssize_t show_cpuhp_target(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
@@ -986,7 +1036,7 @@ static ssize_t show_cpuhp_target(struct
 
 	return sprintf(buf, "%d\n", st->target);
 }
-static DEVICE_ATTR(target, 0444, show_cpuhp_target, NULL);
+static DEVICE_ATTR(target, 0644, show_cpuhp_target, write_cpuhp_target);
 
 static struct attribute *cpuhp_cpu_attrs[] = {
 	&dev_attr_state.attr,
@@ -1007,7 +1057,7 @@ static ssize_t show_cpuhp_states(struct
 	int i;
 
 	mutex_lock(&cpuhp_state_mutex);
-	for (i = 0; i <= CPUHP_ONLINE; i++) {
+	for (i = CPUHP_OFFLINE; i <= CPUHP_ONLINE; i++) {
 		struct cpuhp_step *sp = cpuhp_get_step(i);
 
 		if (sp->name) {
Index: b/lib/Kconfig.debug
===================================================================
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1442,6 +1442,19 @@ config DEBUG_BLOCK_EXT_DEVT
 
 	  Say N if you are unsure.
 
+config CPU_HOTPLUG_STATE_CONTROL
+	bool "Enable CPU hotplug state control"
+	depends on DEBUG_KERNEL
+	depends on HOTPLUG_CPU
+	default n
+	help
+	  Allows to write steps between "offline" and "online" to the CPUs
+	  sysfs target file so states can be stepped granular. This is a debug
+	  option for now as the hotplug machinery cannot be stopped and
+	  restarted at arbitrary points yet.
+
+	  Say N if your are unsure.
+
 config NOTIFIER_ERROR_INJECTION
 	tristate "Notifier error injection"
 	depends on DEBUG_KERNEL
