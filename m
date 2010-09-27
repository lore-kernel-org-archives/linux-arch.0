From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 15/19] genirq; Provide compat handling for chip->set_wake()
Date: Mon, 27 Sep 2010 12:45:50 -0000
Message-ID: <20100927121842.927527393@linutronix.de>
References: <20100927121651.904100669@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=genirq-wrap-chip-set-wake.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

Wrap the old chip function set_wake() until the migration is complete
and the old chip functions are removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c   |    7 +++++++
 kernel/irq/manage.c |    4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

Index: linux-2.6-tip/kernel/irq/chip.c
===================================================================
--- linux-2.6-tip.orig/kernel/irq/chip.c
+++ linux-2.6-tip/kernel/irq/chip.c
@@ -384,6 +384,11 @@ static int compat_irq_set_type(struct ir
 	return irq_data_to_desc(data)->chip->set_type(data->irq, type);
 }
 
+static int compat_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	return irq_data_to_desc(data)->chip->set_wake(data->irq, on);
+}
+
 static void compat_bus_lock(struct irq_data *data)
 {
 	irq_data_to_desc(data)->chip->bus_lock(data->irq);
@@ -454,6 +459,8 @@ void irq_chip_set_defaults(struct irq_ch
 		chip->irq_set_affinity = compat_irq_set_affinity;
 	if (chip->set_type)
 		chip->irq_set_type = compat_irq_set_type;
+	if (chip->set_wake)
+		chip->irq_set_wake = compat_irq_set_wake;
 }
 
 static inline void mask_ack_irq(struct irq_desc *desc)
Index: linux-2.6-tip/kernel/irq/manage.c
===================================================================
--- linux-2.6-tip.orig/kernel/irq/manage.c
+++ linux-2.6-tip/kernel/irq/manage.c
@@ -336,8 +336,8 @@ static int set_irq_wake_real(unsigned in
 	struct irq_desc *desc = irq_to_desc(irq);
 	int ret = -ENXIO;
 
-	if (desc->chip->set_wake)
-		ret = desc->chip->set_wake(irq, on);
+	if (desc->chip->irq_set_wake)
+		ret = desc->chip->irq_set_wake(&desc->irq_data, on);
 
 	return ret;
 }
