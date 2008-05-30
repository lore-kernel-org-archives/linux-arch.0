From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 08/41] cpu alloc: ACPI cstate handling conversion
Date: Thu, 29 May 2008 20:56:28 -0700
Message-ID: <20080530040012.864398705@sgi.com>
References: <20080530035620.587204923@sgi.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.171.30]:56570 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751030AbYE3EAP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 00:00:15 -0400
Content-Disposition: inline; filename=cpu_alloc_acpi_cstate_handling_conversion
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

Convert ACPI per cpu handling to cpu alloc.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
---
 arch/x86/kernel/acpi/cstate.c              |    9 +++++----
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    7 ++++---
 drivers/acpi/processor_perflib.c           |    4 ++--
 3 files changed, 11 insertions(+), 9 deletions(-)

Index: linux-2.6/arch/x86/kernel/acpi/cstate.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/cstate.c	2008-04-29 14:55:48.000000000 -0700
+++ linux-2.6/arch/x86/kernel/acpi/cstate.c	2008-05-21 21:43:07.000000000 -0700
@@ -85,7 +85,7 @@
 	if (reg->bit_offset != NATIVE_CSTATE_BEYOND_HALT)
 		return -1;
 
-	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
+	percpu_entry = CPU_PTR(cpu_cstate_entry, cpu);
 	percpu_entry->states[cx->index].eax = 0;
 	percpu_entry->states[cx->index].ecx = 0;
 
@@ -138,7 +138,7 @@
 	unsigned int cpu = smp_processor_id();
 	struct cstate_entry *percpu_entry;
 
-	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
+	percpu_entry = CPU_PTR(cpu_cstate_entry, cpu);
 	mwait_idle_with_hints(percpu_entry->states[cx->index].eax,
 	                      percpu_entry->states[cx->index].ecx);
 }
@@ -150,13 +150,14 @@
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return -1;
 
-	cpu_cstate_entry = alloc_percpu(struct cstate_entry);
+	cpu_cstate_entry = CPU_ALLOC(struct cstate_entry,
+					GFP_KERNEL|__GFP_ZERO);
 	return 0;
 }
 
 static void __exit ffh_cstate_exit(void)
 {
-	free_percpu(cpu_cstate_entry);
+	CPU_FREE(cpu_cstate_entry);
 	cpu_cstate_entry = NULL;
 }
 
Index: linux-2.6/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c	2008-04-29 14:55:48.000000000 -0700
+++ linux-2.6/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c	2008-05-21 21:44:02.000000000 -0700
@@ -524,7 +524,8 @@
 {
 	dprintk("acpi_cpufreq_early_init\n");
 
-	acpi_perf_data = alloc_percpu(struct acpi_processor_performance);
+	acpi_perf_data = CPU_ALLOC(struct acpi_processor_performance,
+						GFP_KERNEL|__GFP_ZERO);
 	if (!acpi_perf_data) {
 		dprintk("Memory allocation error for acpi_perf_data.\n");
 		return -ENOMEM;
@@ -580,7 +581,7 @@
 	if (!data)
 		return -ENOMEM;
 
-	data->acpi_data = percpu_ptr(acpi_perf_data, cpu);
+	data->acpi_data = CPU_PTR(acpi_perf_data, cpu);
 	per_cpu(drv_data, cpu) = data;
 
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC))
@@ -794,7 +795,7 @@
 
 	cpufreq_unregister_driver(&acpi_cpufreq_driver);
 
-	free_percpu(acpi_perf_data);
+	CPU_FREE(acpi_perf_data);
 
 	return;
 }
Index: linux-2.6/drivers/acpi/processor_perflib.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_perflib.c	2008-04-29 14:55:49.000000000 -0700
+++ linux-2.6/drivers/acpi/processor_perflib.c	2008-05-21 21:43:07.000000000 -0700
@@ -583,12 +583,12 @@
 			continue;
 		}
 
-		if (!performance || !percpu_ptr(performance, i)) {
+		if (!performance || !CPU_PTR(performance, i)) {
 			retval = -EINVAL;
 			continue;
 		}
 
-		pr->performance = percpu_ptr(performance, i);
+		pr->performance = CPU_PTR(performance, i);
 		cpu_set(i, pr->performance->shared_cpu_map);
 		if (acpi_processor_get_psd(pr)) {
 			retval = -EINVAL;

-- 
