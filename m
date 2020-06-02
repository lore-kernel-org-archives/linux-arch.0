Return-Path: <SRS0=y6BJ=7P=kvack.org=owner-linux-mm@kernel.org>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v4 5/6] arm64: tlb: Set the TTL field in flush_tlb_range
Date: Tue, 2 Jun 2020 21:58:35 +0800
Message-ID: <20200602135836.1620-6-yezhenyu2@huawei.com>
In-Reply-To: <20200602135836.1620-1-yezhenyu2@huawei.com>
References: <20200602135836.1620-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: catalin.marinas@arm.com, peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200602135835.kbjQVK0fQWE-5F_in0P9p7GJ5CQin0qFLzuVO7T9txE@z>

This patch uses the cleared_* in struct mmu_gather to set the
TTL field in flush_tlb_range().

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/tlb.h      | 29 ++++++++++++++++++++++++++++-
 arch/arm64/include/asm/tlbflush.h | 14 ++++++++------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index b76df828e6b7..61c97d3b58c7 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -21,11 +21,37 @@ static void tlb_flush(struct mmu_gather *tlb);
=20
 #include <asm-generic/tlb.h>
=20
+/*
+ * get the tlbi levels in arm64.  Default value is 0 if more than one
+ * of cleared_* is set or neither is set.
+ * Arm64 doesn't support p4ds now.
+ */
+static inline int tlb_get_level(struct mmu_gather *tlb)
+{
+	if (tlb->cleared_ptes && !(tlb->cleared_pmds ||
+				   tlb->cleared_puds ||
+				   tlb->cleared_p4ds))
+		return 3;
+
+	if (tlb->cleared_pmds && !(tlb->cleared_ptes ||
+				   tlb->cleared_puds ||
+				   tlb->cleared_p4ds))
+		return 2;
+
+	if (tlb->cleared_puds && !(tlb->cleared_ptes ||
+				   tlb->cleared_pmds ||
+				   tlb->cleared_p4ds))
+		return 1;
+
+	return 0;
+}
+
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	struct vm_area_struct vma =3D TLB_FLUSH_VMA(tlb->mm, 0);
 	bool last_level =3D !tlb->freed_tables;
 	unsigned long stride =3D tlb_get_unmap_size(tlb);
+	int tlb_level =3D tlb_get_level(tlb);
=20
 	/*
 	 * If we're tearing down the address space then we only care about
@@ -38,7 +64,8 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 		return;
 	}
=20
-	__flush_tlb_range(&vma, tlb->start, tlb->end, stride, last_level);
+	__flush_tlb_range(&vma, tlb->start, tlb->end, stride,
+			  last_level, tlb_level);
 }
=20
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/t=
lbflush.h
index bfb58e62c127..84cb98b60b7b 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -215,7 +215,8 @@ static inline void flush_tlb_page(struct vm_area_stru=
ct *vma,
=20
 static inline void __flush_tlb_range(struct vm_area_struct *vma,
 				     unsigned long start, unsigned long end,
-				     unsigned long stride, bool last_level)
+				     unsigned long stride, bool last_level,
+				     int tlb_level)
 {
 	unsigned long asid =3D ASID(vma->vm_mm);
 	unsigned long addr;
@@ -237,11 +238,11 @@ static inline void __flush_tlb_range(struct vm_area=
_struct *vma,
 	dsb(ishst);
 	for (addr =3D start; addr < end; addr +=3D stride) {
 		if (last_level) {
-			__tlbi_level(vale1is, addr, 0);
-			__tlbi_user_level(vale1is, addr, 0);
+			__tlbi_level(vale1is, addr, tlb_level);
+			__tlbi_user_level(vale1is, addr, tlb_level);
 		} else {
-			__tlbi_level(vae1is, addr, 0);
-			__tlbi_user_level(vae1is, addr, 0);
+			__tlbi_level(vae1is, addr, tlb_level);
+			__tlbi_user_level(vae1is, addr, tlb_level);
 		}
 	}
 	dsb(ish);
@@ -253,8 +254,9 @@ static inline void flush_tlb_range(struct vm_area_str=
uct *vma,
 	/*
 	 * We cannot use leaf-only invalidation here, since we may be invalidat=
ing
 	 * table entries as part of collapsing hugepages or moving page tables.
+	 * Set the tlb_level to 0 because we can not get enough information her=
e.
 	 */
-	__flush_tlb_range(vma, start, end, PAGE_SIZE, false);
+	__flush_tlb_range(vma, start, end, PAGE_SIZE, false, 0);
 }
=20
 static inline void flush_tlb_kernel_range(unsigned long start, unsigned =
long end)
--=20
2.19.1
