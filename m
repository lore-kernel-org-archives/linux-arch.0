From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 47/47] genirq: Remove the old sparse irq allocator function
Date: Thu, 30 Sep 2010 23:18:32 -0000
Message-ID: <20100930221743.113364752@linutronix.de>
References: <20100930221351.682772535@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=genirq-remove-craplocator.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Last user is gone. Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h  |    2 --
 kernel/irq/irqdesc.c |    9 ---------
 2 files changed, 11 deletions(-)

Index: linux-2.6-tip/include/linux/irq.h
===================================================================
--- linux-2.6-tip.orig/include/linux/irq.h
+++ linux-2.6-tip/include/linux/irq.h
@@ -261,8 +261,6 @@ struct irq_desc {
 extern struct irq_desc irq_desc[NR_IRQS];
 #endif
 
-extern struct irq_desc *irq_to_desc_alloc_node(unsigned int irq, int node);
-
 int irq_alloc_descs(unsigned int irq, unsigned int from, unsigned int cnt, int node);
 
 static inline int irq_alloc_desc(int node)
Index: linux-2.6-tip/kernel/irq/irqdesc.c
===================================================================
--- linux-2.6-tip.orig/kernel/irq/irqdesc.c
+++ linux-2.6-tip/kernel/irq/irqdesc.c
@@ -192,15 +192,6 @@ err:
 	return -ENOMEM;
 }
 
-struct irq_desc * __ref irq_to_desc_alloc_node(unsigned int irq, int node)
-{
-	int res = irq_alloc_descs(irq, irq, 1, node);
-
-	if (res == -EEXIST || res == irq)
-		return irq_to_desc(irq);
-	return NULL;
-}
-
 int __init early_irq_init(void)
 {
 	int i, initcnt, node = first_online_node;
