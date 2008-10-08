From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/4] improve precision of idle accounting.
Date: Wed, 08 Oct 2008 18:20:01 +0200
Message-ID: <20081008162144.772227050@de.ibm.com>
References: <20081008161958.767142939@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate8.de.ibm.com ([195.212.29.157]:38644 "EHLO
	mtagate8.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332AbYJHQ3p (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Oct 2008 12:29:45 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id m98GT6DM528182
	for <linux-arch@vger.kernel.org>; Wed, 8 Oct 2008 16:29:06 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id m98GT6NW2605110
	for <linux-arch@vger.kernel.org>; Wed, 8 Oct 2008 18:29:06 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m98GT1x8012335
	for <linux-arch@vger.kernel.org>; Wed, 8 Oct 2008 18:29:02 +0200
Content-Disposition: inline; filename=204-cputime-idle-stck.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Michael Neuling <mikey@neuling.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Increase the precision of the idle time calculation that is exported
to user space via /sys/devices/system/cpu/cpu<x>/idle_time_us

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/cpu.h |    3 -
 arch/s390/kernel/process.c  |   67 +++++++++++++++++++++++++++++---------------
 arch/s390/kernel/smp.c      |   25 ++++++++--------
 3 files changed, 59 insertions(+), 36 deletions(-)

Index: linux-idle/arch/s390/include/asm/cpu.h
===================================================================
--- linux-idle.orig/arch/s390/include/asm/cpu.h
+++ linux-idle/arch/s390/include/asm/cpu.h
@@ -14,7 +14,6 @@
 
 struct s390_idle_data {
 	spinlock_t lock;
-	unsigned int in_idle;
 	unsigned long long idle_count;
 	unsigned long long idle_enter;
 	unsigned long long idle_time;
@@ -26,7 +25,7 @@ void s390_idle_leave(void);
 
 static inline void s390_idle_check(void)
 {
-	if ((&__get_cpu_var(s390_idle))->in_idle)
+	if ((&__get_cpu_var(s390_idle))->idle_enter != 0ULL)
 		s390_idle_leave();
 }
 
Index: linux-idle/arch/s390/kernel/process.c
===================================================================
--- linux-idle.orig/arch/s390/kernel/process.c
+++ linux-idle/arch/s390/kernel/process.c
@@ -38,6 +38,7 @@
 #include <linux/utsname.h>
 #include <linux/tick.h>
 #include <linux/elfcore.h>
+#include <linux/kernel_stat.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
@@ -79,30 +80,19 @@ DEFINE_PER_CPU(struct s390_idle_data, s3
 	.lock = __SPIN_LOCK_UNLOCKED(s390_idle.lock)
 };
 
-static int s390_idle_enter(void)
+void s390_idle_leave(void)
 {
 	struct s390_idle_data *idle;
+	unsigned long long idle_time;
 
 	idle = &__get_cpu_var(s390_idle);
+	idle_time = S390_lowcore.int_clock - idle->idle_enter;
 	spin_lock(&idle->lock);
+	idle->idle_time += idle_time;
+	idle->idle_enter = 0ULL;
 	idle->idle_count++;
-	idle->in_idle = 1;
-	idle->idle_enter = get_clock();
 	spin_unlock(&idle->lock);
-	vtime_stop_cpu_timer();
-	return NOTIFY_OK;
-}
-
-void s390_idle_leave(void)
-{
-	struct s390_idle_data *idle;
-
 	vtime_start_cpu_timer();
-	idle = &__get_cpu_var(s390_idle);
-	spin_lock(&idle->lock);
-	idle->idle_time += get_clock() - idle->idle_enter;
-	idle->in_idle = 0;
-	spin_unlock(&idle->lock);
 }
 
 extern void s390_handle_mcck(void);
@@ -111,16 +101,16 @@ extern void s390_handle_mcck(void);
  */
 static void default_idle(void)
 {
+	struct s390_idle_data *idle = &__get_cpu_var(s390_idle);
+	unsigned long addr;
+	psw_t psw;
+
 	/* CPU is going idle. */
 	local_irq_disable();
 	if (need_resched()) {
 		local_irq_enable();
 		return;
 	}
-	if (s390_idle_enter() == NOTIFY_BAD) {
-		local_irq_enable();
-		return;
-	}
 #ifdef CONFIG_HOTPLUG_CPU
 	if (cpu_is_offline(smp_processor_id())) {
 		preempt_enable_no_resched();
@@ -136,9 +126,42 @@ static void default_idle(void)
 		return;
 	}
 	trace_hardirqs_on();
+	vtime_stop_cpu_timer();
+
+	/*
+	 * The inline assembly is equivalent to
+	 * 	idle->idle_enter = get_clock();
+	 * 	__load_psw_mask(psw_kernel_bits | PSW_MASK_WAIT |
+	 *			   PSW_MASK_IO | PSW_MASK_EXT);
+	 * The difference is that the inline assembly makes sure that
+	 * the stck instruction is right before the lpsw instruction.
+	 * This is done to increase the precision.
+	 */
+
 	/* Wait for external, I/O or machine check interrupt. */
-	__load_psw_mask(psw_kernel_bits | PSW_MASK_WAIT |
-			PSW_MASK_IO | PSW_MASK_EXT);
+	psw.mask = psw_kernel_bits|PSW_MASK_WAIT|PSW_MASK_IO|PSW_MASK_EXT;
+#ifndef __s390x__
+	asm volatile(
+		"	basr	%0,0\n"
+		"0:	ahi	%0,1f-0b\n"
+		"	st	%0,4(%2)\n"
+		"	stck	0(%3)\n"
+		"	lpsw	0(%2)\n"
+		"1:"
+		: "=&d" (addr), "=m" (idle->idle_enter)
+		: "a" (&psw), "a" (&idle->idle_enter), "m" (psw)
+		: "memory", "cc");
+#else /* __s390x__ */
+	asm volatile(
+		"	larl	%0,1f\n"
+		"	stg	%0,8(%2)\n"
+		"	stck	0(%3)\n"
+		"	lpswe	0(%2)\n"
+		"1:"
+		: "=&d" (addr), "=m" (idle->idle_enter)
+		: "a" (&psw), "a" (&idle->idle_enter), "m" (psw)
+		: "memory", "cc");
+#endif /* __s390x__ */
 }
 
 void cpu_idle(void)
Index: linux-idle/arch/s390/kernel/smp.c
===================================================================
--- linux-idle.orig/arch/s390/kernel/smp.c
+++ linux-idle/arch/s390/kernel/smp.c
@@ -992,9 +992,11 @@ static ssize_t show_idle_count(struct sy
 	unsigned long long idle_count;
 
 	idle = &per_cpu(s390_idle, dev->id);
-	spin_lock_irq(&idle->lock);
+	spin_lock(&idle->lock);
 	idle_count = idle->idle_count;
-	spin_unlock_irq(&idle->lock);
+	if (idle->idle_enter)
+		idle_count++;
+	spin_unlock(&idle->lock);
 	return sprintf(buf, "%llu\n", idle_count);
 }
 static SYSDEV_ATTR(idle_count, 0444, show_idle_count, NULL);
@@ -1003,18 +1005,17 @@ static ssize_t show_idle_time(struct sys
 				struct sysdev_attribute *attr, char *buf)
 {
 	struct s390_idle_data *idle;
-	unsigned long long new_time;
+	unsigned long long now, idle_time, idle_enter;
 
 	idle = &per_cpu(s390_idle, dev->id);
-	spin_lock_irq(&idle->lock);
-	if (idle->in_idle) {
-		new_time = get_clock();
-		idle->idle_time += new_time - idle->idle_enter;
-		idle->idle_enter = new_time;
-	}
-	new_time = idle->idle_time;
-	spin_unlock_irq(&idle->lock);
-	return sprintf(buf, "%llu\n", new_time >> 12);
+	spin_lock(&idle->lock);
+	now = get_clock();
+	idle_time = idle->idle_time;
+	idle_enter = idle->idle_enter;
+	if (idle_enter != 0ULL && idle_enter < now)
+		idle_time += now - idle_enter;
+	spin_unlock(&idle->lock);
+	return sprintf(buf, "%llu\n", idle_time >> 12);
 }
 static SYSDEV_ATTR(idle_time_us, 0444, show_idle_time, NULL);
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
