Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:59111 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751371AbWIISvg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 9 Sep 2006 14:51:36 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id k89IpY528275
	for <linux-arch@vger.kernel.org>; Sat, 9 Sep 2006 14:51:34 -0400
Subject: [PATCH] update generic irq for parisc
From: James Bottomley <James.Bottomley@steeleye.com>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 13:51:33 -0500
Message-Id: <1157827893.3462.19.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

We have had a specific problem with the current generic linux IRQ code
for ages, in that indirection via function pointers is horribly
expensive for us (basically, the CPU pipes stall).  We'd like to use the
new genirq infrastructure to mitigate some of the problem.

I didn't want simply to move the irq handlers back into our arch code
again, since that would remove all the benefits of common handling code.
What I did was template out the common code in a way that keeps it
common but allows an architecture to modify it (for us to put our acks
and eoi's in as functions instead of function pointers).

If everyone is OK with this, I'll introduce a new type of interrupt with
a specific handler (so for our heavily called interrupts like timer and
IPI we don't even need to indirect through action->handler()).

James

Index: parisc-2.6/include/linux/irq_helpers.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ parisc-2.6/include/linux/irq_helpers.h	2006-09-09 08:21:31.000000000 -0700
@@ -0,0 +1,64 @@
+#ifdef CONFIG_SMP
+#define HANDLE_PERCPU_IRQ(NAME, ACK, EOI)				\
+void fastcall								\
+handle_percpu_irq##NAME(unsigned int irq, struct irq_desc *desc,	\
+			struct pt_regs *regs)				\
+{									\
+	irqreturn_t action_ret;						\
+									\
+	kstat_this_cpu.irqs[irq]++;					\
+									\
+	ACK(desc, irq);							\
+									\
+	action_ret = handle_IRQ_event(irq, regs, desc->action);		\
+	if (!noirqdebug)						\
+		note_interrupt(irq, desc, action_ret, regs);		\
+									\
+	EOI(desc,irq);							\
+}
+#else
+#define HANDLE_PERCPU_IRQ(NAME, ACK, END)
+#endif /* CONFIG_SMP */
+
+#define HANDLE_LEVEL_IRQ(NAME, MASK, UNMASK)				\
+void fastcall								\
+handle_level_irq##NAME(unsigned int irq, struct irq_desc *desc,		\
+			struct pt_regs *regs)				\
+{									\
+	unsigned int cpu = smp_processor_id();				\
+	struct irqaction *action;					\
+	irqreturn_t action_ret;						\
+									\
+	spin_lock(&desc->lock);						\
+	MASK(desc, irq);						\
+									\
+	if (unlikely(desc->status & IRQ_INPROGRESS))			\
+		goto out;						\
+	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);			\
+	kstat_cpu(cpu).irqs[irq]++;					\
+									\
+	/*								\
+	 * If its disabled or no action available			\
+	 * keep it masked and get out of here				\
+	 */								\
+	action = desc->action;						\
+	if (unlikely(!action || (desc->status & IRQ_DISABLED))) {	\
+		desc->status |= IRQ_PENDING;				\
+		goto out;						\
+	}								\
+									\
+	desc->status |= IRQ_INPROGRESS;					\
+	desc->status &= ~IRQ_PENDING;					\
+	spin_unlock(&desc->lock);					\
+									\
+	action_ret = handle_IRQ_event(irq, regs, action);		\
+	if (!noirqdebug)						\
+		note_interrupt(irq, desc, action_ret, regs);		\
+									\
+	spin_lock(&desc->lock);						\
+	desc->status &= ~IRQ_INPROGRESS;				\
+out:									\
+	UNMASK(desc,irq);						\
+	spin_unlock(&desc->lock);					\
+}
+
Index: parisc-2.6/kernel/irq/chip.c
===================================================================
--- parisc-2.6.orig/kernel/irq/chip.c	2006-09-09 07:32:35.000000000 -0700
+++ parisc-2.6/kernel/irq/chip.c	2006-09-09 07:58:45.000000000 -0700
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/irq_helpers.h>
 
 #include "internals.h"
 
@@ -186,6 +187,24 @@
 	}
 }
 
+static inline void unmask_enabled_irq(struct irq_desc *desc, int irq)
+{
+	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
+		desc->chip->unmask(irq);
+}
+
+static inline void ack_irq(struct irq_desc *desc, int irq)
+{
+	if (desc->chip->ack)
+		desc->chip->ack(irq);
+}
+
+static inline void eoi_irq(struct irq_desc *desc, int irq)
+{
+	if (desc->chip->eoi)
+		desc->chip->eoi(irq);
+}
+
 /**
  *	handle_simple_irq - Simple and software-decoded IRQs.
  *	@irq:	the interrupt number
@@ -241,46 +260,7 @@
  *	it after the associated handler has acknowledged the device, so the
  *	interrupt line is back to inactive.
  */
-void fastcall
-handle_level_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs)
-{
-	unsigned int cpu = smp_processor_id();
-	struct irqaction *action;
-	irqreturn_t action_ret;
-
-	spin_lock(&desc->lock);
-	mask_ack_irq(desc, irq);
-
-	if (unlikely(desc->status & IRQ_INPROGRESS))
-		goto out;
-	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
-	kstat_cpu(cpu).irqs[irq]++;
-
-	/*
-	 * If its disabled or no action available
-	 * keep it masked and get out of here
-	 */
-	action = desc->action;
-	if (unlikely(!action || (desc->status & IRQ_DISABLED))) {
-		desc->status |= IRQ_PENDING;
-		goto out;
-	}
-
-	desc->status |= IRQ_INPROGRESS;
-	desc->status &= ~IRQ_PENDING;
-	spin_unlock(&desc->lock);
-
-	action_ret = handle_IRQ_event(irq, regs, action);
-	if (!noirqdebug)
-		note_interrupt(irq, desc, action_ret, regs);
-
-	spin_lock(&desc->lock);
-	desc->status &= ~IRQ_INPROGRESS;
-out:
-	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
-		desc->chip->unmask(irq);
-	spin_unlock(&desc->lock);
-}
+HANDLE_LEVEL_IRQ(, mask_ack_irq, unmask_enabled_irq)
 
 /**
  *	handle_fasteoi_irq - irq handler for transparent controllers
@@ -416,7 +396,6 @@
 	spin_unlock(&desc->lock);
 }
 
-#ifdef CONFIG_SMP
 /**
  *	handle_percpu_IRQ - Per CPU local irq handler
  *	@irq:	the interrupt number
@@ -425,25 +404,19 @@
  *
  *	Per CPU interrupts on SMP machines without locking requirements
  */
-void fastcall
-handle_percpu_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs)
-{
-	irqreturn_t action_ret;
-
-	kstat_this_cpu.irqs[irq]++;
+HANDLE_PERCPU_IRQ(, ack_irq, eoi_irq)
 
-	if (desc->chip->ack)
-		desc->chip->ack(irq);
-
-	action_ret = handle_IRQ_event(irq, regs, desc->action);
-	if (!noirqdebug)
-		note_interrupt(irq, desc, action_ret, regs);
-
-	if (desc->chip->eoi)
-		desc->chip->eoi(irq);
+#ifdef ARCH_HAS_IRQ_HANDLERS
+#include <asm/irq-handlers.h>
+#else
+static inline char *arch_handle_irq_name(void fastcall (*handle)(unsigned int,
+							struct irq_desc *,
+							struct pt_regs *))
+{
+	return NULL;
 }
+#endif
 
-#endif /* CONFIG_SMP */
 
 void
 __set_irq_handler(unsigned int irq,
@@ -533,5 +506,5 @@
 	if (handle == handle_bad_irq)
 		return "bad    ";
 
-	return NULL;
+	return arch_handle_irq_name(handle);
 }


