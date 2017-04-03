Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751716AbdDCPU1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Apr 2017 11:20:27 -0400
From: Mark Rutland <mark.rutland@arm.com>
Subject: [RFC 4/9] arm64/cpufeature: detect pointer authentication
Date: Mon,  3 Apr 2017 16:19:20 +0100
Message-ID: <1491232765-32501-5-git-send-email-mark.rutland@arm.com>
In-Reply-To: <1491232765-32501-1-git-send-email-mark.rutland@arm.com>
References: <1491232765-32501-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, christoffer.dall@linaro.org, jiong.wang@arm.com, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org, marc.zyngier@arm.com, mark.rutland@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com
Message-ID: <20170403151920.JRB4-bDn9znBmjsgfLoWaPuQ2KcMufnt3_sDABp7HKI@z>

So that we can dynamically handle the presence of pointer authentication
functionality, wire up probing code in cpufeature.c.

Currently, this only detects the presence of an architected algorithm.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpucaps.h |  4 +++-
 arch/arm64/kernel/cpufeature.c   | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index fb78a5d..15dd6d6 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -37,7 +37,9 @@
 #define ARM64_HAS_NO_FPSIMD			16
 #define ARM64_WORKAROUND_REPEAT_TLBI		17
 #define ARM64_WORKAROUND_QCOM_FALKOR_E1003	18
+#define ARM64_HAS_ADDRESS_AUTH			19
+#define ARM64_HAS_GENERIC_AUTH			20
 
-#define ARM64_NCAPS				19
+#define ARM64_NCAPS				21
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 30255b2..172c80e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -871,6 +871,28 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
 		.min_field_value = 0,
 		.matches = has_no_fpsimd,
 	},
+#ifdef CONFIG_ARM64_POINTER_AUTHENTICATION
+	{
+		.desc = "Address authentication (architected algorithm)",
+		.capability = ARM64_HAS_ADDRESS_AUTH,
+		.def_scope = SCOPE_SYSTEM,
+		.sys_reg = SYS_ID_AA64ISAR1_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64ISAR1_APA_SHIFT,
+		.min_field_value = ID_AA64ISAR1_APA_ARCHITECTED,
+		.matches = has_cpuid_feature,
+	},
+	{
+		.desc = "Generic authentication (architected algorithm)",
+		.capability = ARM64_HAS_GENERIC_AUTH,
+		.def_scope = SCOPE_SYSTEM,
+		.sys_reg = SYS_ID_AA64ISAR1_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64ISAR1_GPA_SHIFT,
+		.min_field_value = ID_AA64ISAR1_GPA_ARCHITECTED,
+		.matches = has_cpuid_feature
+	},
+#endif /* CONFIG_ARM64_POINTER_AUTHENTICATION */
 	{},
 };
 
-- 
1.9.1
