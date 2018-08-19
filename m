From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v4 15/16] driver/edac: enable Hygon support to AMD64 EDAC driver
Date: Mon, 20 Aug 2018 00:14:58 +0800
Message-ID: <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
References: <cover.1534599097.git.puwen@hygon.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1534599097.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, mchehab@kernel.org, mikhail.jin@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org, Pu Wen <puwen@hygon.cn>
List-Id: linux-arch.vger.kernel.org

To make AMD64 EDAC and MCE drivers working on Hygon platforms, add
vendor checking for Hygon by using the code path of AMD 0x17. Add a
vendor field to struct amd64_pvt and initialize it in per_family_init
for vendor checking.

Also Hygon PCI Device ID DF_F0/DF_F6(0x1460/0x1466) of Host bridges
is needed for edac driver.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 drivers/edac/amd64_edac.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/edac/amd64_edac.h |  5 +++++
 drivers/edac/mce_amd.c    | 15 +++++++++++++-
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 18aeabb..3cefb25 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -211,7 +211,8 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
 
 	scrubval = scrubrates[i].scrubval;
 
-	if (pvt->fam == 0x17) {
+	if (pvt->fam == 0x17 ||
+	   (pvt->vendor == X86_VENDOR_HYGON && pvt->fam == 0x18)) {
 		__f17h_set_scrubval(pvt, scrubval);
 	} else if (pvt->fam == 0x15 && pvt->model == 0x60) {
 		f15h_select_dct(pvt, 0);
@@ -274,6 +275,21 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
 		}
 		break;
 
+	case 0x18:
+		if (pvt->vendor == X86_VENDOR_HYGON) {
+			amd64_read_pci_cfg(pvt->F6, F17H_SCR_BASE_ADDR, &scrubval);
+			if (scrubval & BIT(0)) {
+				amd64_read_pci_cfg(pvt->F6, F17H_SCR_LIMIT_ADDR, &scrubval);
+				scrubval &= 0xF;
+				scrubval += 0x5;
+			} else {
+				scrubval = 0;
+			}
+			break;
+		}
+
+		/* fall through */
+
 	default:
 		amd64_read_pci_cfg(pvt->F3, SCRCTRL, &scrubval);
 		break;
@@ -1052,6 +1068,19 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 			pvt->dram_type = MEM_DDR4;
 		return;
 
+	case 0x18:
+		if (pvt->vendor == X86_VENDOR_HYGON) {
+			if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
+				pvt->dram_type = MEM_LRDDR4;
+			else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
+				pvt->dram_type = MEM_RDDR4;
+			else
+				pvt->dram_type = MEM_DDR4;
+			return;
+		}
+
+		/* fall through */
+
 	default:
 		WARN(1, KERN_ERR "%s: Family??? 0x%x\n", __func__, pvt->fam);
 		pvt->dram_type = MEM_EMPTY;
@@ -2200,6 +2229,16 @@ static struct amd64_family_type family_types[] = {
 			.dbam_to_cs		= f17_base_addr_to_cs_size,
 		}
 	},
+	[HYGON_F18_CPUS] = {
+		/* Hygon F18h uses the same AMD F17h support */
+		.ctl_name = "Hygon_F18h",
+		.f0_id = PCI_DEVICE_ID_HYGON_18H_DF_F0,
+		.f6_id = PCI_DEVICE_ID_HYGON_18H_DF_F6,
+		.ops = {
+			.early_channel_count	= f17_early_channel_count,
+			.dbam_to_cs		= f17_base_addr_to_cs_size,
+		}
+	},
 };
 
 /*
@@ -3149,6 +3188,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 	pvt->ext_model  = boot_cpu_data.x86_model >> 4;
 	pvt->stepping	= boot_cpu_data.x86_stepping;
 	pvt->model	= boot_cpu_data.x86_model;
+	pvt->vendor	= boot_cpu_data.x86_vendor;
 	pvt->fam	= boot_cpu_data.x86;
 
 	switch (pvt->fam) {
@@ -3192,6 +3232,15 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		pvt->ops	= &family_types[F17_CPUS].ops;
 		break;
 
+	case 0x18:
+		if (pvt->vendor == X86_VENDOR_HYGON) {
+			fam_type	= &family_types[HYGON_F18_CPUS];
+			pvt->ops	= &family_types[HYGON_F18_CPUS].ops;
+			break;
+		}
+
+		/* fall through */
+
 	default:
 		amd64_err("Unsupported family!\n");
 		return NULL;
@@ -3428,6 +3477,7 @@ static const struct x86_cpu_id amd64_cpuids[] = {
 	{ X86_VENDOR_AMD, 0x15, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
 	{ X86_VENDOR_AMD, 0x16, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
 	{ X86_VENDOR_AMD, 0x17, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
+	{ X86_VENDOR_HYGON, 0x18, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 1d4b74e..5176b51 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -116,6 +116,9 @@
 #define PCI_DEVICE_ID_AMD_17H_DF_F0	0x1460
 #define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
 
+#define PCI_DEVICE_ID_HYGON_18H_DF_F0	0x1460
+#define PCI_DEVICE_ID_HYGON_18H_DF_F6	0x1466
+
 /*
  * Function 1 - Address Map
  */
@@ -281,6 +284,7 @@ enum amd_families {
 	F16_CPUS,
 	F16_M30H_CPUS,
 	F17_CPUS,
+	HYGON_F18_CPUS,
 	NUM_FAMILIES,
 };
 
@@ -328,6 +332,7 @@ struct amd64_pvt {
 	struct pci_dev *F0, *F1, *F2, *F3, *F6;
 
 	u16 mc_node_id;		/* MC index of this MC node */
+	u8 vendor;		/* CPU vendor */
 	u8 fam;			/* CPU family */
 	u8 model;		/* ... model */
 	u8 stepping;		/* ... stepping */
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 2ab4d61..886e2bb 100644
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
@@ -1120,6 +1121,18 @@ static int __init mce_amd_init(void)
 		}
 		break;
 
+	case 0x18:
+		if (c->x86_vendor == X86_VENDOR_HYGON) {
+			xec_mask = 0x3f;
+			if (!boot_cpu_has(X86_FEATURE_SMCA)) {
+				pr_warn("Decoding supported only on Scalable MCA processors.\n");
+				goto err_out;
+			}
+			break;
+		}
+
+		/* fall through */
+
 	default:
 		printk(KERN_WARNING "Huh? What family is it: 0x%x?!\n", c->x86);
 		goto err_out;
-- 
2.7.4
