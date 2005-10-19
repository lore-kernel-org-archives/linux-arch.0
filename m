Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 19 Oct 2005 14:43:14 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] Make NO_IRQ more widespread
Message-ID: <20051019204314.GB17314@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


This is just the first step; it'll take a lot of driver auditing before
we can change over to using NO_IRQ everywhere.

 - Add a default definition of NO_IRQ to <linux/hardirq.h>
 - Remove NO_IRQ definitions from all architectures which defined it
   (since they all defined it to -1 anyway)
 - Add a PCI_NO_IRQ to <linux/pci.h> so I don't have to touch all the
   drivers at once
 - Change pci/probe.c to use it (should have no effect)
 - Convert pd6729 to use PCI_NO_IRQ instead of NO_IRQ
 - Add checks in manage.c to do the right thing if an invalid irq (such
   as NO_IRQ) is passed in

comments welcomed.

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0057864..99681db 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -571,9 +571,12 @@ static void pci_read_irq(struct pci_dev 
 	unsigned char irq;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
-	if (irq)
+	if (irq) {
 		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
-	dev->irq = irq;
+		dev->irq = irq;
+	} else {
+		dev->irq = PCI_NO_IRQ;
+	}
 }
 
 /**
diff --git a/drivers/pcmcia/pd6729.c b/drivers/pcmcia/pd6729.c
index 20642f0..403d68b 100644
--- a/drivers/pcmcia/pd6729.c
+++ b/drivers/pcmcia/pd6729.c
@@ -39,10 +39,6 @@ MODULE_AUTHOR("Jun Komuro <komurojun-mbn
  */
 #define to_cycles(ns)	((ns)/120)
 
-#ifndef NO_IRQ
-#define NO_IRQ	((unsigned int)(0))
-#endif
-
 /*
  * PARAMETERS
  *  irq_mode=n
@@ -733,7 +729,7 @@ static int __devinit pd6729_pci_probe(st
 		goto err_out_disable;
 	}
 
-	if (dev->irq == NO_IRQ)
+	if (dev->irq == PCI_NO_IRQ)
 		irq_mode = 0;	/* fall back to ISA interrupt mode */
 
 	mask = pd6729_isa_scan();
diff --git a/include/asm-arm/irq.h b/include/asm-arm/irq.h
index f97912f..11f35a0 100644
--- a/include/asm-arm/irq.h
+++ b/include/asm-arm/irq.h
@@ -11,14 +11,6 @@
 #define NR_IRQS	128
 #endif
 
-/*
- * Use this value to indicate lack of interrupt
- * capability
- */
-#ifndef NO_IRQ
-#define NO_IRQ	((unsigned int)(-1))
-#endif
-
 struct irqaction;
 
 extern void disable_irq_nosync(unsigned int);
diff --git a/include/asm-arm26/irq.h b/include/asm-arm26/irq.h
index 06bd5a5..7957d4e 100644
--- a/include/asm-arm26/irq.h
+++ b/include/asm-arm26/irq.h
@@ -14,14 +14,6 @@
 #endif
 
 
-/*
- * Use this value to indicate lack of interrupt
- * capability
- */
-#ifndef NO_IRQ
-#define NO_IRQ	((unsigned int)(-1))
-#endif
-
 struct irqaction;
 
 #define disable_irq_nosync(i) disable_irq(i)
diff --git a/include/asm-frv/irq.h b/include/asm-frv/irq.h
index 2c16d8d..fbc5bd7 100644
--- a/include/asm-frv/irq.h
+++ b/include/asm-frv/irq.h
@@ -20,9 +20,6 @@
  * drivers
  */
 
-/* this number is used when no interrupt has been assigned */
-#define NO_IRQ				(-1)
-
 #define NR_IRQ_LOG2_ACTIONS_PER_GROUP	5
 #define NR_IRQ_ACTIONS_PER_GROUP	(1 << NR_IRQ_LOG2_ACTIONS_PER_GROUP)
 #define NR_IRQ_GROUPS			4
diff --git a/include/asm-parisc/irq.h b/include/asm-parisc/irq.h
index f876bdf..037ef9f 100644
--- a/include/asm-parisc/irq.h
+++ b/include/asm-parisc/irq.h
@@ -10,8 +10,6 @@
 #include <linux/config.h>
 #include <asm/types.h>
 
-#define NO_IRQ		(-1)
-
 #ifdef CONFIG_GSC
 #define GSC_IRQ_BASE	16
 #define GSC_IRQ_MAX	63
diff --git a/include/asm-ppc64/irq.h b/include/asm-ppc64/irq.h
index 99782af..d5739b7 100644
--- a/include/asm-ppc64/irq.h
+++ b/include/asm-ppc64/irq.h
@@ -17,9 +17,6 @@
  */
 #define NR_IRQS		512
 
-/* this number is used when no interrupt has been assigned */
-#define NO_IRQ			(-1)
-
 /*
  * These constants are used for passing information about interrupt
  * signal polarity and level/edge sensing to the low-level PIC chip
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 5912874..f71a3ba 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -87,6 +87,16 @@ extern void synchronize_irq(unsigned int
 # define synchronize_irq(irq)	barrier()
 #endif
 
+/*
+ * This value means "Device has no interrupt".  For most pieces of code,
+ * any value above NR_IRQS would do, but -1 is traditional.  The PCI
+ * subsystem used to use 0, but that's a legal IRQ number on some
+ * architectures.
+ */
+#ifndef NO_IRQ
+#define NO_IRQ			((unsigned int)(-1))
+#endif
+
 #define nmi_enter()		irq_enter()
 #define nmi_exit()		sub_preempt_count(HARDIRQ_OFFSET)
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7349058..12f4317 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -139,6 +139,14 @@ struct pci_dev {
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 };
 
+/*
+ * The PCI subsystem has traditionally filled in 0 when no interrupt has been
+ * assigned.  While we should move to using NO_IRQ instead, many drivers
+ * remain to be converted.  Once all drivers are using PCI_NO_IRQ, switching
+ * over should be a simple search-and-replace.
+ */
+#define PCI_NO_IRQ		0
+
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
 #define pci_dev_b(n) list_entry(n, struct pci_dev, bus_list)
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1cfdb08..4190d9e 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -35,6 +35,9 @@ void synchronize_irq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_desc + irq;
 
+	if (irq >= NR_IRQS)
+		return;
+
 	while (desc->status & IRQ_INPROGRESS)
 		cpu_relax();
 }
@@ -59,6 +62,9 @@ void disable_irq_nosync(unsigned int irq
 	irq_desc_t *desc = irq_desc + irq;
 	unsigned long flags;
 
+	if (irq >= NR_IRQS)
+		return;
+
 	spin_lock_irqsave(&desc->lock, flags);
 	if (!desc->depth++) {
 		desc->status |= IRQ_DISABLED;
@@ -85,6 +91,9 @@ void disable_irq(unsigned int irq)
 {
 	irq_desc_t *desc = irq_desc + irq;
 
+	if (irq >= NR_IRQS)
+		return;
+
 	disable_irq_nosync(irq);
 	if (desc->action)
 		synchronize_irq(irq);
@@ -107,6 +116,9 @@ void enable_irq(unsigned int irq)
 	irq_desc_t *desc = irq_desc + irq;
 	unsigned long flags;
 
+	if (irq >= NR_IRQS)
+		return;
+
 	spin_lock_irqsave(&desc->lock, flags);
 	switch (desc->depth) {
 	case 0:
@@ -162,6 +174,9 @@ int setup_irq(unsigned int irq, struct i
 	unsigned long flags;
 	int shared = 0;
 
+	if (irq >= NR_IRQS)
+		return -EINVAL;
+
 	if (desc->handler == &no_irq_type)
 		return -ENOSYS;
 	/*
