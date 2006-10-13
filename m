Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:25900 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750725AbWJMNYb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Oct 2006 09:24:31 -0400
Received: from ocs3.ocs.com.au (ocs3w.ocs.com.au [192.168.254.3])
	by mail.ocs.com.au (Postfix) with ESMTP id A4DDDE0B20A
	for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2006 23:24:29 +1000 (EST)
Received: from ocs3.ocs.com.au (localhost [127.0.0.1])
	by ocs3.ocs.com.au (Postfix) with ESMTP id EE45881EE7
	for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2006 23:24:51 +1000 (EST)
From: Keith Owens <kaos@sgi.com>
Subject: [RFC] crash_stop: crash_stop_headers
In-reply-to: Your message of "Fri, 13 Oct 2006 23:23:35 +1000."
             <26656.1160745815@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Oct 2006 23:24:51 +1000
Message-ID: <27420.1160745891@ocs3.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

crash_stop() headers.  The common header defines the API.  The
architecture headers define arch dependent state that is saved on each
cpu, this is typically the data that is required to get a decent
backtrace.

---
 include/asm-i386/crash_stop.h |   14 ++++++++++
 include/linux/crash_stop.h    |   57 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

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
Index: linux/include/linux/crash_stop.h
===================================================================
--- /dev/null
+++ linux/include/linux/crash_stop.h
@@ -0,0 +1,57 @@
+#ifndef _LINUX_CRASH_STOP_H
+#define _LINUX_CRASH_STOP_H
+
+#ifdef	CONFIG_CRASH_STOP_SUPPORTED
+
+#include <linux/cpumask.h>
+#include <linux/ptrace.h>
+#include <asm/crash_stop.h>
+
+typedef asmlinkage int (*printk_t)(const char * fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
+
+/* These five entries are the only ones used by code outside crash_stop itself.
+ * Anything starting with 'crash_stop' is part of the external ABI, anything
+ * starting with'cs_' is only to be used by internal crash_stop code.
+ */
+extern int crash_stop(void (*callback)(int monarch, void *data),
+		      void *data, struct pt_regs *regs, printk_t print,
+		      const char *text);
+extern int crash_stop_recovered(void);
+extern void crash_stop_cpu(int monarch, struct pt_regs *regs);
+extern int crash_stop_sent_nmi(void);
+struct crash_stop_running_process {
+	struct task_struct *p;
+	struct pt_regs *regs;
+	struct crash_stop_running_process *prev;
+	struct crash_stop_running_process_arch arch;
+};
+
+extern void cs_common_ipi(struct pt_regs *regs);
+extern void cs_arch_send_ipi(int);
+extern void cs_arch_send_nmi(int);
+
+extern void cs_arch_cpu(int, struct crash_stop_running_process *);
+extern void cs_common_cpu(int);
+
+extern spinlock_t cs_lock;
+extern int cs_monarch;
+extern int cs_notify_chain;
+
+struct cs_global {
+	void (*callback)(int monarch, void *data);
+	void *data;
+	printk_t print;
+};
+extern struct cs_global cs_global;
+
+#else	/* !CONFIG_CRASH_STOP_SUPPORTED */
+
+#define crash_stop(callback, data, regs, print, text) {(void) data; (void) regs; -ENOSYS}
+#define crash_stop_recovered() do {} while(0)
+#define crash_stop_cpu(monarch, regs) {(void) monarch; (void)regs}
+#define crash_stop_sent_nmi() 0
+
+#endif	/* CONFIG_CRASH_STOP_SUPPORTED */
+
+#endif	/* _LINUX_CRASH_STOP_H */

