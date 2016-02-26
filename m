From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 19/20] cpu/hotplug: Make wait for dead cpu completion based
Date: Fri, 26 Feb 2016 18:43:43 -0000
Message-ID: <20160226182341.776157858@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=hotplug--Make-wait-for-dead-cpu-completion-based.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>
List-Id: linux-arch.vger.kernel.org

Kill the busy spinning on the control side and just wait for the hotplugged
cpu to tell that it reached the dead state.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cpu.h        |    5 +++--
 include/linux/cpuhotplug.h |    1 +
 kernel/cpu.c               |   16 ++++++++++++----
 kernel/sched/idle.c        |    5 +----
 4 files changed, 17 insertions(+), 10 deletions(-)

Index: b/include/linux/cpu.h
===================================================================
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -276,14 +276,15 @@ void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
 void arch_cpu_idle_dead(void);
 
-DECLARE_PER_CPU(bool, cpu_dead_idle);
-
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 bool cpu_wait_death(unsigned int cpu, int seconds);
 bool cpu_report_death(void);
+void cpuhp_report_idle_dead(void);
+#else
+static inline void cpuhp_report_idle_dead(void) { }
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 
 #endif /* _LINUX_CPU_H_ */
Index: b/include/linux/cpuhotplug.h
===================================================================
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -6,6 +6,7 @@ enum cpuhp_state {
 	CPUHP_CREATE_THREADS,
 	CPUHP_NOTIFY_PREPARE,
 	CPUHP_BRINGUP_CPU,
+	CPUHP_AP_IDLE_DEAD,
 	CPUHP_AP_OFFLINE,
 	CPUHP_AP_NOTIFY_STARTING,
 	CPUHP_AP_ONLINE,
Index: b/kernel/cpu.c
===================================================================
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -688,6 +688,7 @@ static int take_cpu_down(void *_param)
 
 static int takedown_cpu(unsigned int cpu)
 {
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	int err;
 
 	/*
@@ -733,10 +734,8 @@ static int takedown_cpu(unsigned int cpu
 	 *
 	 * Wait for the stop thread to go away.
 	 */
-	while (!per_cpu(cpu_dead_idle, cpu))
-		cpu_relax();
-	smp_mb(); /* Read from cpu_dead_idle before __cpu_die(). */
-	per_cpu(cpu_dead_idle, cpu) = false;
+	wait_for_completion(&st->done);
+	BUG_ON(st->state != CPUHP_AP_IDLE_DEAD);
 
 	/* Interrupts are moved away from the dying cpu, reenable alloc/free */
 	irq_unlock_sparse();
@@ -756,6 +755,15 @@ static int notify_dead(unsigned int cpu)
 	return 0;
 }
 
+void cpuhp_report_idle_dead(void)
+{
+	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
+
+	BUG_ON(st->state != CPUHP_AP_OFFLINE);
+	st->state = CPUHP_AP_IDLE_DEAD;
+	complete(&st->done);
+}
+
 #else
 #define notify_down_prepare	NULL
 #define takedown_cpu		NULL
Index: b/kernel/sched/idle.c
===================================================================
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -194,8 +194,6 @@ static void cpuidle_idle_call(void)
 	rcu_idle_exit();
 }
 
-DEFINE_PER_CPU(bool, cpu_dead_idle);
-
 /*
  * Generic idle loop implementation
  *
@@ -224,8 +222,7 @@ static void cpu_idle_loop(void)
 			if (cpu_is_offline(smp_processor_id())) {
 				rcu_cpu_notify(NULL, CPU_DYING_IDLE,
 					       (void *)(long)smp_processor_id());
-				smp_mb(); /* all activity before dead. */
-				this_cpu_write(cpu_dead_idle, true);
+				cpuhp_report_idle_dead();
 				arch_cpu_idle_dead();
 			}
 
