Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:63872 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424031AbWKIEE5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2006 23:04:57 -0500
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id kA96m27i005353
	for <@external-mail-relay.sgi.com:linux-arch@vger.kernel.org>; Wed, 8 Nov 2006 22:48:04 -0800
From: Keith Owens <kaos@sgi.com>
Date: Thu, 09 Nov 2006 15:04:52 +1100
Message-Id: <20061109040452.17391.83587.sendpatchset@chook.melbourne.sgi.com>
In-Reply-To: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
References: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
Subject: [patch 2.6.19-rc5 6/12] crash_stop: x86_64 interrupt handlers
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Keith Owens <kaos@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

Define the x86_64 crash_stop() interrupt handler and associated routines.

CRASH_STOP_VECTOR conflicts with the KDB vector.  This is deliberate,
one aim of the crash_stop() API is to remove all the interrupt code
from the various kernel debug patches and use the common crash_stop
code instead.

Signed-off-by: Keith Owens <kaos@sgi.com>
---
 arch/x86_64/kernel/entry.S  |    6 ++++++
 arch/x86_64/kernel/i8259.c  |    4 ++++
 arch/x86_64/kernel/smp.c    |   23 +++++++++++++++++++++++
 include/asm-x86_64/hw_irq.h |    3 +--
 4 files changed, 34 insertions(+), 2 deletions(-)

Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -699,6 +699,12 @@ END(invalidate_interrupt\num)
 ENTRY(call_function_interrupt)
 	apicinterrupt CALL_FUNCTION_VECTOR,smp_call_function_interrupt
 END(call_function_interrupt)
+
+#ifdef CONFIG_CRASH_STOP_SUPPORTED
+ENTRY(crash_stop_interrupt)
+	apicinterrupt CRASH_STOP_VECTOR,smp_crash_stop_interrupt
+END(crash_stop_interrupt)
+#endif	/* CONFIG_CRASH_STOP_SUPPORTED */
 #endif
 
 ENTRY(apic_timer_interrupt)
Index: linux/arch/x86_64/kernel/i8259.c
===================================================================
--- linux.orig/arch/x86_64/kernel/i8259.c
+++ linux/arch/x86_64/kernel/i8259.c
@@ -458,6 +458,7 @@ void invalidate_interrupt6(void);
 void invalidate_interrupt7(void);
 void thermal_interrupt(void);
 void threshold_interrupt(void);
+void crash_stop_interrupt(void);
 void i8254_timer_resume(void);
 
 static void setup_timer_hardware(void)
@@ -541,6 +542,9 @@ void __init init_IRQ(void)
 
 	/* IPI for generic function call */
 	set_intr_gate(CALL_FUNCTION_VECTOR, call_function_interrupt);
+#ifdef CONFIG_CRASH_STOP_SUPPORTED
+	set_intr_gate(CRASH_STOP_VECTOR, crash_stop_interrupt);
+#endif	/* CONFIG_CRASH_STOP_SUPPORTED */
 #endif	
 	set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
 	set_intr_gate(THRESHOLD_APIC_VECTOR, threshold_interrupt);
Index: linux/arch/x86_64/kernel/smp.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smp.c
+++ linux/arch/x86_64/kernel/smp.c
@@ -19,6 +19,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/mc146818rtc.h>
 #include <linux/interrupt.h>
+#include <linux/crash_stop.h>
 
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
@@ -522,3 +523,25 @@ asmlinkage void smp_call_function_interr
 	}
 }
 
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
+asmlinkage void
+smp_crash_stop_interrupt(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	ack_APIC_irq();
+	cs_common_ipi();
+	set_irq_regs(old_regs);
+}
+#endif	/* CONFIG_CRASH_STOP_SUPPORTED */
Index: linux/include/asm-x86_64/hw_irq.h
===================================================================
--- linux.orig/include/asm-x86_64/hw_irq.h
+++ linux/include/asm-x86_64/hw_irq.h
@@ -47,8 +47,7 @@
 #define ERROR_APIC_VECTOR	0xfe
 #define RESCHEDULE_VECTOR	0xfd
 #define CALL_FUNCTION_VECTOR	0xfc
-/* fb free - please don't readd KDB here because it's useless
-   (hint - think what a NMI bit does to a vector) */
+#define CRASH_STOP_VECTOR	0xfb
 #define THERMAL_APIC_VECTOR	0xfa
 #define THRESHOLD_APIC_VECTOR   0xf9
 /* f8 free */
