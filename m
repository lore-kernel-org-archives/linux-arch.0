Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp21.cstnet.cn ([159.226.251.21]:52041 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387986AbeGWO3f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Jul 2018 10:29:35 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 02/17] x86/cache: get Dhyana cache size/leaves and setup cache cpumap
Date: Mon, 23 Jul 2018 21:20:22 +0800
Message-ID: <1532352037-7151-3-git-send-email-puwen@hygon.cn>
In-Reply-To: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180723132022.LW65uOaVn4Bzl7U8Bps91X0iI0z4BPq69GOcNcwMLsw@z>

Hygon Dhyana processor has the topology extensions bit in CPUID.
With this bit kernel can get the cache info. So add support
in cpuid4_cache_lookup_regs() to get the correct cache size.

Dhyana also find num_cache_leaves via CPUID leaf 0x8000001d, so
add Hygon support in find_num_cache_leaves().

Also add cacheinfo_hygon_init_llc_id() and init_hygon_cacheinfo()
functions to initialize Dhyana cache info. Setup cache cpumap in
the same way as AMD does.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/include/asm/cacheinfo.h |  1 +
 arch/x86/kernel/cpu/cacheinfo.c  | 31 +++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/cpu.h        |  1 +
 arch/x86/kernel/cpu/hygon.c      |  3 +++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index e958e28..86b63c7 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -3,5 +3,6 @@
 #define _ASM_X86_CACHEINFO_H
 
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
 
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 0c5fcbd..dc1b934 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -602,6 +602,10 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
 		else
 			amd_cpuid4(index, &eax, &ebx, &ecx);
 		amd_init_l3_cache(this_leaf, index);
+	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+		cpuid_count(0x8000001d, index, &eax.full,
+			    &ebx.full, &ecx.full, &edx);
+		amd_init_l3_cache(this_leaf, index);
 	} else {
 		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &edx);
 	}
@@ -625,7 +629,8 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	union _cpuid4_leaf_eax	cache_eax;
 	int 			i = -1;
 
-	if (c->x86_vendor == X86_VENDOR_AMD)
+	if (c->x86_vendor == X86_VENDOR_AMD ||
+	    c->x86_vendor == X86_VENDOR_HYGON)
 		op = 0x8000001d;
 	else
 		op = 4;
@@ -678,6 +683,22 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 	}
 }
 
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
+{
+	/*
+	 * We may have multiple LLCs if L3 caches exist, so check if we
+	 * have an L3 cache by looking at the L3 cache CPUID leaf.
+	 */
+	if (!cpuid_edx(0x80000006))
+		return;
+
+	/*
+	 * LLC is at the core complex level.
+	 * Core complex ID is ApicId[3] for these processors.
+	 */
+	per_cpu(cpu_llc_id, cpu) = c->apicid >> 3;
+}
+
 void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 {
 
@@ -691,6 +712,11 @@ void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 	}
 }
 
+void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
+{
+	num_cache_leaves = find_num_cache_leaves(c);
+}
+
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
@@ -913,7 +939,8 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 	int index_msb, i;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-	if (c->x86_vendor == X86_VENDOR_AMD) {
+	if (c->x86_vendor == X86_VENDOR_AMD ||
+	    c->x86_vendor == X86_VENDOR_HYGON) {
 		if (__cache_amd_cpumap_setup(cpu, index, base))
 			return;
 	}
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 38216f6..c2ba596 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -53,6 +53,7 @@ extern u32 get_scattered_cpuid_leaf(unsigned int level,
 				    enum cpuid_regs_idx reg);
 extern void init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
+extern void init_hygon_cacheinfo(struct cpuinfo_x86 *c);
 
 extern void detect_num_cpu_cores(struct cpuinfo_x86 *c);
 extern int detect_extended_topology(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index cc296e5..0d77b91 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -85,6 +85,7 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
+		cacheinfo_amd_init_llc_id(c, cpu, node_id);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
@@ -315,6 +316,8 @@ static void init_hygon(struct cpuinfo_x86 *c)
 		srat_detect_node(c);
 	}
 
+	init_hygon_cacheinfo(c);
+
 	set_cpu_cap(c, X86_FEATURE_K8);
 
 	if (cpu_has(c, X86_FEATURE_XMM2)) {
-- 
2.7.4
