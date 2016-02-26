From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 12/20] cpu/hotplug: Move scheduler cpu_online notifier to
 hotplug core
Date: Fri, 26 Feb 2016 18:43:35 -0000
Message-ID: <20160226182341.200791046@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33424 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbcBZSpB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Feb 2016 13:45:01 -0500
Content-Disposition: inline;
 filename=hotplug--Move-scheduler-cpu_online-notifier-to-hotplug-core.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

Move the scheduler cpu online notifier part to the hotplug core. This is
anyway the highest priority callback and we need that functionality right now
for the next changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cpuhotplug.h |    1 +
 kernel/cpu.c               |   18 ++++++++++++++++++
 kernel/sched/core.c        |   10 ----------
 3 files changed, 19 insertions(+), 10 deletions(-)

Index: b/include/linux/cpuhotplug.h
===================================================================
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -10,6 +10,7 @@ enum cpuhp_state {
 	CPUHP_AP_NOTIFY_STARTING,
 	CPUHP_AP_ONLINE,
 	CPUHP_TEARDOWN_CPU,
+	CPUHP_CPU_SET_ACTIVE,
 	CPUHP_NOTIFY_ONLINE,
 	CPUHP_ONLINE_DYN,
 	CPUHP_ONLINE_DYN_END		= CPUHP_ONLINE_DYN + 30,
Index: b/kernel/cpu.c
===================================================================
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -666,6 +666,19 @@ void notify_cpu_starting(unsigned int cp
 	}
 }
 
+/*
+ * Called from the idle task. We need to set active here, so we can kick off
+ * the stopper thread.
+ */
+static int cpuhp_set_cpu_active(unsigned int cpu)
+{
+	/* The cpu is marked online, set it active now */
+	set_cpu_active(cpu, true);
+	/* Unpark the stopper thread */
+	stop_machine_unpark(cpu);
+	return 0;
+}
+
 static void undo_cpu_up(unsigned int cpu, struct cpuhp_cpu_state *st)
 {
 	for (st->state--; st->state > st->target; st->state--) {
@@ -941,6 +954,11 @@ static struct cpuhp_step cpuhp_bp_states
 		.teardown		= takedown_cpu,
 		.cant_stop		= true,
 	},
+	[CPUHP_CPU_SET_ACTIVE] = {
+		.name			= "cpu:active",
+		.startup		= cpuhp_set_cpu_active,
+		.teardown		= NULL,
+	},
 	[CPUHP_NOTIFY_ONLINE] = {
 		.name			= "notify:online",
 		.startup		= notify_online,
Index: b/kernel/sched/core.c
===================================================================
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5692,16 +5692,6 @@ static int sched_cpu_active(struct notif
 		set_cpu_rq_start_time();
 		return NOTIFY_OK;
 
-	case CPU_ONLINE:
-		/*
-		 * At this point a starting CPU has marked itself as online via
-		 * set_cpu_online(). But it might not yet have marked itself
-		 * as active, which is essential from here on.
-		 */
-		set_cpu_active(cpu, true);
-		stop_machine_unpark(cpu);
-		return NOTIFY_OK;
-
 	case CPU_DOWN_FAILED:
 		set_cpu_active(cpu, true);
 		return NOTIFY_OK;
