Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266257AbUIMHYj@vger.kernel.org>
Received: from mtagate2.de.ibm.com ([195.212.29.151]:39157 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S266221AbUIMHYj
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Sep 2004 03:24:39 -0400
Date: Mon, 13 Sep 2004 09:24:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] cleanup: move call to update_process_times.
Message-ID: <20040913072415.GA2171@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

[PATCH] cleanup: move call to update_process_times.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

For non-smp kernels the call to update_process_times is done
in the do_timer function. It is more consistent with smp kernels
to move this call to the architecture file which calls do_timer. 

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/alpha/kernel/time.c                 |    3 +++
 arch/arm/kernel/time.c                   |    3 +++
 arch/arm26/kernel/time.c                 |    3 +++
 arch/cris/arch-v10/kernel/time.c         |    3 +++
 arch/h8300/kernel/time.c                 |    3 +++
 arch/ia64/kernel/time.c                  |    8 +-------
 arch/m68k/kernel/time.c                  |    3 +++
 arch/m68k/sun3/sun3ints.c                |    3 +++
 arch/m68knommu/kernel/time.c             |    3 +++
 arch/mips/au1000/common/time.c           |    9 +++++++++
 arch/mips/baget/time.c                   |    3 +++
 arch/mips/galileo-boards/ev96100/time.c  |    3 +++
 arch/mips/gt64120/common/time.c          |    3 +++
 arch/mips/kernel/time.c                  |    3 ---
 arch/mips/momentum/ocelot_g/gt-irq.c     |    3 +++
 arch/mips/sgi-ip27/ip27-timer.c          |    2 --
 arch/parisc/kernel/time.c                |    2 ++
 arch/ppc/kernel/time.c                   |    3 +++
 arch/ppc64/kernel/time.c                 |    3 +++
 arch/s390/kernel/time.c                  |    4 +++-
 arch/sh/kernel/time.c                    |    3 +++
 arch/sh64/kernel/time.c                  |    3 +++
 arch/sparc/kernel/pcic.c                 |    3 +++
 arch/sparc/kernel/time.c                 |    4 ++++
 arch/sparc64/kernel/time.c               |    1 +
 arch/um/kernel/time_kern.c               |    2 --
 arch/v850/kernel/time.c                  |    3 +++
 arch/x86_64/kernel/time.c                |    3 +++
 include/asm-arm/arch-clps711x/time.h     |    3 +++
 include/asm-arm/arch-integrator/time.h   |    3 +++
 include/asm-arm/arch-l7200/time.h        |    3 +++
 include/asm-i386/mach-default/do_timer.h |    3 +++
 include/asm-i386/mach-visws/do_timer.h   |    3 +++
 include/asm-i386/mach-voyager/do_timer.h |    3 +++
 kernel/timer.c                           |    5 -----
 35 files changed, 95 insertions(+), 20 deletions(-)

diff -urN linux-2.6/arch/alpha/kernel/time.c linux-2.6-patched/arch/alpha/kernel/time.c
--- linux-2.6/arch/alpha/kernel/time.c	2004-09-10 17:02:12.000000000 +0200
+++ linux-2.6-patched/arch/alpha/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -138,6 +138,9 @@
 
 	while (nticks > 0) {
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 		nticks--;
 	}
 
diff -urN linux-2.6/arch/arm/kernel/time.c linux-2.6-patched/arch/arm/kernel/time.c
--- linux-2.6/arch/arm/kernel/time.c	2004-09-10 17:02:12.000000000 +0200
+++ linux-2.6-patched/arch/arm/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -311,6 +311,9 @@
 	do_leds();
 	do_set_rtc();
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 }
 
 void (*init_arch_time)(void);
diff -urN linux-2.6/arch/arm26/kernel/time.c linux-2.6-patched/arch/arm26/kernel/time.c
--- linux-2.6/arch/arm26/kernel/time.c	2004-09-10 17:02:12.000000000 +0200
+++ linux-2.6-patched/arch/arm26/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -166,6 +166,9 @@
 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
         do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
         do_set_rtc(); //FIME - EVERY timer IRQ?
         profile_tick(CPU_PROFILING, regs);
 	return IRQ_HANDLED; //FIXME - is this right?
diff -urN linux-2.6/arch/cris/arch-v10/kernel/time.c linux-2.6-patched/arch/cris/arch-v10/kernel/time.c
--- linux-2.6/arch/cris/arch-v10/kernel/time.c	2004-08-14 12:55:47.000000000 +0200
+++ linux-2.6-patched/arch/cris/arch-v10/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -227,6 +227,9 @@
 	/* call the real timer interrupt handler */
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	
 	/*
 	 * If we have an externally synchronized Linux clock, then update
diff -urN linux-2.6/arch/h8300/kernel/time.c linux-2.6-patched/arch/h8300/kernel/time.c
--- linux-2.6/arch/h8300/kernel/time.c	2004-09-10 17:02:12.000000000 +0200
+++ linux-2.6-patched/arch/h8300/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -46,6 +46,9 @@
 	platform_timer_eoi();
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	profile_tick(CPU_PROFILING, regs);
 }
 
diff -urN linux-2.6/arch/ia64/kernel/time.c linux-2.6-patched/arch/ia64/kernel/time.c
--- linux-2.6/arch/ia64/kernel/time.c	2004-09-10 17:02:13.000000000 +0200
+++ linux-2.6-patched/arch/ia64/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -67,14 +67,8 @@
 	profile_tick(CPU_PROFILING, regs);
 
 	while (1) {
-#ifdef CONFIG_SMP
-		/*
-		 * For UP, this is done in do_timer().  Weird, but
-		 * fixing that would require updates to all
-		 * platforms.
-		 */
 		update_process_times(user_mode(regs));
-#endif
+
 		new_itm += local_cpu_data->itm_delta;
 
 		if (smp_processor_id() == TIME_KEEPER_ID) {
diff -urN linux-2.6/arch/m68k/kernel/time.c linux-2.6-patched/arch/m68k/kernel/time.c
--- linux-2.6/arch/m68k/kernel/time.c	2004-09-10 17:02:13.000000000 +0200
+++ linux-2.6-patched/arch/m68k/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -45,6 +45,9 @@
 static irqreturn_t timer_interrupt(int irq, void *dummy, struct pt_regs * regs)
 {
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	profile_tick(CPU_PROFILING, regs);
 
 #ifdef CONFIG_HEARTBEAT
diff -urN linux-2.6/arch/m68k/sun3/sun3ints.c linux-2.6-patched/arch/m68k/sun3/sun3ints.c
--- linux-2.6/arch/m68k/sun3/sun3ints.c	2004-08-14 12:56:24.000000000 +0200
+++ linux-2.6-patched/arch/m68k/sun3/sun3ints.c	2004-09-10 17:02:51.000000000 +0200
@@ -85,6 +85,9 @@
 	intersil_clear();
 #endif
         do_timer(fp);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(fp));
+#endif
         if(!(kstat_cpu(0).irqs[SYS_IRQS + irq] % 20))
                 sun3_leds(led_pattern[(kstat_cpu(0).irqs[SYS_IRQS+irq]%160)
                 /20]);
diff -urN linux-2.6/arch/m68knommu/kernel/time.c linux-2.6-patched/arch/m68knommu/kernel/time.c
--- linux-2.6/arch/m68knommu/kernel/time.c	2004-09-10 17:02:13.000000000 +0200
+++ linux-2.6-patched/arch/m68knommu/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -57,6 +57,9 @@
 	write_seqlock(&xtime_lock);
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	if (current->pid)
 		profile_tick(CPU_PROFILING, regs);
 
diff -urN linux-2.6/arch/mips/au1000/common/time.c linux-2.6-patched/arch/mips/au1000/common/time.c
--- linux-2.6/arch/mips/au1000/common/time.c	2004-09-10 17:02:13.000000000 +0200
+++ linux-2.6-patched/arch/mips/au1000/common/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -99,6 +99,9 @@
 
 		kstat_this_cpu.irqs[irq]++;
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 		r4k_cur += r4k_offset;
 		ack_r4ktimer(r4k_cur);
 
@@ -137,6 +140,9 @@
 
 	while (time_elapsed > 0) {
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 		time_elapsed -= MATCH20_INC;
 		last_match20 += MATCH20_INC;
 		jiffie_drift++;
@@ -153,6 +159,9 @@
 	if (jiffie_drift >= 999) {
 		jiffie_drift -= 999;
 		do_timer(regs); /* increment jiffies by one */
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 	}
 }
 
diff -urN linux-2.6/arch/mips/baget/time.c linux-2.6-patched/arch/mips/baget/time.c
--- linux-2.6/arch/mips/baget/time.c	2004-08-14 12:54:46.000000000 +0200
+++ linux-2.6-patched/arch/mips/baget/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -52,6 +52,9 @@
 	if (timer_intr_valid()) {
 		sti();
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 	}
 }
 
diff -urN linux-2.6/arch/mips/galileo-boards/ev96100/time.c linux-2.6-patched/arch/mips/galileo-boards/ev96100/time.c
--- linux-2.6/arch/mips/galileo-boards/ev96100/time.c	2004-08-14 12:55:32.000000000 +0200
+++ linux-2.6-patched/arch/mips/galileo-boards/ev96100/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -73,6 +73,9 @@
 	do {
 		kstat_this_cpu.irqs[irq]++;
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 		r4k_cur += r4k_offset;
 		ack_r4ktimer(r4k_cur);
 
diff -urN linux-2.6/arch/mips/gt64120/common/time.c linux-2.6-patched/arch/mips/gt64120/common/time.c
--- linux-2.6/arch/mips/gt64120/common/time.c	2004-08-14 12:56:01.000000000 +0200
+++ linux-2.6-patched/arch/mips/gt64120/common/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -36,6 +36,9 @@
 		handled = 1;
 		irq_src &= ~0x00000800;
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 	}
 
 	GT_WRITE(GT_INTRCAUSE_OFS, 0);
diff -urN linux-2.6/arch/mips/kernel/time.c linux-2.6-patched/arch/mips/kernel/time.c
--- linux-2.6/arch/mips/kernel/time.c	2004-09-10 17:02:13.000000000 +0200
+++ linux-2.6-patched/arch/mips/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -418,10 +418,7 @@
 {
 	if (current->pid)
 		profile_tick(CPU_PROFILING, regs);
-#ifdef CONFIG_SMP
-	/* in UP mode, update_process_times() is invoked by do_timer() */
 	update_process_times(user_mode(regs));
-#endif
 }
 
 /*
diff -urN linux-2.6/arch/mips/momentum/ocelot_g/gt-irq.c linux-2.6-patched/arch/mips/momentum/ocelot_g/gt-irq.c
--- linux-2.6/arch/mips/momentum/ocelot_g/gt-irq.c	2004-08-14 12:56:25.000000000 +0200
+++ linux-2.6-patched/arch/mips/momentum/ocelot_g/gt-irq.c	2004-09-10 17:02:51.000000000 +0200
@@ -134,6 +134,9 @@
 
 		/* handle the timer call */
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 	}
 
 	if (irq_src) {
diff -urN linux-2.6/arch/mips/sgi-ip27/ip27-timer.c linux-2.6-patched/arch/mips/sgi-ip27/ip27-timer.c
--- linux-2.6/arch/mips/sgi-ip27/ip27-timer.c	2004-08-14 12:55:10.000000000 +0200
+++ linux-2.6-patched/arch/mips/sgi-ip27/ip27-timer.c	2004-09-10 17:02:51.000000000 +0200
@@ -112,9 +112,7 @@
 	if (cpu == 0)
 		do_timer(regs);
 
-#ifdef CONFIG_SMP
 	update_process_times(user_mode(regs));
-#endif /* CONFIG_SMP */
 
 	/*
 	 * If we have an externally synchronized Linux clock, then update
diff -urN linux-2.6/arch/parisc/kernel/time.c linux-2.6-patched/arch/parisc/kernel/time.c
--- linux-2.6/arch/parisc/kernel/time.c	2004-09-10 17:02:13.000000000 +0200
+++ linux-2.6-patched/arch/parisc/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -79,6 +79,8 @@
 	while (nticks--) {
 #ifdef CONFIG_SMP
 		smp_do_timer(regs);
+#else
+		update_process_times(user_mode(regs));
 #endif
 		if (cpu == 0) {
 			write_seqlock(&xtime_lock);
diff -urN linux-2.6/arch/ppc/kernel/time.c linux-2.6-patched/arch/ppc/kernel/time.c
--- linux-2.6/arch/ppc/kernel/time.c	2004-09-10 17:02:14.000000000 +0200
+++ linux-2.6-patched/arch/ppc/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -151,6 +151,9 @@
 		write_seqlock(&xtime_lock);
 		tb_last_stamp = jiffy_stamp;
 		do_timer(regs);
+#ifndef CONFIG_SMP
+		update_process_times(user_mode(regs));
+#endif
 
 		/*
 		 * update the rtc when needed, this should be performed on the
diff -urN linux-2.6/arch/ppc64/kernel/time.c linux-2.6-patched/arch/ppc64/kernel/time.c
--- linux-2.6/arch/ppc64/kernel/time.c	2004-09-10 17:02:15.000000000 +0200
+++ linux-2.6-patched/arch/ppc64/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -278,6 +278,9 @@
 			write_seqlock(&xtime_lock);
 			tb_last_stamp = lpaca->next_jiffy_update_tb;
 			do_timer(regs);
+#ifndef CONFIG_SMP
+			update_process_times(user_mode(regs));
+#endif
 			timer_sync_xtime( cur_tb );
 			timer_check_rtc();
 			write_sequnlock(&xtime_lock);
diff -urN linux-2.6/arch/s390/kernel/time.c linux-2.6-patched/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	2004-09-10 17:02:15.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -233,8 +233,10 @@
 	while (ticks--)
 		update_process_times(user_mode(regs));
 #else
-	while (ticks--)
+	while (ticks--) {
 		do_timer(regs);
+		update_process_times(user_mode(regs));
+	}
 #endif
 	s390_do_profile(regs);
 }
diff -urN linux-2.6/arch/sh/kernel/time.c linux-2.6-patched/arch/sh/kernel/time.c
--- linux-2.6/arch/sh/kernel/time.c	2004-09-10 17:02:15.000000000 +0200
+++ linux-2.6-patched/arch/sh/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -258,6 +258,9 @@
 static inline void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	profile_tick(CPU_PROFILING, regs);
 
 #ifdef CONFIG_HEARTBEAT
diff -urN linux-2.6/arch/sh64/kernel/time.c linux-2.6-patched/arch/sh64/kernel/time.c
--- linux-2.6/arch/sh64/kernel/time.c	2004-09-10 17:02:15.000000000 +0200
+++ linux-2.6-patched/arch/sh64/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -309,6 +309,9 @@
 	ctc_last_interrupt = (unsigned long) current_ctc;
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	profile_tick(CPU_PROFILING, regs);
 
 #ifdef CONFIG_HEARTBEAT
diff -urN linux-2.6/arch/sparc/kernel/pcic.c linux-2.6-patched/arch/sparc/kernel/pcic.c
--- linux-2.6/arch/sparc/kernel/pcic.c	2004-09-10 17:02:15.000000000 +0200
+++ linux-2.6-patched/arch/sparc/kernel/pcic.c	2004-09-10 17:02:51.000000000 +0200
@@ -716,6 +716,9 @@
 	write_seqlock(&xtime_lock);	/* Dummy, to show that we remember */
 	pcic_clear_clock_irq();
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	write_sequnlock(&xtime_lock);
 	return IRQ_HANDLED;
 }
diff -urN linux-2.6/arch/sparc/kernel/time.c linux-2.6-patched/arch/sparc/kernel/time.c
--- linux-2.6/arch/sparc/kernel/time.c	2004-09-10 17:02:15.000000000 +0200
+++ linux-2.6-patched/arch/sparc/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -132,6 +132,10 @@
 	clear_clock_irq();
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
+
 
 	/* Determine when to update the Mostek clock. */
 	if ((time_status & STA_UNSYNC) == 0 &&
diff -urN linux-2.6/arch/sparc64/kernel/time.c linux-2.6-patched/arch/sparc64/kernel/time.c
--- linux-2.6/arch/sparc64/kernel/time.c	2004-09-10 17:02:15.000000000 +0200
+++ linux-2.6-patched/arch/sparc64/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -464,6 +464,7 @@
 	do {
 #ifndef CONFIG_SMP
 		profile_tick(CPU_PROFILING, regs);
+		update_process_times(user_mode(regs));
 #endif
 		do_timer(regs);
 
diff -urN linux-2.6/arch/um/kernel/time_kern.c linux-2.6-patched/arch/um/kernel/time_kern.c
--- linux-2.6/arch/um/kernel/time_kern.c	2004-09-10 17:02:16.000000000 +0200
+++ linux-2.6-patched/arch/um/kernel/time_kern.c	2004-09-10 17:02:51.000000000 +0200
@@ -165,11 +165,9 @@
 
 void timer_handler(int sig, union uml_pt_regs *regs)
 {
-#ifdef CONFIG_SMP
 	local_irq_disable();
 	update_process_times(user_context(UPT_SP(regs)));
 	local_irq_enable();
-#endif
 	if(current_thread->cpu == 0)
 		timer_irq(regs);
 }
diff -urN linux-2.6/arch/v850/kernel/time.c linux-2.6-patched/arch/v850/kernel/time.c
--- linux-2.6/arch/v850/kernel/time.c	2004-09-10 17:02:16.000000000 +0200
+++ linux-2.6-patched/arch/v850/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -56,6 +56,9 @@
 	  mach_tick ();
 
 	do_timer (regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	profile_tick(CPU_PROFILING, regs);
 #if 0
 	/*
diff -urN linux-2.6/arch/x86_64/kernel/time.c linux-2.6-patched/arch/x86_64/kernel/time.c
--- linux-2.6/arch/x86_64/kernel/time.c	2004-09-10 17:02:16.000000000 +0200
+++ linux-2.6-patched/arch/x86_64/kernel/time.c	2004-09-10 17:02:51.000000000 +0200
@@ -417,6 +417,9 @@
  */
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 
 /*
  * In the SMP case we use the local APIC timer interrupt to do the profiling,
diff -urN linux-2.6/include/asm-arm/arch-clps711x/time.h linux-2.6-patched/include/asm-arm/arch-clps711x/time.h
--- linux-2.6/include/asm-arm/arch-clps711x/time.h	2004-08-14 12:56:24.000000000 +0200
+++ linux-2.6-patched/include/asm-arm/arch-clps711x/time.h	2004-09-10 17:02:51.000000000 +0200
@@ -30,6 +30,9 @@
 {
 	do_leds();
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	do_profile(regs);
 	return IRQ_HANDLED;
 }
diff -urN linux-2.6/include/asm-arm/arch-integrator/time.h linux-2.6-patched/include/asm-arm/arch-integrator/time.h
--- linux-2.6/include/asm-arm/arch-integrator/time.h	2004-08-14 12:55:48.000000000 +0200
+++ linux-2.6-patched/include/asm-arm/arch-integrator/time.h	2004-09-10 17:02:51.000000000 +0200
@@ -107,6 +107,9 @@
 
 	do_leds();
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	do_profile(regs);
 
 	return IRQ_HANDLED;
diff -urN linux-2.6/include/asm-arm/arch-l7200/time.h linux-2.6-patched/include/asm-arm/arch-l7200/time.h
--- linux-2.6/include/asm-arm/arch-l7200/time.h	2004-08-14 12:55:34.000000000 +0200
+++ linux-2.6-patched/include/asm-arm/arch-l7200/time.h	2004-09-10 17:02:51.000000000 +0200
@@ -46,6 +46,9 @@
 timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	do_profile(regs);
 	RTC_RTCC = 0;				/* Clear interrupt */
 
diff -urN linux-2.6/include/asm-i386/mach-default/do_timer.h linux-2.6-patched/include/asm-i386/mach-default/do_timer.h
--- linux-2.6/include/asm-i386/mach-default/do_timer.h	2004-09-10 17:02:31.000000000 +0200
+++ linux-2.6-patched/include/asm-i386/mach-default/do_timer.h	2004-09-10 17:02:51.000000000 +0200
@@ -16,6 +16,9 @@
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 /*
  * In the SMP case we use the local APIC timer interrupt to do the
  * profiling, except when we simulate SMP mode on a uniprocessor
diff -urN linux-2.6/include/asm-i386/mach-visws/do_timer.h linux-2.6-patched/include/asm-i386/mach-visws/do_timer.h
--- linux-2.6/include/asm-i386/mach-visws/do_timer.h	2004-09-10 17:02:31.000000000 +0200
+++ linux-2.6-patched/include/asm-i386/mach-visws/do_timer.h	2004-09-10 17:02:51.000000000 +0200
@@ -9,6 +9,9 @@
 	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
 
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 /*
  * In the SMP case we use the local APIC timer interrupt to do the
  * profiling, except when we simulate SMP mode on a uniprocessor
diff -urN linux-2.6/include/asm-i386/mach-voyager/do_timer.h linux-2.6-patched/include/asm-i386/mach-voyager/do_timer.h
--- linux-2.6/include/asm-i386/mach-voyager/do_timer.h	2004-08-14 12:55:48.000000000 +0200
+++ linux-2.6-patched/include/asm-i386/mach-voyager/do_timer.h	2004-09-10 17:02:51.000000000 +0200
@@ -4,6 +4,9 @@
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
 	do_timer(regs);
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 
 	voyager_timer_interrupt(regs);
 }
diff -urN linux-2.6/kernel/timer.c linux-2.6-patched/kernel/timer.c
--- linux-2.6/kernel/timer.c	2004-09-10 17:02:34.000000000 +0200
+++ linux-2.6-patched/kernel/timer.c	2004-09-10 17:02:51.000000000 +0200
@@ -957,11 +957,6 @@
 void do_timer(struct pt_regs *regs)
 {
 	jiffies_64++;
-#ifndef CONFIG_SMP
-	/* SMP process accounting uses the local APIC timer */
-
-	update_process_times(user_mode(regs));
-#endif
 	update_times();
 }
 
