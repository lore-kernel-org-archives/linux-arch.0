Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:45493 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757681Ab2FAKXm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 06:23:42 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 1 Jun 2012 09:15:36 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 23/27] cris, smpboot: Use generic SMP booting infrastructure
Date: Fri, 01 Jun 2012 14:45:40 +0530
Message-ID: <20120601091534.31979.34403.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com
Cc: rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <eric.dumazet@gmail.com>, Mike Frysinger <vapier@gentoo.org>, linux-cris-kernel@axis.com
Message-ID: <20120601091540.q5EynbtjL1SoENWID_DoZKOteROo5zGTMDXrdn5nX84@z>

Convert cris to use the generic framework to boot secondary CPUs.

Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: linux-cris-kernel@axis.com
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/cris/arch-v32/kernel/smp.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/cris/arch-v32/kernel/smp.c b/arch/cris/arch-v32/kernel/smp.c
index ebe2cb3..357114a 100644
--- a/arch/cris/arch-v32/kernel/smp.c
+++ b/arch/cris/arch-v32/kernel/smp.c
@@ -17,6 +17,7 @@
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/smpboot.h>
 
 #define IPI_SCHEDULE 1
 #define IPI_CALL 2
@@ -145,8 +146,11 @@ smp_boot_one_cpu(int cpuid, struct task_struct idle)
  * specific stuff such as the local timer and the MMU. */
 void __init smp_callin(void)
 {
-	extern void cpu_idle(void);
+	smpboot_start_secondary(NULL);
+}
 
+void __cpuinit __cpu_pre_starting(void *unused)
+{
 	int cpu = cpu_now_booting;
 	reg_intr_vect_rw_mask vect_mask = {0};
 
@@ -161,16 +165,10 @@ void __init smp_callin(void)
 	/* Setup local timer. */
 	cris_timer_init();
 
-	/* Enable IRQ and idle */
+	/* Enable IRQ */
 	REG_WR(intr_vect, irq_regs[cpu], rw_mask, vect_mask);
 	crisv32_unmask_irq(IPI_INTR_VECT);
 	crisv32_unmask_irq(TIMER0_INTR_VECT);
-	preempt_disable();
-	notify_cpu_starting(cpu);
-	local_irq_enable();
-
-	set_cpu_online(cpu, true);
-	cpu_idle();
 }
 
 /* Stop execution on this CPU.*/

