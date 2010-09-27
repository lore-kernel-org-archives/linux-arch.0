From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 16/19] genirq; Provide compat handling for chip->retrigger()
Date: Mon, 27 Sep 2010 12:45:53 -0000
Message-ID: <20100927121843.025801092@linutronix.de>
References: <20100927121651.904100669@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=genirq-wrap-chip-retrigger.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

Wrap the old chip function retrigger() until the migration is complete
and the old chip functions are removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c   |    7 +++++++
 kernel/irq/resend.c |    3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

Index: linux-2.6-tip/kernel/irq/chip.c
===================================================================
--- linux-2.6-tip.orig/kernel/irq/chip.c
+++ linux-2.6-tip/kernel/irq/chip.c
@@ -389,6 +389,11 @@ static int compat_irq_set_wake(struct ir
 	return irq_data_to_desc(data)->chip->set_wake(data->irq, on);
 }
 
+static int compat_irq_retrigger(struct irq_data *data)
+{
+	return irq_data_to_desc(data)->chip->retrigger(data->irq);
+}
+
 static void compat_bus_lock(struct irq_data *data)
 {
 	irq_data_to_desc(data)->chip->bus_lock(data->irq);
@@ -461,6 +466,8 @@ void irq_chip_set_defaults(struct irq_ch
 		chip->irq_set_type = compat_irq_set_type;
 	if (chip->set_wake)
 		chip->irq_set_wake = compat_irq_set_wake;
+	if (chip->retrigger)
+		chip->irq_retrigger = compat_irq_retrigger;
 }
 
 static inline void mask_ack_irq(struct irq_desc *desc)
Index: linux-2.6-tip/kernel/irq/resend.c
===================================================================
--- linux-2.6-tip.orig/kernel/irq/resend.c
+++ linux-2.6-tip/kernel/irq/resend.c
@@ -70,7 +70,8 @@ void check_irq_resend(struct irq_desc *d
 	if ((status & (IRQ_LEVEL | IRQ_PENDING | IRQ_REPLAY)) == IRQ_PENDING) {
 		desc->status = (status & ~IRQ_PENDING) | IRQ_REPLAY;
 
-		if (!desc->chip->retrigger || !desc->chip->retrigger(irq)) {
+		if (!desc->chip->irq_retrigger ||
+		    !desc->chip->irq_retrigger(&desc->irq_data)) {
 #ifdef CONFIG_HARDIRQS_SW_RESEND
 			/* Set it pending and activate the softirq: */
 			set_bit(irq, irqs_resend);
