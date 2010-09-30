From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 21/47] x86: Sanitize apb timer interrupt handling
Date: Thu, 30 Sep 2010 23:16:16 -0000
Message-ID: <20100930221740.545532651@linutronix.de>
References: <20100930221351.682772535@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=x86-sanitize-abptimer.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Disable the interrupt in CPU_DEAD where it belongs. Remove the
open coded irq_desc manipulation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apb_timer.c |   54 +++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

Index: linux-2.6-tip/arch/x86/kernel/apb_timer.c
===================================================================
--- linux-2.6-tip.orig/arch/x86/kernel/apb_timer.c
+++ linux-2.6-tip/arch/x86/kernel/apb_timer.c
@@ -231,34 +231,6 @@ static void apbt_restart_clocksource(str
 	apbt_start_counter(phy_cs_timer_id);
 }
 
-/* Setup IRQ routing via IOAPIC */
-#ifdef CONFIG_SMP
-static void apbt_setup_irq(struct apbt_dev *adev)
-{
-	struct irq_chip *chip;
-	struct irq_desc *desc;
-
-	/* timer0 irq has been setup early */
-	if (adev->irq == 0)
-		return;
-	desc = irq_to_desc(adev->irq);
-	chip = get_irq_chip(adev->irq);
-	disable_irq(adev->irq);
-	desc->status |= IRQ_MOVE_PCNTXT;
-	irq_set_affinity(adev->irq, cpumask_of(adev->cpu));
-	/* APB timer irqs are set up as mp_irqs, timer is edge triggerred */
-	set_irq_chip_and_handler_name(adev->irq, chip, handle_edge_irq, "edge");
-	enable_irq(adev->irq);
-	if (system_state == SYSTEM_BOOTING)
-		if (request_irq(adev->irq, apbt_interrupt_handler,
-				IRQF_TIMER | IRQF_DISABLED | IRQF_NOBALANCING,
-				adev->name, adev)) {
-			printk(KERN_ERR "Failed request IRQ for APBT%d\n",
-			       adev->num);
-		}
-}
-#endif
-
 static void apbt_enable_int(int n)
 {
 	unsigned long ctrl = apbt_readl(n, APBTMR_N_CONTROL);
@@ -334,6 +306,27 @@ static int __init apbt_clockevent_regist
 }
 
 #ifdef CONFIG_SMP
+
+static void apbt_setup_irq(struct apbt_dev *adev)
+{
+	/* timer0 irq has been setup early */
+	if (adev->irq == 0)
+		return;
+
+	if (system_state == SYSTEM_BOOTING) {
+		irq_modify_status(adev->irq, 0, IRQ_MOVE_PCNTXT);
+		/* APB timer irqs are set up as mp_irqs, timer is edge type */
+		__set_irq_handler(adev->irq, handle_edge_irq, 0, "edge");
+		if (request_irq(adev->irq, apbt_interrupt_handler,
+				IRQF_TIMER | IRQF_DISABLED | IRQF_NOBALANCING,
+				adev->name, adev)) {
+			printk(KERN_ERR "Failed request IRQ for APBT%d\n",
+			       adev->num);
+		}
+	} else
+		enable_irq(adev->irq);
+}
+
 /* Should be called with per cpu */
 void apbt_setup_secondary_clock(void)
 {
@@ -389,10 +382,11 @@ static int apbt_cpuhp_notify(struct noti
 
 	switch (action & 0xf) {
 	case CPU_DEAD:
+		disable_irq(adev->irq);
 		apbt_disable_int(cpu);
-		if (system_state == SYSTEM_RUNNING)
+		if (system_state == SYSTEM_RUNNING) {
 			pr_debug("skipping APBT CPU %lu offline\n", cpu);
-		else if (adev) {
+		}else if (adev) {
 			pr_debug("APBT clockevent for cpu %lu offline\n", cpu);
 			free_irq(adev->irq, adev);
 		}
