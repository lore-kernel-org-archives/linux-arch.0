From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/4] fix scaled & unscaled cputime accounting
Date: Wed, 08 Oct 2008 18:19:59 +0200
Message-ID: <20081008162144.167670472@de.ibm.com>
References: <20081008161958.767142939@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.17.161]:54859 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbYJHQ3H (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Oct 2008 12:29:07 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.1/8.13.1) with ESMTP id m98GT5Ks010983
	for <linux-arch@vger.kernel.org>; Wed, 8 Oct 2008 16:29:05 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id m98GT5Xl3956740
	for <linux-arch@vger.kernel.org>; Wed, 8 Oct 2008 18:29:05 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m98GT1m2012309
	for <linux-arch@vger.kernel.org>; Wed, 8 Oct 2008 18:29:02 +0200
Content-Disposition: inline; filename=202-cputime-scaled.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Michael Neuling <mikey@neuling.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The utimescaled / stimescaled fields in the task structure and the
global cpustat should be set on all architectures. On s390 the calls
to account_user_time_scaled and account_system_time_scaled never have
been added. In addition system time that is accounted as guest time
to the user time of a process is accounted to the scaled system time
instead of the scaled user time. 
To fix the bugs and to prevent future forgetfulness this patch merges
account_system_time_scaled into account_system_time and
account_user_time_scaled into account_user_time.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/ia64/kernel/time.c     |   12 ++++--------
 arch/powerpc/kernel/time.c  |    7 ++-----
 arch/s390/kernel/vtime.c    |   10 +++++-----
 include/linux/kernel_stat.h |    6 ++----
 kernel/sched.c              |   41 ++++++++++++++++-------------------------
 kernel/time/tick-sched.c    |    5 +++--
 kernel/timer.c              |   12 +++++-------
 7 files changed, 37 insertions(+), 56 deletions(-)

Index: linux-idle/arch/ia64/kernel/time.c
===================================================================
--- linux-idle.orig/arch/ia64/kernel/time.c
+++ linux-idle/arch/ia64/kernel/time.c
@@ -93,13 +93,11 @@ void ia64_account_on_switch(struct task_
 	now = ia64_get_itc();
 
 	delta_stime = cycle_to_cputime(pi->ac_stime + (now - pi->ac_stamp));
-	account_system_time(prev, 0, delta_stime);
-	account_system_time_scaled(prev, delta_stime);
+	account_system_time(prev, 0, delta_stime, delta_stime);
 
 	if (pi->ac_utime) {
 		delta_utime = cycle_to_cputime(pi->ac_utime);
-		account_user_time(prev, delta_utime);
-		account_user_time_scaled(prev, delta_utime);
+		account_user_time(prev, delta_utime, delta_utime);
 	}
 
 	pi->ac_stamp = ni->ac_stamp = now;
@@ -122,8 +120,7 @@ void account_system_vtime(struct task_st
 	now = ia64_get_itc();
 
 	delta_stime = cycle_to_cputime(ti->ac_stime + (now - ti->ac_stamp));
-	account_system_time(tsk, 0, delta_stime);
-	account_system_time_scaled(tsk, delta_stime);
+	account_system_time(tsk, 0, delta_stime, delta_stime);
 	ti->ac_stime = 0;
 
 	ti->ac_stamp = now;
@@ -143,8 +140,7 @@ void account_process_tick(struct task_st
 
 	if (ti->ac_utime) {
 		delta_utime = cycle_to_cputime(ti->ac_utime);
-		account_user_time(p, delta_utime);
-		account_user_time_scaled(p, delta_utime);
+		account_user_time(p, delta_utime, delta_utime);
 		ti->ac_utime = 0;
 	}
 }
Index: linux-idle/arch/powerpc/kernel/time.c
===================================================================
--- linux-idle.orig/arch/powerpc/kernel/time.c
+++ linux-idle/arch/powerpc/kernel/time.c
@@ -258,8 +258,7 @@ void account_system_vtime(struct task_st
 		delta += sys_time;
 		get_paca()->system_time = 0;
 	}
-	account_system_time(tsk, 0, delta);
-	account_system_time_scaled(tsk, deltascaled);
+	account_system_time(tsk, 0, delta, deltascaled);
 	per_cpu(cputime_last_delta, smp_processor_id()) = delta;
 	per_cpu(cputime_scaled_last_delta, smp_processor_id()) = deltascaled;
 	local_irq_restore(flags);
@@ -277,10 +276,8 @@ void account_process_tick(struct task_st
 
 	utime = get_paca()->user_time;
 	get_paca()->user_time = 0;
-	account_user_time(tsk, utime);
-
 	utimescaled = cputime_to_scaled(utime);
-	account_user_time_scaled(tsk, utimescaled);
+	account_user_time(tsk, utime, utimescaled);
 }
 
 /*
Index: linux-idle/arch/s390/kernel/vtime.c
===================================================================
--- linux-idle.orig/arch/s390/kernel/vtime.c
+++ linux-idle/arch/s390/kernel/vtime.c
@@ -51,12 +51,12 @@ void account_process_tick(struct task_st
 	rcu_user_flag = cputime != 0;
 	S390_lowcore.user_timer -= cputime << 12;
 	S390_lowcore.steal_clock -= cputime << 12;
-	account_user_time(tsk, cputime);
+	account_user_time(tsk, cputime, cputime);
 
 	cputime =  S390_lowcore.system_timer >> 12;
 	S390_lowcore.system_timer -= cputime << 12;
 	S390_lowcore.steal_clock -= cputime << 12;
-	account_system_time(tsk, HARDIRQ_OFFSET, cputime);
+	account_system_time(tsk, HARDIRQ_OFFSET, cputime, cputime);
 
 	cputime = S390_lowcore.steal_clock;
 	if ((__s64) cputime > 0) {
@@ -83,12 +83,12 @@ void account_vtime(struct task_struct *t
 	cputime = S390_lowcore.user_timer >> 12;
 	S390_lowcore.user_timer -= cputime << 12;
 	S390_lowcore.steal_clock -= cputime << 12;
-	account_user_time(tsk, cputime);
+	account_user_time(tsk, cputime, cputime);
 
 	cputime =  S390_lowcore.system_timer >> 12;
 	S390_lowcore.system_timer -= cputime << 12;
 	S390_lowcore.steal_clock -= cputime << 12;
-	account_system_time(tsk, 0, cputime);
+	account_system_time(tsk, 0, cputime, cputime);
 }
 
 /*
@@ -108,7 +108,7 @@ void account_system_vtime(struct task_st
 	cputime =  S390_lowcore.system_timer >> 12;
 	S390_lowcore.system_timer -= cputime << 12;
 	S390_lowcore.steal_clock -= cputime << 12;
-	account_system_time(tsk, 0, cputime);
+	account_system_time(tsk, 0, cputime, cputime);
 }
 EXPORT_SYMBOL_GPL(account_system_vtime);
 
Index: linux-idle/include/linux/kernel_stat.h
===================================================================
--- linux-idle.orig/include/linux/kernel_stat.h
+++ linux-idle/include/linux/kernel_stat.h
@@ -52,10 +52,8 @@ static inline int kstat_irqs(int irq)
 	return sum;
 }
 
-extern void account_user_time(struct task_struct *, cputime_t);
-extern void account_user_time_scaled(struct task_struct *, cputime_t);
-extern void account_system_time(struct task_struct *, int, cputime_t);
-extern void account_system_time_scaled(struct task_struct *, cputime_t);
+extern void account_user_time(struct task_struct *, cputime_t, cputime_t);
+extern void account_system_time(struct task_struct *, int, cputime_t, cputime_t);
 extern void account_steal_time(struct task_struct *, cputime_t);
 
 #endif /* _LINUX_KERNEL_STAT_H */
Index: linux-idle/kernel/sched.c
===================================================================
--- linux-idle.orig/kernel/sched.c
+++ linux-idle/kernel/sched.c
@@ -4063,13 +4063,17 @@ unsigned long long task_sched_runtime(st
  * Account user cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @cputime: the cpu time spent in user space since the last update
+ * @cputime_scaled: cputime scaled by cpu frequency
  */
-void account_user_time(struct task_struct *p, cputime_t cputime)
+void account_user_time(struct task_struct *p, cputime_t cputime,
+		       cputime_t cputime_scaled)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	cputime64_t tmp;
 
+	/* Add user time to process. */
 	p->utime = cputime_add(p->utime, cputime);
+	p->utimescaled = cputime_add(p->utimescaled, cputime_scaled);
 
 	/* Add user time to cpustat. */
 	tmp = cputime_to_cputime64(cputime);
@@ -4085,50 +4089,48 @@ void account_user_time(struct task_struc
  * Account guest cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @cputime: the cpu time spent in virtual machine since the last update
+ * @cputime_scaled: cputime scaled by cpu frequency
  */
-static void account_guest_time(struct task_struct *p, cputime_t cputime)
+static void account_guest_time(struct task_struct *p, cputime_t cputime,
+			       cputime_t cputime_scaled)
 {
 	cputime64_t tmp;
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 
 	tmp = cputime_to_cputime64(cputime);
 
+	/* Add guest time to process. */
 	p->utime = cputime_add(p->utime, cputime);
 	p->gtime = cputime_add(p->gtime, cputime);
+	p->utimescaled = cputime_add(p->utimescaled, cputime_scaled);
 
+	/* Add guest time to cpustat. */
 	cpustat->user = cputime64_add(cpustat->user, tmp);
 	cpustat->guest = cputime64_add(cpustat->guest, tmp);
 }
 
 /*
- * Account scaled user cpu time to a process.
- * @p: the process that the cpu time gets accounted to
- * @cputime: the cpu time spent in user space since the last update
- */
-void account_user_time_scaled(struct task_struct *p, cputime_t cputime)
-{
-	p->utimescaled = cputime_add(p->utimescaled, cputime);
-}
-
-/*
  * Account system cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @hardirq_offset: the offset to subtract from hardirq_count()
  * @cputime: the cpu time spent in kernel space since the last update
+ * @cputime_scaled: cputime scaled by cpu frequency
  */
 void account_system_time(struct task_struct *p, int hardirq_offset,
-			 cputime_t cputime)
+			 cputime_t cputime, cputime_t cputime_scaled)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	struct rq *rq = this_rq();
 	cputime64_t tmp;
 
 	if ((p->flags & PF_VCPU) && (irq_count() - hardirq_offset == 0)) {
-		account_guest_time(p, cputime);
+		account_guest_time(p, cputime, cputime_scaled);
 		return;
 	}
 
+	/* Add system time to process. */
 	p->stime = cputime_add(p->stime, cputime);
+	p->stimescaled = cputime_add(p->stimescaled, cputime_scaled);
 
 	/* Add system time to cpustat. */
 	tmp = cputime_to_cputime64(cputime);
@@ -4147,17 +4149,6 @@ void account_system_time(struct task_str
 }
 
 /*
- * Account scaled system cpu time to a process.
- * @p: the process that the cpu time gets accounted to
- * @hardirq_offset: the offset to subtract from hardirq_count()
- * @cputime: the cpu time spent in kernel space since the last update
- */
-void account_system_time_scaled(struct task_struct *p, cputime_t cputime)
-{
-	p->stimescaled = cputime_add(p->stimescaled, cputime);
-}
-
-/*
  * Account for involuntary wait time.
  * @p: the process from which the cpu time has been stolen
  * @steal: the cpu time spent in involuntary wait
Index: linux-idle/kernel/time/tick-sched.c
===================================================================
--- linux-idle.orig/kernel/time/tick-sched.c
+++ linux-idle/kernel/time/tick-sched.c
@@ -378,6 +378,7 @@ void tick_nohz_restart_sched_tick(void)
 	int cpu = smp_processor_id();
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 	unsigned long ticks;
+	cputime_t cputime;
 	ktime_t now;
 
 	local_irq_disable();
@@ -410,8 +411,8 @@ void tick_nohz_restart_sched_tick(void)
 	 */
 	if (ticks && ticks < LONG_MAX) {
 		add_preempt_count(HARDIRQ_OFFSET);
-		account_system_time(current, HARDIRQ_OFFSET,
-				    jiffies_to_cputime(ticks));
+		cputime = jiffies_to_cputime(ticks);
+		account_system_time(current, HARDIRQ_OFFSET, cputime, cputime);
 		sub_preempt_count(HARDIRQ_OFFSET);
 	}
 
Index: linux-idle/kernel/timer.c
===================================================================
--- linux-idle.orig/kernel/timer.c
+++ linux-idle/kernel/timer.c
@@ -954,13 +954,11 @@ void account_process_tick(struct task_st
 {
 	cputime_t one_jiffy = jiffies_to_cputime(1);
 
-	if (user_tick) {
-		account_user_time(p, one_jiffy);
-		account_user_time_scaled(p, cputime_to_scaled(one_jiffy));
-	} else {
-		account_system_time(p, HARDIRQ_OFFSET, one_jiffy);
-		account_system_time_scaled(p, cputime_to_scaled(one_jiffy));
-	}
+	if (user_tick)
+		account_user_time(p, one_jiffy, cputime_to_scaled(one_jiffy));
+	else
+		account_system_time(p, HARDIRQ_OFFSET, one_jiffy,
+				    cputime_to_scaled(one_jiffy));
 }
 #endif
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
