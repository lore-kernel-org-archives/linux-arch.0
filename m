Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33115 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204Ab3CUVxJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Mar 2013 17:53:09 -0400
Message-ID: <20130321215234.217235264@linutronix.de>
Date: Thu, 21 Mar 2013 21:53:07 -0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 14/34] frv: Use generic idle loop
References: <20130321214930.752934102@linutronix.de>
Content-Disposition: inline; filename=frv-use-generic-idle-loop.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>, David Howells <dhowells@redhat.com>
Message-ID: <20130321215307.OmbTg2qAmtHKf6FRE6bqaWmK9xGW8ansVJXJ8vJw2S4@z>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Howells <dhowells@redhat.com>
---
 arch/frv/Kconfig          |    1 +
 arch/frv/kernel/process.c |   27 +++++----------------------
 2 files changed, 6 insertions(+), 22 deletions(-)

Index: linux-2.6/arch/frv/Kconfig
===================================================================
--- linux-2.6.orig/arch/frv/Kconfig
+++ linux-2.6/arch/frv/Kconfig
@@ -8,6 +8,7 @@ config FRV
 	select HAVE_GENERIC_HARDIRQS
 	select VIRT_TO_BUS
 	select GENERIC_IRQ_SHOW
+	select GENERIC_IDLE_LOOP
 	select HAVE_DEBUG_BUGVERBOSE
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_CPU_DEVICES
Index: linux-2.6/arch/frv/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/frv/kernel/process.c
+++ linux-2.6/arch/frv/kernel/process.c
@@ -59,29 +59,12 @@ static void core_sleep_idle(void)
 	mb();
 }
 
-void (*idle)(void) = core_sleep_idle;
-
-/*
- * The idle thread. There's no useful work to be
- * done, so just try to conserve power and have a
- * low exit latency (ie sit in a loop waiting for
- * somebody to say that they'd like to reschedule)
- */
-void cpu_idle(void)
+void arch_cpu_idle(void)
 {
-	/* endless idle loop with no priority at all */
-	while (1) {
-		rcu_idle_enter();
-		while (!need_resched()) {
-			check_pgt_cache();
-
-			if (!frv_dma_inprogress && idle)
-				idle();
-		}
-		rcu_idle_exit();
-
-		schedule_preempt_disabled();
-	}
+	if (!frv_dma_inprogress)
+		core_sleep_idle();
+	else
+		local_irq_enable();
 }
 
 void machine_restart(char * __unused)


