From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/4] idle cputime accounting
Date: Wed, 08 Oct 2008 18:20:00 +0200
Message-ID: <20081008162144.500130264@de.ibm.com>
References: <20081008161958.767142939@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.de.ibm.com ([195.212.17.162]:60270 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYJHQ3I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Oct 2008 12:29:08 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.1/8.13.1) with ESMTP id m98GT6e2015128
	for <linux-arch@vger.kernel.org>; Wed, 8 Oct 2008 16:29:06 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id m98GT6SZ3956742
	for <linux-arch@vger.kernel.org>; Wed, 8 Oct 2008 18:29:06 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m98GT1QX012321
	for <linux-arch@vger.kernel.org>; Wed, 8 Oct 2008 18:29:02 +0200
Content-Disposition: inline; filename=203-cputime-idle.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Michael Neuling <mikey@neuling.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The cpu time spent by the idle process actually doing something is
currently accounted as idle time. This is plain wrong, the architectures
that support VIRT_CPU_ACCOUNTING=y can do better: distinguish between the
time spent doing nothing and the time spent by idle doing work. The first
is accounted with account_steal_time and the second with account_idle_time.
To improve the tick based accounting as well we would need an architecture
primitive that can tell us if the pt_regs of the interrupted context
points to the magic instruction that halts the cpu.

In addition idle time is no more added to the stime of the idle process.
This field now contains the system time of the idle process as it should
be. On systems without VIRT_CPU_ACCOUNTING this will always be zero as
every tick that occurs while idle is running will be accounted as idle
time.

This patch contains the necessary common code changes to be able to
distinguish idle system time and true idle time. The architectures with
support for VIRT_CPU_ACCOUNTING need some changes to exploit this.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/ia64/kernel/time.c     |   10 ++++-
 arch/powerpc/kernel/time.c  |   13 +++++--
 arch/s390/kernel/vtime.c    |   20 ++++++++---
 arch/x86/xen/time.c         |   10 ++---
 include/linux/kernel_stat.h |    7 +++
 include/linux/sched.h       |    1 
 kernel/sched.c              |   80 ++++++++++++++++++++++++++++++++++----------
 kernel/time/tick-sched.c    |   11 ++----
 kernel/timer.c              |   13 -------
 9 files changed, 111 insertions(+), 54 deletions(-)

Index: linux-idle/arch/ia64/kernel/time.c
===================================================================
--- linux-idle.orig/arch/ia64/kernel/time.c
+++ linux-idle/arch/ia64/kernel/time.c
@@ -93,7 +93,10 @@ void ia64_account_on_switch(struct task_
 	now = ia64_get_itc();
 
 	delta_stime = cycle_to_cputime(pi->ac_stime + (now - pi->ac_stamp));
-	account_system_time(prev, 0, delta_stime, delta_stime);
+	if (idle_task(smp_processor_id()) != prev)
+		account_system_time(prev, 0, delta_stime, delta_stime);
+	else
+		account_idle_time(delta_stime);
 
 	if (pi->ac_utime) {
 		delta_utime = cycle_to_cputime(pi->ac_utime);
@@ -120,7 +123,10 @@ void account_system_vtime(struct task_st
 	now = ia64_get_itc();
 
 	delta_stime = cycle_to_cputime(ti->ac_stime + (now - ti->ac_stamp));
-	account_system_time(tsk, 0, delta_stime, delta_stime);
+	if (irq_count() || idle_task(smp_processor_id()) != tsk)
+		account_system_time(tsk, 0, delta_stime, delta_stime);
+	else
+		account_idle_time(delta_stime);
 	ti->ac_stime = 0;
 
 	ti->ac_stamp = now;
Index: linux-idle/arch/powerpc/kernel/time.c
===================================================================
--- linux-idle.orig/arch/powerpc/kernel/time.c
+++ linux-idle/arch/powerpc/kernel/time.c
@@ -258,7 +258,10 @@ void account_system_vtime(struct task_st
 		delta += sys_time;
 		get_paca()->system_time = 0;
 	}
-	account_system_time(tsk, 0, delta, deltascaled);
+	if (in_irq() || idle_task(smp_processor_id()) != tsk)
+		account_system_time(tsk, 0, delta, deltascaled);
+	else
+		account_idle_time(delta);
 	per_cpu(cputime_last_delta, smp_processor_id()) = delta;
 	per_cpu(cputime_scaled_last_delta, smp_processor_id()) = deltascaled;
 	local_irq_restore(flags);
@@ -337,8 +340,12 @@ void calculate_steal_time(void)
 	tb = mftb();
 	purr = mfspr(SPRN_PURR);
 	stolen = (tb - pme->tb) - (purr - pme->purr);
-	if (stolen > 0)
-		account_steal_time(current, stolen);
+	if (stolen > 0) {
+		if (idle_task(smp_processor_id()) != current)
+			account_steal_time(stolen);
+		else
+			account_idle_time(stolen);
+	}
 	pme->tb = tb;
 	pme->purr = purr;
 }
Index: linux-idle/arch/s390/kernel/vtime.c
===================================================================
--- linux-idle.orig/arch/s390/kernel/vtime.c
+++ linux-idle/arch/s390/kernel/vtime.c
@@ -56,13 +56,19 @@ void account_process_tick(struct task_st
 	cputime =  S390_lowcore.system_timer >> 12;
 	S390_lowcore.system_timer -= cputime << 12;
 	S390_lowcore.steal_clock -= cputime << 12;
-	account_system_time(tsk, HARDIRQ_OFFSET, cputime, cputime);
+	if (idle_task(smp_processor_id()) != current)
+		account_system_time(tsk, HARDIRQ_OFFSET, cputime, cputime);
+	else
+		account_idle_time(cputime);
 
 	cputime = S390_lowcore.steal_clock;
 	if ((__s64) cputime > 0) {
 		cputime >>= 12;
 		S390_lowcore.steal_clock -= cputime << 12;
-		account_steal_time(tsk, cputime);
+		if (idle_task(smp_processor_id()) != current)
+			account_steal_time(cputime);
+		else
+			account_idle_time(cputime);
 	}
 }
 
@@ -88,7 +94,10 @@ void account_vtime(struct task_struct *t
 	cputime =  S390_lowcore.system_timer >> 12;
 	S390_lowcore.system_timer -= cputime << 12;
 	S390_lowcore.steal_clock -= cputime << 12;
-	account_system_time(tsk, 0, cputime, cputime);
+	if (idle_task(smp_processor_id()) != current)
+		account_system_time(tsk, 0, cputime, cputime);
+	else
+		account_idle_time(cputime);
 }
 
 /*
@@ -108,7 +117,10 @@ void account_system_vtime(struct task_st
 	cputime =  S390_lowcore.system_timer >> 12;
 	S390_lowcore.system_timer -= cputime << 12;
 	S390_lowcore.steal_clock -= cputime << 12;
-	account_system_time(tsk, 0, cputime, cputime);
+	if (in_irq() || idle_task(smp_processor_id()) != current)
+		account_system_time(tsk, 0, cputime, cputime);
+	else
+		account_idle_time(cputime);
 }
 EXPORT_SYMBOL_GPL(account_system_vtime);
 
Index: linux-idle/arch/x86/xen/time.c
===================================================================
--- linux-idle.orig/arch/x86/xen/time.c
+++ linux-idle/arch/x86/xen/time.c
@@ -134,8 +134,7 @@ static void do_stolen_accounting(void)
 	*snap = state;
 
 	/* Add the appropriate number of ticks of stolen time,
-	   including any left-overs from last time.  Passing NULL to
-	   account_steal_time accounts the time as stolen. */
+	   including any left-overs from last time. */
 	stolen = runnable + offline + __get_cpu_var(residual_stolen);
 
 	if (stolen < 0)
@@ -143,11 +142,10 @@ static void do_stolen_accounting(void)
 
 	ticks = iter_div_u64_rem(stolen, NS_PER_TICK, &stolen);
 	__get_cpu_var(residual_stolen) = stolen;
-	account_steal_time(NULL, ticks);
+	account_steal_ticks(ticks);
 
 	/* Add the appropriate number of ticks of blocked time,
-	   including any left-overs from last time.  Passing idle to
-	   account_steal_time accounts the time as idle/wait. */
+	   including any left-overs from last time. */
 	blocked += __get_cpu_var(residual_blocked);
 
 	if (blocked < 0)
@@ -155,7 +153,7 @@ static void do_stolen_accounting(void)
 
 	ticks = iter_div_u64_rem(blocked, NS_PER_TICK, &blocked);
 	__get_cpu_var(residual_blocked) = blocked;
-	account_steal_time(idle_task(smp_processor_id()), ticks);
+	account_idle_ticks(ticks);
 }
 
 /*
Index: linux-idle/include/linux/kernel_stat.h
===================================================================
--- linux-idle.orig/include/linux/kernel_stat.h
+++ linux-idle/include/linux/kernel_stat.h
@@ -54,6 +54,11 @@ static inline int kstat_irqs(int irq)
 
 extern void account_user_time(struct task_struct *, cputime_t, cputime_t);
 extern void account_system_time(struct task_struct *, int, cputime_t, cputime_t);
-extern void account_steal_time(struct task_struct *, cputime_t);
+extern void account_steal_time(cputime_t);
+extern void account_idle_time(cputime_t);
+
+extern void account_process_tick(struct task_struct *, int user);
+extern void account_steal_ticks(unsigned long ticks);
+extern void account_idle_ticks(unsigned long ticks);
 
 #endif /* _LINUX_KERNEL_STAT_H */
Index: linux-idle/include/linux/sched.h
===================================================================
--- linux-idle.orig/include/linux/sched.h
+++ linux-idle/include/linux/sched.h
@@ -284,7 +284,6 @@ long io_schedule_timeout(long timeout);
 
 extern void cpu_init (void);
 extern void trap_init(void);
-extern void account_process_tick(struct task_struct *task, int user);
 extern void update_process_times(int user);
 extern void scheduler_tick(void);
 extern void hrtick_resched(void);
Index: linux-idle/kernel/sched.c
===================================================================
--- linux-idle.orig/kernel/sched.c
+++ linux-idle/kernel/sched.c
@@ -4120,7 +4120,6 @@ void account_system_time(struct task_str
 			 cputime_t cputime, cputime_t cputime_scaled)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
-	struct rq *rq = this_rq();
 	cputime64_t tmp;
 
 	if ((p->flags & PF_VCPU) && (irq_count() - hardirq_offset == 0)) {
@@ -4138,37 +4137,84 @@ void account_system_time(struct task_str
 		cpustat->irq = cputime64_add(cpustat->irq, tmp);
 	else if (softirq_count())
 		cpustat->softirq = cputime64_add(cpustat->softirq, tmp);
-	else if (p != rq->idle)
-		cpustat->system = cputime64_add(cpustat->system, tmp);
-	else if (atomic_read(&rq->nr_iowait) > 0)
-		cpustat->iowait = cputime64_add(cpustat->iowait, tmp);
 	else
-		cpustat->idle = cputime64_add(cpustat->idle, tmp);
+		cpustat->system = cputime64_add(cpustat->system, tmp);
+
 	/* Account for system time used */
 	acct_update_integrals(p);
 }
 
 /*
  * Account for involuntary wait time.
- * @p: the process from which the cpu time has been stolen
  * @steal: the cpu time spent in involuntary wait
  */
-void account_steal_time(struct task_struct *p, cputime_t steal)
+void account_steal_time(cputime_t cputime)
+{
+	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
+	cputime64_t cputime64 = cputime_to_cputime64(cputime);
+
+	cpustat->steal = cputime64_add(cpustat->steal, cputime64);
+}
+
+/*
+ * Account for idle time.
+ * @cputime: the cpu time spent in idle wait
+ */
+void account_idle_time(cputime_t cputime)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
-	cputime64_t tmp = cputime_to_cputime64(steal);
+	cputime64_t cputime64 = cputime_to_cputime64(cputime);
 	struct rq *rq = this_rq();
 
-	if (p == rq->idle) {
-		p->stime = cputime_add(p->stime, steal);
-		if (atomic_read(&rq->nr_iowait) > 0)
-			cpustat->iowait = cputime64_add(cpustat->iowait, tmp);
-		else
-			cpustat->idle = cputime64_add(cpustat->idle, tmp);
-	} else
-		cpustat->steal = cputime64_add(cpustat->steal, tmp);
+	if (atomic_read(&rq->nr_iowait) > 0)
+		cpustat->iowait = cputime64_add(cpustat->iowait, cputime64);
+	else
+		cpustat->idle = cputime64_add(cpustat->idle, cputime64);
 }
 
+#ifndef CONFIG_VIRT_CPU_ACCOUNTING
+
+/*
+ * Account a single tick of cpu time.
+ * @p: the process that the cpu time gets accounted to
+ * @user_tick: indicates if the tick is a user or a system tick
+ */
+void account_process_tick(struct task_struct *p, int user_tick)
+{
+	cputime_t one_jiffy = jiffies_to_cputime(1);
+	cputime_t one_jiffy_scaled = cputime_to_scaled(one_jiffy);
+	struct rq *rq = this_rq();
+
+	if (user_tick)
+		account_user_time(p, one_jiffy, one_jiffy_scaled);
+	else if (p != rq->idle)
+		account_system_time(p, HARDIRQ_OFFSET, one_jiffy,
+				    one_jiffy_scaled);
+	else
+		account_idle_time(one_jiffy);
+}
+
+/*
+ * Account multiple ticks of steal time.
+ * @p: the process from which the cpu time has been stolen
+ * @ticks: number of stolen ticks
+ */
+void account_steal_ticks(unsigned long ticks)
+{
+	account_steal_time(jiffies_to_cputime(ticks));
+}
+
+/*
+ * Account multiple ticks of idle time.
+ * @ticks: number of stolen ticks
+ */
+void account_idle_ticks(unsigned long ticks)
+{
+	account_idle_time(jiffies_to_cputime(ticks));
+}
+
+#endif
+
 /*
  * Use precise platform statistics if available:
  */
Index: linux-idle/kernel/time/tick-sched.c
===================================================================
--- linux-idle.orig/kernel/time/tick-sched.c
+++ linux-idle/kernel/time/tick-sched.c
@@ -378,7 +378,6 @@ void tick_nohz_restart_sched_tick(void)
 	int cpu = smp_processor_id();
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 	unsigned long ticks;
-	cputime_t cputime;
 	ktime_t now;
 
 	local_irq_disable();
@@ -400,6 +399,7 @@ void tick_nohz_restart_sched_tick(void)
 	tick_do_update_jiffies64(now);
 	cpu_clear(cpu, nohz_cpu_mask);
 
+#ifndef CONFIG_VIRT_CPU_ACCOUNTING
 	/*
 	 * We stopped the tick in idle. Update process times would miss the
 	 * time we slept as update_process_times does only a 1 tick
@@ -409,12 +409,9 @@ void tick_nohz_restart_sched_tick(void)
 	/*
 	 * We might be one off. Do not randomly account a huge number of ticks!
 	 */
-	if (ticks && ticks < LONG_MAX) {
-		add_preempt_count(HARDIRQ_OFFSET);
-		cputime = jiffies_to_cputime(ticks);
-		account_system_time(current, HARDIRQ_OFFSET, cputime, cputime);
-		sub_preempt_count(HARDIRQ_OFFSET);
-	}
+	if (ticks && ticks < LONG_MAX)
+		account_idle_ticks(ticks);
+#endif
 
 	touch_softlockup_watchdog();
 	/*
Index: linux-idle/kernel/timer.c
===================================================================
--- linux-idle.orig/kernel/timer.c
+++ linux-idle/kernel/timer.c
@@ -949,19 +949,6 @@ unsigned long get_next_timer_interrupt(u
 }
 #endif
 
-#ifndef CONFIG_VIRT_CPU_ACCOUNTING
-void account_process_tick(struct task_struct *p, int user_tick)
-{
-	cputime_t one_jiffy = jiffies_to_cputime(1);
-
-	if (user_tick)
-		account_user_time(p, one_jiffy, cputime_to_scaled(one_jiffy));
-	else
-		account_system_time(p, HARDIRQ_OFFSET, one_jiffy,
-				    cputime_to_scaled(one_jiffy));
-}
-#endif
-
 /*
  * Called from the timer interrupt handler to charge one tick to the current
  * process.  user_tick is 1 if the tick is user time, 0 for system.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
