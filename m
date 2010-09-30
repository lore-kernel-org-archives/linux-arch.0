From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 43/47] x86: xen: Sanitise sparse_irq handling
Date: Thu, 30 Sep 2010 23:18:14 -0000
Message-ID: <20100930221742.717242572@linutronix.de>
References: <20100930221351.682772535@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=xen-sanitise-sparse.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

There seems to be more cleanups possible, but that's left to the xen
experts :)

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/xen/events.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

Index: linux-2.6-tip/drivers/xen/events.c
===================================================================
--- linux-2.6-tip.orig/drivers/xen/events.c
+++ linux-2.6-tip/drivers/xen/events.c
@@ -338,30 +338,29 @@ static void unmask_evtchn(int port)
 
 static int find_unbound_irq(void)
 {
-	int irq;
-	struct irq_desc *desc;
+	struct irq_data *data;
+	int irq, res;
 
 	for (irq = 0; irq < nr_irqs; irq++) {
-		desc = irq_to_desc(irq);
+		data = irq_get_irq_data(irq);
 		/* only 0->15 have init'd desc; handle irq > 16 */
-		if (desc == NULL)
+		if (!data)
 			break;
-		if (desc->chip == &no_irq_chip)
+		if (data->chip == &no_irq_chip)
 			break;
-		if (desc->chip != &xen_dynamic_chip)
+		if (data->chip != &xen_dynamic_chip)
 			continue;
 		if (irq_info[irq].type == IRQT_UNBOUND)
-			break;
+			return irq;
 	}
 
 	if (irq == nr_irqs)
 		panic("No available IRQ to bind to: increase nr_irqs!\n");
 
-	desc = irq_to_desc_alloc_node(irq, 0);
-	if (WARN_ON(desc == NULL))
-		return -1;
+	res = irq_alloc_desc_at(irq, 0);
 
-	dynamic_irq_init_keep_chip_data(irq);
+	if (WARN_ON(res != irq))
+		return -1;
 
 	return irq;
 }
@@ -495,7 +494,7 @@ static void unbind_from_irq(unsigned int
 	if (irq_info[irq].type != IRQT_UNBOUND) {
 		irq_info[irq] = mk_unbound_info();
 
-		dynamic_irq_cleanup(irq);
+		irq_free_desc(irq);
 	}
 
 	spin_unlock(&irq_mapping_update_lock);
