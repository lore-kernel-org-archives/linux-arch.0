From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 15/47] genirq: Prepare proc for real sparse irq support
Date: Thu, 30 Sep 2010 23:15:49 -0000
Message-ID: <20100930221739.955643455@linutronix.de>
References: <20100930221351.682772535@linutronix.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:52529 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755374Ab0I3XQL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 30 Sep 2010 19:16:11 -0400
Content-Disposition: inline; filename=genirq-prepare-proc-for-real-sparse.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Eric W. Biederman" <ebiederm@xmission.com>

/proc/irq never removes any entries, but when irq descriptors can be
freed for real this is necessary. Otherwise we'd reference a freed
descriptor in /proc/irq/N

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/internals.h |    2 ++
 kernel/irq/irqdesc.c   |    2 ++
 kernel/irq/proc.c      |   18 ++++++++++++++++++
 3 files changed, 22 insertions(+)

Index: linux-2.6-tip/kernel/irq/internals.h
===================================================================
--- linux-2.6-tip.orig/kernel/irq/internals.h
+++ linux-2.6-tip/kernel/irq/internals.h
@@ -26,10 +26,12 @@ void replace_irq_desc(unsigned int irq, 
 
 #ifdef CONFIG_PROC_FS
 extern void register_irq_proc(unsigned int irq, struct irq_desc *desc);
+extern void unregister_irq_proc(unsigned int irq, struct irq_desc *desc);
 extern void register_handler_proc(unsigned int irq, struct irqaction *action);
 extern void unregister_handler_proc(unsigned int irq, struct irqaction *action);
 #else
 static inline void register_irq_proc(unsigned int irq, struct irq_desc *desc) { }
+static inline void unregister_irq_proc(unsigned int irq, struct irq_desc *desc); { }
 static inline void register_handler_proc(unsigned int irq,
 					 struct irqaction *action) { }
 static inline void unregister_handler_proc(unsigned int irq,
Index: linux-2.6-tip/kernel/irq/irqdesc.c
===================================================================
--- linux-2.6-tip.orig/kernel/irq/irqdesc.c
+++ linux-2.6-tip/kernel/irq/irqdesc.c
@@ -210,6 +210,8 @@ static void free_desc(unsigned int irq)
 	struct irq_desc *desc = irq_to_desc(irq);
 	unsigned long flags;
 
+	unregister_irq_proc(irq, desc);
+
 	raw_spin_lock_irqsave(&sparse_irq_lock, flags);
 	delete_irq_desc(irq);
 	raw_spin_unlock_irqrestore(&sparse_irq_lock, flags);
Index: linux-2.6-tip/kernel/irq/proc.c
===================================================================
--- linux-2.6-tip.orig/kernel/irq/proc.c
+++ linux-2.6-tip/kernel/irq/proc.c
@@ -297,6 +297,24 @@ void register_irq_proc(unsigned int irq,
 			 &irq_spurious_proc_fops, (void *)(long)irq);
 }
 
+void unregister_irq_proc(unsigned int irq, struct irq_desc *desc)
+{
+	char name [MAX_NAMELEN];
+
+	if (!root_irq_dir || !desc->dir)
+		return;
+#ifdef CONFIG_SMP
+	remove_proc_entry("smp_affinity", desc->dir);
+	remove_proc_entry("affinity_hint", desc->dir);
+	remove_proc_entry("node", desc->dir);
+#endif
+	remove_proc_entry("spurious", desc->dir);
+
+	memset(name, 0, MAX_NAMELEN);
+	sprintf(name, "%u", irq);
+	remove_proc_entry(name, root_irq_dir);
+}
+
 #undef MAX_NAMELEN
 
 void unregister_handler_proc(unsigned int irq, struct irqaction *action)
