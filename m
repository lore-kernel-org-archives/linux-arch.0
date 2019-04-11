Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33395 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKDf0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Apr 2019 23:35:26 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 5/5] nohz_full: Allow the boot CPU to be nohz_full
Date: Thu, 11 Apr 2019 13:34:48 +1000
Message-ID: <20190411033448.20842-6-npiggin@gmail.com>
In-Reply-To: <20190411033448.20842-1-npiggin@gmail.com>
References: <20190411033448.20842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190411033448.HpGwoff3EuExv_8bQx-iE56O9vZWzUIF4DKeb3fPRn0@z>

Allow the boot CPU / CPU0 to be nohz_full. Have the boot CPU take the
do_timer duty during boot until a housekeeping CPU can take over.

This is supported when CONFIG_PM_SLEEP_SMP is not configured, or when
it is configured and the arch allows suspend on non-zero CPUs.

nohz_full has been trialed at a large supercomputer site and found to
significantly reduce jitter. In order to deploy it in production, they
need CPU0 to be nohz_full because their job control system requires
the application CPUs to start from 0, and the housekeeping CPUs are
placed higher. An equivalent job scheduling that uses CPU0 for
housekeeping could be achieved by modifying their system, but it is
preferable if nohz_full can support their environment without
modification.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/time/tick-common.c | 50 +++++++++++++++++++++++++++++++++++----
 kernel/time/tick-sched.c  | 34 ++++++++++++++++++--------
 2 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 529143b4c8d2..31146c13226e 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -46,6 +46,14 @@ ktime_t tick_period;
  *    procedure also covers cpu hotplug.
  */
 int tick_do_timer_cpu __read_mostly = TICK_DO_TIMER_BOOT;
+#ifdef CONFIG_NO_HZ_FULL
+/*
+ * tick_do_timer_boot_cpu indicates the boot CPU temporarily owns
+ * tick_do_timer_cpu and it should be taken over by an eligible secondary
+ * when one comes online.
+ */
+static int tick_do_timer_boot_cpu __read_mostly = -1;
+#endif
 
 /*
  * Debugging: see timer_list.c
@@ -167,6 +175,26 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 	}
 }
 
+#ifdef CONFIG_NO_HZ_FULL
+static void giveup_do_timer(void *info)
+{
+	int cpu = *(unsigned int *)info;
+
+	WARN_ON(tick_do_timer_cpu != smp_processor_id());
+
+	tick_do_timer_cpu = cpu;
+}
+
+static void tick_take_do_timer_from_boot(void)
+{
+	int cpu = smp_processor_id();
+	int from = tick_do_timer_boot_cpu;
+
+	if (from >= 0 && from != cpu)
+		smp_call_function_single(from, giveup_do_timer, &cpu, 1);
+}
+#endif
+
 /*
  * Setup the tick device
  */
@@ -186,12 +214,26 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
-			if (!tick_nohz_full_cpu(cpu))
-				tick_do_timer_cpu = cpu;
-			else
-				tick_do_timer_cpu = TICK_DO_TIMER_NONE;
+			tick_do_timer_cpu = cpu;
+
 			tick_next_period = ktime_get();
 			tick_period = NSEC_PER_SEC / HZ;
+#ifdef CONFIG_NO_HZ_FULL
+			/*
+			 * The boot CPU may be nohz_full, in which case set
+			 * tick_do_timer_boot_cpu so the first housekeeping
+			 * secondary that comes up will take do_timer from
+			 * us.
+			 */
+			if (tick_nohz_full_cpu(cpu))
+				tick_do_timer_boot_cpu = cpu;
+
+		} else if (tick_do_timer_boot_cpu != -1 &&
+						!tick_nohz_full_cpu(cpu)) {
+			tick_take_do_timer_from_boot();
+			tick_do_timer_boot_cpu = -1;
+			WARN_ON(tick_do_timer_cpu != cpu);
+#endif
 		}
 
 		/*
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6fa52cd6df0b..4aa917acbe1c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -121,10 +121,16 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	 * into a long sleep. If two CPUs happen to assign themselves to
 	 * this duty, then the jiffies update is still serialized by
 	 * jiffies_lock.
+	 *
+	 * If nohz_full is enabled, this should not happen because the
+	 * tick_do_timer_cpu never relinquishes.
 	 */
-	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)
-	    && !tick_nohz_full_cpu(cpu))
+	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
+#ifdef CONFIG_NO_HZ_FULL
+		WARN_ON(tick_nohz_full_running);
+#endif
 		tick_do_timer_cpu = cpu;
+	}
 #endif
 
 	/* Check, if the jiffies need an update */
@@ -395,8 +401,8 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 static int tick_nohz_cpu_down(unsigned int cpu)
 {
 	/*
-	 * The boot CPU handles housekeeping duty (unbound timers,
-	 * workqueues, timekeeping, ...) on behalf of full dynticks
+	 * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
+	 * timers, workqueues, timekeeping, ...) on behalf of full dynticks
 	 * CPUs. It must remain online when nohz full is enabled.
 	 */
 	if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
@@ -423,12 +429,15 @@ void __init tick_nohz_init(void)
 		return;
 	}
 
-	cpu = smp_processor_id();
+	if (IS_ENABLED(CONFIG_PM_SLEEP_SMP) &&
+			!IS_ENABLED(CONFIG_PM_SLEEP_SMP_NONZERO_CPU)) {
+		cpu = smp_processor_id();
 
-	if (cpumask_test_cpu(cpu, tick_nohz_full_mask)) {
-		pr_warn("NO_HZ: Clearing %d from nohz_full range for timekeeping\n",
-			cpu);
-		cpumask_clear_cpu(cpu, tick_nohz_full_mask);
+		if (cpumask_test_cpu(cpu, tick_nohz_full_mask)) {
+			pr_warn("NO_HZ: Clearing %d from nohz_full range "
+				"for timekeeping\n", cpu);
+			cpumask_clear_cpu(cpu, tick_nohz_full_mask);
+		}
 	}
 
 	for_each_cpu(cpu, tick_nohz_full_mask)
@@ -904,8 +913,13 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		/*
 		 * Boot safety: make sure the timekeeping duty has been
 		 * assigned before entering dyntick-idle mode,
+		 * tick_do_timer_cpu is TICK_DO_TIMER_BOOT
 		 */
-		if (tick_do_timer_cpu == TICK_DO_TIMER_NONE)
+		if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_BOOT))
+			return false;
+
+		/* Should not happen for nohz-full */
+		if (WARN_ON_ONCE(tick_do_timer_cpu == TICK_DO_TIMER_NONE))
 			return false;
 	}
 
-- 
2.20.1
