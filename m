Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:23272 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751376AbWIITQS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 9 Sep 2006 15:16:18 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id k89JGH529481
	for <linux-arch@vger.kernel.org>; Sat, 9 Sep 2006 15:16:17 -0400
Subject: Re: [PATCH] update generic irq for parisc
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <1157827893.3462.19.camel@mulgrave.il.steeleye.com>
References: <1157827893.3462.19.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 14:16:16 -0500
Message-Id: <1157829376.3462.22.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

And for reference, this is how we plan to use the generic irq
enhancements on parisc.

James

Index: parisc-2.6/include/asm-parisc/irq-handlers.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ parisc-2.6/include/asm-parisc/irq-handlers.h	2006-09-09 10:57:28.000000000 -0700
@@ -0,0 +1,12 @@
+HANDLE_LEVEL_IRQ(_chip, cpu_ack_irq, cpu_end_irq)
+HANDLE_PERCPU_IRQ(_chip, cpu_ack_irq, cpu_end_irq)
+#ifdef CONFIG_IOSAPIC
+HANDLE_LEVEL_IRQ(_iosapic, cpu_ack_irq, iosapic_end_irq)
+#endif
+
+static inline char *arch_handle_irq_name(void fastcall (*handle)(unsigned int,
+							struct irq_desc *,
+							struct pt_regs *))
+{
+	return NULL;
+}
Index: parisc-2.6/include/asm-parisc/irq.h
===================================================================
--- parisc-2.6.orig/include/asm-parisc/irq.h	2006-09-09 08:30:10.000000000 -0700
+++ parisc-2.6/include/asm-parisc/irq.h	2006-09-09 11:24:25.000000000 -0700
@@ -26,6 +26,17 @@
 
 #define NR_IRQS		(CPU_IRQ_MAX + 1)
 
+#define ARCH_HAS_IRQ_HANDLERS
+
+struct irq_desc;
+
+void fastcall handle_level_irq_chip(unsigned int irq, struct irq_desc *desc,
+				    struct pt_regs *regs);
+void fastcall handle_level_irq_iosapic(unsigned int irq, struct irq_desc *desc,
+				       struct pt_regs *regs);
+void fastcall handle_percpu_irq_chip(unsigned int irq, struct irq_desc *desc,
+				     struct pt_regs *regs);
+
 static __inline__ int irq_canonicalize(int irq)
 {
 	return (irq == 2) ? 9 : irq;
@@ -39,8 +50,9 @@
  */
 void no_ack_irq(unsigned int irq);
 void no_end_irq(unsigned int irq);
-void cpu_ack_irq(unsigned int irq);
-void cpu_end_irq(unsigned int irq);
+void cpu_ack_irq(struct irq_desc *, unsigned int irq);
+void cpu_end_irq(struct irq_desc *, unsigned int irq);
+void iosapic_end_irq(struct irq_desc *, unsigned int irq);
 
 extern int txn_alloc_irq(unsigned int nbits);
 extern int txn_claim_irq(int);
Index: parisc-2.6/arch/parisc/kernel/irq.c
===================================================================
--- parisc-2.6.orig/arch/parisc/kernel/irq.c	2006-09-09 10:01:02.000000000 -0700
+++ parisc-2.6/arch/parisc/kernel/irq.c	2006-09-09 11:17:49.000000000 -0700
@@ -88,7 +88,7 @@
 void no_ack_irq(unsigned int irq) { }
 void no_end_irq(unsigned int irq) { }
 
-void cpu_ack_irq(unsigned int irq)
+void cpu_ack_irq(struct irq_desc *dummy, unsigned int irq)
 {
 	unsigned long mask = EIEM_MASK(irq);
 	int cpu = smp_processor_id();
@@ -105,7 +105,7 @@
 	mtctl(mask, 23);
 }
 
-void cpu_end_irq(unsigned int irq)
+void cpu_end_irq(struct irq_desc *dummy, unsigned int irq)
 {
 	unsigned long mask = EIEM_MASK(irq);
 	int cpu = smp_processor_id();
@@ -155,8 +155,6 @@
 	.shutdown	= cpu_disable_irq,
 	.enable		= cpu_enable_irq,
 	.disable	= cpu_disable_irq,
-	.ack		= cpu_ack_irq,
-	.end		= cpu_end_irq,
 #ifdef CONFIG_SMP
 	.set_affinity	= cpu_set_affinity_irq,
 #endif
@@ -253,8 +251,8 @@
 		return -EBUSY;
 
 	if (type) {
-		irq_desc[irq].chip = type;
-		irq_desc[irq].chip_data = data;
+		set_irq_chip(irq, type);
+		set_irq_chip_data(irq, data);
 		cpu_interrupt_type.enable(irq);
 	}
 	return 0;
@@ -375,7 +373,7 @@
 		goto set_out;
 	}
 #endif
-	__do_IRQ(irq, regs);
+	generic_handle_irq(irq, regs);
 
  out:
 	irq_exit();
@@ -403,15 +401,17 @@
 static void claim_cpu_irqs(void)
 {
 	int i;
-	for (i = CPU_IRQ_BASE; i <= CPU_IRQ_MAX; i++) {
-		irq_desc[i].chip = &cpu_interrupt_type;
-	}
+	for (i = CPU_IRQ_BASE; i <= CPU_IRQ_MAX; i++)
+		set_irq_chip_and_handler(i, &cpu_interrupt_type,
+					 handle_level_irq_chip);
 
 	irq_desc[TIMER_IRQ].action = &timer_action;
 	irq_desc[TIMER_IRQ].status |= IRQ_PER_CPU;
 #ifdef CONFIG_SMP
+	set_irq_handler(TIMER_IRQ, handle_percpu_irq_chip);
 	irq_desc[IPI_IRQ].action = &ipi_action;
 	irq_desc[IPI_IRQ].status = IRQ_PER_CPU;
+	set_irq_handler(IPI_IRQ, handle_percpu_irq_chip);
 #endif
 }
 
Index: parisc-2.6/drivers/parisc/iosapic.c
===================================================================
--- parisc-2.6.orig/drivers/parisc/iosapic.c	2006-09-09 10:26:14.000000000 -0700
+++ parisc-2.6/drivers/parisc/iosapic.c	2006-09-09 11:24:20.000000000 -0700
@@ -686,13 +686,13 @@
  * i386/ia64 support ISA devices and have to deal with
  * edge-triggered interrupts too.
  */
-static void iosapic_end_irq(unsigned int irq)
+void iosapic_end_irq(struct irq_desc *dummy, unsigned int irq)
 {
 	struct vector_info *vi = iosapic_get_vector(irq);
 	DBG(KERN_DEBUG "end_irq(%d): eoi(%p, 0x%x)\n", irq,
 			vi->eoi_addr, vi->eoi_data);
 	iosapic_eoi(vi->eoi_addr, vi->eoi_data);
-	cpu_end_irq(irq);
+	cpu_end_irq(NULL, irq);
 }
 
 static unsigned int iosapic_startup_irq(unsigned int irq)
@@ -729,8 +729,6 @@
 	.shutdown =	iosapic_disable_irq,
 	.enable =	iosapic_enable_irq,
 	.disable =	iosapic_disable_irq,
-	.ack =		cpu_ack_irq,
-	.end =		iosapic_end_irq,
 #ifdef CONFIG_SMP
 	.set_affinity =	iosapic_set_affinity_irq,
 #endif
@@ -819,6 +817,7 @@
 	vi->eoi_data = cpu_to_le32(vi->txn_data);
 
 	cpu_claim_irq(vi->txn_irq, &iosapic_interrupt_type, vi);
+	set_irq_handler(vi->txn_irq, handle_level_irq_iosapic);
 
  out:
 	pcidev->irq = vi->txn_irq;


