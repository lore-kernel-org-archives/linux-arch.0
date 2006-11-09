Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:65152 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424034AbWKIEFH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2006 23:05:07 -0500
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id kA96mDOI005371
	for <@external-mail-relay.sgi.com:linux-arch@vger.kernel.org>; Wed, 8 Nov 2006 22:48:14 -0800
From: Keith Owens <kaos@sgi.com>
Date: Thu, 09 Nov 2006 15:05:03 +1100
Message-Id: <20061109040503.17391.66138.sendpatchset@chook.melbourne.sgi.com>
In-Reply-To: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
References: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
Subject: [patch 2.6.19-rc5 8/12] crash_stop: ia64 interrupt handlers
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Keith Owens <kaos@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

Define the ia64 crash_stop() interrupt handler and associated routines.

IPI_CRASH_STOP conflicts with the KDB vector.  This is deliberate, one
aim of the crash_stop() API is to remove all the interrupt code from
the various kernel debug patches and use the common crash_stop code
instead.

Signed-off-by: Keith Owens <kaos@sgi.com>
---
 arch/ia64/kernel/smp.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

Index: linux/arch/ia64/kernel/smp.c
===================================================================
--- linux.orig/arch/ia64/kernel/smp.c
+++ linux/arch/ia64/kernel/smp.c
@@ -30,6 +30,7 @@
 #include <linux/delay.h>
 #include <linux/efi.h>
 #include <linux/bitops.h>
+#include <linux/crash_stop.h>
 
 #include <asm/atomic.h>
 #include <asm/current.h>
@@ -66,6 +67,7 @@ static volatile struct call_data_struct 
 
 #define IPI_CALL_FUNC		0
 #define IPI_CPU_STOP		1
+#define IPI_CRASH_STOP		2
 
 /* This needs to be cacheline aligned because it is written to by *other* CPUs.  */
 static DEFINE_PER_CPU(u64, ipi_operation) ____cacheline_aligned;
@@ -156,6 +158,16 @@ handle_IPI (int irq, void *dev_id)
 				stop_this_cpu();
 				break;
 
+#ifdef	CONFIG_CRASH_STOP_SUPPORTED
+			      case IPI_CRASH_STOP:
+				{
+					extern void smp_crash_stop_interrupt(
+						    struct pt_regs *regs);
+					smp_crash_stop_interrupt(get_irq_regs());
+				}
+				break;
+#endif	/* CONFIG_CRASH_STOP_SUPPORTED */
+
 			      default:
 				printk(KERN_CRIT "Unknown IPI on CPU %d: %lu\n", this_cpu, which);
 				break;
@@ -379,3 +391,26 @@ setup_profiling_timer (unsigned int mult
 {
 	return -EINVAL;
 }
+
+#ifdef	CONFIG_CRASH_STOP_SUPPORTED
+void
+cs_arch_send_ipi(int cpu)
+{
+	send_IPI_single(cpu, IPI_CRASH_STOP);
+}
+
+void
+cs_arch_send_nmi(int cpu)
+{
+	set_mb(cs_arch_monarch_cpu, smp_processor_id());
+	platform_send_ipi(cpu, 0, IA64_IPI_DM_INIT, 0);
+}
+
+void
+smp_crash_stop_interrupt(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	cs_common_ipi();
+	set_irq_regs(old_regs);
+}
+#endif	/* CONFIG_CRASH_STOP_SUPPORTED */
