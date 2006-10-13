Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:40385 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750780AbWJMN23 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Oct 2006 09:28:29 -0400
Received: from ocs3.ocs.com.au (ocs3w.ocs.com.au [192.168.254.3])
	by mail.ocs.com.au (Postfix) with ESMTP id 1E71FE0B20A
	for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2006 23:28:28 +1000 (EST)
Received: from ocs3.ocs.com.au (localhost [127.0.0.1])
	by ocs3.ocs.com.au (Postfix) with ESMTP id 636CC81EE7
	for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2006 23:28:50 +1000 (EST)
From: Keith Owens <kaos@sgi.com>
Subject: [RFC] crash_stop: crash_stop_demo
In-reply-to: Your message of "Fri, 13 Oct 2006 23:23:35 +1000."
             <26656.1160745815@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Oct 2006 23:28:50 +1000
Message-ID: <28291.1160746130@ocs3.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

A quick and dirty crash_stop() demo program.  Most of the code is to
get the machine into a suitable state for testing both the normal IPI
and NMI code.  The interesting crash_stop bits are cs_demo_callback*()
and simulate_crash_stop_event().

The base patch does not export any crash_stop() symbols.  They can be
added later if any debug style code can be installed in a module.
Since the demo is best used as a module, this patch temporarilly
exports some symbols.

---
 kernel/Makefile          |    1 
 kernel/crash_stop.c      |    5 +
 kernel/crash_stop_demo.c |  160 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug        |   12 +++
 4 files changed, 177 insertions(+), 1 deletion(-)

Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile
+++ linux/kernel/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_UTS_NS) += utsname.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
 obj-$(CONFIG_TASKSTATS) += taskstats.o tsacct.o
 obj-$(CONFIG_CRASH_STOP_SUPPORTED) += crash_stop.o
+obj-$(CONFIG_CRASH_STOP_DEMO) += crash_stop_demo.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux/kernel/crash_stop.c
===================================================================
--- linux.orig/kernel/crash_stop.c
+++ linux/kernel/crash_stop.c
@@ -134,6 +134,7 @@
 #include <linux/delay.h>
 #include <linux/crash_stop.h>
 #include <linux/kernel.h>
+#include <linux/module.h>		/* used by crash_stop_demo */
 #include <linux/ptrace.h>
 #include <linux/nmi.h>
 #include <linux/spinlock.h>
@@ -255,6 +256,7 @@ crash_stop_sent_nmi(void)
 {
 	return cpu_isset(smp_processor_id(), cs_sent_nmi);
 }
+EXPORT_SYMBOL(crash_stop_sent_nmi);	/* used by crash_stop_demo */
 
 /* Should only be called by the arch specific crash_stop code, after they have
  * saved any arch specific state.  The call chain is :-
@@ -307,7 +309,7 @@ cs_wait_for_cpus(void)
 {
 	int count, prev_count = 0, sent_nmi = 0, t, wait_secs, slaves, cpu;
 	slaves = num_online_cpus() - 1;
-	wait_secs = min(3, (slaves * 100) / 1000);
+	wait_secs = 3 + (slaves * 100) / 1000;
 	cs_mdelay(100);
 	for (t = 0; t < wait_secs; ++t) {
 		count = 0;
@@ -495,6 +497,7 @@ retry:
 	spin_unlock(&cs_lock);
 	return 0;
 }
+EXPORT_SYMBOL(crash_stop);		/* used by crash_stop_demo */
 
 /**
  * crash_stop_recovered: - Release any slaves in crash_stop state.
Index: linux/kernel/crash_stop_demo.c
===================================================================
--- /dev/null
+++ linux/kernel/crash_stop_demo.c
@@ -0,0 +1,160 @@
+/*
+ * linux/arch/i386/crash_stop_demo.c
+ *
+ * Copyright (C) 2006 Keith Owens <kaos@sgi.com>
+ *
+ * Demonstrate the use of crash_stop().  This module requires at least 2 slave
+ * cpus, plus the monarch cpu.  One of the slaves is put into a disabled spin
+ * loop, the other slaves are left alone.  The monarch calls crash_stop().
+ * Most of the slaves will respond to the normal IPI, the disabled cpu will
+ * only respond to NMI.
+ */
+
+#include <linux/cpumask.h>
+#include <linux/crash_stop.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/nmi.h>
+
+MODULE_LICENSE("GPL");
+
+/* The callback function passed to crash_stop() is invoked on each cpu that is
+ * in crash_stop state.  The main crash_stop() code will ensure that slaves are
+ * entered first, followed by the monarch after a short delay.  The debug
+ * specific callback then does its own work.
+ */
+
+static int cs_demo_monarch_entered, cs_demo_monarch_exited;
+
+static void
+cs_demo_callback_monarch(void *data) {
+	printk(KERN_ALERT "%s: entering monarch cpu %d\n",
+	       __FUNCTION__, smp_processor_id());
+	cs_demo_monarch_entered = 1;
+	wmb();
+	/* Monarch callback processing using data and struct
+	 * crash_stop_running_process goes here.
+	 */
+	cs_demo_monarch_exited = 1;
+	wmb();
+}
+
+static void
+cs_demo_callback_slave(void *data) {
+	printk(KERN_ALERT "%s: entering slave cpu %d via %s\n",
+	       __FUNCTION__, smp_processor_id(),
+	       crash_stop_sent_nmi() ? "NMI" : "IPI");
+	while (!cs_demo_monarch_entered) {
+		touch_nmi_watchdog();
+		cpu_relax();
+	}
+	/* Slave callback processing using data goes here.   In most cases the
+	 * slaves will just spin until the monarch releases them.  The main
+	 * crash_stop() code saves the state for each slave cpu before entering
+	 * the callback.  The monarch can used that saved state without the
+	 * slave callback doing any more work.
+	 */
+	while (!cs_demo_monarch_exited) {
+		touch_nmi_watchdog();
+		cpu_relax();
+	}
+}
+
+static void
+cs_demo_callback(int monarch, void *data)
+{
+	if (monarch)
+		cs_demo_callback_monarch(data);
+	else
+		cs_demo_callback_slave(data);
+	printk(KERN_ALERT "%s: leaving cpu %d\n",
+	       __FUNCTION__, smp_processor_id());
+}
+
+/* crash_stop() is usually called from an error state where pt_regs are
+ * available and interrupts are already disabled.  For the demo, use a NULL
+ * pt_regs and disable interrupts by hand.  Use printk as the demo I/O routine,
+ * even though that is not always a good choice (not NMI safe).
+ */
+static void
+simulate_crash_stop_event(void)
+{
+	printk(KERN_ALERT "%s: before crash_stop()\n", __FUNCTION__);
+	local_irq_disable();
+	crash_stop(cs_demo_callback, NULL, NULL, printk, "cs_demo");
+	local_irq_enable();
+	printk(KERN_ALERT "%s: after crash_stop()\n", __FUNCTION__);
+}
+
+static int cs_demo_do_spin = 1, cs_demo_spinning;
+static DECLARE_COMPLETION(cs_demo_done);
+
+/* spin disabled on one cpu until the crash_stop test has finished */
+static int
+cs_demo_spin(void *vdata)
+{
+	local_irq_disable();
+	cs_demo_spinning = 1;
+	wmb();
+	while (cs_demo_do_spin) {
+		touch_nmi_watchdog();
+		cpu_relax();
+	}
+	local_irq_enable();
+	complete(&cs_demo_done);
+	do_exit(0);
+}
+
+/* Ignore most of this routine, the complexity comes from getting the various
+ * cpus into a suitable state for testing crash_stop(), including NMI
+ * processing.  In real life, the system would already be dying before
+ * crash_stop() was invoked.
+ */
+static int __init
+cs_demo_init(void)
+{
+	struct task_struct *p;
+	int c, disabled = 0, this_cpu = get_cpu(), slaves = 0;
+
+	printk(KERN_ALERT "%s: monarch is cpu %d\n",
+	       __FUNCTION__, this_cpu);
+	set_cpus_allowed(current, cpumask_of_cpu(this_cpu));
+	put_cpu();
+	for_each_online_cpu(c) {
+		if (c != this_cpu) {
+			++slaves;
+			disabled = c;
+		}
+	}
+	if (slaves < 2) {
+		printk(KERN_ERR "%s needs at least two slave cpus\n",
+		       __FUNCTION__);
+		return -EINVAL;
+	}
+
+	init_completion(&cs_demo_done);
+	p = kthread_create(cs_demo_spin, NULL, "kcrash_stop_demo");
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+	kthread_bind(p, disabled);
+	wake_up_process(p);
+	while (!cs_demo_spinning)
+		cpu_relax();
+	printk(KERN_ALERT "%s: cpu %d is spinning disabled\n",
+	       __FUNCTION__, disabled);
+
+	simulate_crash_stop_event();
+
+	cs_demo_do_spin = 0;
+	wmb();
+	wait_for_completion(&cs_demo_done);
+	return 0;
+}
+
+static void __exit
+cs_demo_exit(void)
+{
+}
+
+module_init(cs_demo_init)
+module_exit(cs_demo_exit)
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -405,3 +405,15 @@ config CRASH_STOP
 
 config CRASH_STOP_SUPPORTED
 	bool
+
+config CRASH_STOP_DEMO
+	tristate "Demonstrate the use of crash_stop"
+	default m
+	depends on SMP
+	select CRASH_STOP
+	help
+          Code to demonstrate the use of crash_stop.  Build it as a
+          module and load it.  It will make one cpu spin disabled then
+          call crash_stop.  All slave cpus bar one will get a normal
+          IPI, the spinning cpu will get NMI.  You need at least 3 cpus
+          to run crash_stop_demo.

