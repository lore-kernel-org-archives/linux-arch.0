Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:43176 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932505AbWFVJBk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Jun 2006 05:01:40 -0400
From: Keith Owens <kaos@sgi.com>
Subject: [patch 2.6.17] Standardize i386/x86_64 handling of NMI_VECTOR
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 Jun 2006 19:01:06 +1000
Message-ID: <11413.1150966866@kao2.melbourne.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

x86_64 and i386 behave inconsistently when sending an IPI on vector 2
(NMI_VECTOR).  Make both behave the same, so IPI 2 is sent as NMI.

The crash code was abusing send_IPI_allbutself() by passing a code
instead of a vector, it only worked because crash knew about the
internal code of send_IPI_allbutself().  Change crash to use NMI_VECTOR
instead, and remove the comment about how crash was abusing the function.

Signed-off-by: Keith Owens <kaos@sgi.com>

---
 arch/i386/kernel/crash.c   |    7 +------
 arch/i386/kernel/smp.c     |   12 +++++++++++-
 arch/x86_64/kernel/crash.c |    2 +-
 include/asm-i386/hw_irq.h  |    2 ++
 4 files changed, 15 insertions(+), 8 deletions(-)

Index: linux/arch/i386/kernel/crash.c
===================================================================
--- linux.orig/arch/i386/kernel/crash.c
+++ linux/arch/i386/kernel/crash.c
@@ -119,14 +119,9 @@ static int crash_nmi_callback(struct pt_
 	return 1;
 }
 
-/*
- * By using the NMI code instead of a vector we just sneak thru the
- * word generator coming out with just what we want.  AND it does
- * not matter if clustered_apic_mode is set or not.
- */
 static void smp_send_nmi_allbutself(void)
 {
-	send_IPI_allbutself(APIC_DM_NMI);
+	send_IPI_allbutself(NMI_VECTOR);
 }
 
 static void nmi_shootdown_cpus(void)
Index: linux/arch/i386/kernel/smp.c
===================================================================
--- linux.orig/arch/i386/kernel/smp.c
+++ linux/arch/i386/kernel/smp.c
@@ -114,7 +114,17 @@ DEFINE_PER_CPU(struct tlb_state, cpu_tlb
 
 static inline int __prepare_ICR (unsigned int shortcut, int vector)
 {
-	return APIC_DM_FIXED | shortcut | vector | APIC_DEST_LOGICAL;
+	unsigned int icr = shortcut | APIC_DEST_LOGICAL;
+
+	switch (vector) {
+	default:
+		icr |= APIC_DM_FIXED | vector;
+		break;
+	case NMI_VECTOR:
+		icr |= APIC_DM_NMI;
+		break;
+	}
+	return icr;
 }
 
 static inline int __prepare_ICR2 (unsigned int mask)
Index: linux/arch/x86_64/kernel/crash.c
===================================================================
--- linux.orig/arch/x86_64/kernel/crash.c
+++ linux/arch/x86_64/kernel/crash.c
@@ -118,7 +118,7 @@ static int crash_nmi_callback(struct pt_
 
 static void smp_send_nmi_allbutself(void)
 {
-	send_IPI_allbutself(APIC_DM_NMI);
+	send_IPI_allbutself(NMI_VECTOR);
 }
 
 /*
Index: linux/include/asm-i386/hw_irq.h
===================================================================
--- linux.orig/include/asm-i386/hw_irq.h
+++ linux/include/asm-i386/hw_irq.h
@@ -20,6 +20,8 @@
 
 struct hw_interrupt_type;
 
+#define NMI_VECTOR		0x02
+
 /*
  * Various low-level irq details needed by irq.c, process.c,
  * time.c, io_apic.c and smp.c

