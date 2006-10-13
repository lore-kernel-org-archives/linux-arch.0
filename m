Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:26156 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750735AbWJMNZU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Oct 2006 09:25:20 -0400
Received: from ocs3.ocs.com.au (ocs3w.ocs.com.au [192.168.254.3])
	by mail.ocs.com.au (Postfix) with ESMTP id B6560E0B20A
	for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2006 23:25:18 +1000 (EST)
Received: from ocs3.ocs.com.au (localhost [127.0.0.1])
	by ocs3.ocs.com.au (Postfix) with ESMTP id F15A781EE7
	for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2006 23:25:40 +1000 (EST)
From: Keith Owens <kaos@sgi.com>
Subject: [RFC] crash_stop: crash_stop_i386_handler
In-reply-to: Your message of "Fri, 13 Oct 2006 23:23:35 +1000."
             <26656.1160745815@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Oct 2006 23:25:40 +1000
Message-ID: <27440.1160745940@ocs3.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Define the i386 crash_stop() interrupt handler and associated routines.

Yes, I know that CRASH_STOP_VECTOR conflicts with the lkcd vector.
This is deliberate, one aim of the crash_stop() API is to remove all
the interrupt code from the various kernel debug patches.

Note 1: I have patched visw but I cannot test it, no hardware.

Note 2: This patch does not cover i386 voyager.  I do not understand
        the voyager interrupt mechanism well enough to define its
        interrupt handlers (hint, hint).

---
 arch/i386/kernel/smp.c                      |   21 +++++++++++++++++++++
 arch/i386/kernel/smpboot.c                  |    4 ++++
 include/asm-i386/hw_irq.h                   |    1 +
 include/asm-i386/mach-default/entry_arch.h  |    3 +++
 include/asm-i386/mach-default/irq_vectors.h |    1 +
 include/asm-i386/mach-visws/entry_arch.h    |    3 +++
 6 files changed, 33 insertions(+)

Index: linux/arch/i386/kernel/smp.c
===================================================================
--- linux.orig/arch/i386/kernel/smp.c
+++ linux/arch/i386/kernel/smp.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/crash_stop.h>
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
@@ -727,3 +728,23 @@ int safe_smp_processor_id(void)
 
 	return cpuid >= 0 ? cpuid : 0;
 }
+
+#ifdef	CONFIG_CRASH_STOP_SUPPORTED
+void
+cs_arch_send_ipi(int cpu)
+{
+	send_IPI_mask(cpumask_of_cpu(cpu), CRASH_STOP_VECTOR);
+}
+
+void
+cs_arch_send_nmi(int cpu)
+{
+	send_IPI_mask(cpumask_of_cpu(cpu), NMI_VECTOR);
+}
+
+fastcall void smp_crash_stop_interrupt(struct pt_regs *regs)
+{
+	ack_APIC_irq();
+	cs_common_ipi(regs);
+}
+#endif	/* CONFIG_CRASH_STOP_SUPPORTED */
Index: linux/arch/i386/kernel/smpboot.c
===================================================================
--- linux.orig/arch/i386/kernel/smpboot.c
+++ linux/arch/i386/kernel/smpboot.c
@@ -1497,6 +1497,10 @@ void __init smp_intr_init(void)
 
 	/* IPI for generic function call */
 	set_intr_gate(CALL_FUNCTION_VECTOR, call_function_interrupt);
+
+#ifdef	CONFIG_CRASH_STOP_SUPPORTED
+	set_intr_gate(CRASH_STOP_VECTOR, crash_stop_interrupt);
+#endif	/* CONFIG_CRASH_STOP_SUPPORTED */
 }
 
 /*
Index: linux/include/asm-i386/hw_irq.h
===================================================================
--- linux.orig/include/asm-i386/hw_irq.h
+++ linux/include/asm-i386/hw_irq.h
@@ -35,6 +35,7 @@ extern void (*interrupt[NR_IRQS])(void);
 fastcall void reschedule_interrupt(void);
 fastcall void invalidate_interrupt(void);
 fastcall void call_function_interrupt(void);
+fastcall void crash_stop_interrupt(void);
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
Index: linux/include/asm-i386/mach-default/entry_arch.h
===================================================================
--- linux.orig/include/asm-i386/mach-default/entry_arch.h
+++ linux/include/asm-i386/mach-default/entry_arch.h
@@ -13,6 +13,9 @@
 BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
 BUILD_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
 BUILD_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
+#ifdef	CONFIG_CRASH_STOP_SUPPORTED
+BUILD_INTERRUPT(crash_stop_interrupt,CRASH_STOP_VECTOR)
+#endif	/* CONFIG_CRASH_STOP_SUPPORTED */
 #endif
 
 /*
Index: linux/include/asm-i386/mach-default/irq_vectors.h
===================================================================
--- linux.orig/include/asm-i386/mach-default/irq_vectors.h
+++ linux/include/asm-i386/mach-default/irq_vectors.h
@@ -48,6 +48,7 @@
 #define INVALIDATE_TLB_VECTOR	0xfd
 #define RESCHEDULE_VECTOR	0xfc
 #define CALL_FUNCTION_VECTOR	0xfb
+#define CRASH_STOP_VECTOR	0xfa
 
 #define THERMAL_APIC_VECTOR	0xf0
 /*
Index: linux/include/asm-i386/mach-visws/entry_arch.h
===================================================================
--- linux.orig/include/asm-i386/mach-visws/entry_arch.h
+++ linux/include/asm-i386/mach-visws/entry_arch.h
@@ -7,6 +7,9 @@
 BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
 BUILD_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
 BUILD_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
+#ifdef	CONFIG_CRASH_STOP_SUPPORTED
+BUILD_INTERRUPT(crash_stop_interrupt,CRASH_STOP_VECTOR)
+#endif	/* CONFIG_CRASH_STOP_SUPPORTED */
 #endif
 
 /*

