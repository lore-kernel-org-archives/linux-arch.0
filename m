Return-Path: <SRS0=y6BJ=7P=kvack.org=owner-linux-mm@kernel.org>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v4 1/6] arm64: Detect the ARMv8.4 TTL feature
Date: Tue, 2 Jun 2020 21:58:31 +0800
Message-ID: <20200602135836.1620-2-yezhenyu2@huawei.com>
In-Reply-To: <20200602135836.1620-1-yezhenyu2@huawei.com>
References: <20200602135836.1620-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: catalin.marinas@arm.com, peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200602135831.bdXqwYwq2ExKbfl6ZUMe1eyVgvv9SkptqX2mA6CplJM@z>

From: Marc Zyngier <maz@kernel.org>

In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
feature allows TLBs to be issued with a level allowing for quicker
invalidation.

Let's detect the feature for now. Further patches will implement
its actual usage.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/include/asm/sysreg.h  |  1 +
 arch/arm64/kernel/cpufeature.c   | 11 +++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cp=
ucaps.h
index 8eb5a088ae65..cabb0c49a1d1 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -61,7 +61,8 @@
 #define ARM64_HAS_AMU_EXTN			51
 #define ARM64_HAS_ADDRESS_AUTH			52
 #define ARM64_HAS_GENERIC_AUTH			53
+#define ARM64_HAS_ARMv8_4_TTL			54
=20
-#define ARM64_NCAPS				54
+#define ARM64_NCAPS				55
=20
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sys=
reg.h
index c4ac0ac25a00..477d84ba1056 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -725,6 +725,7 @@
=20
 /* id_aa64mmfr2 */
 #define ID_AA64MMFR2_E0PD_SHIFT		60
+#define ID_AA64MMFR2_TTL_SHIFT		48
 #define ID_AA64MMFR2_FWB_SHIFT		40
 #define ID_AA64MMFR2_AT_SHIFT		32
 #define ID_AA64MMFR2_LVA_SHIFT		16
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeatur=
e.c
index 9fac745aa7bb..d993dc6dc7d5 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -244,6 +244,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr1[]=
 =3D {
=20
 static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] =3D {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_=
E0PD_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_TTL=
_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_FWB=
_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_AT=
_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LVA=
_SHIFT, 4, 0),
@@ -1622,6 +1623,16 @@ static const struct arm64_cpu_capabilities arm64_f=
eatures[] =3D {
 		.matches =3D has_cpuid_feature,
 		.cpu_enable =3D cpu_has_fwb,
 	},
+	{
+		.desc =3D "ARMv8.4 Translation Table Level",
+		.type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability =3D ARM64_HAS_ARMv8_4_TTL,
+		.sys_reg =3D SYS_ID_AA64MMFR2_EL1,
+		.sign =3D FTR_UNSIGNED,
+		.field_pos =3D ID_AA64MMFR2_TTL_SHIFT,
+		.min_field_value =3D 1,
+		.matches =3D has_cpuid_feature,
+	},
 #ifdef CONFIG_ARM64_HW_AFDBM
 	{
 		/*
--=20
2.19.1
