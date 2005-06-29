Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42C24874.8030702@yahoo.com.au>
Date: Wed, 29 Jun 2005 17:06:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Remaining arch problems in cpu_idle
Content-Type: multipart/mixed;
 boundary="------------090409050109040507000508"
To: linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090409050109040507000508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have incorporated all feedback I have had since this was
last put to the list, including some documentation.

h8300, ia64, and sh64 still have possible outstanding issues,
which I've put at the end of the Documentation/ file. It
would be nice to get these looked at.

arm26 and ppc64 could really do with a review of the changes
I have made. parisc to a lesser extent (ie. small change
looks pretty safe).

So again, if you own one of these architectures, please have
a quick look.

Andrew is planning to put the patch in the next -mm (it is
diffed against -mm2).

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.


--------------090409050109040507000508
Content-Type: text/plain;
 name="sched-resched-opt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-resched-opt.patch"

Make some changes to the NEED_RESCHED and POLLING_NRFLAG to reduce
confusion, and make their semantics rigid. Also have preempt explicitly
disabled in idle routines. Improves efficiency of resched_task and some
cpu_idle routines.

* In resched_task:
- TIF_NEED_RESCHED is only cleared with the task's runqueue lock held,
  and as we hold it during resched_task, then there is no need for an
  atomic test and set there. The only other time this should be set is
  when the task's quantum expires, in the timer interrupt - this is
  protected against because the rq lock is irq-safe.

- If TIF_NEED_RESCHED is set, then we don't need to do anything. It
  won't get unset until the task get's schedule()d off.

- If we are running on the same CPU as the task we resched, then set
  TIF_NEED_RESCHED and no further action is required.

- If we are running on another CPU, and TIF_POLLING_NRFLAG is *not* set
  after TIF_NEED_RESCHED has been set, then we need to send an IPI.

Using these rules, we are able to remove the test and set operation in
resched_task, and make clear the previously vague semantics of POLLING_NRFLAG.

* In idle routines:
- Enter cpu_idle with preempt disabled. When the need_resched() condition
  becomes true, explicitly call schedule(). This makes things a bit clearer
  (IMO), but haven't updated all architectures yet.

- Many do a test and clear of TIF_NEED_RESCHED for some reason. According
  to the resched_task rules, this isn't needed (and actually breaks the
  assumption that TIF_NEED_RESCHED is only cleared with the runqueue lock
  held). So remove that. Generally one less locked memory op when switching
  to the idle thread.

- Many idle routines clear TIF_POLLING_NRFLAG, and only set it in the inner
  most polling idle loops. The above resched_task semantics allow it to be
  set until before the last time need_resched() is checked before going into
  a halt requiring interrupt wakeup.

  Many idle routines simply never enter such a halt, and so POLLING_NRFLAG
  can be always left set, completely eliminating resched IPIs when rescheduling
  the idle task.

  POLLING_NRFLAG width can be increased, to reduce the chance of resched IPIs.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-06-29 14:05:48.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-06-29 14:07:05.000000000 +1000
@@ -846,21 +846,28 @@ static void deactivate_task(struct task_
 #ifdef CONFIG_SMP
 static void resched_task(task_t *p)
 {
-	int need_resched, nrpolling;
+	int cpu;
 
 	assert_spin_locked(&task_rq(p)->lock);
 
-	/* minimise the chance of sending an interrupt to poll_idle() */
-	nrpolling = test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
-	need_resched = test_and_set_tsk_thread_flag(p,TIF_NEED_RESCHED);
-	nrpolling |= test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
+	if (unlikely(test_tsk_thread_flag(p, TIF_NEED_RESCHED)))
+		return;
+	
+	set_tsk_thread_flag(p, TIF_NEED_RESCHED);
 
-	if (!need_resched && !nrpolling && (task_cpu(p) != smp_processor_id()))
-		smp_send_reschedule(task_cpu(p));
+	cpu = task_cpu(p);
+	if (cpu == smp_processor_id())
+		return;
+
+	/* NEED_RESCHED must be visible before we test POLLING_NRFLAG */
+	smp_mb();
+	if (!test_tsk_thread_flag(p, TIF_POLLING_NRFLAG))
+		smp_send_reschedule(cpu);
 }
 #else
 static inline void resched_task(task_t *p)
 {
+	assert_spin_locked(&task_rq(p)->lock);
 	set_tsk_need_resched(p);
 }
 #endif
Index: linux-2.6/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/process.c	2005-06-29 14:04:42.000000000 +1000
+++ linux-2.6/arch/i386/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -102,14 +102,22 @@ EXPORT_SYMBOL(enable_hlt);
  */
 void default_idle(void)
 {
+	local_irq_enable();
+
 	if (!hlt_counter && boot_cpu_data.hlt_works_ok) {
-		local_irq_disable();
-		if (!need_resched())
-			safe_halt();
-		else
-			local_irq_enable();
+		clear_thread_flag(TIF_POLLING_NRFLAG);
+		smp_mb__after_clear_bit();
+		while (!need_resched()) {
+			local_irq_disable();
+			if (!need_resched())
+				safe_halt();
+			else
+				local_irq_enable();
+		}
+		set_thread_flag(TIF_POLLING_NRFLAG);
 	} else {
-		cpu_relax();
+		while (!need_resched())
+			cpu_relax();
 	}
 }
 #ifdef CONFIG_APM_MODULE
@@ -123,29 +131,14 @@ EXPORT_SYMBOL(default_idle);
  */
 static void poll_idle (void)
 {
-	int oldval;
-
 	local_irq_enable();
 
-	/*
-	 * Deal with another CPU just having chosen a thread to
-	 * run here:
-	 */
-	oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
-
-	if (!oldval) {
-		set_thread_flag(TIF_POLLING_NRFLAG);
-		asm volatile(
-			"2:"
-			"testl %0, %1;"
-			"rep; nop;"
-			"je 2b;"
-			: : "i"(_TIF_NEED_RESCHED), "m" (current_thread_info()->flags));
-
-		clear_thread_flag(TIF_POLLING_NRFLAG);
-	} else {
-		set_need_resched();
-	}
+	asm volatile(
+		"2:"
+		"testl %0, %1;"
+		"rep; nop;"
+		"je 2b;"
+		: : "i"(_TIF_NEED_RESCHED), "m" (current_thread_info()->flags));
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -182,7 +175,9 @@ static inline void play_dead(void)
  */
 void cpu_idle(void)
 {
-	int cpu = raw_smp_processor_id();
+	int cpu = smp_processor_id();
+
+	set_thread_flag(TIF_POLLING_NRFLAG);
 
 	/* endless idle loop with no priority at all */
 	while (1) {
@@ -204,7 +199,9 @@ void cpu_idle(void)
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
@@ -247,15 +244,12 @@ static void mwait_idle(void)
 {
 	local_irq_enable();
 
-	if (!need_resched()) {
-		set_thread_flag(TIF_POLLING_NRFLAG);
-		do {
-			__monitor((void *)&current_thread_info()->flags, 0, 0);
-			if (need_resched())
-				break;
-			__mwait(0, 0);
-		} while (!need_resched());
-		clear_thread_flag(TIF_POLLING_NRFLAG);
+	while (!need_resched()) {
+		__monitor((void *)&current_thread_info()->flags, 0, 0);
+		smp_mb();
+		if (need_resched())
+			break;
+		__mwait(0, 0);
 	}
 }
 
Index: linux-2.6/init/main.c
===================================================================
--- linux-2.6.orig/init/main.c	2005-06-29 14:05:48.000000000 +1000
+++ linux-2.6/init/main.c	2005-06-29 14:07:42.000000000 +1000
@@ -382,14 +382,16 @@ static void noinline rest_init(void)
 	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
 	numa_default_policy();
 	unlock_kernel();
-	preempt_enable_no_resched();
 
 	/*
 	 * The boot idle thread must execute schedule()
 	 * at least one to get things moving:
 	 */
+	preempt_enable_no_resched();
 	schedule();
+	preempt_disable();
 
+	/* Call into cpu_idle with preempt disabled */
 	cpu_idle();
 } 
 
Index: linux-2.6/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/apm.c	2005-06-29 14:04:41.000000000 +1000
+++ linux-2.6/arch/i386/kernel/apm.c	2005-06-29 14:07:05.000000000 +1000
@@ -767,8 +767,26 @@ static int set_system_power_state(u_shor
 static int apm_do_idle(void)
 {
 	u32	eax;
+	u8	ret;
+	int	idled = 0;
+	int	polling;
+
+	polling = test_thread_flag(TIF_POLLING_NRFLAG);
+	if (polling) {
+		clear_thread_flag(TIF_POLLING_NRFLAG);
+		smp_mb__after_clear_bit();
+	}
+	if (!need_resched()) {
+		idled = 1;
+		ret = apm_bios_call_simple(APM_FUNC_IDLE, 0, 0, &eax);
+	}
+	if (polling)
+		set_thread_flag(TIF_POLLING_NRFLAG);
+
+	if (!idled)
+		return 0;
 
-	if (apm_bios_call_simple(APM_FUNC_IDLE, 0, 0, &eax)) {
+	if (ret) {
 		static unsigned long t;
 
 		/* This always fails on some SMP boards running UP kernels.
Index: linux-2.6/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_idle.c	2005-06-29 14:04:53.000000000 +1000
+++ linux-2.6/drivers/acpi/processor_idle.c	2005-06-29 14:07:05.000000000 +1000
@@ -162,6 +162,18 @@ acpi_processor_power_activate (
 	return;
 }
 
+static void acpi_safe_halt (void)
+{
+	int polling = test_thread_flag(TIF_POLLING_NRFLAG);
+	if (polling) {
+		clear_thread_flag(TIF_POLLING_NRFLAG);
+		smp_mb__after_clear_bit();
+	}
+	if (!need_resched())
+		safe_halt();
+	if (polling)
+		set_thread_flag(TIF_POLLING_NRFLAG);
+}
 
 static void acpi_processor_idle (void)
 {
@@ -171,7 +183,7 @@ static void acpi_processor_idle (void)
 	int			sleep_ticks = 0;
 	u32			t1, t2 = 0;
 
-	pr = processors[raw_smp_processor_id()];
+	pr = processors[smp_processor_id()];
 	if (!pr)
 		return;
 
@@ -191,8 +203,13 @@ static void acpi_processor_idle (void)
 	}
 
 	cx = pr->power.state;
-	if (!cx)
-		goto easy_out;
+	if (!cx) {
+		if (pm_idle_save)
+			pm_idle_save();
+		else
+			acpi_safe_halt();
+		return;
+	}
 
 	/*
 	 * Check BM Activity
@@ -272,7 +289,8 @@ static void acpi_processor_idle (void)
 		if (pm_idle_save)
 			pm_idle_save();
 		else
-			safe_halt();
+			acpi_safe_halt();
+
 		/*
                  * TBD: Can't get time duration while in C1, as resumes
 		 *      go to an ISR rather than here.  Need to instrument
@@ -384,16 +402,6 @@ end:
 	 */
 	if (next_state != pr->power.state)
 		acpi_processor_power_activate(pr, next_state);
-
-	return;
-
- easy_out:
-	/* do C1 instead of busy loop */
-	if (pm_idle_save)
-		pm_idle_save();
-	else
-		safe_halt();
-	return;
 }
 
 
Index: linux-2.6/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/smpboot.c	2005-06-29 14:04:42.000000000 +1000
+++ linux-2.6/arch/i386/kernel/smpboot.c	2005-06-29 14:07:05.000000000 +1000
@@ -476,6 +476,8 @@ set_cpu_sibling_map(int cpu)
  */
 static void __devinit start_secondary(void *unused)
 {
+	preempt_disable();
+
 	/*
 	 * Dont put anything before smp_callin(), SMP
 	 * booting is too fragile that we want to limit the
Index: linux-2.6/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/x86_64/kernel/process.c	2005-06-29 14:04:48.000000000 +1000
+++ linux-2.6/arch/x86_64/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -88,12 +88,22 @@ EXPORT_SYMBOL(enable_hlt);
  */
 void default_idle(void)
 {
+	local_irq_enable();
+
 	if (!atomic_read(&hlt_counter)) {
-		local_irq_disable();
-		if (!need_resched())
-			safe_halt();
-		else
-			local_irq_enable();
+		clear_thread_flag(TIF_POLLING_NRFLAG);
+		smp_mb__after_clear_bit();
+		while (!need_resched()) {
+			local_irq_disable();
+			if (!need_resched())
+				safe_halt();
+			else
+				local_irq_enable();
+		}
+		set_thread_flag(TIF_POLLING_NRFLAG);
+	} else {
+		while (!need_resched())
+			cpu_relax();
 	}
 }
 
@@ -104,29 +114,16 @@ void default_idle(void)
  */
 static void poll_idle (void)
 {
-	int oldval;
-
 	local_irq_enable();
 
-	/*
-	 * Deal with another CPU just having chosen a thread to
-	 * run here:
-	 */
-	oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
-
-	if (!oldval) {
-		set_thread_flag(TIF_POLLING_NRFLAG); 
-		asm volatile(
-			"2:"
-			"testl %0,%1;"
-			"rep; nop;"
-			"je 2b;"
-			: :
-			"i" (_TIF_NEED_RESCHED), 
-			"m" (current_thread_info()->flags));
-	} else {
-		set_need_resched();
-	}
+	asm volatile(
+		"2:"
+		"testl %0,%1;"
+		"rep; nop;"
+		"je 2b;"
+		: :
+		"i" (_TIF_NEED_RESCHED), 
+		"m" (current_thread_info()->flags));
 }
 
 void cpu_idle_wait(void)
@@ -188,6 +185,8 @@ static inline void play_dead(void)
  */
 void cpu_idle (void)
 {
+	set_thread_flag(TIF_POLLING_NRFLAG);
+
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
@@ -205,7 +204,9 @@ void cpu_idle (void)
 			idle();
 		}
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
@@ -220,15 +221,12 @@ static void mwait_idle(void)
 {
 	local_irq_enable();
 
-	if (!need_resched()) {
-		set_thread_flag(TIF_POLLING_NRFLAG);
-		do {
-			__monitor((void *)&current_thread_info()->flags, 0, 0);
-			if (need_resched())
-				break;
-			__mwait(0, 0);
-		} while (!need_resched());
-		clear_thread_flag(TIF_POLLING_NRFLAG);
+	while (!need_resched()) {
+		__monitor((void *)&current_thread_info()->flags, 0, 0);
+		smp_mb();
+		if (need_resched())
+			break;
+		__mwait(0, 0);
 	}
 }
 
Index: linux-2.6/arch/ppc64/kernel/idle.c
===================================================================
--- linux-2.6.orig/arch/ppc64/kernel/idle.c	2005-06-29 14:04:44.000000000 +1000
+++ linux-2.6/arch/ppc64/kernel/idle.c	2005-06-29 14:07:05.000000000 +1000
@@ -79,7 +79,8 @@ static void yield_shared_processor(void)
 static int iSeries_idle(void)
 {
 	struct paca_struct *lpaca;
-	long oldval;
+
+	set_thread_flag(TIF_POLLING_NRFLAG);
 
 	/* ensure iSeries run light will be out when idle */
 	ppc64_runlatch_off();
@@ -87,33 +88,23 @@ static int iSeries_idle(void)
 	lpaca = get_paca();
 
 	while (1) {
-		if (lpaca->lppaca.shared_proc) {
-			if (ItLpQueue_isLpIntPending(lpaca->lpqueue_ptr))
-				process_iSeries_events();
-			if (!need_resched())
-				yield_shared_processor();
-		} else {
-			oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
-
-			if (!oldval) {
-				set_thread_flag(TIF_POLLING_NRFLAG);
-
-				while (!need_resched()) {
-					HMT_medium();
-					if (ItLpQueue_isLpIntPending(lpaca->lpqueue_ptr))
-						process_iSeries_events();
-					HMT_low();
-				}
-
+		while (!need_resched()) {
+			HMT_low();
+			if (ItLpQueue_isLpIntPending(lpaca->lpqueue_ptr)) {
 				HMT_medium();
-				clear_thread_flag(TIF_POLLING_NRFLAG);
-			} else {
-				set_need_resched();
+				process_iSeries_events();
+				HMT_low();
 			}
+			if (lpaca->lppaca.shared_proc)
+				yield_shared_processor();
 		}
 
+		HMT_medium();
+
 		ppc64_runlatch_on();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		ppc64_runlatch_off();
 	}
 
@@ -124,32 +115,24 @@ static int iSeries_idle(void)
 
 static int default_idle(void)
 {
-	long oldval;
 	unsigned int cpu = smp_processor_id();
-
+	set_thread_flag(TIF_POLLING_NRFLAG);
+	
 	while (1) {
-		oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
-
-		if (!oldval) {
-			set_thread_flag(TIF_POLLING_NRFLAG);
-
-			while (!need_resched() && !cpu_is_offline(cpu)) {
-				barrier();
-				/*
-				 * Go into low thread priority and possibly
-				 * low power mode.
-				 */
-				HMT_low();
-				HMT_very_low();
-			}
-
-			HMT_medium();
-			clear_thread_flag(TIF_POLLING_NRFLAG);
-		} else {
-			set_need_resched();
+		while (!need_resched() && !cpu_is_offline(cpu)) {
+			barrier();
+			/*
+			 * Go into low thread priority and possibly
+			 * low power mode.
+			 */
+			HMT_low();
+			HMT_very_low();
 		}
+		HMT_medium();
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
 			cpu_die();
 	}
@@ -163,12 +146,12 @@ DECLARE_PER_CPU(unsigned long, smt_snooz
 
 int dedicated_idle(void)
 {
-	long oldval;
 	struct paca_struct *lpaca = get_paca(), *ppaca;
 	unsigned long start_snooze;
 	unsigned long *smt_snooze_delay = &__get_cpu_var(smt_snooze_delay);
 	unsigned int cpu = smp_processor_id();
 
+	set_thread_flag(TIF_POLLING_NRFLAG);
 	ppaca = &paca[cpu ^ 1];
 
 	while (1) {
@@ -178,66 +161,67 @@ int dedicated_idle(void)
 		 */
 		lpaca->lppaca.idle = 1;
 
-		oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
-		if (!oldval) {
-			set_thread_flag(TIF_POLLING_NRFLAG);
-			start_snooze = __get_tb() +
+		start_snooze = __get_tb() +
 				*smt_snooze_delay * tb_ticks_per_usec;
-			while (!need_resched() && !cpu_is_offline(cpu)) {
-				/*
-				 * Go into low thread priority and possibly
-				 * low power mode.
-				 */
-				HMT_low();
-				HMT_very_low();
 
-				if (*smt_snooze_delay == 0 ||
-				    __get_tb() < start_snooze)
-					continue;
+		while (!need_resched() && !cpu_is_offline(cpu)) {
+			/*
+			 * Go into low thread priority and possibly
+			 * low power mode.
+			 */
+			HMT_low();
+			HMT_very_low();
 
-				HMT_medium();
+			if (*smt_snooze_delay == 0 || __get_tb() < start_snooze)
+				continue;
 
-				if (!(ppaca->lppaca.idle)) {
-					local_irq_disable();
+			HMT_medium();
 
-					/*
-					 * We are about to sleep the thread
-					 * and so wont be polling any
-					 * more.
-					 */
-					clear_thread_flag(TIF_POLLING_NRFLAG);
-
-					/*
-					 * SMT dynamic mode. Cede will result
-					 * in this thread going dormant, if the
-					 * partner thread is still doing work.
-					 * Thread wakes up if partner goes idle,
-					 * an interrupt is presented, or a prod
-					 * occurs.  Returning from the cede
-					 * enables external interrupts.
-					 */
-					if (!need_resched())
-						cede_processor();
-					else
-						local_irq_enable();
-				} else {
-					/*
-					 * Give the HV an opportunity at the
-					 * processor, since we are not doing
-					 * any work.
-					 */
-					poll_pending();
-				}
-			}
+			if (!(ppaca->lppaca.idle)) {
+				local_irq_disable();
 
-			clear_thread_flag(TIF_POLLING_NRFLAG);
-		} else {
-			set_need_resched();
+				/*
+				 * We are about to sleep the thread
+				 * and so wont be polling any
+				 * more.
+				 */
+				clear_thread_flag(TIF_POLLING_NRFLAG);
+
+				/* 
+				 * Must have TIF_POLLING_NRFLAG clear visible
+				 * before checking need_resched
+				 */
+				smp_mb__after_clear_bit();
+
+				/*
+				 * SMT dynamic mode. Cede will result
+				 * in this thread going dormant, if the
+				 * partner thread is still doing work.
+				 * Thread wakes up if partner goes idle,
+				 * an interrupt is presented, or a prod
+				 * occurs.  Returning from the cede
+				 * enables external interrupts.
+				 */
+				if (!need_resched())
+					cede_processor();
+				else
+					local_irq_enable();
+				set_thread_flag(TIF_POLLING_NRFLAG);
+			} else {
+				/*
+				 * Give the HV an opportunity at the
+				 * processor, since we are not doing
+				 * any work.
+				 */
+				poll_pending();
+			}
 		}
 
 		HMT_medium();
 		lpaca->lppaca.idle = 0;
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
 			cpu_die();
 	}
@@ -248,6 +232,7 @@ static int shared_idle(void)
 {
 	struct paca_struct *lpaca = get_paca();
 	unsigned int cpu = smp_processor_id();
+	set_thread_flag(TIF_POLLING_NRFLAG);
 
 	while (1) {
 		/*
@@ -259,6 +244,9 @@ static int shared_idle(void)
 		while (!need_resched() && !cpu_is_offline(cpu)) {
 			local_irq_disable();
 
+			clear_thread_flag(TIF_POLLING_NRFLAG);
+			smp_mb__after_clear_bit();
+
 			/*
 			 * Yield the processor to the hypervisor.  We return if
 			 * an external interrupt occurs (which are driven prior
@@ -273,11 +261,14 @@ static int shared_idle(void)
 				cede_processor();
 			else
 				local_irq_enable();
+			set_thread_flag(TIF_POLLING_NRFLAG);
 		}
 
 		HMT_medium();
 		lpaca->lppaca.idle = 0;
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		if (cpu_is_offline(smp_processor_id()) &&
 		    system_state == SYSTEM_RUNNING)
 			cpu_die();
@@ -292,10 +283,12 @@ static int native_idle(void)
 {
 	while(1) {
 		/* check CPU type here */
-		if (!need_resched())
+		while (!need_resched())
 			power4_idle();
-		if (need_resched())
-			schedule();
+
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
 
 		if (cpu_is_offline(raw_smp_processor_id()) &&
 		    system_state == SYSTEM_RUNNING)
Index: linux-2.6/arch/ia64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/process.c	2005-06-29 14:04:43.000000000 +1000
+++ linux-2.6/arch/ia64/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -196,11 +196,16 @@ update_pal_halt_status(int status)
 void
 default_idle (void)
 {
-	while (!need_resched())
-		if (can_do_pal_halt)
+	if (can_do_pal_halt) {
+		clear_thread_flag(TIF_POLLING_NRFLAG);
+		smp_mb__after_clear_bit();
+		while (!need_resched())
 			safe_halt();
-		else
+		set_thread_flag(TIF_POLLING_NRFLAG);
+	} else {
+		while (!need_resched())
 			cpu_relax();
+	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -262,16 +267,16 @@ void __attribute__((noreturn))
 cpu_idle (void)
 {
 	void (*mark_idle)(int) = ia64_mark_idle;
+  	int cpu = smp_processor_id();
+	set_thread_flag(TIF_POLLING_NRFLAG);
 
 	/* endless idle loop with no priority at all */
 	while (1) {
+		if (!need_resched()) {
+			void (*idle)(void);
 #ifdef CONFIG_SMP
-		if (!need_resched())
 			min_xtp();
 #endif
-		while (!need_resched()) {
-			void (*idle)(void);
-
 			if (__get_cpu_var(cpu_idle_state))
 				__get_cpu_var(cpu_idle_state) = 0;
 
@@ -283,17 +288,17 @@ cpu_idle (void)
 			if (!idle)
 				idle = default_idle;
 			(*idle)();
-		}
-
-		if (mark_idle)
-			(*mark_idle)(0);
-
+			if (mark_idle)
+				(*mark_idle)(0);
 #ifdef CONFIG_SMP
-		normal_xtp();
+			normal_xtp();
 #endif
+		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		check_pgt_cache();
-		if (cpu_is_offline(smp_processor_id()))
+		if (cpu_is_offline(cpu))
 			play_dead();
 	}
 }
Index: linux-2.6/arch/ia64/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/smpboot.c	2005-06-29 14:04:43.000000000 +1000
+++ linux-2.6/arch/ia64/kernel/smpboot.c	2005-06-29 14:07:05.000000000 +1000
@@ -394,6 +394,8 @@ smp_callin (void)
 int __devinit
 start_secondary (void *unused)
 {
+	preempt_disable();
+
 	/* Early console may use I/O ports */
 	ia64_set_kr(IA64_KR_IO_BASE, __pa(ia64_iobase));
 	Dprintk("start_secondary: starting CPU 0x%x\n", hard_smp_processor_id());
Index: linux-2.6/arch/ppc64/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/ppc64/kernel/smp.c	2005-06-29 14:04:44.000000000 +1000
+++ linux-2.6/arch/ppc64/kernel/smp.c	2005-06-29 14:07:05.000000000 +1000
@@ -560,7 +560,10 @@ int __devinit __cpu_up(unsigned int cpu)
 /* Activate a secondary processor. */
 int __devinit start_secondary(void *unused)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
+	
+	preempt_disable();
+	cpu = smp_processor_id();
 
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
Index: linux-2.6/arch/sparc64/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/sparc64/kernel/smp.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/sparc64/kernel/smp.c	2005-06-29 14:07:05.000000000 +1000
@@ -147,6 +147,9 @@ void __init smp_callin(void)
 		membar("#LoadLoad");
 
 	cpu_set(cpuid, cpu_online_map);
+
+	/* idle thread is expected to have preempt disabled */
+	preempt_disable();
 }
 
 void cpu_panic(void)
@@ -1170,20 +1173,9 @@ void __init smp_cpus_done(unsigned int m
 	       (bogosum/(5000/HZ))%100);
 }
 
-/* This needn't do anything as we do not sleep the cpu
- * inside of the idler task, so an interrupt is not needed
- * to get a clean fast response.
- *
- * XXX Reverify this assumption... -DaveM
- *
- * Addendum: We do want it to do something for the signal
- *           delivery case, we detect that by just seeing
- *           if we are trying to send this to an idler or not.
- */
 void smp_send_reschedule(int cpu)
 {
-	if (cpu_data(cpu).idle_volume == 0)
-		smp_receive_signal(cpu);
+	smp_receive_signal(cpu);
 }
 
 /* This is a nop because we capture all other cpus
Index: linux-2.6/arch/sparc64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/sparc64/kernel/process.c	2005-06-29 14:04:46.000000000 +1000
+++ linux-2.6/arch/sparc64/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -74,7 +74,9 @@ void cpu_idle(void)
 		while (!need_resched())
 			barrier();
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		check_pgt_cache();
 	}
 }
@@ -83,21 +85,31 @@ void cpu_idle(void)
 
 /*
  * the idle loop on a UltraMultiPenguin...
+ * 
+ * TIF_POLLING_NRFLAG is set because we do not sleep the cpu
+ * inside of the idler task, so an interrupt is not needed
+ * to get a clean fast response.
+ *
+ * XXX Reverify this assumption... -DaveM
+ *
+ * Addendum: We do want it to do something for the signal
+ *           delivery case, we detect that by just seeing
+ *           if we are trying to send this to an idler or not.
  */
-#define idle_me_harder()	(cpu_data(smp_processor_id()).idle_volume += 1)
-#define unidle_me()		(cpu_data(smp_processor_id()).idle_volume = 0)
 void cpu_idle(void)
 {
+	cpuinfo_sparc *cpuinfo = &local_cpu_data();
 	set_thread_flag(TIF_POLLING_NRFLAG);
+
 	while(1) {
 		if (need_resched()) {
-			unidle_me();
-			clear_thread_flag(TIF_POLLING_NRFLAG);
+			cpuinfo->idle_volume = 0;
+			preempt_enable_no_resched();
 			schedule();
-			set_thread_flag(TIF_POLLING_NRFLAG);
+			preempt_disable();
 			check_pgt_cache();
 		}
-		idle_me_harder();
+		cpuinfo->idle_volume++;
 
 		/* The store ordering is so that IRQ handlers on
 		 * other cpus see our increasing idleness for the buddy
Index: linux-2.6/arch/alpha/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/alpha/kernel/process.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/alpha/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -43,21 +43,17 @@
 #include "proto.h"
 #include "pci_impl.h"
 
-void default_idle(void)
-{
-	barrier();
-}
-
 void
 cpu_idle(void)
 {
+	set_thread_flag(TIF_POLLING_NRFLAG);
+	
 	while (1) {
-		void (*idle)(void) = default_idle;
 		/* FIXME -- EV6 and LCA45 know how to power down
 		   the CPU.  */
 
 		while (!need_resched())
-			idle();
+			cpu_relax();
 		schedule();
 	}
 }
Index: linux-2.6/arch/alpha/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/alpha/kernel/smp.c	2005-06-29 14:04:40.000000000 +1000
+++ linux-2.6/arch/alpha/kernel/smp.c	2005-06-29 14:07:05.000000000 +1000
@@ -128,7 +128,9 @@ wait_boot_cpu_to_stop(int cpuid)
 void __init
 smp_callin(void)
 {
-	int cpuid = hard_smp_processor_id();
+	int cpuid;
+	
+	cpuid = hard_smp_processor_id();
 
 	if (cpu_test_and_set(cpuid, cpu_online_map)) {
 		printk("??, cpu 0x%x already present??\n", cpuid);
Index: linux-2.6/arch/s390/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/smp.c	2005-06-29 14:04:46.000000000 +1000
+++ linux-2.6/arch/s390/kernel/smp.c	2005-06-29 14:07:05.000000000 +1000
@@ -528,6 +528,8 @@ extern void pfault_fini(void);
 
 int __devinit start_secondary(void *cpuvoid)
 {
+	preempt_disable();
+
         /* Setup the cpu */
         cpu_init();
         /* init per CPU timer */
Index: linux-2.6/arch/sparc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/process.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/sparc/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -67,13 +67,6 @@ extern void fpsave(unsigned long *, unsi
 struct task_struct *last_task_used_math = NULL;
 struct thread_info *current_set[NR_CPUS];
 
-/*
- * default_idle is new in 2.5. XXX Review, currently stolen from sparc64.
- */
-void default_idle(void)
-{
-}
-
 #ifndef CONFIG_SMP
 
 #define SUN4C_FAULT_HIGH 100
@@ -92,12 +85,11 @@ void cpu_idle(void)
 			static unsigned long fps;
 			unsigned long now;
 			unsigned long faults;
-			unsigned long flags;
 
 			extern unsigned long sun4c_kernel_faults;
 			extern void sun4c_grow_kernel_ring(void);
 
-			local_irq_save(flags);
+			local_irq_disable();
 			now = jiffies;
 			count -= (now - last_jiffies);
 			last_jiffies = now;
@@ -113,14 +105,19 @@ void cpu_idle(void)
 					sun4c_grow_kernel_ring();
 				}
 			}
-			local_irq_restore(flags);
+			local_irq_enable();
 		}
 
-		while((!need_resched()) && pm_idle) {
-			(*pm_idle)();
+		if (pm_idle) {
+			while (!need_resched())
+				(*pm_idle)();
+		} else {
+			while (!need_resched())
+				cpu_relax();
 		}
-
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		check_pgt_cache();
 	}
 }
@@ -130,13 +127,15 @@ void cpu_idle(void)
 /* This is being executed in task 0 'user space'. */
 void cpu_idle(void)
 {
+        set_thread_flag(TIF_POLLING_NRFLAG);
 	/* endless idle loop with no priority at all */
 	while(1) {
-		if(need_resched()) {
-			schedule();
-			check_pgt_cache();
-		}
-		barrier(); /* or else gcc optimizes... */
+		while (!need_resched())
+			cpu_relax();
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+		check_pgt_cache();
 	}
 }
 
Index: linux-2.6/arch/ppc/kernel/idle.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/idle.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/ppc/kernel/idle.c	2005-06-29 14:07:05.000000000 +1000
@@ -50,8 +50,6 @@ void default_idle(void)
 		}
 #endif
 	}
-	if (need_resched())
-		schedule();
 }
 
 /*
@@ -59,11 +57,18 @@ void default_idle(void)
  */
 void cpu_idle(void)
 {
-	for (;;)
-		if (ppc_md.idle != NULL)
-			ppc_md.idle();
-		else
-			default_idle();
+	for (;;) {
+		while (need_resched()) {
+			if (ppc_md.idle != NULL)
+				ppc_md.idle();
+			else
+				default_idle();
+		}
+
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+	}
 }
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_6xx)
Index: linux-2.6/arch/m32r/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/m32r/kernel/process.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/m32r/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -104,7 +104,9 @@ void cpu_idle (void)
 
 			idle();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/frv/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/frv/kernel/process.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/frv/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -77,16 +77,20 @@ void (*idle)(void) = core_sleep_idle;
  */
 void cpu_idle(void)
 {
+	int cpu = smp_processor_id();
+	
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
-			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
+			irq_stat[cpu].idle_timestamp = jiffies;
 
 			if (!frv_dma_inprogress && idle)
 				idle();
 		}
-
+		
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/cris/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/cris/kernel/process.c	2005-06-29 14:04:41.000000000 +1000
+++ linux-2.6/arch/cris/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -217,7 +217,9 @@ void cpu_idle (void)
 				idle = default_idle;
 			idle();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/mips/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/smp.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/mips/kernel/smp.c	2005-06-29 14:07:05.000000000 +1000
@@ -83,7 +83,11 @@ extern ATTRIB_NORET void cpu_idle(void);
  */
 asmlinkage void start_secondary(void)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
+
+	preempt_disable();
+	
+	cpu = smp_processor_id();
 
 	cpu_probe();
 	cpu_report();
Index: linux-2.6/arch/parisc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/process.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/parisc/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -88,11 +88,15 @@ void default_idle(void)
  */
 void cpu_idle(void)
 {
+	set_thread_flag(TIF_POLLING_NRFLAG);
+	
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched())
 			barrier();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		check_pgt_cache();
 	}
 }
Index: linux-2.6/arch/ppc/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/smp.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/ppc/kernel/smp.c	2005-06-29 14:07:05.000000000 +1000
@@ -326,6 +326,8 @@ int __devinit start_secondary(void *unus
 {
 	int cpu;
 
+	preempt_disable();
+
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
 
Index: linux-2.6/arch/sh/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/sh/kernel/process.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/sh/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -51,28 +51,24 @@ void enable_hlt(void)
 
 EXPORT_SYMBOL(enable_hlt);
 
-void default_idle(void)
+void cpu_idle(void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
 		if (hlt_counter) {
-			while (1)
-				if (need_resched())
-					break;
+			while (!need_resched())
+				cpu_relax();
 		} else {
 			while (!need_resched())
 				cpu_sleep();
 		}
 
+		preempt_disable_no_resched();
 		schedule();
+		preempt_enable();
 	}
 }
 
-void cpu_idle(void)
-{
-	default_idle();
-}
-
 void machine_restart(char * __unused)
 {
 	/* SR.BL=1 and invoke address error to let CPU reset (manual reset) */
Index: linux-2.6/arch/m68k/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/process.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/m68k/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -102,7 +102,9 @@ void cpu_idle(void)
 	while (1) {
 		while (!need_resched())
 			idle();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/mips/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/process.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/mips/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -58,7 +58,9 @@ ATTRIB_NORET void cpu_idle(void)
 		while (!need_resched())
 			if (cpu_wait)
 				(*cpu_wait)();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable()
 	}
 }
 
Index: linux-2.6/arch/sh/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/sh/kernel/smp.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/sh/kernel/smp.c	2005-06-29 14:07:05.000000000 +1000
@@ -109,7 +109,11 @@ int __cpu_up(unsigned int cpu)
 
 int start_secondary(void *unused)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
+	
+	preempt_disable();
+	
+	cpu = smp_processor_id();
 
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
Index: linux-2.6/arch/parisc/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/smp.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/parisc/kernel/smp.c	2005-06-29 14:07:05.000000000 +1000
@@ -462,6 +462,8 @@ void __init smp_callin(void)
 	void *istack;
 #endif
 
+	preempt_disable();
+
 	smp_cpu_init(slave_id);
 
 #if 0	/* NOT WORKING YET - see entry.S */
Index: linux-2.6/arch/m32r/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/m32r/kernel/smpboot.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/m32r/kernel/smpboot.c	2005-06-29 14:07:05.000000000 +1000
@@ -424,6 +424,7 @@ void __init smp_cpus_done(unsigned int m
  *==========================================================================*/
 int __init start_secondary(void *unused)
 {
+	preempt_disable();
 	cpu_init();
 	smp_callin();
 	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
Index: linux-2.6/arch/s390/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/process.c	2005-06-29 14:04:46.000000000 +1000
+++ linux-2.6/arch/s390/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -99,15 +99,15 @@ void default_idle(void)
 {
 	int cpu, rc;
 
+	/* CPU is going idle. */
+	cpu = smp_processor_id();
+
 	local_irq_disable();
-        if (need_resched()) {
+	if (need_resched()) {
 		local_irq_enable();
-                schedule();
-                return;
-        }
+		return;
+	}
 
-	/* CPU is going idle. */
-	cpu = smp_processor_id();
 	rc = notifier_call_chain(&idle_chain, CPU_IDLE, (void *)(long) cpu);
 	if (rc != NOTIFY_OK && rc != NOTIFY_DONE)
 		BUG();
@@ -120,7 +120,7 @@ void default_idle(void)
 	__ctl_set_bit(8, 15);
 
 #ifdef CONFIG_HOTPLUG_CPU
-	if (cpu_is_offline(smp_processor_id()))
+	if (cpu_is_offline(cpu))
 		cpu_die();
 #endif
 
@@ -139,8 +139,13 @@ void default_idle(void)
 
 void cpu_idle(void)
 {
-	for (;;)
-		default_idle();
+	for (;;) {
+		while (!need_resched())
+			default_idle();
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+	}
 }
 
 void show_regs(struct pt_regs *regs)
Index: linux-2.6/arch/sh64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/sh64/kernel/process.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/sh64/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -307,23 +307,19 @@ __setup("hlt", hlt_setup);
 
 static inline void hlt(void)
 {
-	if (hlt_counter)
-		return;
-
 	__asm__ __volatile__ ("sleep" : : : "memory");
 }
 
 /*
  * The idle loop on a uniprocessor SH..
  */
-void default_idle(void)
+void cpu_idle(void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
 		if (hlt_counter) {
-			while (1)
-				if (need_resched())
-					break;
+			while (!need_resched())
+				cpu_relax();
 		} else {
 			local_irq_disable();
 			while (!need_resched()) {
@@ -334,13 +330,11 @@ void default_idle(void)
 			}
 			local_irq_enable();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
-}
 
-void cpu_idle(void)
-{
-	default_idle();
 }
 
 void machine_restart(char * __unused)
Index: linux-2.6/arch/arm26/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/arm26/kernel/process.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/arm26/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -74,15 +74,13 @@ __setup("hlt", hlt_setup);
 void cpu_idle(void)
 {
 	/* endless idle loop with no priority at all */
-	preempt_disable();
 	while (1) {
-		while (!need_resched()) {
-			local_irq_disable();
-			if (!need_resched() && !hlt_counter)
-				local_irq_enable();
-		}
+		while (!need_resched())
+			cpu_relax();
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
 	}
-	schedule();
 }
 
 static char reboot_mode = 'h';
Index: linux-2.6/arch/arm/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/process.c	2005-06-29 14:03:05.000000000 +1000
+++ linux-2.6/arch/arm/kernel/process.c	2005-06-29 14:08:19.000000000 +1000
@@ -84,10 +84,14 @@ EXPORT_SYMBOL(pm_power_off);
  */
 void default_idle(void)
 {
-	local_irq_disable();
-	if (!need_resched() && !hlt_counter)
-		arch_idle();
-	local_irq_enable();
+	if (hlt_counter)
+		cpu_relax();
+	else {
+		local_irq_disable();
+		if (!need_resched())
+			arch_idle();
+		local_irq_enable();
+	}
 }
 
 /*
@@ -104,13 +108,13 @@ void cpu_idle(void)
 		void (*idle)(void) = pm_idle;
 		if (!idle)
 			idle = default_idle;
-		preempt_disable();
 		leds_event(led_idle_start);
 		while (!need_resched())
 			idle();
 		leds_event(led_idle_end);
-		preempt_enable();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/h8300/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/h8300/kernel/process.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/h8300/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -53,22 +53,18 @@ asmlinkage void ret_from_fork(void);
 #if !defined(CONFIG_H8300H_SIM) && !defined(CONFIG_H8S_SIM)
 void default_idle(void)
 {
-	while(1) {
-		if (!need_resched()) {
-			local_irq_enable();
-			__asm__("sleep");
-			local_irq_disable();
-		}
-		schedule();
-	}
+	local_irq_disable();
+	if (!need_resched()) {
+		local_irq_enable();
+		/* XXX: race here! What if need_resched() gets set now? */
+		__asm__("sleep");
+	} else
+		local_irq_enable();
 }
 #else
 void default_idle(void)
 {
-	while(1) {
-		if (need_resched())
-			schedule();
-	}
+	cpu_relax();
 }
 #endif
 void (*idle)(void) = default_idle;
@@ -81,7 +77,13 @@ void (*idle)(void) = default_idle;
  */
 void cpu_idle(void)
 {
-	idle();
+	while (1) {
+		while (!need_resched())
+			idle();
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+	}
 }
 
 void machine_restart(char * __unused)
Index: linux-2.6/arch/xtensa/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/xtensa/kernel/process.c	2005-06-29 14:04:48.000000000 +1000
+++ linux-2.6/arch/xtensa/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -96,8 +96,9 @@ void cpu_idle(void)
 	while (1) {
 		while (!need_resched())
 			platform_idle();
-		preempt_enable();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/v850/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/v850/kernel/process.c	2005-06-29 14:01:39.000000000 +1000
+++ linux-2.6/arch/v850/kernel/process.c	2005-06-29 14:07:05.000000000 +1000
@@ -36,11 +36,8 @@ extern void ret_from_fork (void);
 /* The idle loop.  */
 void default_idle (void)
 {
-	while (1) {
-		while (! need_resched ())
-			asm ("halt; nop; nop; nop; nop; nop" ::: "cc");
-		schedule ();
-	}
+	while (! need_resched ())
+		asm ("halt; nop; nop; nop; nop; nop" ::: "cc");
 }
 
 void (*idle)(void) = default_idle;
@@ -54,7 +51,14 @@ void (*idle)(void) = default_idle;
 void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
-	(*idle) ();
+	while (1) {
+		while (!need_resched())
+			(*idle) ();
+
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+	}
 }
 
 /*
Index: linux-2.6/Documentation/sched-arch.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/Documentation/sched-arch.txt	2005-06-29 14:07:05.000000000 +1000
@@ -0,0 +1,89 @@
+	CPU Scheduler implementation hints for architecture specific code
+
+	Nick Piggin, 2005
+
+Context switch
+==============
+1. Runqueue locking
+By default, the switch_to arch function is called with the runqueue
+locked. This is usually not a problem unless switch_to may need to
+take the runqueue lock. This is usually due to a wake up operation in
+the context switch. See include/asm-ia64/system.h for an example.
+
+To request the scheduler call switch_to with the runqueue unlocked,
+you must `#define __ARCH_WANT_UNLOCKED_CTXSW` in a header file
+(typically the one where switch_to is defined).
+
+Unlocked context switches introduce only a very minor performance
+penalty to the core scheduler implementation in the CONFIG_SMP case.
+
+2. Interrupt status
+By default, the switch_to arch function is called with interrupts
+disabled. Interrupts may be enabled over the call if it is likely to
+introduce a significant interrupt latency by adding the line
+`#define __ARCH_WANT_INTERRUPTS_ON_CTXSW` in the same place as for
+unlocked context switches. This define also implies
+`__ARCH_WANT_UNLOCKED_CTXSW`. See include/asm-arm/system.h for an
+example.
+
+
+CPU idle
+========
+Your cpu_idle routines need to obey the following rules:
+
+1. Preempt should now disabled over idle routines. Should only
+   be enabled to call schedule() then disabled again.
+
+2. need_resched/TIF_NEED_RESCHED is only ever set, and will never
+   be cleared until the running task has called schedule(). Idle
+   threads need only ever query need_resched, and may never set or
+   clear it.
+
+3. When cpu_idle finds (need_resched() == 'true'), it should call
+   schedule(). It should not call schedule() otherwise.
+
+4. The only time interrupts need to be disabled when checking
+   need_resched is if we are about to sleep the processor until
+   the next interrupt (this doesn't provide any protection of
+   need_resched, it prevents losing an interrupt).
+
+	4a. Common problem with this type of sleep appears to be:
+	        local_irq_disable();
+	        if (!need_resched()) {
+	                local_irq_enable();
+	                *** resched interrupt arrives here ***
+	                __asm__("sleep until next interrupt");
+	        }
+
+5. TIF_POLLING_NRFLAG can be set by idle routines that do not
+   need an interrupt to wake them up when need_resched goes high.
+   In other words, they must be periodically polling need_resched,
+   although it may be reasonable to do some background work or enter
+   a low CPU priority.
+
+   	5a. If TIF_POLLING_NRFLAG is set, and we do decide to enter
+	    an interrupt sleep, it needs to be cleared then a memory
+	    barrier issued (followed by a test of need_resched with
+	    interrupts disabled, as explained in 3). 
+
+arch/i386/kernel/process.c has examples of both polling and 
+sleeping idle functions.
+
+
+Possible arch/ problems
+=======================
+
+Possible arch problems I found (and either tried to fix or didn't):
+
+h8300 - Is such sleeping racy vs interrupts? (See #4a).
+        The H8/300 manual I found indicates yes, however disabling IRQs
+        over the sleep mean only NMIs can wake it up, so can't fix easily
+        without doing spin waiting.
+
+ia64 - is safe_halt call racy vs interrupts? (does it sleep?) (See #4a)
+
+sh64 - Is sleeping racy vs interrupts? (See #4a)
+
+sparc - IRQs on at this point(?), change local_irq_save to _disable.
+      - TODO: needs secondary CPUs to disable preempt (See #1)
+

--------------090409050109040507000508--
Send instant messages to your online friends http://au.messenger.yahoo.com 
