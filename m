Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:26412 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750749AbWJMN0d (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Oct 2006 09:26:33 -0400
Received: from ocs3.ocs.com.au (ocs3w.ocs.com.au [192.168.254.3])
	by mail.ocs.com.au (Postfix) with ESMTP id EDAFDE0B20A
	for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2006 23:26:31 +1000 (EST)
Received: from ocs3.ocs.com.au (localhost [127.0.0.1])
	by ocs3.ocs.com.au (Postfix) with ESMTP id 4334281EE7
	for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2006 23:26:54 +1000 (EST)
From: Keith Owens <kaos@sgi.com>
Subject: [RFC] crash_stop: crash_stop_i386
In-reply-to: Your message of "Fri, 13 Oct 2006 23:23:35 +1000."
             <26656.1160745815@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Oct 2006 23:26:54 +1000
Message-ID: <28237.1160746014@ocs3.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Add the i386 specific crash_stop code.  This contains routines that are
called from the common crash_stop code and from the i386 notify_die
chain.

Note 1: Not tested on visw nor voyager, no hardware.

Note 2: It is missing the code to handle a notify_chain (see scenario 4
        in kernel/crash_stop.c in a later patch).  I want to make sure
        that the API design is right before adding that code.

---
 arch/i386/kernel/Makefile     |    1 
 arch/i386/kernel/crash_stop.c |   75 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

Index: linux/arch/i386/kernel/Makefile
===================================================================
--- linux.orig/arch/i386/kernel/Makefile
+++ linux/arch/i386/kernel/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_VM86)		+= vm86.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 obj-$(CONFIG_K8_NB)		+= k8.o
+obj-$(CONFIG_CRASH_STOP_SUPPORTED)	+= crash_stop.o
 
 EXTRA_AFLAGS   := -traditional
 
Index: linux/arch/i386/kernel/crash_stop.c
===================================================================
--- /dev/null
+++ linux/arch/i386/kernel/crash_stop.c
@@ -0,0 +1,75 @@
+/*
+ * linux/arch/i386/crash_stop.c
+ *
+ * Copyright (C) 2006 Keith Owens <kaos@sgi.com>
+ *
+ * Most of the i386 specific bits of the crash_stop code.  There is a little
+ * bit of crash_stop code in arch/i386/kernel/{smp,smpboot}.c to handle
+ * CRASH_STOP_VECTOR, everything else is in this file.
+ */
+
+#include <linux/crash_stop.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <asm/kdebug.h>
+
+/* The starting point for a backtrace on a running process is set to
+ * cs_arch_cpu().  It would be nice to go up a couple of levels to start the
+ * backtrace where crash_stop() or cs_ipi() were invoked, but that is more work
+ * than I am willing to do in this function.  Starting the backtrace at
+ * cs_arch_cpu() is simple and reliable, which is exactly what we want when the
+ * machine is already failing.
+ */
+void
+cs_arch_cpu(int monarch, struct crash_stop_running_process *r)
+{
+	r->arch.esp = current_stack_pointer;
+	r->arch.eip = (unsigned long)current_text_addr();
+	/* separate any stack changes from current_stack_pointer above */
+	barrier();
+	cs_common_cpu(monarch);
+}
+
+/* Pick up any NMI IPIs that were sent by crash_stop. */
+static int
+crash_stop_arch_notify(struct notifier_block *self,
+		       unsigned long val, void *data)
+{
+	struct die_args *args = (struct die_args *)data;
+	switch(val) {
+	case DIE_NMI_IPI:
+		if (crash_stop_sent_nmi()) {
+			crash_stop_cpu(0, args->regs);
+			return NOTIFY_STOP;
+		}
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_stop_arch_nb = {
+	.notifier_call = crash_stop_arch_notify,
+	.priority = ~0 >> 1,
+};
+
+static int __init
+crash_stop_arch_init(void)
+{
+	int err = register_die_notifier(&crash_stop_arch_nb);
+	if (err) {
+		printk(KERN_ERR "Failed to register crash_stop_arch_nb\n");
+		return err;
+	}
+	return 0;
+}
+
+static void __exit
+crash_stop_arch_exit(void)
+{
+	unregister_die_notifier(&crash_stop_arch_nb);
+	return;
+}
+
+module_init(crash_stop_arch_init);
+module_exit(crash_stop_arch_exit);

