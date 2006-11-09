Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:3201 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424035AbWKIEFZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2006 23:05:25 -0500
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id kA96mU80005461
	for <@external-mail-relay.sgi.com:linux-arch@vger.kernel.org>; Wed, 8 Nov 2006 22:48:31 -0800
From: Keith Owens <kaos@sgi.com>
Date: Thu, 09 Nov 2006 15:05:20 +1100
Message-Id: <20061109040520.17391.74072.sendpatchset@chook.melbourne.sgi.com>
In-Reply-To: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
References: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
Subject: [patch 2.6.19-rc5 11/12] crash_stop: demonstration code
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Keith Owens <kaos@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

A quick and dirty crash_stop() demo program.

Notice that this demo is almost completely architecture independent.
It has no code to do per architecture IPI/NMI, nor does it need to save
any per cpu state - all of that is handled by the common code.  IOW, a
debug style tool can concentrate on its own requirements, leaving all
the complicated code to the crash_stop API.

The base patch does not export any crash_stop() symbols.  They can be
added later if any debug style code can be installed in a module.
Since the demo is best used as a module, this patch temporarilly
exports some symbols.

No signed-off-by, this code is not going into the kernel.
---
 kernel/Makefile          |    1 
 kernel/crash_stop.c      |    6 +-
 kernel/crash_stop_demo.c |  134 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug        |   11 +++
 4 files changed, 151 insertions(+), 1 deletion(-)

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
@@ -197,6 +197,7 @@
 #include <linux/crash_stop.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/module.h>		/* used by crash_stop_demo */
 #include <linux/ptrace.h>
 #include <linux/nmi.h>
 #include <linux/spinlock.h>
@@ -335,7 +336,7 @@ retry:
 	set_mb(cs_notify_chain_owner, cpu);
 	set_mb(cs_lock_owner, -1);
 	spin_unlock(&cs_lock);
-	crash_stop(cs_notify_callback, NULL, NULL, regs, __FUNCTION__);
+	crash_stop(cs_notify_callback, NULL, printk, regs, __FUNCTION__);
 }
 
 /* Called by the arch specific crash_stop code, when they reach the end of a
@@ -463,6 +464,7 @@ crash_stop_sent_nmi(void)
 {
 	return cpu_isset(smp_processor_id(), cs_sent_nmi);
 }
+EXPORT_SYMBOL(crash_stop_sent_nmi);	/* used by crash_stop_demo */
 #endif	/* CONFIG_SMP */
 
 /* Should only be called by the arch specific crash_stop code, after they have
@@ -752,6 +754,7 @@ retry:
 	set_mb(cs_leaving, 0);
 	return 0;
 }
+EXPORT_SYMBOL(crash_stop);		/* used by crash_stop_demo */
 
 /**
  * crash_stop_recovered: - Release any slaves in crash_stop state.
@@ -841,3 +844,4 @@ crash_stop_slaves(void)
 	else
 		return 0;
 }
+EXPORT_SYMBOL(crash_stop_slaves);	/* used by crash_stop_demo */
Index: linux/kernel/crash_stop_demo.c
===================================================================
--- /dev/null
+++ linux/kernel/crash_stop_demo.c
@@ -0,0 +1,134 @@
+/*
+ * linux/kernel/crash_stop_demo.c
+ *
+ * Copyright (C) 2006 Keith Owens <kaos@sgi.com>
+ *
+ * Demonstrate the use of crash_stop() by debug style code.
+ */
+
+#include <linux/crash_stop.h>
+#include <linux/module.h>
+#include <linux/nmi.h>
+#include <asm/kdebug.h>
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
+atomic_t slave_count;
+
+static void
+cs_demo_callback_monarch(void *data) {
+	printk("%s: entering monarch cpu %d\n",
+	       __FUNCTION__, smp_processor_id());
+	if (cs_demo_monarch_entered) {
+		printk("%s: recursive call detected\n", __FUNCTION__);
+		return;
+	}
+	set_mb(cs_demo_monarch_entered, 1);
+	/* wait for all the slaves to enter */
+	while (atomic_read(&slave_count) != crash_stop_slaves()) {
+		touch_nmi_watchdog();
+		cpu_relax();
+	}
+
+	/* Monarch callback processing using data and struct
+	 * crash_stop_running_process goes here.
+	 */
+
+	set_mb(cs_demo_monarch_exited, 1);
+	/* wait for all the slaves to leave */
+	while (atomic_read(&slave_count)) {
+		touch_nmi_watchdog();
+		cpu_relax();
+	}
+	/* reset state for next entry */
+	set_mb(cs_demo_monarch_entered, 0);
+	set_mb(cs_demo_monarch_exited, 0);
+}
+
+static void
+cs_demo_callback_slave(void *data) {
+	printk("%s: entering slave cpu %d via %s\n",
+	       __FUNCTION__, smp_processor_id(),
+	       crash_stop_sent_nmi() ? "NMI" : "IPI");
+	atomic_inc(&slave_count);
+	while (!cs_demo_monarch_entered) {
+		touch_nmi_watchdog();
+		cpu_relax();
+	}
+	/* Slave callback processing using data goes here.   In most cases the
+	 * slaves will just spin until the monarch releases them.  The main
+	 * crash_stop() code saves the state for each slave cpu before entering
+	 * the callback.  The monarch can used that saved state without the
+	 * callback on the slave cpu doing any more work.
+	 */
+	while (!cs_demo_monarch_exited) {
+		touch_nmi_watchdog();
+		cpu_relax();
+	}
+	atomic_dec(&slave_count);
+}
+
+static void
+cs_demo_callback(int monarch, void *data)
+{
+	if (monarch)
+		cs_demo_callback_monarch(data);
+	else
+		cs_demo_callback_slave(data);
+	printk("%s: leaving cpu %d\n",
+	       __FUNCTION__, smp_processor_id());
+}
+
+/* Handle various kernel error conditions. */
+static int
+cs_demo_notify(struct notifier_block *self,
+	       unsigned long val, void *data)
+{
+	struct die_args *args = data;
+	switch(val) {
+#ifdef	CONFIG_X86
+	case DIE_NMIWATCHDOG:
+#endif
+#ifdef	CONFIG_IA64
+	case DIE_MCA_MONARCH_LEAVE:
+	case DIE_INIT_MONARCH_LEAVE:
+#endif
+	case DIE_OOPS:
+		crash_stop(cs_demo_callback, NULL, printk, args->regs, __FUNCTION__);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cs_demo_nb = {
+	.notifier_call = cs_demo_notify,
+	.priority = 100,
+};
+
+static int __init
+cs_demo_init(void)
+{
+	int err;
+	if ((err = register_die_notifier(&cs_demo_nb))) {
+		printk(KERN_ERR "%s: failed to register cs_demo_nb\n",
+		       __FUNCTION__);
+		return err;
+	}
+	return 0;
+}
+
+static void __exit
+cs_demo_exit(void)
+{
+	unregister_die_notifier(&cs_demo_nb);
+}
+
+module_init(cs_demo_init)
+module_exit(cs_demo_exit)
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -419,3 +419,14 @@ config CRASH_STOP
 
 config CRASH_STOP_SUPPORTED
 	bool
+
+config CRASH_STOP_DEMO
+	tristate "Demonstrate the use of crash_stop"
+	default m
+	select CRASH_STOP
+	help
+          Code to demonstrate the use of crash_stop.  Build it as a
+          module and load it.  It will make one cpu spin disabled then
+          call crash_stop.  All slave cpus bar one will get a normal
+          IPI, the spinning cpu will get NMI.  You need at least 3 cpus
+          to run crash_stop_demo.
