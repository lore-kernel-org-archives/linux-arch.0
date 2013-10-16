From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 12/17] xtensa: clean up do_interrupt/do_IRQ
Date: Thu, 17 Oct 2013 02:42:23 +0400
Message-ID: <1381963348-29448-13-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:62777 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762058Ab3JPWnE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:43:04 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so1164019lbh.23
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:43:02 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

- set up irq registers and call irq_enter/irq_exit once for each kernel
  entry due to interrupt;
- don't attempt to clear current IRQ in the do_interrupt, IRQ handler
  will take care of it;
- find pending interrupt with highest priority before every ISR
  invocation.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/irq.c   |  6 ------
 arch/xtensa/kernel/traps.c | 23 +++++++++--------------
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index ada1e48..3cef58e 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -30,7 +30,6 @@ atomic_t irq_err_count;
 
 asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
 	int irq = irq_find_mapping(NULL, hwirq);
 
 	if (hwirq >= NR_IRQS) {
@@ -38,8 +37,6 @@ asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
 				__func__, hwirq);
 	}
 
-	irq_enter();
-
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
 	{
@@ -54,9 +51,6 @@ asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
 	}
 #endif
 	generic_handle_irq(irq);
-
-	irq_exit();
-	set_irq_regs(old_regs);
 }
 
 int arch_show_interrupts(struct seq_file *p, int prec)
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 3e8a05c..3dbe864 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -212,6 +212,9 @@ void do_interrupt(struct pt_regs *regs)
 		XCHAL_INTLEVEL6_MASK,
 		XCHAL_INTLEVEL7_MASK,
 	};
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	irq_enter();
 
 	for (;;) {
 		unsigned intread = get_sr(interrupt);
@@ -227,21 +230,13 @@ void do_interrupt(struct pt_regs *regs)
 		}
 
 		if (level == 0)
-			return;
-
-		/*
-		 * Clear the interrupt before processing, in case it's
-		 *  edge-triggered or software-generated
-		 */
-		while (int_at_level) {
-			unsigned i = __ffs(int_at_level);
-			unsigned mask = 1 << i;
-
-			int_at_level ^= mask;
-			set_sr(mask, intclear);
-			do_IRQ(i, regs);
-		}
+			break;
+
+		do_IRQ(__ffs(int_at_level), regs);
 	}
+
+	irq_exit();
+	set_irq_regs(old_regs);
 }
 
 /*
-- 
1.8.1.4
