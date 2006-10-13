Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:39873 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750762AbWJMN1R (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Oct 2006 09:27:17 -0400
Received: from ocs3.ocs.com.au (ocs3w.ocs.com.au [192.168.254.3])
	by mail.ocs.com.au (Postfix) with ESMTP id 92CE8E0B20A
	for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2006 23:27:14 +1000 (EST)
Received: from ocs3.ocs.com.au (localhost [127.0.0.1])
	by ocs3.ocs.com.au (Postfix) with ESMTP id DA52281EE7
	for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2006 23:27:36 +1000 (EST)
From: Keith Owens <kaos@sgi.com>
Subject: [RFC] crash_stop: crash_stop_common
In-reply-to: Your message of "Fri, 13 Oct 2006 23:23:35 +1000."
             <26656.1160745815@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Oct 2006 23:27:36 +1000
Message-ID: <28251.1160746056@ocs3.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

The common crash_stop code, including the design level documentation.

This patch is missing the code to handle a notify_chain (see scenario 4
in kernel/crash_stop.c).  I want to make sure that the API design is
right before adding that code.

---
 kernel/Makefile     |    1 
 kernel/crash_stop.c |  563 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 564 insertions(+)

Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile
+++ linux/kernel/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_UTS_NS) += utsname.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
 obj-$(CONFIG_TASKSTATS) += taskstats.o tsacct.o
+obj-$(CONFIG_CRASH_STOP_SUPPORTED) += crash_stop.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux/kernel/crash_stop.c
===================================================================
--- /dev/null
+++ linux/kernel/crash_stop.c
@@ -0,0 +1,563 @@
+/*
+ * linux/kernel/crash_stop.c
+ *
+ * Copyright (C) 2006 Keith Owens <kaos@sgi.com>
+ *
+ * Bring the system to a crash stop for debugging by stopping all the online
+ * cpus apart from the current cpu.  To interrupt the other cpus, first send a
+ * normal IPI, if any cpus have not responded after a few seconds then send a
+ * non-maskable interrupt.  Only used if CONFIG_SMP=y.
+ *
+ * These routines can be used by any debug style code that needs to stop the
+ * other cpus in the system, including those cpus that are not responding to
+ * normal interrupts.  Debug style code includes debuggers such as kdb, kgdb,
+ * nlkd as well as dump tools such as netdump, lkcd, kdump.  All these tools
+ * have the same basic synchronization requirements, the need to stop all the
+ * cpus, save the complete state of the tasks that were running then do some
+ * work on the current cpu.
+ *
+ * For each invocation of crash_stop, one cpu is the monarch, the other cpus
+ * are slaves.  There is no external guarantee of ordering between monarch and
+ * slave events.  The most common case is when the monarch is invoked via
+ * crash_stop(), it then drives the debugger's callback on the slave cpus,
+ * followed by the callback on the monarch cpu.
+ *
+ * Some architectures (IA64 in particular) define their own global machine
+ * synchronization events where a global event can drive the slave cpus ether
+ * before or after the monarch.  See INIT in Documentation/ia64/mca.txt.
+ *
+ * To hide the external monarch/slave races from the users of crash_stop, this
+ * code enforces a standard order on the events.  The debugger's callback
+ * routine is invoked on all the slaves "at the same time", followed 10 ms
+ * later by the callback on the monarch cpu.  Typically the callback will spin
+ * on the slave cpus until the monarch callback has done its work and released
+ * the slave cpus.
+ *
+ * There is no guarantee that all online cpus will be in crash_stop state when
+ * the monarch is entered.  If a cpu or chipset is so badly hung that it will
+ * not even respond to NMI then there will be no state for that cpu in
+ * crash_stop_running_process.
+ *
+ * A live locked system can result in a slave cpu processing the crash_stop IPI
+ * _after_ the monarch cpu has done its processing and left crash_stop status.
+ * The slave will not service the normal IPI fast enough (it is live locked
+ * with interrupts disabled) so it will be interrupted by NMI.  The monarch
+ * does its work and leaves crash_stop.  Later the slave gets out of the live
+ * lock and services the crash_stop IPI, but now there is no monarch to do
+ * anything.  To catch this delayed event, a crash_stop IPI is ignored if there
+ * is no current monarch.
+ *
+ * For some events, we cannot tell straight away if we want to debug the event
+ * or not.  For example, an IA64 MCA is architecturally defined to stop all the
+ * slaves before entering the monarch.  Only when the monarch is entered do we
+ * get any data on the event, it is only on the monarch that we can tell if the
+ * MCA is recoverable or not.  In this case, the monarch must call
+ * crash_stop_recovered() instead of crash_stop().  crash_stop_recovered()
+ * releases all the slaves.  Neither the slaves nor the monarch will use the
+ * callback routine.
+ *
+ * All routines are entered with interrupts disabled.  If necessary, the caller
+ * must disable interrupts before calling crash_stop.
+ */
+
+
+/* There are several possible scenarios for using crash_stop:
+ *
+ * (1) An explicit call to crash_stop from debugging code.  For example, a
+ *     direct entry into a debugger or an explicit request to dump via sysrq.
+ *     The debugging code calls crash_stop() which stops the slaves.
+ *
+ * (2) A nested call to crash_stop on the same cpu.  For example, a user is
+ *     debugging and they decide to take a kernel dump from inside the
+ *     debugger.  The debugger has already brought the system to crash_stop
+ *     state so the dump callback will be called on the current cpu (the
+ *     monarch) but not on the slaves.  The dump code uses the data that is
+ *     already in crash_stop_running_process[].
+ *
+ * (3) Concurrent calls to crash_stop on separate cpus.  One cpu will become
+ *     the monarch for one of the events and interrupt all the others,
+ *     including any cpus that are also trying to enter crash_stop.  When the
+ *     current monarch finishes, the other cpus will race for the crash_stop
+ *     lock and one will become the new monarch (assuming the system is still
+ *     usable).
+ *
+ * (4) A system error occurs and drives the notify_die callback chain, this one
+ *     can be tricky.  It is not known which entries on the notify_die chain
+ *     will do any work, but all of them need to see the same system state.  An
+ *     arch dependent crash_stop callback is called at the start and end of the
+ *     notify_die chain.  At the start it brings the system into crash_stop
+ *     state, using its own callbacks on the slave cpus.  Then it holds the
+ *     slave cpus and releases the monarch cpu.  This allows the rest of the
+ *     entries on the notify_die chain to run, each of them can call crash_stop
+ *     and run their callback on the current cpu and the slaves.  At the end of
+ *     the notify_die chain, the main crash_stop code releases the slave cpus.
+ *     This gives a consistent view of the system to all the entries on the
+ *     notify_die chain.
+ *
+ * The various states are a little complicated, because the code has to cope
+ * with normal calls, nested calls, concurrent calls on separate cpus plus
+ * keeping a consistent view for the life of a notify chain.  A few rules :-
+ *
+ *   Variables cs_lock_cpu, cs_monarch and cs_notify_chain hold a cpu number,
+ *   -1 is 'not set'.  These variables are only updated on the monarch cpu and
+ *   are all protected by cs_lock.
+ *
+ *   Entering a nested call only affects the monarch cpu.  The slave cpus will
+ *   continue to spin in the callback for the first crash_stop() event.
+ *
+ *   Returning from a nested call does not clear cs_monarch nor release the
+ *   slaves.
+ *
+ *   If a monarch gets the lock and cs_notify_chain is not the current cpu then
+ *   another cpu is already running a notify chain.  This monarch must back off
+ *   and wait for the other cpu to finish running its notify chain.
+ *
+ *   Returning from a notify_chain call clears cs_monarch but does not release
+ *   the slaves.  Instead the slaves loop inside this code, in the expectation
+ *   that another notify chain driven routine will call crash_stop and will
+ *   need the slaves.  Unlike a nested call, the slaves will use the supplied
+ *   callback for each entry on the notify chain that calls crash_stop().
+ *
+ * Why the difference between nested calls and a notify chain?  Mainly because
+ * the entries on a notify chain are defined to be separate, also crash_stop
+ * can easily detect the start and end of running the chain.  With a nested
+ * call, there is no way to tell if the first callback will use crash_stop() a
+ * second time.  Nested calls can result from explicit calls to other debug
+ * style code or from an oops in the current callback.  On a nested call, the
+ * monarch callback owns and controls the slaves, they are out of crash_stop()
+ * control.  Only the monarch callback can release the slaves by leaving
+ * crash_stop() state, at which point the sconed call to crash_stop is not a
+ * nested call.
+ */
+
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/crash_stop.h>
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <linux/nmi.h>
+#include <linux/spinlock.h>
+#include <linux/threads.h>
+
+DEFINE_SPINLOCK(cs_lock);
+int cs_lock_cpu = -1;
+int cs_monarch = -1;
+int cs_notify_chain = -1;
+
+static int cs_recovered;
+
+static cpumask_t cs_cpu_mask, cs_sent_ipi, cs_sent_nmi;
+
+static struct crash_stop_running_process crash_stop_running_process[NR_CPUS];
+
+struct cs_global cs_global;
+
+/* Use a local version of mdelay because RedHat patch the kernel to give a
+ * warning when mdelay is used with interrupts disabled.  Why do RedHat do
+ * these silly things, have they never heard of debugging?
+ */
+static void
+cs_mdelay(int ms)
+{
+	while (ms > 0) {
+		touch_nmi_watchdog();
+		udelay(1000);
+		--ms;
+	}
+}
+
+static void
+cpu_relax_watchdog(void)
+{
+	touch_nmi_watchdog();
+	cpu_relax();
+}
+
+/* If we cannot safely use an external print routine then save any messages in
+ * a local buffer.  This code is not performance sensitive so we take the time
+ * to left justify the entire buffer instead of using ring pointers, this
+ * removes the need for users to cope with wrapped cs_msg text when analysing a
+ * crash_stopped kernel.
+ */
+
+static char cs_msg[4096];
+
+static asmlinkage int
+cs_printk(const char * fmt, ...)
+{
+	int l, ret, shift;
+	va_list ap;
+	static DEFINE_SPINLOCK(cs_msg_lock);
+	spin_lock(&cs_msg_lock);
+	l = strlen(cs_msg);
+	while (1) {
+		va_start(ap, fmt);
+		ret = vsnprintf(cs_msg+l, sizeof(cs_msg)-l, fmt, ap);
+		va_end(ap);
+		if (l == 0 || ret < sizeof(cs_msg)-l)
+			break;
+		shift = sizeof(cs_msg) / 10 + 1;
+		shift = max(shift, ret);
+		shift = min(shift, l);
+		l -= shift;
+		memcpy(cs_msg, cs_msg+shift, l);
+		memset(cs_msg+l, 0, sizeof(cs_msg)-l);
+	}
+	spin_unlock(&cs_msg_lock);
+	return 0;
+}
+
+static void
+cs_online_cpu_status(const char *text)
+{
+	int slaves = num_online_cpus() - 1, count = 0, cpu, unknown;
+	if (!slaves)
+		return;
+	for_each_online_cpu(cpu) {
+		if (cpu_isset(cpu, cs_cpu_mask) &&
+		    cpu != smp_processor_id())
+			++count;
+	}
+	unknown = slaves - count;
+	if (unknown == 0)
+		cs_global.print(
+			"All cpus are in crash_stop for %s\n",
+			text);
+	else
+		cs_global.print(
+			"%d cpu%s not in crash_stop for %s, %s state is unknown\n",
+			unknown,
+			unknown == 1 ? " is" : "s are",
+			text,
+			unknown == 1 ? "its" : "their");
+}
+
+/* Should only be called by the arch interrupt handlers, when they receive the
+ * crash_stop specific IPI.
+ */
+void
+cs_common_ipi(struct pt_regs *regs)
+{
+	if (!cs_global.callback) {
+		printk(KERN_DEBUG "Ignoring late cs_ipi on cpu %d\n",
+		       smp_processor_id());
+		return;
+	}
+	crash_stop_cpu(0, regs);
+}
+
+/* Should only be called by the arch specific NMI handlers, to see if this NMI
+ * is for crash_stop or for something else.  On most architectures, an NMI
+ * signal carries no state so we have to deduce why it was sent.
+ */
+int
+crash_stop_sent_nmi(void)
+{
+	return cpu_isset(smp_processor_id(), cs_sent_nmi);
+}
+
+/* Should only be called by the arch specific crash_stop code, after they have
+ * saved any arch specific state.  The call chain is :-
+ *
+ * crash_stop() [monarch] or cs_ipi() [slave] ->
+ *   crash_stop_cpu() [common front end code] ->
+ *     cs_arch_cpu() [arch dependent code] ->
+ *       cs_common_cpu() [common back end code] ->
+ *         callback
+ *
+ * When cs_common_cpu() is entered for a slave cpu, it must spin while
+ * cs_monarch < 0.  That enforces the order of slave callbacks first, then
+ * monarch callback.
+ *
+ * When handling a notify chain, park the slave cpus in this holding routine
+ * while the monarch cpu runs down the notify chain.  If any entry on the
+ * notify chain calls crash_stop_cpu() than release the slaves to the
+ * corresponding crash_stop callback.  On return from the callback, put them
+ * back in a holding loop.  The state of the slave cpus is not significantly
+ * changed by this process and each caller of crash_stop_cpu() gets the same
+ * data in crash_stop_running_process.  IOW, all entries on the notify chain
+ * see the state that was saved by the first crash_stop entry on the chain, not
+ * some state that changes as we run the notify chain.
+ */
+void
+cs_common_cpu(int monarch)
+{
+	do {
+		/* wait until the monarch enters */
+		while (cs_monarch < 0)
+			cpu_relax_watchdog();
+		if (!cs_recovered)
+			cs_global.callback(monarch, cs_global.data);
+		if (monarch)
+			return;
+		/* wait until the monarch leaves */
+		while (cs_monarch >= 0)
+			cpu_relax_watchdog();
+	} while (cs_notify_chain >= 0);
+}
+
+/* Wait for at least 3 seconds, but allow an extra 100 ms per online cpu to
+ * cope with live lock on systems with large cpu counts.  These are arbitrary
+ * numbers, it might be worth exposing them as /sys values so sites can tune
+ * their debugging.  Review this after we have more experience with this
+ * code - KAO.
+ */
+static void
+cs_wait_for_cpus(void)
+{
+	int count, prev_count = 0, sent_nmi = 0, t, wait_secs, slaves, cpu;
+	slaves = num_online_cpus() - 1;
+	wait_secs = min(3, (slaves * 100) / 1000);
+	cs_mdelay(100);
+	for (t = 0; t < wait_secs; ++t) {
+		count = 0;
+		slaves = num_online_cpus() - 1;
+		for_each_online_cpu(cpu) {
+			if (cpu_isset(cpu, cs_cpu_mask))
+				++count;
+		}
+		if (count == slaves)
+			break;
+		if (prev_count != count) {
+			cs_global.print(
+				"  %d out of %d cpus in crash_stop, "
+				"waiting for the rest, timeout in %d "
+				"second(s)\n",
+				count, slaves, wait_secs-t);
+			prev_count = count;
+		}
+		cs_mdelay(1000);
+		if (!sent_nmi && t == min(wait_secs / 2, 5)) {
+			for_each_online_cpu(cpu) {
+				if (cpu_isset(cpu, cs_cpu_mask) ||
+				    cpu_isset(cpu, cs_sent_nmi) ||
+				    cpu == smp_processor_id())
+					continue;
+				if (!sent_nmi) {
+					cs_global.print(" sending NMI ");
+					sent_nmi = 1;
+				}
+				cpu_set(cpu, cs_sent_nmi);
+				wmb();
+				cs_arch_send_nmi(cpu);
+			}
+		}
+		if (t % 4 == 0)
+			cs_global.print(".");
+	}
+}
+
+static void
+cs_send_ipi(void)
+{
+	int sent_ipi = 0, cpu;
+	for_each_online_cpu(cpu) {
+		if (cpu_isset(cpu, cs_cpu_mask) ||
+		    cpu_isset(cpu, cs_sent_ipi) ||
+		    cpu == smp_processor_id())
+			continue;
+		cpu_set(cpu, cs_sent_ipi);
+		cs_arch_send_ipi(cpu);
+		sent_ipi = 1;
+	}
+	if (sent_ipi)
+		cs_wait_for_cpus();
+}
+
+/**
+ * crash_stop_cpu: - Put the current cpu into crash_stop state.
+ * @monarch: 0 for a slave cpu, 1 for the monarch cpu.
+ * @regs: pt_regs for the current interrupting event.
+ *
+ * Invoked on every cpu that is being stopped, with no externally defined order
+ * between monarch and slaves.  The arch independent running state is saved
+ * here, then cs_arch_cpu() saves any arch specific state, followed by
+ * invocation of cs_common_cpu() which drives the callback routine.
+ */
+void
+crash_stop_cpu(int monarch, struct pt_regs *regs)
+{
+	struct crash_stop_running_process *r, prev;
+	int cpu = smp_processor_id();
+	cpu_set(cpu, cs_cpu_mask);
+	r = crash_stop_running_process + cpu;
+	prev = *r;
+	r->p = current;
+	r->regs = regs;
+	r->prev = &prev;
+	if (monarch && cs_monarch < 0) {
+		cs_monarch = cpu;
+		wmb();
+		cs_mdelay(10);	/* give the slaves a chance to get going */
+	}
+	cs_arch_cpu(monarch, r);
+	*r = prev;
+	if (r->p == NULL) {
+		cpu_clear(cpu, cs_sent_ipi);
+		cpu_clear(cpu, cs_sent_nmi);
+		smp_mb__before_clear_bit();
+		cpu_clear(cpu, cs_cpu_mask);
+		if (monarch)
+			cs_monarch = -1;
+	}
+}
+
+/**
+ * crash_stop: - Bring the system to a crash stop for debugging.
+ * @callback: After each cpu has been interrupted, the callback is invoked on
+ * that cpu, with the monarch flag set to 0.  After all cpus have responded or
+ * the timeout has been reached then the callback is invoked on the current cpu
+ * with the monarch flag set to 1.
+ * @data: Callback specific data, crash_stop does not use this data.
+ * @print: Optionally, the name of a debugger specific print routine.  If this
+ * is NULL then crash_stop will default to using cs_printk(), messages will be
+ * left justified in cs_msg[].
+ *
+ * Unlike stop_machine(), crash_stop() does not ask if the other cpus are
+ * ready to be stopped and will use non-maskable interrupts to stop cpus that
+ * do not respond after a few seconds.
+ *
+ * crash_stop() must be entered with interrupts disabled, it can even be
+ * entered from an NMI event.  It is the caller's responsibility to ensure that
+ * their print routine (if any) is safe in the current context.
+ *
+ * If the system has already entered a globally stopped state then sending IPI
+ * or NMI is pointless and may even be unsafe.  This particularly applies to
+ * MCA or global INIT on IA64, these events are already defined to stop the
+ * entire machine and they also prevent crash_stop() from sending any IPI or
+ * NMI events.  Only send IPI/NMI to cpus that are not yet in crash_stop state.
+ *
+ * The global structure crash_stop_running_process is updated with information
+ * about the tasks that are running on each cpu.  The debugger can use this
+ * information to start the analysis of the running tasks.
+ *
+ * Returns: 0 normal
+ *
+ *          -ENOSYS crash_stop is not supported on this architecture.
+ */
+
+int
+crash_stop(void (*callback)(int monarch, void *data), void *data,
+	   struct pt_regs *regs, printk_t print,
+	   const char *text)
+{
+	int cpu;
+	struct cs_global csg_save, csg = {
+		.callback = callback,
+		.data = data,
+		.print = print ? print : cs_printk,
+	};
+
+	WARN_ON(!irqs_disabled());
+retry:
+	if (!spin_trylock(&cs_lock)) {
+		if (cs_lock_cpu == smp_processor_id()) {
+			/* nested call on the same cpu */
+			csg_save = cs_global;
+			cs_global = csg;
+			wmb();
+			cs_online_cpu_status(text);
+			crash_stop_cpu(1, regs);
+			cs_global = csg_save;
+			wmb();
+			return 0;
+		}
+		/* concurrent call on another cpu */
+		while (cs_lock_cpu != -1)
+			cpu_relax_watchdog();
+		goto retry;
+	}
+
+	if (cs_notify_chain >= 0 &&
+	    cs_notify_chain != smp_processor_id()) {
+		/* another cpu is running a notify chain, back off */
+		spin_unlock(&cs_lock);
+		cs_mdelay(1);
+		goto retry;
+	}
+
+	cs_lock_cpu = smp_processor_id();
+	csg_save = cs_global;
+	cs_global = csg;
+	wmb();
+	cs_send_ipi();
+	cs_online_cpu_status(text);
+	crash_stop_cpu(1, regs);
+	if (cs_monarch < 0 && cs_notify_chain < 0) {
+		/* leaving a normal call, wait for the slaves to exit */
+		for_each_online_cpu(cpu) {
+			while (cpu_isset(cpu, cs_cpu_mask))
+				cpu_relax_watchdog();
+		}
+	}
+	cs_global = csg_save;
+	cs_lock_cpu = -1;
+	spin_unlock(&cs_lock);
+	return 0;
+}
+
+/**
+ * crash_stop_recovered: - Release any slaves in crash_stop state.
+ *
+ * On architectures that define their own global synchronization methods, the
+ * slave cpus may enter crash_stop state before the monarch.  If the monarch
+ * decides that the event is recoverable then the slaves need to be released
+ * from crash_stop, without invoking any callbacks.
+ *
+ * For recovered events, we do not always force the other cpus into slave
+ * state.  The assumption is that crash_stop_recovered() is only required on
+ * architectures that define their own global synchronization methods (e.g.
+ * IA64 MCA), in which case the architecture has already take care of the
+ * slaves.  If no slave cpu is in crash_stop() state then do nothing, otherwise
+ * wait until all the slaves are in crash_stop().
+ *
+ * Note: this routine does not check for a nested call to crash_stop, nor does
+ * it handle notify chains.  It makes no sense to recover an error except at
+ * the top level.
+ */
+int
+crash_stop_recovered(void)
+{
+	int cpu, any_slaves = 0;
+
+	WARN_ON(!irqs_disabled());
+retry:
+	spin_lock(&cs_lock);
+	if (cs_notify_chain >= 0 &&
+	    cs_notify_chain != smp_processor_id()) {
+		/* another cpu is running a notify chain, back off */
+		spin_unlock(&cs_lock);
+		cs_mdelay(1);
+		goto retry;
+	}
+	BUG_ON(cs_notify_chain >= 0);
+	for_each_online_cpu(cpu) {
+		if (cpu_isset(cpu, cs_cpu_mask) &&
+		    cpu != smp_processor_id()) {
+			any_slaves = 1;
+			break;
+		}
+	}
+	if (any_slaves) {
+		/* give cs_send_ipi/cs_wait_for_cpus a safe print routine */
+		struct cs_global csg_save, csg = {
+			.print = cs_printk,
+		};
+		csg_save = cs_global;
+		cs_global = csg;
+		wmb();
+		cs_send_ipi();
+		cs_global = csg_save;
+	}
+	cs_recovered = 1;
+	wmb();
+	cs_monarch = smp_processor_id();
+	for_each_online_cpu(cpu) {
+		while (cpu_isset(cpu, cs_cpu_mask))
+			cpu_relax_watchdog();
+	}
+	cs_recovered = 0;
+	cs_monarch = -1;
+	spin_unlock(&cs_lock);
+	return 0;
+}

