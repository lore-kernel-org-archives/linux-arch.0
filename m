Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:60288 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1423819AbWKIEE2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2006 23:04:28 -0500
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id kA96lYWE005326
	for <@external-mail-relay.sgi.com:linux-arch@vger.kernel.org>; Wed, 8 Nov 2006 22:47:35 -0800
From: Keith Owens <kaos@sgi.com>
Date: Thu, 09 Nov 2006 15:04:24 +1100
Message-Id: <20061109040424.17391.26988.sendpatchset@chook.melbourne.sgi.com>
In-Reply-To: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
References: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
Subject: [patch 2.6.19-rc5 1/12] crash_stop: common header
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Keith Owens <kaos@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

crash_stop() common header.

Signed-off-by: Keith Owens <kaos@sgi.com>
---
 include/linux/crash_stop.h |   71 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

Index: linux/include/linux/crash_stop.h
===================================================================
--- /dev/null
+++ linux/include/linux/crash_stop.h
@@ -0,0 +1,71 @@
+#ifndef _LINUX_CRASH_STOP_H
+
+#include <linux/cpumask.h>
+#include <linux/errno.h>
+#include <linux/ptrace.h>
+
+typedef asmlinkage int (*printk_t)(const char * fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
+#define _LINUX_CRASH_STOP_H
+
+#ifdef	CONFIG_CRASH_STOP_SUPPORTED
+
+#include <asm/crash_stop.h>
+
+/* These six entries are the only ones used by code outside crash_stop itself.
+ * Anything starting with 'crash_stop' is part of the external ABI, anything
+ * starting with'cs_' is only to be used by internal crash_stop code.
+ */
+extern int crash_stop(void (*callback)(int monarch, void *data),
+		      void *data, printk_t print,
+		      struct pt_regs *regs, const char *text);
+extern void crash_stop_recovered(void);
+#ifdef	CONFIG_SMP
+extern void crash_stop_slave(void);
+extern int crash_stop_sent_nmi(void);
+#else	/* !CONFIG_SMP */
+#define crash_stop_slave() do {} while(0)
+#define crash_stop_sent_nmi() 0
+#endif	/* CONFIG_SMP */
+extern int crash_stop_slaves(void);
+struct crash_stop_running_process {
+	struct task_struct *p;
+	struct pt_regs *regs;
+	struct crash_stop_running_process *prev;
+	struct crash_stop_running_process_arch arch;
+};
+
+extern void cs_common_ipi(void);
+extern void cs_arch_send_ipi(int);
+extern void cs_arch_send_nmi(int);
+
+extern void cs_arch_cpu(int, struct crash_stop_running_process *);
+extern void cs_common_cpu(int);
+
+extern void cs_notify_chain_start(struct pt_regs *);
+extern void cs_notify_chain_end(void);
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
+static inline
+int crash_stop(void (*callback)(int monarch, void *data),
+		     void *data, printk_t print,
+		     struct pt_regs *regs, const char *text)
+{
+	return -ENOSYS;
+}
+#define crash_stop_recovered() do {} while(0)
+#define crash_stop_slave() do {} while(0)
+#define crash_stop_sent_nmi() 0
+#define crash_stop_slaves() 0
+
+#endif	/* CONFIG_CRASH_STOP_SUPPORTED */
+
+#endif	/* _LINUX_CRASH_STOP_H */
