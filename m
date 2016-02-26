From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 09/20] cpu/hotplug: Add sysfs state interface
Date: Fri, 26 Feb 2016 18:43:31 -0000
Message-ID: <20160226182340.942257522@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33392 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422893AbcBZSo5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Feb 2016 13:44:57 -0500
Content-Disposition: inline; filename=hotplug--Add-sysfs-state-interface.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

Add a sysfs interface so we can actually see in which state the cpus are in.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/cpu.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

Index: b/kernel/cpu.c
===================================================================
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -56,6 +56,7 @@ struct cpuhp_step {
 	bool		skip_onerr;
 };
 
+static DEFINE_MUTEX(cpuhp_state_mutex);
 static struct cpuhp_step cpuhp_bp_states[];
 static struct cpuhp_step cpuhp_ap_states[];
 
@@ -955,6 +956,103 @@ static struct cpuhp_step cpuhp_ap_states
 	},
 };
 
+static bool cpuhp_is_ap_state(enum cpuhp_state state)
+{
+	return (state > CPUHP_AP_OFFLINE && state < CPUHP_AP_ONLINE);
+}
+
+static struct cpuhp_step *cpuhp_get_step(enum cpuhp_state state)
+{
+	struct cpuhp_step *sp;
+
+	sp = cpuhp_is_ap_state(state) ? cpuhp_ap_states : cpuhp_bp_states;
+	return sp + state;
+}
+
+#if defined(CONFIG_SYSFS) && defined(CONFIG_HOTPLUG_CPU)
+static ssize_t show_cpuhp_state(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
+
+	return sprintf(buf, "%d\n", st->state);
+}
+static DEVICE_ATTR(state, 0444, show_cpuhp_state, NULL);
+
+static ssize_t show_cpuhp_target(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
+
+	return sprintf(buf, "%d\n", st->target);
+}
+static DEVICE_ATTR(target, 0444, show_cpuhp_target, NULL);
+
+static struct attribute *cpuhp_cpu_attrs[] = {
+	&dev_attr_state.attr,
+	&dev_attr_target.attr,
+	NULL
+};
+
+static struct attribute_group cpuhp_cpu_attr_group = {
+	.attrs = cpuhp_cpu_attrs,
+	.name = "hotplug",
+	NULL
+};
+
+static ssize_t show_cpuhp_states(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	ssize_t cur, res = 0;
+	int i;
+
+	mutex_lock(&cpuhp_state_mutex);
+	for (i = 0; i <= CPUHP_ONLINE; i++) {
+		struct cpuhp_step *sp = cpuhp_get_step(i);
+
+		if (sp->name) {
+			cur = sprintf(buf, "%3d: %s\n", i, sp->name);
+			buf += cur;
+			res += cur;
+		}
+	}
+	mutex_unlock(&cpuhp_state_mutex);
+	return res;
+}
+static DEVICE_ATTR(states, 0444, show_cpuhp_states, NULL);
+
+static struct attribute *cpuhp_cpu_root_attrs[] = {
+	&dev_attr_states.attr,
+	NULL
+};
+
+static struct attribute_group cpuhp_cpu_root_attr_group = {
+	.attrs = cpuhp_cpu_root_attrs,
+	.name = "hotplug",
+	NULL
+};
+
+static int __init cpuhp_sysfs_init(void)
+{
+	int cpu, ret;
+
+	ret = sysfs_create_group(&cpu_subsys.dev_root->kobj,
+				 &cpuhp_cpu_root_attr_group);
+	if (ret)
+		return ret;
+
+	for_each_possible_cpu(cpu) {
+		struct device *dev = get_cpu_device(cpu);
+
+		ret = sysfs_create_group(&dev->kobj, &cpuhp_cpu_attr_group);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+device_initcall(cpuhp_sysfs_init);
+#endif
+
 /*
  * cpu_bit_bitmap[] is a special, "compressed" data structure that
  * represents all NR_CPUS bits binary values of 1<<nr.
