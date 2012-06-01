Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:54887 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758790Ab2FAJ6G (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 05:58:06 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 1 Jun 2012 09:16:27 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 24/27] parisc, smpboot: Use generic SMP booting infrastructure
Date: Fri, 01 Jun 2012 14:45:54 +0530
Message-ID: <20120601091549.31979.6082.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com
Cc: rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>Andrew Morton <akpm@linux-foundation.org>Rusty Russell <rusty@rustcorp.com.au>, Mike Frysinger <vapier@gentoo.org>, David Howells <dhowells@redhat.com>, linux-parisc@vger.kernel.org
Message-ID: <20120601091554.jKh8PvT4WVmauizddBDdH6QoE39yWXqhFF1VwUy7T3c@z>

Convert parisc to use the generic framework to boot secondary CPUs.

Notes:
1. The secondary cpu was being set in the cpu_online_mask way too early
when things aren't initialized fully yet. Postpone that.

Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/parisc/kernel/smp.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index 6266730..a6199e2 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -32,6 +32,7 @@
 #include <linux/bitops.h>
 #include <linux/ftrace.h>
 #include <linux/cpu.h>
+#include <linux/smpboot.h>
 
 #include <linux/atomic.h>
 #include <asm/current.h>
@@ -280,8 +281,6 @@ static void __init
 smp_cpu_init(int cpunum)
 {
 	extern int init_per_cpu(int);  /* arch/parisc/kernel/processor.c */
-	extern void init_IRQ(void);    /* arch/parisc/kernel/irq.c */
-	extern void start_cpu_itimer(void); /* arch/parisc/kernel/time.c */
 
 	/* Set modes and Enable floating point coprocessor */
 	(void) init_per_cpu(cpunum);
@@ -297,10 +296,12 @@ smp_cpu_init(int cpunum)
 		printk(KERN_CRIT "CPU#%d already initialized!\n", cpunum);
 		machine_halt();
 	}
+}
 
-	notify_cpu_starting(cpunum);
-
-	set_cpu_online(cpunum, true);
+void __cpuinit __cpu_pre_online(void *unused)
+{
+	extern void init_IRQ(void);    /* arch/parisc/kernel/irq.c */
+	extern void start_cpu_itimer(void); /* arch/parisc/kernel/time.c */
 
 	/* Initialise the idle task for this CPU */
 	atomic_inc(&init_mm.mm_count);
@@ -310,6 +311,9 @@ smp_cpu_init(int cpunum)
 
 	init_IRQ();   /* make sure no IRQs are enabled or pending */
 	start_cpu_itimer();
+
+	flush_cache_all_local(); /* start with known state */
+	flush_tlb_all_local(NULL);
 }
 
 
@@ -319,20 +323,14 @@ smp_cpu_init(int cpunum)
  */
 void __init smp_callin(void)
 {
+	smpboot_start_secondary(NULL);
+}
+
+void __cpuinit __cpu_pre_starting(void *unused)
+{
 	int slave_id = cpu_now_booting;
 
 	smp_cpu_init(slave_id);
-	preempt_disable();
-
-	flush_cache_all_local(); /* start with known state */
-	flush_tlb_all_local(NULL);
-
-	local_irq_enable();  /* Interrupts have been off until now */
-
-	cpu_idle();      /* Wait for timer to schedule some work */
-
-	/* NOTREACHED */
-	panic("smp_callin() AAAAaaaaahhhh....\n");
 }
 
 /*

