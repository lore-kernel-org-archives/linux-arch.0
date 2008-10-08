From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/4] improve idle cputime accounting
Date: Wed, 08 Oct 2008 18:20:02 +0200
Message-ID: <20081008162145.024573988@de.ibm.com>
References: <20081008161958.767142939@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate8.de.ibm.com ([195.212.29.157]:38657 "EHLO
	mtagate8.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361AbYJHQ3q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Oct 2008 12:29:46 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id m98GT6RT112846
	for <linux-arch@vger.kernel.org>; Wed, 8 Oct 2008 16:29:06 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id m98GT6p24165748
	for <linux-arch@vger.kernel.org>; Wed, 8 Oct 2008 18:29:06 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m98GT2ou012349
	for <linux-arch@vger.kernel.org>; Wed, 8 Oct 2008 18:29:03 +0200
Content-Disposition: inline; filename=205-cputime-idle-s390.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Michael Neuling <mikey@neuling.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Distinguish the cputime of the idle process where idle is actually using
cpu cycles from the cputime where idle is sleeping on an enabled wait psw.
The former is acconuted as system time, the later as idle time.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/cpu.h |    1 +
 arch/s390/kernel/process.c  |    7 +++++++
 arch/s390/kernel/s390_ext.c |    2 +-
 arch/s390/kernel/vtime.c    |   24 ++++++------------------
 drivers/s390/cio/cio.c      |    2 +-
 5 files changed, 16 insertions(+), 20 deletions(-)

Index: linux-idle/arch/s390/include/asm/cpu.h
===================================================================
--- linux-idle.orig/arch/s390/include/asm/cpu.h
+++ linux-idle/arch/s390/include/asm/cpu.h
@@ -15,6 +15,7 @@
 struct s390_idle_data {
 	spinlock_t lock;
 	unsigned long long idle_count;
+	unsigned long long idle_delta;
 	unsigned long long idle_enter;
 	unsigned long long idle_time;
 };
Index: linux-idle/arch/s390/kernel/process.c
===================================================================
--- linux-idle.orig/arch/s390/kernel/process.c
+++ linux-idle/arch/s390/kernel/process.c
@@ -87,6 +87,13 @@ void s390_idle_leave(void)
 
 	idle = &__get_cpu_var(s390_idle);
 	idle_time = S390_lowcore.int_clock - idle->idle_enter;
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+	idle_time += idle->idle_delta;
+	idle->idle_delta = idle_time & 4095;
+	idle_time -= idle->idle_delta;
+	account_idle_time(idle_time >> 12);
+	S390_lowcore.last_update_clock = S390_lowcore.int_clock;
+#endif
 	spin_lock(&idle->lock);
 	idle->idle_time += idle_time;
 	idle->idle_enter = 0ULL;
Index: linux-idle/arch/s390/kernel/s390_ext.c
===================================================================
--- linux-idle.orig/arch/s390/kernel/s390_ext.c
+++ linux-idle/arch/s390/kernel/s390_ext.c
@@ -119,8 +119,8 @@ void do_extint(struct pt_regs *regs, uns
 	struct pt_regs *old_regs;
 
 	old_regs = set_irq_regs(regs);
-	irq_enter();
 	s390_idle_check();
+	irq_enter();
 	if (S390_lowcore.int_clock >= S390_lowcore.clock_comparator)
 		/* Serve timer interrupts first. */
 		clock_comparator_work();
Index: linux-idle/arch/s390/kernel/vtime.c
===================================================================
--- linux-idle.orig/arch/s390/kernel/vtime.c
+++ linux-idle/arch/s390/kernel/vtime.c
@@ -56,19 +56,13 @@ void account_process_tick(struct task_st
 	cputime =  S390_lowcore.system_timer >> 12;
 	S390_lowcore.system_timer -= cputime << 12;
 	S390_lowcore.steal_clock -= cputime << 12;
-	if (idle_task(smp_processor_id()) != current)
-		account_system_time(tsk, HARDIRQ_OFFSET, cputime, cputime);
-	else
-		account_idle_time(cputime);
+	account_system_time(tsk, HARDIRQ_OFFSET, cputime, cputime);
 
 	cputime = S390_lowcore.steal_clock;
 	if ((__s64) cputime > 0) {
 		cputime >>= 12;
 		S390_lowcore.steal_clock -= cputime << 12;
-		if (idle_task(smp_processor_id()) != current)
-			account_steal_time(cputime);
-		else
-			account_idle_time(cputime);
+		account_steal_time(cputime);
 	}
 }
 
@@ -94,10 +88,7 @@ void account_vtime(struct task_struct *t
 	cputime =  S390_lowcore.system_timer >> 12;
 	S390_lowcore.system_timer -= cputime << 12;
 	S390_lowcore.steal_clock -= cputime << 12;
-	if (idle_task(smp_processor_id()) != current)
-		account_system_time(tsk, 0, cputime, cputime);
-	else
-		account_idle_time(cputime);
+	account_system_time(tsk, 0, cputime, cputime);
 }
 
 /*
@@ -117,10 +108,7 @@ void account_system_vtime(struct task_st
 	cputime =  S390_lowcore.system_timer >> 12;
 	S390_lowcore.system_timer -= cputime << 12;
 	S390_lowcore.steal_clock -= cputime << 12;
-	if (in_irq() || idle_task(smp_processor_id()) != current)
-		account_system_time(tsk, 0, cputime, cputime);
-	else
-		account_idle_time(cputime);
+	account_system_time(tsk, 0, cputime, cputime);
 }
 EXPORT_SYMBOL_GPL(account_system_vtime);
 
@@ -158,8 +146,8 @@ void vtime_start_cpu_timer(void)
 	if (vt_list->idle & 1LL<<63)
 		return;
 
-	if (!list_empty(&vt_list->list))
-		set_vtimer(vt_list->idle);
+	S390_lowcore.last_update_timer = S390_lowcore.async_enter_timer;
+	set_vtimer(vt_list->idle);
 }
 
 void vtime_stop_cpu_timer(void)
Index: linux-idle/drivers/s390/cio/cio.c
===================================================================
--- linux-idle.orig/drivers/s390/cio/cio.c
+++ linux-idle/drivers/s390/cio/cio.c
@@ -626,8 +626,8 @@ do_IRQ (struct pt_regs *regs)
 	struct pt_regs *old_regs;
 
 	old_regs = set_irq_regs(regs);
-	irq_enter();
 	s390_idle_check();
+	irq_enter();
 	if (S390_lowcore.int_clock >= S390_lowcore.clock_comparator)
 		/* Serve timer interrupts first. */
 		clock_comparator_work();

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
