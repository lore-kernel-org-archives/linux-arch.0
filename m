From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH 1/2] x86/amd_nb: Add vendor checking for strict function access
Date: Tue, 25 Sep 2018 22:45:01 +0800
Message-ID: <487d8078708baedaf63eb00a82251e228b58f1c2.1537885177.git.puwen@hygon.cn>
References: <cover.1537533368.git.puwen@hygon.cn> <580dc519d37ad9257520fe8c533f2c61d3e0cd83.1537533369.git.puwen@hygon.cn> <20180924152448.GE20187@zn.tnic>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924152448.GE20187@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: bp@alien8.de, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, helgaas@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, Pu Wen <puwen@hygon.cn>
List-Id: linux-arch.vger.kernel.org

To prevent further PCI device ids checking in early_gart_iommu_check
which cannot happen both on Hygon and Intel platform, the function
amd_gart_present should return if it's not a AMD CPU.

Also only AMD or Hygon CPU should use the functionality provided by
early_is_amd_nb.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/include/asm/amd_nb.h | 3 +++
 arch/x86/kernel/amd_nb.c      | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index fddb6d2..1ae4e57 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -103,6 +103,9 @@ static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
 
 static inline bool amd_gart_present(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return false;
+
 	/* GART present only on Fam15h, upto model 0fh */
 	if (boot_cpu_data.x86 == 0xf || boot_cpu_data.x86 == 0x10 ||
 	    (boot_cpu_data.x86 == 0x15 && boot_cpu_data.x86_model < 0x10))
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index b481b95..b51c6b1 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -264,6 +264,10 @@ bool __init early_is_amd_nb(u32 device)
 	const struct pci_device_id *id;
 	u32 vendor = device & 0xffff;
 
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return false;
+
 	device >>= 16;
 	for (id = amd_nb_misc_ids; id->vendor; id++)
 		if (vendor == id->vendor && device == id->device)
-- 
2.7.4
