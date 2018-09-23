Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp21.cstnet.cn ([159.226.251.21]:50760 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbeIWPey (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 23 Sep 2018 11:34:54 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v8 14/16] cpufreq, x86: Add Hygon Dhyana support
Date: Sun, 23 Sep 2018 17:37:38 +0800
Message-ID: <4db6f0f8537a93c172430c446a0297a6ab1c3c2d.1537533369.git.puwen@hygon.cn>
In-Reply-To: <cover.1537533368.git.puwen@hygon.cn>
References: <cover.1537533368.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, rafael@kernel.org, rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pm@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180923093738.wUaOacayTFcQasgKsxG-V4f7a3DUtmo3WEDZHrPladY@z>

The Hygon Dhyana CPU supports ACPI P-States feature, and there is
SMBus device(PCI device ID 0x790b) on Hygon platform, so add Hygon
Dhyana support to the cpufreq driver by using the code path of AMD
family 17h.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c         | 5 +++++
 drivers/cpufreq/amd_freq_sensitivity.c | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index b61f4ec..d62fd37 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -61,6 +61,7 @@ enum {
 
 #define INTEL_MSR_RANGE		(0xffff)
 #define AMD_MSR_RANGE		(0x7)
+#define HYGON_MSR_RANGE		(0x7)
 
 #define MSR_K7_HWCR_CPB_DIS	(1ULL << 25)
 
@@ -95,6 +96,7 @@ static bool boost_state(unsigned int cpu)
 		rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &lo, &hi);
 		msr = lo | ((u64)hi << 32);
 		return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
 		msr = lo | ((u64)hi << 32);
@@ -113,6 +115,7 @@ static int boost_set_msr(bool enable)
 		msr_addr = MSR_IA32_MISC_ENABLE;
 		msr_mask = MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
 		break;
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		msr_addr = MSR_K7_HWCR;
 		msr_mask = MSR_K7_HWCR_CPB_DIS;
@@ -225,6 +228,8 @@ static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
 		msr &= AMD_MSR_RANGE;
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		msr &= HYGON_MSR_RANGE;
 	else
 		msr &= INTEL_MSR_RANGE;
 
diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index be926d9..4ac7c3c 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -111,11 +111,16 @@ static int __init amd_freq_sensitivity_init(void)
 {
 	u64 val;
 	struct pci_dev *pcidev;
+	unsigned int pci_vendor;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		pci_vendor = PCI_VENDOR_ID_AMD;
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		pci_vendor = PCI_VENDOR_ID_HYGON;
+	else
 		return -ENODEV;
 
-	pcidev = pci_get_device(PCI_VENDOR_ID_AMD,
+	pcidev = pci_get_device(pci_vendor,
 			PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, NULL);
 
 	if (!pcidev) {
-- 
2.7.4
