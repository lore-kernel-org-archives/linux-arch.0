From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 04/20] cpu/hotplug: Split out cpu down functions
Date: Fri, 26 Feb 2016 18:43:25 -0000
Message-ID: <20160226182340.511796562@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=cpu-hotplug-Split-out-cpu-down-functions.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>
List-Id: linux-arch.vger.kernel.org

Split cpu_down in separate functions in preparation for state machine
conversion.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/cpu.c |   83 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 30 deletions(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -266,11 +266,6 @@ static int bringup_cpu(unsigned int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-
-static void cpu_notify_nofail(unsigned long val, unsigned int cpu)
-{
-	BUG_ON(cpu_notify(val, cpu));
-}
 EXPORT_SYMBOL(register_cpu_notifier);
 EXPORT_SYMBOL(__register_cpu_notifier);
 
@@ -353,6 +348,25 @@ static inline void check_for_tasks(int d
 	read_unlock(&tasklist_lock);
 }
 
+static void cpu_notify_nofail(unsigned long val, unsigned int cpu)
+{
+	BUG_ON(cpu_notify(val, cpu));
+}
+
+static int notify_down_prepare(unsigned int cpu)
+{
+	int err, nr_calls = 0;
+
+	err = __cpu_notify(CPU_DOWN_PREPARE, cpu, -1, &nr_calls);
+	if (err) {
+		nr_calls--;
+		__cpu_notify(CPU_DOWN_FAILED, cpu, nr_calls, NULL);
+		pr_warn("%s: attempt to take down CPU %u failed\n",
+				__func__, cpu);
+	}
+	return err;
+}
+
 /* Take this CPU down. */
 static int take_cpu_down(void *_param)
 {
@@ -371,29 +385,9 @@ static int take_cpu_down(void *_param)
 	return 0;
 }
 
-/* Requires cpu_add_remove_lock to be held */
-static int _cpu_down(unsigned int cpu, int tasks_frozen)
+static int takedown_cpu(unsigned int cpu)
 {
-	int err, nr_calls = 0;
-
-	if (num_online_cpus() == 1)
-		return -EBUSY;
-
-	if (!cpu_online(cpu))
-		return -EINVAL;
-
-	cpu_hotplug_begin();
-
-	cpuhp_tasks_frozen = tasks_frozen;
-
-	err = __cpu_notify(CPU_DOWN_PREPARE, cpu, -1, &nr_calls);
-	if (err) {
-		nr_calls--;
-		__cpu_notify(CPU_DOWN_FAILED, cpu, nr_calls, NULL);
-		pr_warn("%s: attempt to take down CPU %u failed\n",
-			__func__, cpu);
-		goto out_release;
-	}
+	int err;
 
 	/*
 	 * By now we've cleared cpu_active_mask, wait for all preempt-disabled
@@ -426,7 +420,7 @@ static int _cpu_down(unsigned int cpu, i
 		/* CPU didn't die: tell everyone.  Can't complain. */
 		cpu_notify_nofail(CPU_DOWN_FAILED, cpu);
 		irq_unlock_sparse();
-		goto out_release;
+		return err;
 	}
 	BUG_ON(cpu_online(cpu));
 
@@ -449,11 +443,40 @@ static int _cpu_down(unsigned int cpu, i
 	/* This actually kills the CPU. */
 	__cpu_die(cpu);
 
-	/* CPU is completely dead: tell everyone.  Too late to complain. */
 	tick_cleanup_dead_cpu(cpu);
-	cpu_notify_nofail(CPU_DEAD, cpu);
+	return 0;
+}
 
+static int notify_dead(unsigned int cpu)
+{
+	cpu_notify_nofail(CPU_DEAD, cpu);
 	check_for_tasks(cpu);
+	return 0;
+}
+
+/* Requires cpu_add_remove_lock to be held */
+static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
+{
+	int err;
+
+	if (num_online_cpus() == 1)
+		return -EBUSY;
+
+	if (!cpu_online(cpu))
+		return -EINVAL;
+
+	cpu_hotplug_begin();
+
+	cpuhp_tasks_frozen = tasks_frozen;
+
+	err = notify_down_prepare(cpu);
+	if (err)
+		goto out_release;
+	err = takedown_cpu(cpu);
+	if (err)
+		goto out_release;
+
+	notify_dead(cpu);
 
 out_release:
 	cpu_hotplug_done();
