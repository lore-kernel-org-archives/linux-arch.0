Return-Path: <SRS0=cph+=44=kvack.org=owner-linux-mm@kernel.org>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [RFC PATCH v1 1/3] arm64: tlb: add TTL field to __TLBI_ADDR
Date: Wed, 11 Mar 2020 10:53:07 +0800
Message-ID: <20200311025309.1743-2-yezhenyu2@huawei.com>
In-Reply-To: <20200311025309.1743-1-yezhenyu2@huawei.com>
References: <20200311025309.1743-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, maz@kernel.org, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200311025307.L3FkFC2XuyAC3SwWMDoVtYNqpurOp9Uh4vjVpMgMbOE@z>

ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
the level of translation table walk holding the leaf entry for the
address that is being invalidated.

This patch add support for TTL feature and set the default value 0
where __TLBI_ADDR is called.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/cpucaps.h  |  3 ++-
 arch/arm64/include/asm/sysreg.h   |  4 ++++
 arch/arm64/include/asm/tlbflush.h | 33 ++++++++++++++++++++++---------
 arch/arm64/kernel/cpufeature.c    | 10 ++++++++++
 arch/arm64/kernel/sys_compat.c    |  2 +-
 5 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cp=
ucaps.h
index 865e0253fc1e..60f3b090ea9a 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -58,7 +58,8 @@
 #define ARM64_WORKAROUND_SPECULATIVE_AT_NVHE	48
 #define ARM64_HAS_E0PD				49
 #define ARM64_HAS_RNG				50
+#define ARM64_HAS_TLBI_TTL			51
=20
-#define ARM64_NCAPS				51
+#define ARM64_NCAPS				52
=20
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sys=
reg.h
index b91570ff9db1..7caa3c9facfe 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -685,6 +685,7 @@
=20
 /* id_aa64mmfr2 */
 #define ID_AA64MMFR2_E0PD_SHIFT		60
+#define ID_AA64MMFR2_TTL_SHIFT		48
 #define ID_AA64MMFR2_FWB_SHIFT		40
 #define ID_AA64MMFR2_AT_SHIFT		32
 #define ID_AA64MMFR2_LVA_SHIFT		16
@@ -693,6 +694,9 @@
 #define ID_AA64MMFR2_UAO_SHIFT		4
 #define ID_AA64MMFR2_CNP_SHIFT		0
=20
+#define ID_AA64MMFR2_TTL_NI		0x0
+#define ID_AA64MMFR2_TTL_SUPPORTED	0x1
+
 /* id_aa64dfr0 */
 #define ID_AA64DFR0_PMSVER_SHIFT	32
 #define ID_AA64DFR0_CTX_CMPS_SHIFT	28
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/t=
lbflush.h
index bc3949064725..10b12710b7cc 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -50,15 +50,30 @@
 		__tlbi(op, (arg) | USER_ASID_FLAG);				\
 } while (0)
=20
-/* This macro creates a properly formatted VA operand for the TLBI */
-#define __TLBI_VADDR(addr, asid)				\
+/* This macro creates a properly formatted VA operand for the TLBI.
+ * The TTL field is introduced since ARMv8.4. ARMv8.4-TTL provides the T=
TL
+ * field to indicate the level of translation table walk holding the lea=
f entry
+ * for the address that is being invalidated.
+ */
+#define __TLBI_VADDR(addr, asid, ttl)				\
 	({							\
 		unsigned long __ta =3D (addr) >> 12;		\
 		__ta &=3D GENMASK_ULL(43, 0);			\
+		if (cpus_have_const_cap(ARM64_HAS_TLBI_TTL))	\
+			__ta |=3D (unsigned long)(ttl) << 44;	\
 		__ta |=3D (unsigned long)(asid) << 48;		\
 		__ta;						\
 	})
=20
+/*
+ * __TLB_TG defines translation granule of the system, which is defined =
by
+ * PAGE_SHIFT.  Used by TTL.
+ *  - 4KB	: 1
+ *  - 16KB	: 2
+ *  - 64KB	: 3
+ */
+#define __TLB_TG	((PAGE_SHIFT - 12) / 2 + 1)
+
 /*
  *	TLB Invalidation
  *	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -146,7 +161,7 @@ static inline void flush_tlb_all(void)
=20
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
-	unsigned long asid =3D __TLBI_VADDR(0, ASID(mm));
+	unsigned long asid =3D __TLBI_VADDR(0, ASID(mm), 0);
=20
 	dsb(ishst);
 	__tlbi(aside1is, asid);
@@ -157,7 +172,7 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
 					 unsigned long uaddr)
 {
-	unsigned long addr =3D __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
+	unsigned long addr =3D __TLBI_VADDR(uaddr, ASID(vma->vm_mm), 0);
=20
 	dsb(ishst);
 	__tlbi(vale1is, addr);
@@ -195,8 +210,8 @@ static inline void __flush_tlb_range(struct vm_area_s=
truct *vma,
 	/* Convert the stride into units of 4k */
 	stride >>=3D 12;
=20
-	start =3D __TLBI_VADDR(start, asid);
-	end =3D __TLBI_VADDR(end, asid);
+	start =3D __TLBI_VADDR(start, asid, 0);
+	end =3D __TLBI_VADDR(end, asid, 0);
=20
 	dsb(ishst);
 	for (addr =3D start; addr < end; addr +=3D stride) {
@@ -230,8 +245,8 @@ static inline void flush_tlb_kernel_range(unsigned lo=
ng start, unsigned long end
 		return;
 	}
=20
-	start =3D __TLBI_VADDR(start, 0);
-	end =3D __TLBI_VADDR(end, 0);
+	start =3D __TLBI_VADDR(start, 0, 0);
+	end =3D __TLBI_VADDR(end, 0, 0);
=20
 	dsb(ishst);
 	for (addr =3D start; addr < end; addr +=3D 1 << (PAGE_SHIFT - 12))
@@ -246,7 +261,7 @@ static inline void flush_tlb_kernel_range(unsigned lo=
ng start, unsigned long end
  */
 static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
 {
-	unsigned long addr =3D __TLBI_VADDR(kaddr, 0);
+	unsigned long addr =3D __TLBI_VADDR(kaddr, 0, 0);
=20
 	dsb(ishst);
 	__tlbi(vaae1is, addr);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeatur=
e.c
index 0b6715625cf6..9a84c59e1482 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1672,6 +1672,16 @@ static const struct arm64_cpu_capabilities arm64_f=
eatures[] =3D {
 		.min_field_value =3D 1,
 	},
 #endif
+	{
+		.desc =3D "TTL field in TLBI operation",
+		.capability =3D ARM64_HAS_TLBI_TTL,
+		.type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches =3D has_cpuid_feature,
+		.sys_reg =3D SYS_ID_AA64MMFR2_EL1,
+		.field_pos =3D ID_AA64MMFR2_TTL_SHIFT,
+		.sign =3D FTR_UNSIGNED,
+		.min_field_value =3D ID_AA64MMFR2_TTL_SUPPORTED,
+	},
 	{},
 };
=20
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compa=
t.c
index 3c18c2454089..5d1570354d29 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -37,7 +37,7 @@ __do_compat_cache_op(unsigned long start, unsigned long=
 end)
 			 * The workaround requires an inner-shareable tlbi.
 			 * We pick the reserved-ASID to minimise the impact.
 			 */
-			__tlbi(aside1is, __TLBI_VADDR(0, 0));
+			__tlbi(aside1is, __TLBI_VADDR(0, 0, 0));
 			dsb(ish);
 		}
=20
--=20
2.19.1
