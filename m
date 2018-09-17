Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:59915 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728300AbeIQTBI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Sep 2018 15:01:08 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v7 12/16] x86/xen: Add Hygon Dhyana support to Xen
Date: Mon, 17 Sep 2018 21:33:23 +0800
Message-ID: <442c514034790d4f6b8b743769114be6d48b3094.1537182523.git.puwen@hygon.cn>
In-Reply-To: <cover.1537182523.git.puwen@hygon.cn>
References: <cover.1537182523.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, boris.ostrovsky@oracle.com, jgross@suse.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180917133323.50b4n0gqEnncZkMuGZql8sYDkAbpFeE_ycEIq-Qj8ls@z>

To make Xen works functionally on Hygon platform, reuse AMD's Xen
support code path for Hygon Dhyana CPU.

There are six core performance events counters per thread, so there are
six MSRs for these counters(0-5). Also there are four legacy PMC MSRs,
they are alias of the counters(0-3).

In this version of kernel Hygon use the legacy and safe version of MSR
access. It works fine when VPMU enabled in Xen on Hygon platform by
testing with perf.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/xen/pmu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 7d00d4a..9403854 100644
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
 
@@ -285,7 +291,7 @@ static bool xen_amd_pmu_emulate(unsigned int msr, u64 *val, bool is_read)
 
 bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
 		if (is_amd_pmu_msr(msr)) {
 			if (!xen_amd_pmu_emulate(msr, val, 1))
 				*val = native_read_msr_safe(msr, err);
@@ -308,7 +314,7 @@ bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err)
 {
 	uint64_t val = ((uint64_t)high << 32) | low;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
 		if (is_amd_pmu_msr(msr)) {
 			if (!xen_amd_pmu_emulate(msr, &val, 0))
 				*err = native_write_msr_safe(msr, low, high);
@@ -379,7 +385,7 @@ static unsigned long long xen_intel_read_pmc(int counter)
 
 unsigned long long xen_read_pmc(int counter)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return xen_amd_read_pmc(counter);
 	else
 		return xen_intel_read_pmc(counter);
-- 
2.7.4
