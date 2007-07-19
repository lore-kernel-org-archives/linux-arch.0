Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:52860 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753821AbXGSHBc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jul 2007 03:01:32 -0400
From: Keith Owens <kaos@ocs.com.au>
Subject: [patch 2.6.22] Do not include other cpus' interrupt 0 in nmi_watchdog
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 19 Jul 2007 17:01:26 +1000
Message-ID: <9346.1184828486@kao2.melbourne.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

kstat_irqs(0) includes the count of interrupt 0 from all cpus, not just
the current cpu.  The updated interrupt 0 on other cpus can stop the
nmi_watchdog from tripping, so only include the current cpu's int 0.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

---
 arch/i386/kernel/nmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -351,7 +351,7 @@ __kprobes int nmi_watchdog_tick(struct p
 	 * Take the local apic timer and PIT/HPET into account. We don't
 	 * know which one is active, when we have highres/dyntick on
 	 */
-	sum = per_cpu(irq_stat, cpu).apic_timer_irqs + kstat_irqs(0);
+	sum = per_cpu(irq_stat, cpu).apic_timer_irqs + kstat_cpu(cpu).irqs[0];
 
 	/* if the none of the timers isn't firing, this cpu isn't doing much */
 	if (!touched && last_irq_sums[cpu] == sum) {

