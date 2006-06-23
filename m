Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:50819 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932215AbWFWEcl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Jun 2006 00:32:41 -0400
From: Keith Owens <kaos@sgi.com>
Subject: [patch 2.6.17] Avoid broadcasting NMI IPIs
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 23 Jun 2006 14:32:01 +1000
Message-ID: <8637.1151037121@kao2.melbourne.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On some i386/x86_64 systems, sending an NMI IPI as a broadcast will
reset the system.  This seems to be a BIOS bug which affects machines
where one or more cpus are not under OS control.  It occurs on HT
systems with a version of the OS that is not compiled without HT
support.  It also occurs when a system is booted with max_cpus=n where
2 <= n < cpus known to the BIOS.  The fix is to always send NMI IPI as
a mask instead of as a broadcast.

Signed-off-by: Keith Owens <kaos@sgi.com>

---

This patch needs my earlier patch that defines NMI_VECTOR for i386.
http://marc.theaimsgroup.com/?l=linux-arch&m=115096692430934&w=2

I was going to do a bigger patch that removed all the broadcast mode
IPI code, so all systems would use cpu masks for IPI.  Broadcast mode
is currently restricted to small machines with CONFIG_HOTPLUG_CPU=n,
everything else already uses mask mode.  Removing broadcast mode would
simplify the maze of per-platform IPI handling, everything would be
using masks.  But I decided to do the minimal fix and leave the IPI
clean up (and removing the trailing white space in those files) for
another time.

 arch/x86_64/kernel/genapic_flat.c        |   25 ++++++++++++++++---------
 include/asm-i386/mach-default/mach_ipi.h |    4 ++--
 2 files changed, 18 insertions(+), 11 deletions(-)

Index: linux/arch/x86_64/kernel/genapic_flat.c
===================================================================
--- linux.orig/arch/x86_64/kernel/genapic_flat.c
+++ linux/arch/x86_64/kernel/genapic_flat.c
@@ -78,22 +78,29 @@ static void flat_send_IPI_mask(cpumask_t
 
 static void flat_send_IPI_allbutself(int vector)
 {
-#ifndef CONFIG_HOTPLUG_CPU
-	if (((num_online_cpus()) - 1) >= 1)
-		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector,APIC_DEST_LOGICAL);
+#ifdef	CONFIG_HOTPLUG_CPU
+	int hotplug = 1;
 #else
-	cpumask_t allbutme = cpu_online_map;
+	int hotplug = 0;
+#endif
+	if (hotplug || vector == NMI_VECTOR) {
+		cpumask_t allbutme = cpu_online_map;
 
-	cpu_clear(smp_processor_id(), allbutme);
+		cpu_clear(smp_processor_id(), allbutme);
 
-	if (!cpus_empty(allbutme))
-		flat_send_IPI_mask(allbutme, vector);
-#endif
+		if (!cpus_empty(allbutme))
+			flat_send_IPI_mask(allbutme, vector);
+	} else if (num_online_cpus() > 1) {
+		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector,APIC_DEST_LOGICAL);
+	}
 }
 
 static void flat_send_IPI_all(int vector)
 {
-	__send_IPI_shortcut(APIC_DEST_ALLINC, vector, APIC_DEST_LOGICAL);
+	if (vector == NMI_VECTOR)
+		flat_send_IPI_mask(cpu_online_map, vector);
+	else
+		__send_IPI_shortcut(APIC_DEST_ALLINC, vector, APIC_DEST_LOGICAL);
 }
 
 static int flat_apic_id_registered(void)
Index: linux/include/asm-i386/mach-default/mach_ipi.h
===================================================================
--- linux.orig/include/asm-i386/mach-default/mach_ipi.h
+++ linux/include/asm-i386/mach-default/mach_ipi.h
@@ -13,7 +13,7 @@ static inline void send_IPI_mask(cpumask
 
 static inline void __local_send_IPI_allbutself(int vector)
 {
-	if (no_broadcast) {
+	if (no_broadcast || vector == NMI_VECTOR) {
 		cpumask_t mask = cpu_online_map;
 
 		cpu_clear(smp_processor_id(), mask);
@@ -24,7 +24,7 @@ static inline void __local_send_IPI_allb
 
 static inline void __local_send_IPI_all(int vector)
 {
-	if (no_broadcast)
+	if (no_broadcast || vector == NMI_VECTOR)
 		send_IPI_mask(cpu_online_map, vector);
 	else
 		__send_IPI_shortcut(APIC_DEST_ALLINC, vector);

