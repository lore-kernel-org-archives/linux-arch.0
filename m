Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:35745 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727304AbeHKQAe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 11 Aug 2018 12:00:34 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v3 01/17] x86/cpu: create Dhyana init file and register new cpu_dev to system
Date: Sat, 11 Aug 2018 21:25:46 +0800
Message-ID: <82cb25b7531b758c0e368bc3b2d7974a47412e5e.1533989492.git.puwen@hygon.cn>
In-Reply-To: <cover.1533989492.git.puwen@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180811132546.3qkJ8EC5n8rgvCtIiv6LIEWpp9Ua-1AyUxCPWiVYCew@z>

Add x86 architecture support for new processor Hygon Dhyana Family 18h.
Rework to create a separated file(arch/x86/kernel/cpu/hygon.c) from the
AMD init one(arch/x86/kernel/cpu/amd.c) to initialize Dhyana CPU. In
this way we can remove old AMD architecture support codes from Hygon
code path and generate a clear initialization flow for Hygon processors.
It also reduce long-term maintenance effort.
Also add Maintainer information for hygon.c in accordance.

To identify Hygon processors, add a new vendor type X86_VENDOR_HYGON(9)
for system recognition.

To enable Hygon processor config, add a separated Kconfig entry
(CPU_SUP_HYGON) for Dhyana CPU in kernel config setup.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 MAINTAINERS                      |   6 +
 arch/x86/Kconfig.cpu             |  13 ++
 arch/x86/include/asm/processor.h |   3 +-
 arch/x86/kernel/cpu/Makefile     |   1 +
 arch/x86/kernel/cpu/hygon.c      | 401 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 423 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/hygon.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7cebd5b..1aed9fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6605,6 +6605,12 @@ S:	Maintained
 F:	mm/memory-failure.c
 F:	mm/hwpoison-inject.c
 
+HYGON PROCESSOR SUPPORT
+M:	Pu Wen <puwen@hygon.cn>
+L:	linux-arch@vger.kernel.org
+S:	Supported
+F:	arch/x86/kernel/cpu/hygon.c
+
 Hyper-V CORE AND DRIVERS
 M:	"K. Y. Srinivasan" <kys@microsoft.com>
 M:	Haiyang Zhang <haiyangz@microsoft.com>
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 638411f..2e92267 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -426,6 +426,19 @@ config CPU_SUP_AMD
 
 	  If unsure, say N.
 
+config CPU_SUP_HYGON
+	default y
+	bool "Support Hygon processors" if PROCESSOR_SELECT
+	help
+	  This enables detection, tunings and quirks for Hygon processors
+
+	  You need this enabled if you want your kernel to run on an
+	  Hygon CPU. Disabling this option on other types of CPUs
+	  makes the kernel a tiny bit smaller. Disabling it on an Hygon
+	  CPU might render the kernel unbootable.
+
+	  If unsure, say N.
+
 config CPU_SUP_CENTAUR
 	default y
 	bool "Support Centaur processors" if PROCESSOR_SELECT
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cfd29ee..b4f4fbd 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -153,7 +153,8 @@ enum cpuid_regs_idx {
 #define X86_VENDOR_CENTAUR	5
 #define X86_VENDOR_TRANSMETA	7
 #define X86_VENDOR_NSC		8
-#define X86_VENDOR_NUM		9
+#define X86_VENDOR_HYGON	9
+#define X86_VENDOR_NUM		10
 
 #define X86_VENDOR_UNKNOWN	0xff
 
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 7a40196..889ce58 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
 
 obj-$(CONFIG_CPU_SUP_INTEL)		+= intel.o intel_pconfig.o
 obj-$(CONFIG_CPU_SUP_AMD)		+= amd.o
+obj-$(CONFIG_CPU_SUP_HYGON)		+= hygon.o
 obj-$(CONFIG_CPU_SUP_CYRIX_32)		+= cyrix.o
 obj-$(CONFIG_CPU_SUP_CENTAUR)		+= centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+= transmeta.o
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
new file mode 100644
index 0000000..cc296e5
--- /dev/null
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hygon Processor Support for Linux
+ *
+ * Copyright (c) Chengdu Haiguang IC Design Co., Ltd.
+ *
+ * Author: 2018 Pu Wen <puwen@hygon.cn>
+ *
+ * This file is licensed under the terms of the GNU General
+ * License v2.0 or later. See file COPYING for details.
+ */
+#include <linux/io.h>
+
+#include <asm/cpu.h>
+#include <asm/smp.h>
+#include <asm/cacheinfo.h>
+#include <asm/spec-ctrl.h>
+#include <asm/delay.h>
+#ifdef CONFIG_X86_64
+# include <asm/set_memory.h>
+#endif
+
+#include "cpu.h"
+
+/*
+ * nodes_per_socket: Stores the number of nodes per socket.
+ * Refer to CPUID Fn8000_001E_ECX Node Identifiers[10:8]
+ */
+static u32 nodes_per_socket = 1;
+
+#ifdef CONFIG_NUMA
+/*
+ * To workaround broken NUMA config.  Read the comment in
+ * srat_detect_node().
+ */
+static int nearby_node(int apicid)
+{
+	int i, node;
+
+	for (i = apicid - 1; i >= 0; i--) {
+		node = __apicid_to_node[i];
+		if (node != NUMA_NO_NODE && node_online(node))
+			return node;
+	}
+	for (i = apicid + 1; i < MAX_LOCAL_APIC; i++) {
+		node = __apicid_to_node[i];
+		if (node != NUMA_NO_NODE && node_online(node))
+			return node;
+	}
+	return first_node(node_online_map); /* Shouldn't happen */
+}
+#endif
+
+/*
+ * Fixup core topology information for
+ * (1) Hygon multi-node processors
+ *     Assumption: Number of cores in each internal node is the same.
+ * (2) Hygon processors supporting compute units
+ */
+static void hygon_get_topology(struct cpuinfo_x86 *c)
+{
+	u8 node_id;
+	int cpu = smp_processor_id();
+
+	/* get information required for multi-node processors */
+	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
+		int err;
+		u32 eax, ebx, ecx, edx;
+
+		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
+
+		node_id  = ecx & 0xff;
+		smp_num_siblings = ((ebx >> 8) & 0xff) + 1;
+
+		c->cpu_core_id = ebx & 0xff;
+
+		if (smp_num_siblings > 1)
+			c->x86_max_cores /= smp_num_siblings;
+
+		/*
+		 * In case leaf B is available, use it to derive
+		 * topology information.
+		 */
+		err = detect_extended_topology(c);
+		if (!err)
+			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
+
+	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
+		u64 value;
+
+		rdmsrl(MSR_FAM10H_NODE_ID, value);
+		node_id = value & 7;
+
+		per_cpu(cpu_llc_id, cpu) = node_id;
+	} else
+		return;
+
+	if (nodes_per_socket > 1)
+		set_cpu_cap(c, X86_FEATURE_AMD_DCM);
+}
+
+/*
+ * On Hygon setup the lower bits of the APIC id distinguish the cores.
+ * Assumes number of cores is a power of two.
+ */
+static void hygon_detect_cmp(struct cpuinfo_x86 *c)
+{
+	unsigned int bits;
+	int cpu = smp_processor_id();
+
+	bits = c->x86_coreid_bits;
+	/* Low order bits define the core id (index of core in socket) */
+	c->cpu_core_id = c->initial_apicid & ((1 << bits)-1);
+	/* Convert the initial APIC ID into the socket ID */
+	c->phys_proc_id = c->initial_apicid >> bits;
+	/* use socket ID also for last level cache */
+	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
+}
+
+static void srat_detect_node(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_NUMA
+	int cpu = smp_processor_id();
+	int node;
+	unsigned int apicid = c->apicid;
+
+	node = numa_cpu_node(cpu);
+	if (node == NUMA_NO_NODE)
+		node = per_cpu(cpu_llc_id, cpu);
+
+	/*
+	 * On multi-fabric platform (e.g. Numascale NumaChip) a
+	 * platform-specific handler needs to be called to fixup some
+	 * IDs of the CPU.
+	 */
+	if (x86_cpuinit.fixup_cpu_id)
+		x86_cpuinit.fixup_cpu_id(c, node);
+
+	if (!node_online(node)) {
+		/*
+		 * Two possibilities here:
+		 *
+		 * - The CPU is missing memory and no node was created.  In
+		 *   that case try picking one from a nearby CPU.
+		 *
+		 * - The APIC IDs differ from the HyperTransport node IDs.
+		 *   Assume they are all increased by a constant offset, but
+		 *   in the same order as the HT nodeids.  If that doesn't
+		 *   result in a usable node fall back to the path for the
+		 *   previous case.
+		 *
+		 * This workaround operates directly on the mapping between
+		 * APIC ID and NUMA node, assuming certain relationship
+		 * between APIC ID, HT node ID and NUMA topology.  As going
+		 * through CPU mapping may alter the outcome, directly
+		 * access __apicid_to_node[].
+		 */
+		int ht_nodeid = c->initial_apicid;
+
+		if (__apicid_to_node[ht_nodeid] != NUMA_NO_NODE)
+			node = __apicid_to_node[ht_nodeid];
+		/* Pick a nearby node */
+		if (!node_online(node))
+			node = nearby_node(apicid);
+	}
+	numa_set_node(cpu, node);
+#endif
+}
+
+static void early_init_hygon_mc(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_SMP
+	unsigned int bits, ecx;
+
+	/* Multi core CPU? */
+	if (c->extended_cpuid_level < 0x80000008)
+		return;
+
+	ecx = cpuid_ecx(0x80000008);
+
+	c->x86_max_cores = (ecx & 0xff) + 1;
+
+	/* CPU telling us the core id bits shift? */
+	bits = (ecx >> 12) & 0xF;
+
+	/* Otherwise recompute */
+	if (bits == 0) {
+		while ((1 << bits) < c->x86_max_cores)
+			bits++;
+	}
+
+	c->x86_coreid_bits = bits;
+#endif
+}
+
+static void bsp_init_hygon(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_X86_64
+	unsigned long long tseg;
+
+	/*
+	 * Split up direct mapping around the TSEG SMM area.
+	 * Don't do it for gbpages because there seems very little
+	 * benefit in doing so.
+	 */
+	if (!rdmsrl_safe(MSR_K8_TSEG_ADDR, &tseg)) {
+		unsigned long pfn = tseg >> PAGE_SHIFT;
+
+		pr_debug("tseg: %010llx\n", tseg);
+		if (pfn_range_is_mapped(pfn, pfn + 1))
+			set_memory_4k((unsigned long)__va(tseg), 1);
+	}
+#endif
+
+	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
+		u64 val;
+
+		rdmsrl(MSR_K7_HWCR, val);
+		if (!(val & BIT(24)))
+			pr_warn(FW_BUG "TSC doesn't count with P0 frequency!\n");
+	}
+
+	if (cpu_has(c, X86_FEATURE_MWAITX))
+		use_mwaitx_delay();
+
+	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
+		u32 ecx;
+
+		ecx = cpuid_ecx(0x8000001e);
+		nodes_per_socket = ((ecx >> 8) & 7) + 1;
+	} else if (boot_cpu_has(X86_FEATURE_NODEID_MSR)) {
+		u64 value;
+
+		rdmsrl(MSR_FAM10H_NODE_ID, value);
+		nodes_per_socket = ((value >> 3) & 7) + 1;
+	}
+
+	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
+	    !boot_cpu_has(X86_FEATURE_VIRT_SSBD)) {
+		/*
+		 * Try to cache the base value so further operations can
+		 * avoid RMW. If that faults, do not enable SSBD.
+		 */
+		if (!rdmsrl_safe(MSR_AMD64_LS_CFG, &x86_amd_ls_cfg_base)) {
+			setup_force_cpu_cap(X86_FEATURE_LS_CFG_SSBD);
+			setup_force_cpu_cap(X86_FEATURE_SSBD);
+			x86_amd_ls_cfg_ssbd_mask = 1ULL << 10;
+		}
+	}
+}
+
+static void early_init_hygon(struct cpuinfo_x86 *c)
+{
+	u32 dummy;
+
+	early_init_hygon_mc(c);
+
+	rdmsr_safe(MSR_AMD64_PATCH_LEVEL, &c->microcode, &dummy);
+
+	/*
+	 * c->x86_power is 8000_0007 edx. Bit 8 is TSC runs at constant rate
+	 * with P/T states and does not stop in deep C-states
+	 */
+	if (c->x86_power & (1 << 8)) {
+		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
+		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
+	}
+
+	/* Bit 12 of 8000_0007 edx is accumulated power mechanism. */
+	if (c->x86_power & BIT(12))
+		set_cpu_cap(c, X86_FEATURE_ACC_POWER);
+
+	set_cpu_cap(c, X86_FEATURE_SYSCALL32);
+
+#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PCI)
+	/*
+	 * ApicID can always be treated as an 8-bit value for Hygon APIC So, we
+	 * can safely set X86_FEATURE_EXTD_APICID unconditionally.
+	 */
+	if (boot_cpu_has(X86_FEATURE_APIC))
+		set_cpu_cap(c, X86_FEATURE_EXTD_APICID);
+#endif
+
+	/*
+	 * This is only needed to tell the kernel whether to use VMCALL
+	 * and VMMCALL.  VMMCALL is never executed except under virt, so
+	 * we can set it unconditionally.
+	 */
+	set_cpu_cap(c, X86_FEATURE_VMMCALL);
+}
+
+static void init_hygon(struct cpuinfo_x86 *c)
+{
+	early_init_hygon(c);
+
+	/*
+	 * Bit 31 in normal CPUID used for nonstandard 3DNow ID;
+	 * 3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway
+	 */
+	clear_cpu_cap(c, 0*32+31);
+
+	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
+
+	/* get apicid instead of initial apic id from cpuid */
+	c->apicid = hard_smp_processor_id();
+
+	set_cpu_cap(c, X86_FEATURE_ZEN);
+
+	cpu_detect_cache_sizes(c);
+
+	/* Multi core CPU? */
+	if (c->extended_cpuid_level >= 0x80000008) {
+		hygon_detect_cmp(c);
+		hygon_get_topology(c);
+		srat_detect_node(c);
+	}
+
+	set_cpu_cap(c, X86_FEATURE_K8);
+
+	if (cpu_has(c, X86_FEATURE_XMM2)) {
+		unsigned long long val;
+		int ret;
+
+		/*
+		 * A serializing LFENCE has less overhead than MFENCE, so
+		 * use it for execution serialization.  On families which
+		 * don't have that MSR, LFENCE is already serializing.
+		 * msr_set_bit() uses the safe accessors, too, even if the MSR
+		 * is not present.
+		 */
+		msr_set_bit(MSR_F10H_DECFG,
+			    MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT);
+
+		/*
+		 * Verify that the MSR write was successful (could be running
+		 * under a hypervisor) and only then assume that LFENCE is
+		 * serializing.
+		 */
+		ret = rdmsrl_safe(MSR_F10H_DECFG, &val);
+		if (!ret && (val & MSR_F10H_DECFG_LFENCE_SERIALIZE)) {
+			/* A serializing LFENCE stops RDTSC speculation */
+			set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
+		} else {
+			/* MFENCE stops RDTSC speculation */
+			set_cpu_cap(c, X86_FEATURE_MFENCE_RDTSC);
+		}
+	}
+
+	/*
+	 * Hygon processors have APIC timer running in deep C states.
+	 */
+	set_cpu_cap(c, X86_FEATURE_ARAT);
+
+	/* Hygon CPUs don't reset SS attributes on SYSRET, Xen does. */
+	if (!cpu_has(c, X86_FEATURE_XENPV))
+		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
+}
+
+static void cpu_detect_tlb_hygon(struct cpuinfo_x86 *c)
+{
+	u32 ebx, eax, ecx, edx;
+	u16 mask = 0xfff;
+
+	if (c->extended_cpuid_level < 0x80000006)
+		return;
+
+	cpuid(0x80000006, &eax, &ebx, &ecx, &edx);
+
+	tlb_lld_4k[ENTRIES] = (ebx >> 16) & mask;
+	tlb_lli_4k[ENTRIES] = ebx & mask;
+
+	/* Handle DTLB 2M and 4M sizes, fall back to L1 if L2 is disabled */
+	if (!((eax >> 16) & mask))
+		tlb_lld_2m[ENTRIES] = (cpuid_eax(0x80000005) >> 16) & 0xff;
+	else
+		tlb_lld_2m[ENTRIES] = (eax >> 16) & mask;
+
+	/* a 4M entry uses two 2M entries */
+	tlb_lld_4m[ENTRIES] = tlb_lld_2m[ENTRIES] >> 1;
+
+	/* Handle ITLB 2M and 4M sizes, fall back to L1 if L2 is disabled */
+	if (!(eax & mask)) {
+		cpuid(0x80000005, &eax, &ebx, &ecx, &edx);
+		tlb_lli_2m[ENTRIES] = eax & 0xff;
+	} else
+		tlb_lli_2m[ENTRIES] = eax & mask;
+
+	tlb_lli_4m[ENTRIES] = tlb_lli_2m[ENTRIES] >> 1;
+}
+
+static const struct cpu_dev hygon_cpu_dev = {
+	.c_vendor	= "Hygon",
+	.c_ident	= { "HygonGenuine" },
+	.c_early_init   = early_init_hygon,
+	.c_detect_tlb	= cpu_detect_tlb_hygon,
+	.c_bsp_init	= bsp_init_hygon,
+	.c_init		= init_hygon,
+	.c_x86_vendor	= X86_VENDOR_HYGON,
+};
+
+cpu_dev_register(hygon_cpu_dev);
-- 
2.7.4
