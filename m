From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v6 15/16] EDAC, amd64: Add Hygon Dhyana support
Date: Mon, 10 Sep 2018 21:20:24 +0800
Message-ID: <7deadc44054d62e3617b9f302f4e5d1fd0d382e7.1536550550.git.puwen@hygon.cn>
References: <cover.1536550549.git.puwen@hygon.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536550549.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, mchehab@kernel.org, mikhail.jin@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org, Pu Wen <puwen@hygon.cn>
List-Id: linux-arch.vger.kernel.org

To make AMD64 EDAC and MCE drivers working on Hygon platforms, add
support for Hygon Dhyana CPU by using the code path of AMD family
17h.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 drivers/edac/amd64_edac.c | 8 +++++++-
 drivers/edac/mce_amd.c    | 4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 18aeabb..bf3314b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -211,7 +211,7 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
 
 	scrubval = scrubrates[i].scrubval;
 
-	if (pvt->fam == 0x17) {
+	if (pvt->fam == 0x17 || pvt->fam == 0x18) {
 		__f17h_set_scrubval(pvt, scrubval);
 	} else if (pvt->fam == 0x15 && pvt->model == 0x60) {
 		f15h_select_dct(pvt, 0);
@@ -264,6 +264,7 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
 		break;
 
 	case 0x17:
+	case 0x18:
 		amd64_read_pci_cfg(pvt->F6, F17H_SCR_BASE_ADDR, &scrubval);
 		if (scrubval & BIT(0)) {
 			amd64_read_pci_cfg(pvt->F6, F17H_SCR_LIMIT_ADDR, &scrubval);
@@ -1044,6 +1045,7 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 		goto ddr3;
 
 	case 0x17:
+	case 0x18:
 		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
 			pvt->dram_type = MEM_LRDDR4;
 		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
@@ -3188,8 +3190,11 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		break;
 
 	case 0x17:
+	case 0x18:
 		fam_type	= &family_types[F17_CPUS];
 		pvt->ops	= &family_types[F17_CPUS].ops;
+		if (pvt->fam == 0x18)
+			family_types[F17_CPUS].ctl_name = "F18h";
 		break;
 
 	default:
@@ -3428,6 +3433,7 @@ static const struct x86_cpu_id amd64_cpuids[] = {
 	{ X86_VENDOR_AMD, 0x15, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
 	{ X86_VENDOR_AMD, 0x16, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
 	{ X86_VENDOR_AMD, 0x17, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
+	{ X86_VENDOR_HYGON, 0x18, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 2ab4d61..c605089 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1059,7 +1059,8 @@ static int __init mce_amd_init(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
-	if (c->x86_vendor != X86_VENDOR_AMD)
+	if (c->x86_vendor != X86_VENDOR_AMD &&
+	    c->x86_vendor != X86_VENDOR_HYGON)
 		return -ENODEV;
 
 	fam_ops = kzalloc(sizeof(struct amd_decoder_ops), GFP_KERNEL);
@@ -1113,6 +1114,7 @@ static int __init mce_amd_init(void)
 		break;
 
 	case 0x17:
+	case 0x18:
 		xec_mask = 0x3f;
 		if (!boot_cpu_has(X86_FEATURE_SMCA)) {
 			printk(KERN_WARNING "Decoding supported only on Scalable MCA processors.\n");
-- 
2.7.4
