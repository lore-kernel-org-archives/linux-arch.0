From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [patch 3/3] sched: Use local_irq_save_nmi() in cpu_clock()
Date: Tue, 06 Apr 2010 15:28:10 +0200
Message-ID: <20100406133141.039454288@chello.nl>
References: <20100406132807.698467930@chello.nl>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49338 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177Ab0DFNjO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2010 09:39:14 -0400
Content-Disposition: inline; filename=sched-clock-nmi.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@elte.hu, David Miller <davem@davemloft.net>, acme@redhat.com, paulus@samba.org, Mike Galbraith <efault@gmx.de>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@l>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>

Since we can call cpu_clock() from NMI context fix up the IRQ
disabling to conform to the new rules.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 kernel/sched_clock.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/kernel/sched_clock.c
===================================================================
--- linux-2.6.orig/kernel/sched_clock.c
+++ linux-2.6/kernel/sched_clock.c
@@ -241,9 +241,9 @@ unsigned long long cpu_clock(int cpu)
 	unsigned long long clock;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_irq_save_nmi(flags);
 	clock = sched_clock_cpu(cpu);
-	local_irq_restore(flags);
+	local_irq_restore_nmi(flags);
 
 	return clock;
 }
