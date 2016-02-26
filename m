From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 13/20] cpu/hotplug: Unpark smpboot threads from the state
 machine
Date: Fri, 26 Feb 2016 18:43:36 -0000
Message-ID: <20160226182341.295777684@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=hotplug--Handle-smpboot-threads-in-state-machine.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>
List-Id: linux-arch.vger.kernel.org

Handle the smpboot threads in the state machine.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cpu.h        |    7 +------
 include/linux/cpuhotplug.h |    1 +
 init/main.c                |    1 -
 kernel/cpu.c               |   39 +++++----------------------------------
 kernel/smpboot.c           |    6 ++++--
 kernel/smpboot.h           |    4 ++--
 6 files changed, 13 insertions(+), 45 deletions(-)

Index: b/include/linux/cpu.h
===================================================================
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -78,7 +78,7 @@ enum {
 	/* migration should happen before other stuff but after perf */
 	CPU_PRI_PERF		= 20,
 	CPU_PRI_MIGRATION	= 10,
-	CPU_PRI_SMPBOOT		= 9,
+
 	/* bring up workqueues before normal notifiers and down after */
 	CPU_PRI_WORKQUEUE_UP	= 5,
 	CPU_PRI_WORKQUEUE_DOWN	= -5,
@@ -172,7 +172,6 @@ static inline void __unregister_cpu_noti
 }
 #endif
 
-void smpboot_thread_init(void);
 int cpu_up(unsigned int cpu);
 void notify_cpu_starting(unsigned int cpu);
 extern void cpu_maps_update_begin(void);
@@ -221,10 +220,6 @@ static inline void cpu_notifier_register
 {
 }
 
-static inline void smpboot_thread_init(void)
-{
-}
-
 #endif /* CONFIG_SMP */
 extern struct bus_type cpu_subsys;
 
Index: b/include/linux/cpuhotplug.h
===================================================================
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -11,6 +11,7 @@ enum cpuhp_state {
 	CPUHP_AP_ONLINE,
 	CPUHP_TEARDOWN_CPU,
 	CPUHP_CPU_SET_ACTIVE,
+	CPUHP_SMPBOOT_THREADS,
 	CPUHP_NOTIFY_ONLINE,
 	CPUHP_ONLINE_DYN,
 	CPUHP_ONLINE_DYN_END		= CPUHP_ONLINE_DYN + 30,
Index: b/init/main.c
===================================================================
--- a/init/main.c
+++ b/init/main.c
@@ -388,7 +388,6 @@ static noinline void __init_refok rest_i
 	int pid;
 
 	rcu_scheduler_starting();
-	smpboot_thread_init();
 	/*
 	 * We need to spawn init first so that it obtains pid 1, however
 	 * the init task will end up wanting to create kthreads, which, if
Index: b/kernel/cpu.c
===================================================================
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -481,8 +481,6 @@ static int takedown_cpu(unsigned int cpu
 	else
 		synchronize_rcu();
 
-	smpboot_park_threads(cpu);
-
 	/*
 	 * Prevent irq alloc/free while the dying cpu reorganizes the
 	 * interrupt affinities.
@@ -612,38 +610,6 @@ int cpu_down(unsigned int cpu)
 EXPORT_SYMBOL(cpu_down);
 #endif /*CONFIG_HOTPLUG_CPU*/
 
-/*
- * Unpark per-CPU smpboot kthreads at CPU-online time.
- */
-static int smpboot_thread_call(struct notifier_block *nfb,
-			       unsigned long action, void *hcpu)
-{
-	int cpu = (long)hcpu;
-
-	switch (action & ~CPU_TASKS_FROZEN) {
-
-	case CPU_DOWN_FAILED:
-	case CPU_ONLINE:
-		smpboot_unpark_threads(cpu);
-		break;
-
-	default:
-		break;
-	}
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block smpboot_thread_notifier = {
-	.notifier_call = smpboot_thread_call,
-	.priority = CPU_PRI_SMPBOOT,
-};
-
-void smpboot_thread_init(void)
-{
-	register_cpu_notifier(&smpboot_thread_notifier);
-}
-
 /**
  * notify_cpu_starting(cpu) - call the CPU_STARTING notifiers
  * @cpu: cpu that just started
@@ -959,6 +925,11 @@ static struct cpuhp_step cpuhp_bp_states
 		.startup		= cpuhp_set_cpu_active,
 		.teardown		= NULL,
 	},
+	[CPUHP_SMPBOOT_THREADS] = {
+		.name			= "smpboot:threads",
+		.startup		= smpboot_unpark_threads,
+		.teardown		= smpboot_park_threads,
+	},
 	[CPUHP_NOTIFY_ONLINE] = {
 		.name			= "notify:online",
 		.startup		= notify_online,
Index: b/kernel/smpboot.c
===================================================================
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -226,7 +226,7 @@ static void smpboot_unpark_thread(struct
 		kthread_unpark(tsk);
 }
 
-void smpboot_unpark_threads(unsigned int cpu)
+int smpboot_unpark_threads(unsigned int cpu)
 {
 	struct smp_hotplug_thread *cur;
 
@@ -235,6 +235,7 @@ void smpboot_unpark_threads(unsigned int
 		if (cpumask_test_cpu(cpu, cur->cpumask))
 			smpboot_unpark_thread(cur, cpu);
 	mutex_unlock(&smpboot_threads_lock);
+	return 0;
 }
 
 static void smpboot_park_thread(struct smp_hotplug_thread *ht, unsigned int cpu)
@@ -245,7 +246,7 @@ static void smpboot_park_thread(struct s
 		kthread_park(tsk);
 }
 
-void smpboot_park_threads(unsigned int cpu)
+int smpboot_park_threads(unsigned int cpu)
 {
 	struct smp_hotplug_thread *cur;
 
@@ -253,6 +254,7 @@ void smpboot_park_threads(unsigned int c
 	list_for_each_entry_reverse(cur, &hotplug_threads, list)
 		smpboot_park_thread(cur, cpu);
 	mutex_unlock(&smpboot_threads_lock);
+	return 0;
 }
 
 static void smpboot_destroy_threads(struct smp_hotplug_thread *ht)
Index: b/kernel/smpboot.h
===================================================================
--- a/kernel/smpboot.h
+++ b/kernel/smpboot.h
@@ -14,7 +14,7 @@ static inline void idle_threads_init(voi
 #endif
 
 int smpboot_create_threads(unsigned int cpu);
-void smpboot_park_threads(unsigned int cpu);
-void smpboot_unpark_threads(unsigned int cpu);
+int smpboot_park_threads(unsigned int cpu);
+int smpboot_unpark_threads(unsigned int cpu);
 
 #endif
