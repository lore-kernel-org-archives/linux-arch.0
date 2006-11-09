Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:62592 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424029AbWKIEEp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2006 23:04:45 -0500
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id kA96loJh005347
	for <@external-mail-relay.sgi.com:linux-arch@vger.kernel.org>; Wed, 8 Nov 2006 22:47:52 -0800
From: Keith Owens <kaos@sgi.com>
Date: Thu, 09 Nov 2006 15:04:41 +1100
Message-Id: <20061109040441.17391.12845.sendpatchset@chook.melbourne.sgi.com>
In-Reply-To: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
References: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
Subject: [patch 2.6.19-rc5 4/12] crash_stop: i386 specific code
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Keith Owens <kaos@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

Add the i386 specific crash_stop code.  This contains routines that are
called from the common crash_stop code and from the i386 notify_die
chain.

Note: Not tested on visw nor voyager, no hardware.

Signed-off-by: Keith Owens <kaos@sgi.com>
---
 arch/i386/kernel/Makefile     |    1 
 arch/i386/kernel/crash_stop.c |  127 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/crash_stop.h |   14 ++++
 3 files changed, 142 insertions(+)

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
@@ -0,0 +1,127 @@
+/*
+ * linux/arch/i386/crash_stop.c
+ *
+ * Copyright (C) 2006 Keith Owens <kaos@sgi.com>
+ *
+ * The i386 specific bits of the crash_stop code.  There is a little bit of
+ * crash_stop code in arch/i386/kernel/{smp,smpboot}.c to handle
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
+ * backtrace where crash_stop() or cs_common_ipi() were invoked, but that is
+ * more work than I am willing to do in this function.  Starting the backtrace
+ * at cs_arch_cpu() is simple and reliable, which is exactly what we want when
+ * the machine is already failing.
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
+/* Called at the start of a notify_chain. */
+static int
+cs_arch_notify_start(struct notifier_block *self,
+		     unsigned long val, void *data)
+{
+	struct die_args *args = data;
+	switch(val) {
+	case DIE_OOPS:
+	case DIE_NMIWATCHDOG:
+		cs_notify_chain_start(args->regs);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+/* Called at the end of a notify_chain. */
+static int
+cs_arch_notify_end(struct notifier_block *self,
+		   unsigned long val, void *data)
+{
+	switch(val) {
+	case DIE_OOPS:
+	case DIE_NMIWATCHDOG:
+		cs_notify_chain_end();
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+/* Pick up any NMI IPIs that were sent by crash_stop. */
+static int
+cs_arch_notify_nmi(struct notifier_block *self,
+		   unsigned long val, void *data)
+{
+	switch(val) {
+	case DIE_NMI_IPI:
+		if (crash_stop_sent_nmi()) {
+			crash_stop_slave();
+			return NOTIFY_STOP;
+		}
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cs_arch_nb_start = {
+	.notifier_call = cs_arch_notify_start,
+	.priority = ~0U >> 1,
+};
+
+static struct notifier_block cs_arch_nb_end = {
+	.notifier_call = cs_arch_notify_end,
+	.priority = 1,
+};
+
+static struct notifier_block cs_arch_nb_nmi = {
+	.notifier_call = cs_arch_notify_nmi,
+	.priority = 10,
+};
+
+static int __init
+cs_arch_init(void)
+{
+	int err;
+	const char *nb_name;
+	nb_name = "cs_arch_nb_start";
+	if ((err = register_die_notifier(&cs_arch_nb_start)))
+		goto error;
+	nb_name = "cs_arch_nb_end";
+	if ((err = register_die_notifier(&cs_arch_nb_end)))
+		goto error;
+	nb_name = "cs_arch_nb_nmi";
+	if ((err = register_die_notifier(&cs_arch_nb_nmi)))
+		goto error;
+	return 0;
+error:
+	printk(KERN_ERR "Failed to register %s\n", nb_name);
+	unregister_die_notifier(&cs_arch_nb_start);
+	unregister_die_notifier(&cs_arch_nb_end);
+	unregister_die_notifier(&cs_arch_nb_nmi);
+	return err;
+}
+
+static void __exit
+cs_arch_exit(void)
+{
+	unregister_die_notifier(&cs_arch_nb_nmi);
+	unregister_die_notifier(&cs_arch_nb_start);
+	unregister_die_notifier(&cs_arch_nb_end);
+	return;
+}
+
+module_init(cs_arch_init);
+module_exit(cs_arch_exit);
Index: linux/include/asm-i386/crash_stop.h
===================================================================
--- /dev/null
+++ linux/include/asm-i386/crash_stop.h
@@ -0,0 +1,14 @@
+#ifndef _ASM_CRASH_STOP_H
+#define _ASM_CRASH_STOP_H
+
+/* CONFIG_4KSTACKS means that the registers (including eip) at the time of the
+ * interrupt can be on one stack while the crash_stop code is running on
+ * another stack.  We have to save the current esp and eip.
+ */
+struct crash_stop_running_process_arch
+{
+	unsigned long esp;
+	unsigned long eip;
+};
+
+#endif	/* _ASM_CRASH_STOP_H */
