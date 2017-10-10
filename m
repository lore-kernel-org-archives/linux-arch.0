Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932521AbdJJSj2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Oct 2017 14:39:28 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v3 16/28] arm64/sve: Probe SVE capabilities and usable vector lengths
Date: Tue, 10 Oct 2017 19:38:33 +0100
Message-ID: <1507660725-7986-17-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <20171010183833.qP5G5n684zs5pNsxo-xSXy9XF8Ol91VrXjnSlNShpAo@z>

This patch uses the cpufeatures framework to determine common SVE
capabilities and vector lengths, and configures the runtime SVE
support code appropriately.

ZCR_ELx is not really a feature register, but it is convenient to
use it as a template for recording the maximum vector length
supported by a CPU, using the LEN field.  This field is similar to
a feature field in that it is a contiguous bitfield for which we
want to determine the minimum system-wide value.  This patch adds
ZCR as a pseudo-register in cpuinfo/cpufeatures, with appropriate
custom code to populate it.  Finding the minimum supported value of
the LEN field is left to the cpufeatures framework in the usual
way.

The meaning of ID_AA64ZFR0_EL1 is not architecturally defined yet,
so for now we just require it to be zero.

Note that much of this code is dormant and SVE still won't be used
yet, since system_supports_sve() remains hardwired to false.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>

---

Dropped Alex Bennée's Reviewed-by, since there is new logic in this
patch.

Changes since v2
----------------

Bug fixes:

 * Got rid of dynamic allocation of the shadow vector length map during
   secondary boot.  Secondary CPU boot takes place in atomic context,
   and relying on GFP_ATOMIC here doesn't seem justified.

   Instead, the needed additional bitmap is allocated statically.  Only
   one shadow map is needed, because CPUs don't boot concurrently.

Requested by Alex Bennée:

 * Reflowed untidy comment above read_zcr_features()

 * Added comments to read_zcr_features() to explain what it's trying to do
   (which is otherwise not readily apparent).

Requested by Catalin Marinas:

 * Moved disabling of the EL1 SVE trap to the cpufeatures C code.
   This allows addition of new assembler in __cpu_setup to be
   avoided.

Miscellaneous:

 * Added comments explaining the intent, purpose and basic constraints
   for fpsimd.c helpers.
---
 arch/arm64/include/asm/cpu.h        |   4 ++
 arch/arm64/include/asm/cpufeature.h |  36 ++++++++++++
 arch/arm64/include/asm/fpsimd.h     |  14 +++++
 arch/arm64/kernel/cpufeature.c      |  50 ++++++++++++++++
 arch/arm64/kernel/cpuinfo.c         |   6 ++
 arch/arm64/kernel/fpsimd.c          | 114 +++++++++++++++++++++++++++++++++++-
 6 files changed, 221 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 889226b..8839227 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -41,6 +41,7 @@ struct cpuinfo_arm64 {
 	u64		reg_id_aa64mmfr2;
 	u64		reg_id_aa64pfr0;
 	u64		reg_id_aa64pfr1;
+	u64		reg_id_aa64zfr0;
 
 	u32		reg_id_dfr0;
 	u32		reg_id_isar0;
@@ -59,6 +60,9 @@ struct cpuinfo_arm64 {
 	u32		reg_mvfr0;
 	u32		reg_mvfr1;
 	u32		reg_mvfr2;
+
+	/* pseudo-ZCR for recording maximum ZCR_EL1 LEN value: */
+	u64		reg_zcr;
 };
 
 DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 4ea3441..51be8e8 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -10,7 +10,9 @@
 #define __ASM_CPUFEATURE_H
 
 #include <asm/cpucaps.h>
+#include <asm/fpsimd.h>
 #include <asm/hwcap.h>
+#include <asm/sigcontext.h>
 #include <asm/sysreg.h>
 
 /*
@@ -223,6 +225,13 @@ static inline bool id_aa64pfr0_32bit_el0(u64 pfr0)
 	return val == ID_AA64PFR0_EL0_32BIT_64BIT;
 }
 
+static inline bool id_aa64pfr0_sve(u64 pfr0)
+{
+	u32 val = cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_SVE_SHIFT);
+
+	return val > 0;
+}
+
 void __init setup_cpu_features(void);
 
 void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
@@ -267,6 +276,33 @@ static inline bool system_supports_sve(void)
 	return false;
 }
 
+/*
+ * Read the pseudo-ZCR used by cpufeatures to identify the supported SVE
+ * vector length.
+ *
+ * Use only if SVE is present.
+ * This function clobbers the SVE vector length.
+ */
+static u64 __maybe_unused read_zcr_features(void)
+{
+	u64 zcr;
+	unsigned int vq_max;
+
+	/*
+	 * Set the maximum possible VL, and write zeroes to all other
+	 * bits to see if they stick.
+	 */
+	sve_kernel_enable(NULL);
+	write_sysreg_s(ZCR_ELx_LEN_MASK, SYS_ZCR_EL1);
+
+	zcr = read_sysreg_s(SYS_ZCR_EL1);
+	zcr &= ~(u64)ZCR_ELx_LEN_MASK; /* find sticky 1s outside LEN field */
+	vq_max = sve_vq_from_vl(sve_get_vl());
+	zcr |= vq_max - 1; /* set LEN field to maximum effective value */
+
+	return zcr;
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 7dd3939..bad72fd 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -79,6 +79,7 @@ extern void sve_save_state(void *state, u32 *pfpsr);
 extern void sve_load_state(void const *state, u32 const *pfpsr,
 			   unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
+extern int sve_kernel_enable(void *);
 
 extern int __ro_after_init sve_max_vl;
 
@@ -91,10 +92,23 @@ extern void fpsimd_release_thread(struct task_struct *task);
 extern int sve_set_vector_length(struct task_struct *task,
 				 unsigned long vl, unsigned long flags);
 
+/*
+ * Probing and setup functions.
+ * Calls to these functions must be serialised with one another.
+ */
+extern void __init sve_init_vq_map(void);
+extern void sve_update_vq_map(void);
+extern int sve_verify_vq_map(void);
+extern void __init sve_setup(void);
+
 #else /* ! CONFIG_ARM64_SVE */
 
 static void __maybe_unused sve_alloc(struct task_struct *task) { }
 static void __maybe_unused fpsimd_release_thread(struct task_struct *task) { }
+static void __maybe_unused sve_init_vq_map(void) { }
+static void __maybe_unused sve_update_vq_map(void) { }
+static int __maybe_unused sve_verify_vq_map(void) { return 0; }
+static void __maybe_unused sve_setup(void) { }
 
 #endif /* ! CONFIG_ARM64_SVE */
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 92a9502..c5acf38 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -27,6 +27,7 @@
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
+#include <asm/fpsimd.h>
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
@@ -283,6 +284,12 @@ static const struct arm64_ftr_bits ftr_id_dfr0[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_zcr[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE,
+		ZCR_ELx_LEN_SHIFT, ZCR_ELx_LEN_SIZE, 0),	/* LEN */
+	ARM64_FTR_END,
+};
+
 /*
  * Common ftr bits for a 32bit register with all hidden, strict
  * attributes, with 4bit feature fields and a default safe value of
@@ -349,6 +356,7 @@ static const struct __ftr_reg_entry {
 	/* Op1 = 0, CRn = 0, CRm = 4 */
 	ARM64_FTR_REG(SYS_ID_AA64PFR0_EL1, ftr_id_aa64pfr0),
 	ARM64_FTR_REG(SYS_ID_AA64PFR1_EL1, ftr_raz),
+	ARM64_FTR_REG(SYS_ID_AA64ZFR0_EL1, ftr_raz),
 
 	/* Op1 = 0, CRn = 0, CRm = 5 */
 	ARM64_FTR_REG(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0),
@@ -363,6 +371,9 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1),
 	ARM64_FTR_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2),
 
+	/* Op1 = 0, CRn = 1, CRm = 2 */
+	ARM64_FTR_REG(SYS_ZCR_EL1, ftr_zcr),
+
 	/* Op1 = 3, CRn = 0, CRm = 0 */
 	{ SYS_CTR_EL0, &arm64_ftr_reg_ctrel0 },
 	ARM64_FTR_REG(SYS_DCZID_EL0, ftr_dczid),
@@ -500,6 +511,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR2_EL1, info->reg_id_aa64mmfr2);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
+	init_cpu_ftr_reg(SYS_ID_AA64ZFR0_EL1, info->reg_id_aa64zfr0);
 
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
 		init_cpu_ftr_reg(SYS_ID_DFR0_EL1, info->reg_id_dfr0);
@@ -520,6 +532,10 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 		init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
 	}
 
+	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0)) {
+		init_cpu_ftr_reg(SYS_ZCR_EL1, info->reg_zcr);
+		sve_init_vq_map();
+	}
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -623,6 +639,9 @@ void update_cpu_features(int cpu,
 	taint |= check_update_ftr_reg(SYS_ID_AA64PFR1_EL1, cpu,
 				      info->reg_id_aa64pfr1, boot->reg_id_aa64pfr1);
 
+	taint |= check_update_ftr_reg(SYS_ID_AA64ZFR0_EL1, cpu,
+				      info->reg_id_aa64zfr0, boot->reg_id_aa64zfr0);
+
 	/*
 	 * If we have AArch32, we care about 32-bit features for compat.
 	 * If the system doesn't support AArch32, don't update them.
@@ -670,6 +689,14 @@ void update_cpu_features(int cpu,
 					info->reg_mvfr2, boot->reg_mvfr2);
 	}
 
+	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0)) {
+		taint |= check_update_ftr_reg(SYS_ZCR_EL1, cpu,
+					info->reg_zcr, boot->reg_zcr);
+
+		if (!sys_caps_initialised)
+			sve_update_vq_map();
+	}
+
 	/*
 	 * Mismatched CPU features are a recipe for disaster. Don't even
 	 * pretend to support them.
@@ -1097,6 +1124,23 @@ verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
 	}
 }
 
+static void verify_sve_features(void)
+{
+	u64 safe_zcr = read_sanitised_ftr_reg(SYS_ZCR_EL1);
+	u64 zcr = read_zcr_features();
+
+	unsigned int safe_len = safe_zcr & ZCR_ELx_LEN_MASK;
+	unsigned int len = zcr & ZCR_ELx_LEN_MASK;
+
+	if (len < safe_len || sve_verify_vq_map()) {
+		pr_crit("CPU%d: SVE: required vector length(s) missing\n",
+			smp_processor_id());
+		cpu_die_early();
+	}
+
+	/* Add checks on other ZCR bits here if necessary */
+}
+
 /*
  * Run through the enabled system capabilities and enable() it on this CPU.
  * The capabilities were decided based on the available CPUs at the boot time.
@@ -1110,8 +1154,12 @@ static void verify_local_cpu_capabilities(void)
 	verify_local_cpu_errata_workarounds();
 	verify_local_cpu_features(arm64_features);
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
+
 	if (system_supports_32bit_el0())
 		verify_local_elf_hwcaps(compat_elf_hwcaps);
+
+	if (system_supports_sve())
+		verify_sve_features();
 }
 
 void check_local_cpu_capabilities(void)
@@ -1189,6 +1237,8 @@ void __init setup_cpu_features(void)
 	if (system_supports_32bit_el0())
 		setup_elf_hwcaps(compat_elf_hwcaps);
 
+	sve_setup();
+
 	/* Advertise that we have computed the system capabilities */
 	set_sys_caps_initialised();
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 3118859..be260e8 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -19,6 +19,7 @@
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
+#include <asm/fpsimd.h>
 
 #include <linux/bitops.h>
 #include <linux/bug.h>
@@ -326,6 +327,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_aa64mmfr2 = read_cpuid(ID_AA64MMFR2_EL1);
 	info->reg_id_aa64pfr0 = read_cpuid(ID_AA64PFR0_EL1);
 	info->reg_id_aa64pfr1 = read_cpuid(ID_AA64PFR1_EL1);
+	info->reg_id_aa64zfr0 = read_cpuid(ID_AA64ZFR0_EL1);
 
 	/* Update the 32bit ID registers only if AArch32 is implemented */
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
@@ -348,6 +350,10 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 		info->reg_mvfr2 = read_cpuid(MVFR2_EL1);
 	}
 
+	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
+	    id_aa64pfr0_sve(info->reg_id_aa64pfr0))
+		info->reg_zcr = read_zcr_features();
+
 	cpuinfo_detect_icache_policy(info);
 }
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 324c112..5673f50 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -113,19 +113,19 @@
 static DEFINE_PER_CPU(struct fpsimd_state *, fpsimd_last_state);
 
 /* Default VL for tasks that don't set it explicitly: */
-static int sve_default_vl = SVE_VL_MIN;
+static int sve_default_vl = -1;
 
 #ifdef CONFIG_ARM64_SVE
 
 /* Maximum supported vector length across all CPUs (initially poisoned) */
 int __ro_after_init sve_max_vl = -1;
 /* Set of available vector lengths, as vq_to_bit(vq): */
-static DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
+static __ro_after_init DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
 
 #else /* ! CONFIG_ARM64_SVE */
 
 /* Dummy declaration for code that will be optimised out: */
-extern DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
+extern __ro_after_init DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
 
 #endif /* ! CONFIG_ARM64_SVE */
 
@@ -506,6 +506,111 @@ int sve_set_vector_length(struct task_struct *task,
 	return 0;
 }
 
+/*
+ * Bitmap for temporary storage of the per-CPU set of supported vector lengths
+ * during secondary boot.
+ */
+static DECLARE_BITMAP(sve_secondary_vq_map, SVE_VQ_MAX);
+
+static void sve_probe_vqs(DECLARE_BITMAP(map, SVE_VQ_MAX))
+{
+	unsigned int vq, vl;
+	unsigned long zcr;
+
+	bitmap_zero(map, SVE_VQ_MAX);
+
+	zcr = ZCR_ELx_LEN_MASK;
+	zcr = read_sysreg_s(SYS_ZCR_EL1) & ~zcr;
+
+	for (vq = SVE_VQ_MAX; vq >= SVE_VQ_MIN; --vq) {
+		write_sysreg_s(zcr | (vq - 1), SYS_ZCR_EL1); /* self-syncing */
+		vl = sve_get_vl();
+		vq = sve_vq_from_vl(vl); /* skip intervening lengths */
+		set_bit(vq_to_bit(vq), map);
+	}
+}
+
+void __init sve_init_vq_map(void)
+{
+	sve_probe_vqs(sve_vq_map);
+}
+
+/*
+ * If we haven't committed to the set of supported VQs yet, filter out
+ * those not supported by the current CPU.
+ */
+void sve_update_vq_map(void)
+{
+	sve_probe_vqs(sve_secondary_vq_map);
+	bitmap_and(sve_vq_map, sve_vq_map, sve_secondary_vq_map, SVE_VQ_MAX);
+}
+
+/* Check whether the current CPU supports all VQs in the committed set */
+int sve_verify_vq_map(void)
+{
+	int ret = 0;
+
+	sve_probe_vqs(sve_secondary_vq_map);
+	bitmap_andnot(sve_secondary_vq_map, sve_vq_map, sve_secondary_vq_map,
+		      SVE_VQ_MAX);
+	if (!bitmap_empty(sve_secondary_vq_map, SVE_VQ_MAX)) {
+		pr_warn("SVE: cpu%d: Required vector length(s) missing\n",
+			smp_processor_id());
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/*
+ * Enable SVE for EL1.
+ * Intended for use by the cpufeatures code during CPU boot.
+ */
+int sve_kernel_enable(void *__always_unused p)
+{
+	write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_ZEN_EL1EN, CPACR_EL1);
+	isb();
+
+	return 0;
+}
+
+void __init sve_setup(void)
+{
+	u64 zcr;
+
+	if (!system_supports_sve())
+		return;
+
+	/*
+	 * The SVE architecture mandates support for 128-bit vectors,
+	 * so sve_vq_map must have at least SVE_VQ_MIN set.
+	 * If something went wrong, at least try to patch it up:
+	 */
+	if (WARN_ON(!test_bit(vq_to_bit(SVE_VQ_MIN), sve_vq_map)))
+		set_bit(vq_to_bit(SVE_VQ_MIN), sve_vq_map);
+
+	zcr = read_sanitised_ftr_reg(SYS_ZCR_EL1);
+	sve_max_vl = sve_vl_from_vq((zcr & ZCR_ELx_LEN_MASK) + 1);
+
+	/*
+	 * Sanity-check that the max VL we determined through CPU features
+	 * corresponds properly to sve_vq_map.  If not, do our best:
+	 */
+	if (WARN_ON(sve_max_vl != find_supported_vector_length(sve_max_vl)))
+		sve_max_vl = find_supported_vector_length(sve_max_vl);
+
+	/*
+	 * For the default VL, pick the maximum supported value <= 64.
+	 * VL == 64 is guaranteed not to grow the signal frame.
+	 */
+	sve_default_vl = find_supported_vector_length(64);
+
+	pr_info("SVE: maximum available vector length %u bytes per vector\n",
+		sve_max_vl);
+	pr_info("SVE: default vector length %u bytes per vector\n",
+		sve_default_vl);
+}
+
 void fpsimd_release_thread(struct task_struct *dead_task)
 {
 	sve_free(dead_task);
@@ -637,6 +742,9 @@ void fpsimd_flush_thread(void)
 		 * This is where we ensure that all user tasks have a valid
 		 * vector length configured: no kernel task can become a user
 		 * task without an exec and hence a call to this function.
+		 * By the time the first call to this function is made, all
+		 * early hardware probing is complete, so sve_default_vl
+		 * should be valid.
 		 * If a bug causes this to go wrong, we make some noise and
 		 * try to fudge thread.sve_vl to a safe value here.
 		 */
-- 
2.1.4
