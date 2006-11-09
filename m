Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:62080 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424028AbWKIEEl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2006 23:04:41 -0500
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id kA96ljbv005342
	for <@external-mail-relay.sgi.com:linux-arch@vger.kernel.org>; Wed, 8 Nov 2006 22:47:46 -0800
From: Keith Owens <kaos@sgi.com>
Date: Thu, 09 Nov 2006 15:04:35 +1100
Message-Id: <20061109040435.17391.67751.sendpatchset@chook.melbourne.sgi.com>
In-Reply-To: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
References: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
Subject: [patch 2.6.19-rc5 3/12] crash_stop: i386 interrupt handlers
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Keith Owens <kaos@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

Define the i386 crash_stop() interrupt handler and associated routines.

CRASH_STOP_VECTOR conflicts with the lkcd vector.  This is deliberate,
one aim of the crash_stop() API is to remove all the interrupt code
from the various kernel debug patches and use the common crash_stop
code instead.

Note 1: I have patched visw but I cannot test it, no hardware.

Note 2: This patch does not cover i386 voyager.  I do not understand
        the voyager interrupt mechanism well enough to define its
        interrupt handlers.  Somebody with voyager equipment needs to
        define the cs_arch_send_ipi() and cs_arch_send_nmi() routines,
        plus the gate for the voyager CRASH_STOP_VECTOR.

Signed-off-by: Keith Owens <kaos@sgi.com>
---
 arch/i386/kernel/smp.c                      |   23 +++++++++++++++++++++++
 arch/i386/kernel/smpboot.c                  |    4 ++++
 include/asm-i386/hw_irq.h                   |    1 +
 include/asm-i386/mach-default/entry_arch.h  |    3 +++
 include/asm-i386/mach-default/irq_vectors.h |    1 +
 include/asm-i386/mach-visws/entry_arch.h    |    3 +++
 6 files changed, 35 insertions(+)

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
@@ -733,3 +734,25 @@ int safe_smp_processor_id(void)
 
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
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	ack_APIC_irq();
+	cs_common_ipi();
+	set_irq_regs(old_regs);
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
@@ -32,6 +32,7 @@ extern void (*interrupt[NR_IRQS])(void);
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
