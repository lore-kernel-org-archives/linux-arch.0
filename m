Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33277 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204Ab3CUVxW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Mar 2013 17:53:22 -0400
Message-ID: <20130321215235.280451779@linutronix.de>
Date: Thu, 21 Mar 2013 21:53:20 -0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 30/34] tile: Enter idle with preemption disabled
References: <20130321214930.752934102@linutronix.de>
Content-Disposition: inline;
 filename=tile-enter-secondary-idle-with-preempt-disabled.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>
Message-ID: <20130321215320.xtAyYZrnyMBic1InnwHIc732q59P9FfYWx2k0ahhgXI@z>

cpu_idle() needs to be called with preemption disabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Metcalf <cmetcalf@tilera.com>
---
 arch/tile/kernel/smpboot.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6/arch/tile/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/tile/kernel/smpboot.c
+++ linux-2.6/arch/tile/kernel/smpboot.c
@@ -207,8 +207,6 @@ void __cpuinit online_secondary(void)
 	/* Set up tile-timer clock-event device on this cpu */
 	setup_tile_timer();
 
-	preempt_enable();
-
 	cpu_idle();
 }
 


