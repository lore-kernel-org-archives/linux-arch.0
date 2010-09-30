From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 07/47] genirq: Remove early_init_irq_lock_class()
Date: Thu, 30 Sep 2010 23:15:10 -0000
Message-ID: <20100930221739.171290088@linutronix.de>
References: <20100930221351.682772535@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
	filename=genirq-remove-early-init-irq-lock-class.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

early_init_irq_lock_class() is called way before anything touches the
irq descriptors. In case of SPARSE_IRQ=y this is a NOP operation
because the radix tree is empty at this point. For the SPARSE_IRQ=n
case it's sufficient to set the lock class in early_init_irq(). 

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/lockdep.h |    8 --------
 init/main.c             |    1 -
 kernel/irq/irqdesc.c    |   11 +----------
 3 files changed, 1 insertion(+), 19 deletions(-)

Index: linux-2.6-tip/include/linux/lockdep.h
===================================================================
--- linux-2.6-tip.orig/include/linux/lockdep.h
+++ linux-2.6-tip/include/linux/lockdep.h
@@ -424,14 +424,6 @@ do {								\
 
 #endif /* CONFIG_LOCKDEP */
 
-#ifdef CONFIG_GENERIC_HARDIRQS
-extern void early_init_irq_lock_class(void);
-#else
-static inline void early_init_irq_lock_class(void)
-{
-}
-#endif
-
 #ifdef CONFIG_TRACE_IRQFLAGS
 extern void early_boot_irqs_off(void);
 extern void early_boot_irqs_on(void);
Index: linux-2.6-tip/init/main.c
===================================================================
--- linux-2.6-tip.orig/init/main.c
+++ linux-2.6-tip/init/main.c
@@ -556,7 +556,6 @@ asmlinkage void __init start_kernel(void
 
 	local_irq_disable();
 	early_boot_irqs_off();
-	early_init_irq_lock_class();
 
 /*
  * Interrupts are still disabled. Do necessary setups, then
Index: linux-2.6-tip/kernel/irq/irqdesc.c
===================================================================
--- linux-2.6-tip.orig/kernel/irq/irqdesc.c
+++ linux-2.6-tip/kernel/irq/irqdesc.c
@@ -243,6 +243,7 @@ int __init early_irq_init(void)
 		alloc_desc_masks(&desc[i], 0, true);
 		init_desc_masks(&desc[i]);
 		desc[i].kstat_irqs = kstat_irqs_all[i];
+		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
 	}
 	return arch_early_irq_init();
 }
@@ -263,16 +264,6 @@ void clear_kstat_irqs(struct irq_desc *d
 	memset(desc->kstat_irqs, 0, nr_cpu_ids * sizeof(*(desc->kstat_irqs)));
 }
 
-void early_init_irq_lock_class(void)
-{
-	struct irq_desc *desc;
-	int i;
-
-	for_each_irq_desc(i, desc) {
-		lockdep_set_class(&desc->lock, &irq_desc_lock_class);
-	}
-}
-
 unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
