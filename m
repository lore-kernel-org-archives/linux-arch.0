From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 05/37] cris: Convert V10 interrupt handling
Date: Wed, 19 Jan 2011 21:48:20 -0000
Message-ID: <20110119210839.060947825@linutronix.de>
References: <20110119205258.462759212@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=cris-cleanup-v10-irq.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Mikael Starvik <starvik@axis.com>
List-Id: linux-arch.vger.kernel.org

Convert the irq_chip functions and install handle_simple_irq for each
interrupt. This converts V10 to the flow handling and lets us remove
__do_IRQ().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mikael Starvik <starvik@axis.com>
---
 arch/cris/arch-v10/kernel/irq.c |   41 +++++++++-------------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

Index: linux-2.6/arch/cris/arch-v10/kernel/irq.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v10/kernel/irq.c
+++ linux-2.6/arch/cris/arch-v10/kernel/irq.c
@@ -104,43 +104,21 @@ static void (*interrupt[NR_IRQS])(void) 
 	IRQ31_interrupt
 };
 
-static void enable_crisv10_irq(unsigned int irq);
-
-static unsigned int startup_crisv10_irq(unsigned int irq)
-{
-	enable_crisv10_irq(irq);
-	return 0;
-}
-
-#define shutdown_crisv10_irq	disable_crisv10_irq
-
-static void enable_crisv10_irq(unsigned int irq)
-{
-	crisv10_unmask_irq(irq);
-}
-
-static void disable_crisv10_irq(unsigned int irq)
-{
-	crisv10_mask_irq(irq);
-}
-
-static void ack_crisv10_irq(unsigned int irq)
+static void enable_crisv10_irq(struct irq_data *data)
 {
+	crisv10_unmask_irq(data->irq);
 }
 
-static void end_crisv10_irq(unsigned int irq)
+static void disable_crisv10_irq(struct irq_data *data)
 {
+	crisv10_mask_irq(data->irq);
 }
 
 static struct irq_chip crisv10_irq_type = {
-	.name =        "CRISv10",
-	.startup =     startup_crisv10_irq,
-	.shutdown =    shutdown_crisv10_irq,
-	.enable =      enable_crisv10_irq,
-	.disable =     disable_crisv10_irq,
-	.ack =         ack_crisv10_irq,
-	.end =         end_crisv10_irq,
-	.set_affinity = NULL
+	.name		= "CRISv10",
+	.irq_shutdown	= disable_crisv10_irq,
+	.irq_enable	= enable_crisv10_irq,
+	.irq_disable	= disable_crisv10_irq,
 };
 
 void weird_irq(void);
@@ -221,7 +199,8 @@ init_IRQ(void)
 
 	/* Initialize IRQ handler descriptors. */
 	for(i = 2; i < NR_IRQS; i++) {
-		irq_desc[i].chip = &crisv10_irq_type;
+		set_irq_desc_and_handler(i, &crisv10_irq_type,
+					 handle_simple_irq);
 		set_int_vector(i, interrupt[i]);
 	}
 
