Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp21.cstnet.cn ([159.226.251.21]:45754 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388144AbeGWOli (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Jul 2018 10:41:38 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 15/17] driver/cpufreq: enable Hygon support to cpufreq driver
Date: Mon, 23 Jul 2018 21:20:35 +0800
Message-ID: <1532352037-7151-16-git-send-email-puwen@hygon.cn>
In-Reply-To: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180723132035.T_a_-NuJoMxPddN2nFOLJk7aaTl0tIGBfcQ4k4P46Gk@z>

Enable ACPI cpufreq driver support for Hygon by adding family ID check
along with AMD.

As Hygon platforms have SMBus device(PCI device ID 0x790b), enable Hygon
support to function amd_freq_sensitivity_init().

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 drivers/cpufreq/acpi-cpufreq.c         | 11 +++++++++++
 drivers/cpufreq/amd_freq_sensitivity.c |  9 +++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index b61f4ec..cd97a7e 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -61,6 +61,7 @@ enum {
 
 #define INTEL_MSR_RANGE		(0xffff)
 #define AMD_MSR_RANGE		(0x7)
+#define HYGON_MSR_RANGE		(0x7)
 
 #define MSR_K7_HWCR_CPB_DIS	(1ULL << 25)
 
@@ -99,6 +100,10 @@ static bool boost_state(unsigned int cpu)
 		rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
 		msr = lo | ((u64)hi << 32);
 		return !(msr & MSR_K7_HWCR_CPB_DIS);
+	case X86_VENDOR_HYGON:
+		rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
+		msr = lo | ((u64)hi << 32);
+		return !(msr & MSR_K7_HWCR_CPB_DIS);
 	}
 	return false;
 }
@@ -117,6 +122,10 @@ static int boost_set_msr(bool enable)
 		msr_addr = MSR_K7_HWCR;
 		msr_mask = MSR_K7_HWCR_CPB_DIS;
 		break;
+	case X86_VENDOR_HYGON:
+		msr_addr = MSR_K7_HWCR;
+		msr_mask = MSR_K7_HWCR_CPB_DIS;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -225,6 +234,8 @@ static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
 
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
