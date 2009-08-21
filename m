From: Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC patch 31/32] init: Move sched_clock_init after late_time_init
Date: Fri, 21 Aug 2009 21:32:18 -0000
Message-ID: <20090821205603.324314018@linutronix.de>
References: <20090821205008.518392436@linutronix.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:52024 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933050AbZHUVeG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Aug 2009 17:34:06 -0400
Content-Disposition: inline;
	filename=init-move-sched-clock-init-after-late-time-init.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86 team <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Veen <arjan@infradead.org>, Avi Kivity <avi@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Alok N Kataria <akataria@vmware.com>, Pan Jacob jun <jacob.jun.pan@intel.com>, linux-arch@vger.kernel.org

Some architectures initialize clocks and timers in late_time_init and
x86 wants to do the same to avoid FIXMAP hackery for calibrating the
TSC. That would result in undefined sched_clock readout and wreckaged
printk timestamps again. We probably have those already on archs which
do all their time/clock setup in late_time_init.

There is no harm to move that after late_time_init except that a few
more boot timestamps are stale. The scheduler is not active at that
point so no real wreckage is expected.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
---
 init/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/init/main.c
===================================================================
--- linux-2.6.orig/init/main.c
+++ linux-2.6/init/main.c
@@ -631,7 +631,6 @@ asmlinkage void __init start_kernel(void
 	softirq_init();
 	timekeeping_init();
 	time_init();
-	sched_clock_init();
 	profile_init();
 	if (!irqs_disabled())
 		printk(KERN_CRIT "start_kernel(): bug: interrupts were "
@@ -682,6 +681,7 @@ asmlinkage void __init start_kernel(void
 	numa_policy_init();
 	if (late_time_init)
 		late_time_init();
+	sched_clock_init();
 	calibrate_delay();
 	pidmap_init();
 	anon_vma_init();
