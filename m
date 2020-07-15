Return-Path: <SRS0=Bqph=A2=kvack.org=owner-linux-mm@kernel.org>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v3 1/3] arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
Date: Wed, 15 Jul 2020 15:19:43 +0800
Message-ID: <20200715071945.897-2-yezhenyu2@huawei.com>
In-Reply-To: <20200715071945.897-1-yezhenyu2@huawei.com>
References: <20200715071945.897-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: catalin.marinas@arm.com, will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200715071943.vsZsut8O6u5UIEbr2d7fu3RiZZLO-HdzA9mC-QdqkYg@z>

ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
range of input addresses. This patch detect this feature.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
Link: https://lore.kernel.org/r/20200710094420.517-2-yezhenyu2@huawei.com
[catalin.marinas@arm.com: some renaming for consistency]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/include/asm/sysreg.h  |  3 +++
 arch/arm64/kernel/cpufeature.c   | 10 ++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cp=
ucaps.h
index d44ba903d11d..07b643a70710 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -63,7 +63,8 @@
 #define ARM64_HAS_32BIT_EL1			53
 #define ARM64_BTI				54
 #define ARM64_HAS_ARMv8_4_TTL			55
+#define ARM64_HAS_TLB_RANGE			56
=20
-#define ARM64_NCAPS				56
+#define ARM64_NCAPS				57
=20
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sys=
reg.h
index 8c209aa17273..551f30ace4db 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -617,6 +617,9 @@
 #define ID_AA64ISAR0_SHA1_SHIFT		8
 #define ID_AA64ISAR0_AES_SHIFT		4
=20
+#define ID_AA64ISAR0_TLB_RANGE_NI	0x0
+#define ID_AA64ISAR0_TLB_RANGE		0x2
+
 /* id_aa64isar1 */
 #define ID_AA64ISAR1_I8MM_SHIFT		52
 #define ID_AA64ISAR1_DGH_SHIFT		48
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeatur=
e.c
index e877f56ff1ab..2f5adefef34d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1893,6 +1893,16 @@ static const struct arm64_cpu_capabilities arm64_f=
eatures[] =3D {
 		.min_field_value =3D 1,
 		.matches =3D has_cpuid_feature,
 	},
+	{
+		.desc =3D "TLB range maintenance instructions",
+		.capability =3D ARM64_HAS_TLB_RANGE,
+		.type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches =3D has_cpuid_feature,
+		.sys_reg =3D SYS_ID_AA64ISAR0_EL1,
+		.field_pos =3D ID_AA64ISAR0_TLB_SHIFT,
+		.sign =3D FTR_UNSIGNED,
+		.min_field_value =3D ID_AA64ISAR0_TLB_RANGE,
+	},
 #ifdef CONFIG_ARM64_HW_AFDBM
 	{
 		/*
--=20
2.19.1
