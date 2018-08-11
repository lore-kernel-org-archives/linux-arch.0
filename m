Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:42043 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbeHKQEC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 11 Aug 2018 12:04:02 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v3 13/17] x86/xen: enable Hygon support to Xen
Date: Sat, 11 Aug 2018 21:29:24 +0800
Message-ID: <2747ad959f07459000f2693a98d237e2b3149ca1.1533989493.git.puwen@hygon.cn>
In-Reply-To: <cover.1533989492.git.puwen@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, JBeulich@suse.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180811132924.ck60YxSEUvEge4SrFgd7kWACa7jhLZdqit6TiLHD0H8@z>

To make Xen work correctly on Hygon platforms, reuse AMD's Xen support
code path and add vendor check for Hygon along with AMD.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/xen/pmu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 7d00d4a..1053dda 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -90,6 +90,12 @@ static void xen_pmu_arch_init(void)
 			k7_counters_mirrored = 0;
 			break;
 		}
+	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+		amd_num_counters = F10H_NUM_COUNTERS;
+		amd_counters_base = MSR_K7_PERFCTR0;
+		amd_ctrls_base = MSR_K7_EVNTSEL0;
+		amd_msr_step = 1;
+		k7_counters_mirrored = 0;
 	} else {
 		uint32_t eax, ebx, ecx, edx;
 
@@ -285,7 +291,8 @@ static bool xen_amd_pmu_emulate(unsigned int msr, u64 *val, bool is_read)
 
 bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 		if (is_amd_pmu_msr(msr)) {
 			if (!xen_amd_pmu_emulate(msr, val, 1))
 				*val = native_read_msr_safe(msr, err);
@@ -308,7 +315,8 @@ bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err)
 {
 	uint64_t val = ((uint64_t)high << 32) | low;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 		if (is_amd_pmu_msr(msr)) {
 			if (!xen_amd_pmu_emulate(msr, &val, 0))
 				*err = native_write_msr_safe(msr, low, high);
@@ -379,7 +387,8 @@ static unsigned long long xen_intel_read_pmc(int counter)
 
 unsigned long long xen_read_pmc(int counter)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return xen_amd_read_pmc(counter);
 	else
 		return xen_intel_read_pmc(counter);
-- 
2.7.4
