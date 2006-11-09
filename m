Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:61312 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1423822AbWKIEEg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2006 23:04:36 -0500
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id kA96ld9O005332
	for <@external-mail-relay.sgi.com:linux-arch@vger.kernel.org>; Wed, 8 Nov 2006 22:47:41 -0800
From: Keith Owens <kaos@sgi.com>
Date: Thu, 09 Nov 2006 15:04:29 +1100
Message-Id: <20061109040429.17391.65720.sendpatchset@chook.melbourne.sgi.com>
In-Reply-To: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
References: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
Subject: [patch 2.6.19-rc5 2/12] crash_stop: common code
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Keith Owens <kaos@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

The common crash_stop code, including the design level documentation.

Signed-off-by: Keith Owens <kaos@sgi.com>
---
 kernel/Makefile     |    1 
 kernel/crash_stop.c |  843 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sys.c        |    5 
 3 files changed, 848 insertions(+), 1 deletion(-)

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
@@ -0,0 +1,843 @@
+/*
+ * linux/kernel/crash_stop.c
+ *
+ * Copyright (C) 2006 Keith Owens <kaos@sgi.com>
+ *
+ * Bring the system to a crash stop for debugging by stopping all the online
+ * cpus apart from the current cpu.  To interrupt the other cpus, first send a
+ * normal IPI, if any cpus have not responded after a few seconds then send a
+ * non-maskable interrupt.
+ *
+ * Most of this code disappears with CONFIG_SMP=n.  It devolves to running the
+ * callback routine on this cpu as the monarch and setting up the saved state
+ * for this cpu.  That gives a common interface for debug style tools, even on
+ * UP.
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
+ *     To make things more interesting, crash_stop() can be entered for one
+ *     reason then a software interrupt or NMI can come over the top.  That
+ *     will result in a notify_chain being run while the system is already in
+ *     crash_stop state.  Which means that any calls from the notify_chain to
+ *     crash_stop() must be treated as a nested calls.
+ *
+ *     Finally it is just possible to have multiple levels of notify_chain
+ *     running at the same time.  For example, an oops occurs and drives the
+ *     notify_chain.  At the start of that chain, the slaves are put into
+ *     crash_stop state and the monarch is allowed to run the chain.  A
+ *     callback on the chain breaks or loops and a second scan of the
+ *     notify_chain is done for this nested failure.  For this case, crash_stop
+ *     must ignore the use of the second notify_chain and treat any calls as
+ *     nested ones.
+ *
+ * The various states are a little complicated, because the code has to cope
+ * with normal calls, nested calls, concurrent calls on separate cpus,
+ * keeping a consistent view for the life of a notify_chain plus nested events
+ * that involve notify_chains.  And do it all without deadlocks, particularly
+ * on non-maskable interrupts.  A few rules :-
+ *
+ *   Variables cs_lock_owner, cs_monarch and cs_notify_chain_owner hold a cpu
+ *   number, -1 is 'not set'.  cs_notify_chain_depth is a counter.  These
+ *   variables are only updated on the monarch cpu.  The variables are
+ *   protected by cs_lock or by the fact that the current cpu is handling a
+ *   nested monarch event.
+ *
+ *   Entering a nested call only affects the monarch cpu.  The slave cpus will
+ *   continue to spin in the callback for the first crash_stop() event.  Nested
+ *   calls cannot take cs_lock, they would deadlock.
+ *
+ *   Returning from a nested call does not clear cs_monarch nor release the
+ *   slaves.
+ *
+ *   If a monarch gets the lock and cs_notify_chain_owner is not the current
+ *   cpu then another cpu is already running a notify_chain.  This monarch must
+ *   back off and wait for the other cpu to finish running its notify_chain.
+ *
+ *   Returning from a notify_chain call clears cs_monarch but does not release
+ *   the slaves.  Instead the slaves loop inside this code, in the expectation
+ *   that another notify_chain driven routine will call crash_stop and will
+ *   need the slaves.  Unlike a nested call, the slaves will use the supplied
+ *   callback for each entry on the notify_chain that calls crash_stop().
+ *
+ *   If cs_notify_chain_owner is already set to the monarch cpu on entry to a
+ *   notify_chain then ignore the use of the chain.  Any calls to crash_stop()
+ *   from entries on the chain will be treated as nested calls.
+ *
+ * Why the difference between nested calls and a notify_chain?  Mainly because
+ * the entries on a notify_chain are defined to be separate, also crash_stop
+ * can easily detect the start and end of running the chain.  With a nested
+ * call, there is no way to tell if the first callback will use crash_stop() a
+ * second time.  Nested calls can result from explicit calls to other debug
+ * style code or from an error in the current callback.  On a nested call, the
+ * monarch callback owns and controls the slaves, they are out of crash_stop()
+ * control.  Only the monarch callback can release the slaves by leaving
+ * crash_stop() state, at which point the second call to crash_stop is not a
+ * nested call.
+ */
+
+/* FIXME (maybe): There is a possible deadlock scenario:
+ *
+ * A monarch cpu calls crash_stop().
+ * All the slave cpus are put into crash_stop() state.
+ * One of the slaves gets a non-maskable interrupt - where from?
+ * The slave calls crash_stop() and spins waiting for cs_lock.
+ * The monarch exits and waits for all the slaves to exit.
+ * The slave that took NMI will not exit until cs_lock is free.
+ * The monarch will not free cs_lock until all the slaves exit.
+ *
+ * This deadlock can only occur if some external hardware generates an NMI and
+ * that NMI is sent to slave cpus instead of the monarch.  Until that situation
+ * can be demonstrated (and any workaround can be tested), I am going to ignore
+ * this scenario - KAO.
+ */
+
+/* Danger - Here there be races and compiler/hardware reordering gotchas.
+ *
+ * This code relies on variables that must be set on one cpu and seen on other
+ * cpus in the right order.  Both the compiler and the hardware can reorder
+ * operations, so use memory barriers when necessary.
+ *
+ * The biggest problem is that the compiler does not know about the other cpus,
+ * so the compiler may incorrectly think that an operation on this cpu has no
+ * side effects and may move the operation or even optimize it away.  To be on
+ * the safe side and to document the ordering requirements, barriers have been
+ * used wherever there is even the remote possibility of a current or future
+ * compiler being too smart for its own good.  Look for 'barrier:' comments.
+ *
+ * Obviously calls to spin_lock/spin_unlock are already barriers.  Only the
+ * additional barrier operations are commented.
+ */
+
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/crash_stop.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <linux/nmi.h>
+#include <linux/spinlock.h>
+#include <linux/threads.h>
+
+static DEFINE_SPINLOCK(cs_lock);
+static int cs_lock_owner = -1;
+static int cs_monarch = -1;
+static int cs_monarch_depth;
+static int cs_notify_chain_owner = -1;
+static int cs_notify_chain_depth;
+static int cs_notify_chain_ended;
+static int cs_leaving;
+static atomic_t cs_common_cpu_slaves;
+
+static int cs_recovered;
+
+static cpumask_t cs_cpu_mask, cs_sent_ipi, cs_sent_nmi;
+
+static struct crash_stop_running_process crash_stop_running_process[NR_CPUS];
+
+struct cs_global cs_global;
+
+/* Use a local version of mdelay because RedHat patch their kernel to give a
+ * warning when mdelay is used with interrupts disabled.  Why do RedHat do
+ * these silly things, have they never heard of debugging?
+ */
+static void
+cs_mdelay(int ms)
+{
+	while (ms > 0) {
+		touch_nmi_watchdog();
+		udelay(1000);	/* barrier: udelay -> cpu_relax -> barrier */
+		--ms;
+	}
+}
+
+static void
+cs_cpu_relax_watchdog(void)
+{
+	touch_nmi_watchdog();
+	cpu_relax();	/* barrier: cpu_relax -> barrier */
+}
+
+/* barrier: On some architectures, set_mb() uses xchg so it only works on 1, 2,
+ * 4 or 8 byte quantities.  This violates Documentation/memory-barriers.txt
+ * which implies that set_mb can be used on any data type.  The only
+ * requirement is that their be a memory barrier after assigning the value, so
+ * define our own version that uses generic operations.
+ */
+#define cs_set_mb(var, value) do { (var) = (value); mb(); } while (0)
+
+/* If we cannot safely use an external print routine then save any messages in
+ * a local buffer, allowing 256 bytes of messages per cpu.  This code is not
+ * performance sensitive so we take the time to left justify the entire buffer
+ * instead of using ring pointers, this removes the need for users to cope with
+ * wrapped cs_msg text when analysing a crash_stopped kernel.
+ */
+
+static char cs_msg[256*NR_CPUS];
+static DEFINE_SPINLOCK(cs_msg_lock);
+static int cs_msg_lock_owner = -1;
+
+static asmlinkage int
+cs_printk(const char * fmt, ...)
+{
+	int l, ret, shift;
+	va_list ap;
+	/* If we get NMI'd during this code then discard any messages for the
+	 * nested event.  Either way we lose some messages and it is far easier
+	 * (and safer) to discard the nested messages.
+	 */
+	if (cs_msg_lock_owner == smp_processor_id())
+		return 0;
+	spin_lock(&cs_msg_lock);
+	/* barrier: setting cs_msg_lock_owner must not move down */
+	set_mb(cs_msg_lock_owner, smp_processor_id());
+	l = strlen(cs_msg);
+	while (1) {
+		va_start(ap, fmt);
+		ret = vsnprintf(cs_msg+l, sizeof(cs_msg)-l, fmt, ap);
+		va_end(ap);
+		if (l == 0 || ret < sizeof(cs_msg)-l)
+			break;
+		shift = sizeof(cs_msg) / 10;
+		shift = max(shift, ret);
+		shift = min(shift, l);
+		l -= shift;
+		memcpy(cs_msg, cs_msg+shift, l);
+		memset(cs_msg+l, 0, sizeof(cs_msg)-l);
+	}
+	/* barrier: clearing cs_msg_lock_owner must not move up */
+	barrier();
+	cs_msg_lock_owner = -1;
+	spin_unlock(&cs_msg_lock);
+	return ret;
+}
+
+/* At the start of a notify_chain, all cpus are driven into this routine, via
+ * cs_common_cpu().  It is a dummy callback, cs_common_cpu() takes care of
+ * holding the slave cpus until the end of the notify_chain.
+ */
+static void
+cs_notify_callback(int monarch, void *data)
+{
+}
+
+/* Called by the arch specific crash_stop code, when they see a notify_chain()
+ * event that debug style code might care about.
+ */
+void
+cs_notify_chain_start(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+	WARN_ON(!irqs_disabled());
+	while (cs_leaving)
+		cs_cpu_relax_watchdog();
+	if (cs_lock_owner == cpu || cs_notify_chain_owner == cpu) {
+		/* This cpu is already the crash_stop monarch, so the slaves
+		 * are already stopped.  Ignore the fact that we are being
+		 * called from a notify_chain, instead any calls to crash_stop
+		 * from the chain will be treated as nested calls.
+		 */
+		++cs_notify_chain_depth;
+		return;
+	}
+retry:
+	spin_lock(&cs_lock);
+	if (cs_notify_chain_owner >= 0) {
+		/* another monarch is running a notify_chain, back off */
+		spin_unlock(&cs_lock);
+		cs_mdelay(1);
+		goto retry;
+	}
+	set_mb(cs_lock_owner, cpu);
+	set_mb(cs_notify_chain_owner, cpu);
+	set_mb(cs_lock_owner, -1);
+	spin_unlock(&cs_lock);
+	crash_stop(cs_notify_callback, NULL, NULL, regs, __FUNCTION__);
+}
+
+/* Called by the arch specific crash_stop code, when they reach the end of a
+ * notify_chain() event that debug style code might care about.  It is also
+ * called by notifier_call_chain() when it does an early termination of the
+ * chain, that call is required because the arch code will now not be called
+ * for the end of the chain.  For the latter case, do not assume that interupts
+ * are disabled.  Which in turn means using raw_smp_processor_id() to check if
+ * this cpu is running a notify_chain or not.
+ */
+void
+cs_notify_chain_end(void)
+{
+	int cpu = raw_smp_processor_id();
+	while (cs_leaving)
+		cs_cpu_relax_watchdog();
+	if (cs_lock_owner == cpu || cs_notify_chain_owner == cpu) {
+		WARN_ON(!irqs_disabled());
+		if (cs_notify_chain_depth) {
+			/* end of a nested chain */
+			--cs_notify_chain_depth;
+			return;
+		}
+		spin_lock(&cs_lock);
+		set_mb(cs_lock_owner, cpu);
+		/* barrier: setting cs_notify_chain_ended must not move down */
+		set_mb(cs_notify_chain_ended, 1);
+		while (atomic_read(&cs_common_cpu_slaves))
+			cs_cpu_relax_watchdog();
+		set_mb(cs_notify_chain_ended, 0);
+		set_mb(cs_notify_chain_owner, -1);
+		set_mb(cs_lock_owner, -1);
+		spin_unlock(&cs_lock);
+	}
+}
+
+static void
+cs_online_cpu_status(const char *text)
+{
+#ifdef	CONFIG_SMP
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
+			"All cpus are in crash_stop for %s\n", text);
+	else {
+		int first_print = 1, start = -1, stop = -1;
+		cs_global.print("%d cpu%s ",
+			unknown,
+			unknown == 1 ? "" : "s");
+		for (cpu = 0; cpu <= NR_CPUS; ++cpu) {
+			if (cpu == NR_CPUS ||
+			    !cpu_online(cpu) ||
+			    cpu_isset(cpu, cs_cpu_mask) ||
+			    cpu == smp_processor_id())
+				stop = cpu;
+			if (stop >= 0 && start >= 0) {
+				if (first_print) {
+					cs_global.print("(");
+					first_print = 0;
+				} else {
+					cs_global.print(", ");
+				}
+				cs_global.print("%d", start);
+				if (stop - 1 > start)
+					cs_global.print("-%d", stop - 1);
+				stop = -1;
+				start = -1;
+			}
+			if (cpu < NR_CPUS &&
+			    cpu_online(cpu) &&
+			    !cpu_isset(cpu, cs_cpu_mask) &&
+			    cpu != smp_processor_id() &&
+			    start < 0)
+				start = cpu;
+		}
+		cs_global.print(") %s not in crash_stop for %s, %s state is unknown\n",
+			unknown == 1 ? "is" : "are",
+			text,
+			unknown == 1 ? "its" : "their");
+	}
+#else	/* !CONFIG_SMP */
+	cs_global.print(
+		"All cpus are in crash_stop for %s\n", text);
+#endif	/* CONFIG_SMP */
+}
+
+#ifdef	CONFIG_SMP
+/* Should only be called by the arch interrupt handlers, when the slave cpus
+ * receive the crash_stop specific IPI.
+ */
+void
+cs_common_ipi(void)
+{
+	while (cs_leaving)
+		cs_cpu_relax_watchdog();
+	if (!cs_global.callback) {
+		printk(KERN_DEBUG "Ignoring late cs_ipi on cpu %d\n",
+		       smp_processor_id());
+		return;
+	}
+	crash_stop_slave();
+}
+
+/* Should only be called by the arch specific NMI handlers, to see if this NMI
+ * is for crash_stop or for something else.  On most architectures, an NMI
+ * signal carries no state so we have to maintain an external state to indicate
+ * why it was sent.
+ *
+ * Note: this function is only valid when a slave is entering crash_stop()
+ * state.  Due to races between the time that the monarch releases a slave and
+ * the slave actually exiting, it is not safe to call this routine while a
+ * slave is leaving.  It is up to the calling code to save the state of
+ * crash_stop_sent_nmi() on entry if they need to test it on exit.
+ */
+int
+crash_stop_sent_nmi(void)
+{
+	return cpu_isset(smp_processor_id(), cs_sent_nmi);
+}
+#endif	/* CONFIG_SMP */
+
+/* Should only be called by the arch specific crash_stop code, after they have
+ * saved any arch specific state.  The call chain is :-
+ *
+ * crash_stop() [monarch] or cs_common_ipi() [slave] ->
+ *   crash_stop_slave() [common front end code] ->
+ *     cs_arch_cpu() [arch dependent code] ->
+ *       cs_common_cpu() [common back end code] ->
+ *         external crash_stop callback
+ *
+ * When cs_common_cpu() is entered for a slave cpu, it must spin while
+ * cs_monarch < 0.  That enforces the order of slave callbacks first, then
+ * monarch callback.
+ *
+ * When handling a notify_chain, park the slave cpus in this holding routine
+ * while the monarch cpu runs down the notify_chain.  If any entry on the
+ * notify_chain calls crash_stop_slave() than release the slaves to the
+ * corresponding crash_stop callback.  On return from the callback, put them
+ * back in a holding loop.  The state of the slave cpus is not significantly
+ * changed by this process and each caller of crash_stop_slave() gets the same
+ * data in crash_stop_running_process.  IOW, all entries on the notify_chain
+ * see the state that was saved by the first crash_stop entry on the chain, not
+ * some state that changes as the monarch runs the notify_chain.
+ */
+void
+cs_common_cpu(int monarch)
+{
+	if (monarch) {
+		if (!cs_recovered) {
+			++cs_monarch_depth;
+			cs_global.callback(1, cs_global.data);
+			--cs_monarch_depth;
+		}
+		return;
+	}
+	atomic_inc(&cs_common_cpu_slaves);
+	do {
+		/* slaves wait until the monarch enters */
+		while (cs_monarch < 0 && !cs_notify_chain_ended)
+			cs_cpu_relax_watchdog();
+		if (cs_notify_chain_ended)
+			break;
+		if (!cs_recovered)
+			cs_global.callback(0, cs_global.data);
+		/* slaves wait until the monarch leaves */
+		while (cs_monarch >= 0)
+			cs_cpu_relax_watchdog();
+	} while (cs_notify_chain_owner >= 0);
+	atomic_dec(&cs_common_cpu_slaves);
+}
+
+#ifdef	CONFIG_SMP
+/* The monarch has to wait for the slaves to enter crash_stop state.  Wait for
+ * up to 3 seconds plus an extra 100 ms per online cpu to cope with live lock
+ * on systems with large cpu counts.  These are arbitrary numbers, it might be
+ * worth exposing them as /sys values so sites can tune their debugging.
+ * Review this after we have more experience with this code - KAO.
+ */
+static void
+cs_wait_for_cpus(void)
+{
+	int count, prev_count = 0, sent_nmi = 0, t, wait_secs, slaves, cpu;
+	slaves = num_online_cpus() - 1;
+	wait_secs = 3 + (slaves * 100) / 1000;
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
+				count+1, slaves+1, wait_secs-t);
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
+				smp_wmb();
+				cs_arch_send_nmi(cpu);
+			}
+		}
+		if (t % 4 == 0)
+			cs_global.print(".");
+	}
+}
+#endif	/* CONFIG_SMP */
+
+static void
+cs_stop_the_slaves(void)
+{
+#ifdef	CONFIG_SMP
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
+#endif	/* CONFIG_SMP */
+}
+
+/**
+ * cs_cpu: - Put the current cpu into crash_stop state.
+ * @monarch: 0 for a slave cpu, 1 for the monarch cpu.
+ *
+ * Invoked on every cpu that is being stopped, with no externally defined order
+ * between monarch and slaves.  The arch independent running state is saved
+ * here, then cs_arch_cpu() saves any arch specific state, followed by
+ * invocation of cs_common_cpu() which drives the callback routine.
+ */
+static void
+cs_cpu(int monarch)
+{
+	struct crash_stop_running_process *r, prev;
+	int cpu = smp_processor_id();
+	cpu_set(cpu, cs_cpu_mask);
+	r = crash_stop_running_process + cpu;
+	prev = *r;
+	r->p = current;
+	r->regs = get_irq_regs();
+	r->prev = &prev;
+	if (!prev.p) {
+		if (monarch) {
+			/* Top level call to crash_stop().  Delay 10 ms to give
+			 * the slave callbacks (see cs_common_cpu()) a chance
+			 * to get started before running the callback on the
+			 * monarch.
+			 */
+			set_mb(cs_monarch, cpu);
+			cs_mdelay(10);
+		}
+	}
+	cs_arch_cpu(monarch, r);
+	*r = prev;
+	if (!prev.p) {
+		if (monarch) {
+			set_mb(cs_leaving, 1);
+			set_mb(cs_monarch, -1);
+		}
+		cpu_clear(cpu, cs_sent_ipi);
+		cpu_clear(cpu, cs_sent_nmi);
+		/* barrier: cs_cpu_mask functions as the main filter
+		 * for the state of the cpus, flush preceding updates
+		 * to memory before clearing cs_cpu_mask.
+		 */
+		smp_mb__before_clear_bit();
+		cpu_clear(cpu, cs_cpu_mask);
+	}
+}
+
+#ifdef	CONFIG_SMP
+/* crash_stop_slave: - Put the current slave cpu into crash_stop state.  */
+void
+crash_stop_slave(void)
+{
+	while (cs_leaving)
+		cs_cpu_relax_watchdog();
+	cs_cpu(0);
+}
+#endif	/* CONFIG_SMP */
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
+ * This function cannot assume that the caller has already saved the pt_regs,
+ * so it does it anyway.  Some callers (e.g. oops) will have called
+ * set_irq_regs(), others (e.g. NMI watchdog) will not.
+ *
+ * Returns: 0 normal
+ *          -ENOSYS crash_stop is not supported on this architecture.
+ */
+
+int
+crash_stop(void (*callback)(int monarch, void *data),
+	   void *data, printk_t print,
+	   struct pt_regs *regs, const char *text)
+{
+	int cpu;
+	struct cs_global csg_save, csg = {
+		.callback = callback,
+		.data = data,
+		.print = print ? print : cs_printk,
+	};
+	struct pt_regs *old_regs;
+
+	WARN_ON(!irqs_disabled());
+retry:
+	if (!spin_trylock(&cs_lock)) {
+		if (cs_lock_owner == smp_processor_id()) {
+			/* nested call on the same cpu */
+			csg_save = cs_global;
+			cs_set_mb(cs_global, csg);
+			cs_online_cpu_status(text);
+			cs_cpu(1);
+			cs_set_mb(cs_global, csg_save);
+			return 0;
+		}
+		/* concurrent call on another cpu */
+		while (cs_lock_owner != -1)
+			cs_cpu_relax_watchdog();
+		goto retry;
+	}
+
+	if (cs_leaving) {
+		/* previous crash stop has not quite completed, back off */
+		spin_unlock(&cs_lock);
+		cs_mdelay(1);
+		goto retry;
+	}
+
+	if (cs_notify_chain_owner >= 0 &&
+	    cs_notify_chain_owner != smp_processor_id()) {
+		/* another cpu is running a notify_chain, back off */
+		spin_unlock(&cs_lock);
+		cs_mdelay(1);
+		goto retry;
+	}
+
+	set_mb(cs_lock_owner, smp_processor_id());
+	old_regs = set_irq_regs(regs);
+	csg_save = cs_global;
+	cs_set_mb(cs_global, csg);
+	cs_stop_the_slaves();
+	cs_online_cpu_status(text);
+	cs_cpu(1);
+	set_mb(cs_leaving, 1);
+	if (cs_monarch < 0 && cs_notify_chain_owner < 0) {
+		/* leaving a normal call, wait for the slaves to exit */
+		for_each_online_cpu(cpu) {
+			while (cpu_isset(cpu, cs_cpu_mask))
+				cs_cpu_relax_watchdog();
+		}
+	}
+	cs_set_mb(cs_global, csg_save);
+	set_mb(cs_lock_owner, -1);
+	set_irq_regs(old_regs);
+	spin_unlock(&cs_lock);
+	set_mb(cs_leaving, 0);
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
+ * If the code that calls crash_stop_recovered() is in a notify_chain then the
+ * caller must call cs_notify_chain_end() before crash_stop_recovered().
+ * Calling this function when this cpu is the notify_chain owner is assumed to
+ * be a nested call and it is silently ignored.  IOW it is a recovery from a
+ * nested event and we want to hold the slaves until we exit from the top level
+ * of crash_stop code.
+ */
+void
+crash_stop_recovered(void)
+{
+	int cpu, any_slaves = 0;
+
+	WARN_ON(!irqs_disabled());
+	while (cs_leaving)
+		cs_cpu_relax_watchdog();
+	if (cs_notify_chain_owner >= 0 &&
+	    cs_notify_chain_owner == smp_processor_id())
+		return;
+retry:
+	spin_lock(&cs_lock);
+	if (cs_notify_chain_owner >= 0) {
+		/* another cpu is running a notify_chain, back off */
+		spin_unlock(&cs_lock);
+		cs_mdelay(1);
+		goto retry;
+	}
+	set_mb(cs_lock_owner, smp_processor_id());
+	for_each_online_cpu(cpu) {
+		if (cpu_isset(cpu, cs_cpu_mask) &&
+		    cpu != smp_processor_id()) {
+			any_slaves = 1;
+			break;
+		}
+	}
+	if (any_slaves) {
+		/* give cs_stop_the_slaves/cs_wait_for_cpus a safe print
+		 * routine.
+		 */
+		struct cs_global csg_save, csg = {
+			.print = cs_printk,
+		};
+		csg_save = cs_global;
+		cs_set_mb(cs_global, csg);
+		cs_stop_the_slaves();
+		cs_set_mb(cs_global, csg_save);
+	}
+	set_mb(cs_recovered, 1);
+	set_mb(cs_monarch, smp_processor_id());
+	for_each_online_cpu(cpu) {
+		while (cpu_isset(cpu, cs_cpu_mask))
+			cs_cpu_relax_watchdog();
+	}
+	set_mb(cs_recovered, 0);
+	set_mb(cs_monarch, -1);
+	set_mb(cs_lock_owner, -1);
+	spin_unlock(&cs_lock);
+	return;
+}
+
+/**
+ * crash_stop_slaves: - Return the number of slave cpus that the user will see.
+ *
+ * For a non-nested call, the user will see all the cpus that are in crash_stop
+ * state.  For a nested call, the user will not see any slave cpus.
+ */
+int
+crash_stop_slaves(void)
+{
+	if (cs_monarch_depth == 1)
+		return atomic_read(&cs_common_cpu_slaves);
+	else
+		return 0;
+}
Index: linux/kernel/sys.c
===================================================================
--- linux.orig/kernel/sys.c
+++ linux/kernel/sys.c
@@ -29,6 +29,7 @@
 #include <linux/signal.h>
 #include <linux/cn_proc.h>
 #include <linux/getcpu.h>
+#include <linux/crash_stop.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -144,8 +145,10 @@ static int __kprobes notifier_call_chain
 	while (nb) {
 		next_nb = rcu_dereference(nb->next);
 		ret = nb->notifier_call(nb, val, v);
-		if ((ret & NOTIFY_STOP_MASK) == NOTIFY_STOP_MASK)
+		if ((ret & NOTIFY_STOP_MASK) == NOTIFY_STOP_MASK) {
+			cs_notify_chain_end();
 			break;
+		}
 		nb = next_nb;
 	}
 	return ret;
