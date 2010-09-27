From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 03/19] genirq: Provide advanced irq chip functions
Date: Mon, 27 Sep 2010 12:44:32 -0000
Message-ID: <20100927121841.742126604@linutronix.de>
References: <20100927121651.904100669@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
	filename=genirq-migration-path-for-irq-chip-functions.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

The low level irq chip functions want access to irq_desc->irq_data.
Provide new functions which hand down irq_data instead of the irq
number so these functions avoid to call irq_to_desc() which is a radix
tree lookup in case of sparse irq.

This provides all the old functions except one: end(). end() is a
relict of __do_IRQ() and will just go away with the __do_IRQ() code.

The replacement for set_affinity() has an extra argument "bool
force". The reason for this is to notify the low level code, that the
move has to be done right away and cannot be delayed until the next
interrupt happens. That's necessary to handle the irq fixup on cpu
unplug in the generic code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: linux-2.6-tip/include/linux/irq.h
===================================================================
--- linux-2.6-tip.orig/include/linux/irq.h
+++ linux-2.6-tip/include/linux/irq.h
@@ -151,6 +151,26 @@ struct irq_chip {
 	void		(*bus_lock)(unsigned int irq);
 	void		(*bus_sync_unlock)(unsigned int irq);
 
+	unsigned int	(*irq_startup)(struct irq_data *data);
+	void		(*irq_shutdown)(struct irq_data *data);
+	void		(*irq_enable)(struct irq_data *data);
+	void		(*irq_disable)(struct irq_data *data);
+
+	void		(*irq_ack)(struct irq_data *data);
+	void		(*irq_mask)(struct irq_data *data);
+	void		(*irq_mask_ack)(struct irq_data *data);
+	void		(*irq_unmask)(struct irq_data *data);
+	void		(*irq_eoi)(struct irq_data *data);
+	void		(*irq_end)(struct irq_data *data);
+
+	int		(*irq_set_affinity)(struct irq_data *data, const struct cpumask *dest, bool force);
+	int		(*irq_retrigger)(struct irq_data *data);
+	int		(*irq_set_type)(struct irq_data *data, unsigned int flow_type);
+	int		(*irq_set_wake)(struct irq_data *data, unsigned int on);
+
+	void		(*irq_bus_lock)(struct irq_data *data);
+	void		(*irq_bus_sync_unlock)(struct irq_data *data);
+
 	/* Currently used only by UML, might disappear one day.*/
 #ifdef CONFIG_IRQ_RELEASE_METHOD
 	void		(*release)(unsigned int irq, void *dev_id);
