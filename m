From: David Howells <dhowells@redhat.com>
Subject: [PATCH 07/13] Make some apic functions return bool when returning a
 boolean value
Date: Wed, 29 Apr 2015 20:22:16 +0100
Message-ID: <20150429192216.24909.256.stgit@warthog.procyon.org.uk>
References: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42904 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369AbbD2TWT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 29 Apr 2015 15:22:19 -0400
In-Reply-To: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org

Make some apic functions return bool when returning a boolean value as it
better informs gcc and allows the compiler to make better choices.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/apic.h         |   22 +++++++++++-----------
 arch/x86/kernel/apic/apic_flat_64.c |    2 +-
 arch/x86/kernel/apic/apic_noop.c    |    2 +-
 arch/x86/kernel/setup.c             |    2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 976b86a325e5..49f99f236784 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -269,8 +269,8 @@ struct apic {
 
 	int (*probe)(void);
 	int (*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
-	int (*apic_id_valid)(int apicid);
-	int (*apic_id_registered)(void);
+	bool (*apic_id_valid)(int apicid);
+	bool (*apic_id_registered)(void);
 
 	u32 irq_delivery_mode;
 	u32 irq_dest_mode;
@@ -280,7 +280,7 @@ struct apic {
 	int disable_esr;
 
 	int dest_logical;
-	unsigned long (*check_apicid_used)(physid_mask_t *map, int apicid);
+	bool (*check_apicid_used)(physid_mask_t *map, int apicid);
 
 	void (*vector_allocation_domain)(int cpu, struct cpumask *retmask,
 					 const struct cpumask *mask);
@@ -291,7 +291,7 @@ struct apic {
 	void (*setup_apic_routing)(void);
 	int (*cpu_present_to_apicid)(int mps_cpu);
 	void (*apicid_to_cpu_present)(int phys_apicid, physid_mask_t *retmap);
-	int (*check_phys_apicid_present)(int phys_apicid);
+	bool (*check_phys_apicid_present)(int phys_apicid);
 	int (*phys_pkg_id)(int cpuid_apic, int index_msb);
 
 	unsigned int (*get_apic_id)(unsigned long x);
@@ -465,7 +465,7 @@ extern void apic_send_IPI_self(int vector);
 DECLARE_PER_CPU(int, x2apic_extra_bits);
 
 extern int default_cpu_present_to_apicid(int mps_cpu);
-extern int default_check_phys_apicid_present(int phys_apicid);
+extern bool default_check_phys_apicid_present(int phys_apicid);
 #endif
 
 extern void generic_bigsmp_probe(void);
@@ -503,7 +503,7 @@ static inline unsigned int read_apic_id(void)
 	return apic->get_apic_id(reg);
 }
 
-static inline int default_apic_id_valid(int apicid)
+static inline bool default_apic_id_valid(int apicid)
 {
 	return (apicid < 255);
 }
@@ -530,7 +530,7 @@ static inline int noop_x86_32_early_logical_apicid(int cpu)
  */
 extern void default_init_apic_ldr(void);
 
-static inline int default_apic_id_registered(void)
+static inline bool default_apic_id_registered(void)
 {
 	return physid_isset(read_apic_id(), phys_cpu_present_map);
 }
@@ -588,7 +588,7 @@ default_vector_allocation_domain(int cpu, struct cpumask *retmask,
 	cpumask_copy(retmask, cpumask_of(cpu));
 }
 
-static inline unsigned long default_check_apicid_used(physid_mask_t *map, int apicid)
+static inline bool default_check_apicid_used(physid_mask_t *map, int apicid)
 {
 	return physid_isset(apicid, *map);
 }
@@ -606,7 +606,7 @@ static inline int __default_cpu_present_to_apicid(int mps_cpu)
 		return BAD_APICID;
 }
 
-static inline int
+static inline bool
 __default_check_phys_apicid_present(int phys_apicid)
 {
 	return physid_isset(phys_apicid, phys_cpu_present_map);
@@ -618,14 +618,14 @@ static inline int default_cpu_present_to_apicid(int mps_cpu)
 	return __default_cpu_present_to_apicid(mps_cpu);
 }
 
-static inline int
+static inline bool
 default_check_phys_apicid_present(int phys_apicid)
 {
 	return __default_check_phys_apicid_present(phys_apicid);
 }
 #else
 extern int default_cpu_present_to_apicid(int mps_cpu);
-extern int default_check_phys_apicid_present(int phys_apicid);
+extern bool default_check_phys_apicid_present(int phys_apicid);
 #endif
 
 #endif /* CONFIG_X86_LOCAL_APIC */
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index de918c410eae..4853d71be324 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -139,7 +139,7 @@ static unsigned int read_xapic_id(void)
 	return id;
 }
 
-static int flat_apic_id_registered(void)
+static bool flat_apic_id_registered(void)
 {
 	return physid_isset(read_xapic_id(), phys_cpu_present_map);
 }
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index b205cdbdbe6a..acba7847612a 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -72,7 +72,7 @@ static int noop_probe(void)
 	return 0;
 }
 
-static int noop_apic_id_registered(void)
+static bool noop_apic_id_registered(void)
 {
 	/*
 	 * if we would be really "pedantic"
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d74ac33290ae..c38fdd234716 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -136,7 +136,7 @@ int default_cpu_present_to_apicid(int mps_cpu)
 	return __default_cpu_present_to_apicid(mps_cpu);
 }
 
-int default_check_phys_apicid_present(int phys_apicid)
+bool default_check_phys_apicid_present(int phys_apicid)
 {
 	return __default_check_phys_apicid_present(phys_apicid);
 }
