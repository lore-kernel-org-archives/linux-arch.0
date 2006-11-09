Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:3969 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424038AbWKIEFb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2006 23:05:31 -0500
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id kA96mZN6005464
	for <@external-mail-relay.sgi.com:linux-arch@vger.kernel.org>; Wed, 8 Nov 2006 22:48:36 -0800
From: Keith Owens <kaos@sgi.com>
Date: Thu, 09 Nov 2006 15:05:25 +1100
Message-Id: <20061109040525.17391.67396.sendpatchset@chook.melbourne.sgi.com>
In-Reply-To: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
References: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
Subject: [patch 2.6.19-rc5 12/12] crash_stop: test code
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Keith Owens <kaos@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

A quick and dirty crash_stop() test program.  Most of the code is to
get the machine into a suitable state for testing both the normal IPI
and NMI code.  The interesting crash_stop bits are cs_test_callback*()
and simulate_crash_stop_event().

No signed-off-by, this code is not going into the kernel.
---
 kernel/Makefile          |    1 
 kernel/crash_stop_test.c |  177 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug        |   11 ++
 3 files changed, 189 insertions(+)

Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile
+++ linux/kernel/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_TASK_DELAY_ACCT) += delayac
 obj-$(CONFIG_TASKSTATS) += taskstats.o tsacct.o
 obj-$(CONFIG_CRASH_STOP_SUPPORTED) += crash_stop.o
 obj-$(CONFIG_CRASH_STOP_DEMO) += crash_stop_demo.o
+obj-$(CONFIG_CRASH_STOP_TEST) += crash_stop_test.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux/kernel/crash_stop_test.c
===================================================================
--- /dev/null
+++ linux/kernel/crash_stop_test.c
@@ -0,0 +1,177 @@
+/*
+ * linux/kernel/crash_stop_test.c
+ *
+ * Copyright (C) 2006 Keith Owens <kaos@sgi.com>
+ *
+ * Test crash_stop().  This module requires at least 2 slave cpus, plus the
+ * monarch cpu.  One of the slaves is put into a disabled spin loop, the other
+ * slaves are left alone.  The monarch calls crash_stop().  Most of the slaves
+ * will respond to the normal IPI, the disabled cpu will only respond to NMI.
+ *
+ * If test_watchdog is non-zero, the monarch exercises the crash_stop code
+ * that handles the NMI watchdog, but only on i386 or x86_64.  After putting
+ * one of the other cpus into a disabled spin, the monarch itself spins
+ * disabled.  When the nmi_watchdog trips (boot with nmi_watchdog=1 or
+ * nmi_watchdog=2), the kernel drives the notify_die chain with
+ * DIE_NMIWATCHDOG.
+ *
+ * If test_oops is non-zero, the monarch generates an oops.
+ *
+ * For both test_watchdog=1 and test_oops=1, you will first need to load a
+ * debug style tool that uses crash_stop and intercepts DIE_NMIWATCHDOG and
+ * DIE_OOPS.  modprobe crash_stop_demo will work, or you can load and test your
+ * own tool.
+ */
+
+#include <linux/cpumask.h>
+#include <linux/crash_stop.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/nmi.h>
+#include <asm/kdebug.h>
+
+MODULE_LICENSE("GPL");
+
+static int test_watchdog;
+static int test_oops;
+
+module_param(test_watchdog, int, 0444);
+module_param(test_oops, int, 0444);
+
+static int cs_test_do_spin, cs_test_spinning;
+static DECLARE_COMPLETION(cs_test_done);
+
+#ifdef	CONFIG_X86
+static int
+cs_test_notify(struct notifier_block *self,
+	       unsigned long val, void *data)
+{
+	switch(val) {
+	case DIE_NMIWATCHDOG:
+		test_watchdog = 0;
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cs_test_nb = {
+	.notifier_call = cs_test_notify,
+	.priority = 20,
+};
+#endif	/* CONFIG_X86 */
+
+static void
+cs_test_callback(int monarch, void *data)
+{
+	printk("%s: cpu %d monarch %d\n",
+	       __FUNCTION__, smp_processor_id(), monarch);
+	set_mb(cs_test_do_spin, 0);
+	set_mb(test_watchdog, 0);
+}
+
+static void
+simulate_crash_stop_event(void)
+{
+	oops_in_progress = 1;
+	if (test_oops)
+		BUG();
+	printk("%s: cpu %d starting\n", __FUNCTION__, smp_processor_id());
+	local_irq_disable();
+	while (test_watchdog)
+		cpu_relax();
+	/* crash_stop() is usually called from an error state where pt_regs are
+	 * available and interrupts are already disabled.  For the test, use a
+	 * NULL pt_regs and disable interrupts by hand.  Use printk as the test
+	 * I/O routine, even though that is not always a good choice (not NMI
+	 * safe).
+	 */
+	crash_stop(cs_test_callback, NULL, printk, NULL, "cs_test");
+	local_irq_enable();
+	printk("%s: cpu %d leaving\n", __FUNCTION__, smp_processor_id());
+}
+
+/* spin disabled on one cpu until the crash_stop test has finished */
+static int
+cs_test_spin(void *vdata)
+{
+	set_mb(cs_test_spinning, 1);
+	if (test_watchdog)
+		mdelay(2000);
+	local_irq_disable();
+	while (cs_test_do_spin) {
+		if (!test_watchdog)
+			touch_nmi_watchdog();
+		cpu_relax();
+		mb();
+	}
+	printk("%s: cpu %d leaving\n", __FUNCTION__, smp_processor_id());
+	local_irq_enable();
+	complete(&cs_test_done);
+	do_exit(0);
+}
+
+/* Get the various cpus into a suitable state for testing crash_stop(),
+ * including NMI processing.  In real life, the system would already be dying
+ * before crash_stop() was invoked.
+ */
+static int __init
+cs_test_init(void)
+{
+	struct task_struct *p;
+	int c, disabled = 0, this_cpu = get_cpu(), slaves = 0;
+	oops_in_progress = 1;
+
+	printk("%s: monarch is cpu %d\n",
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
+#ifdef	CONFIG_X86
+	if ((c = register_die_notifier(&cs_test_nb))) {
+		printk(KERN_ERR "%s: failed to register cs_test_nb\n",
+		       __FUNCTION__);
+		return c;
+	}
+#endif	/* CONFIG_X86 */
+
+	init_completion(&cs_test_done);
+	set_mb(cs_test_do_spin, 1);
+	p = kthread_create(cs_test_spin, NULL, "kcrash_stop_test");
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+	kthread_bind(p, disabled);
+	wake_up_process(p);
+	while (!cs_test_spinning)
+		cpu_relax();
+	printk("%s: cpu %d is spinning disabled\n",
+	       __FUNCTION__, disabled);
+
+	simulate_crash_stop_event();
+
+	set_mb(cs_test_do_spin, 0);
+	wait_for_completion(&cs_test_done);
+	return 0;
+}
+
+static void __exit
+cs_test_exit(void)
+{
+#ifdef	CONFIG_X86
+	unregister_die_notifier(&cs_test_nb);
+#endif	/* CONFIG_X86 */
+}
+
+module_init(cs_test_init)
+module_exit(cs_test_exit)
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -430,3 +430,14 @@ config CRASH_STOP_DEMO
           call crash_stop.  All slave cpus bar one will get a normal
           IPI, the spinning cpu will get NMI.  You need at least 3 cpus
           to run crash_stop_demo.
+
+config CRASH_STOP_TEST
+	tristate "Test crash_stop"
+	default m
+	help
+          Code to test the use of crash_stop.  Build it as a module and
+          load it.  It will make one cpu spin disabled then generate an
+          oops or NMI.  All slave cpus bar one will get a normal IPI,
+          the spinning cpu will get NMI.  You need at least 3 cpus to
+          run crash_stop_test.  You can also test the NMI watchdog and
+          oops handling of crash_stop, see kernel/crash_stop_test.c.
