From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 04/47] arm: Use irq status modifier
Date: Thu, 30 Sep 2010 23:14:51 -0000
Message-ID: <20100930221738.868664682@linutronix.de>
References: <20100930221351.682772535@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=arm-use-status-modifier.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Replace the open coded unlocked access to irq_desc.status

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/kernel/irq.c |   20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

Index: linux-2.6-tip/arch/arm/kernel/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/arm/kernel/irq.c
+++ linux-2.6-tip/arch/arm/kernel/irq.c
@@ -132,24 +132,18 @@ asmlinkage void __exception asm_do_IRQ(u
 
 void set_irq_flags(unsigned int irq, unsigned int iflags)
 {
-	struct irq_desc *desc;
-	unsigned long flags;
+	unsigned long clr = 0;
 
-	if (irq >= nr_irqs) {
-		printk(KERN_ERR "Trying to set irq flags for IRQ%d\n", irq);
-		return;
-	}
+	irq_set_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN);
 
-	desc = irq_to_desc(irq);
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	desc->status |= IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	if (iflags & IRQF_VALID)
-		desc->status &= ~IRQ_NOREQUEST;
+		clr |= IRQ_NOREQUEST;
 	if (iflags & IRQF_PROBE)
-		desc->status &= ~IRQ_NOPROBE;
+		clr |= IRQ_NOPROBE;
 	if (!(iflags & IRQF_NOAUTOEN))
-		desc->status &= ~IRQ_NOAUTOEN;
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
+		clr |= IRQ_NOAUTOEN;
+
+	irq_clear_status_flags(irq, clr);
 }
 
 void __init init_IRQ(void)
