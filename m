Return-Path: <SRS0=y6BJ=7P=kvack.org=owner-linux-mm@kernel.org>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v4 4/6] tlb: mmu_gather: add tlb_flush_*_range APIs
Date: Tue, 2 Jun 2020 21:58:34 +0800
Message-ID: <20200602135836.1620-5-yezhenyu2@huawei.com>
In-Reply-To: <20200602135836.1620-1-yezhenyu2@huawei.com>
References: <20200602135836.1620-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: catalin.marinas@arm.com, peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200602135834.FvOpmKMF-vHdeiXt-OkXmxZ115LGdLkT5Romm7XiEhs@z>

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

tlb_flush_{pte|pmd|pud|p4d}_range() adjust the tlb->start and
tlb->end, then set corresponding cleared_*.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 include/asm-generic/tlb.h | 55 ++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 3f1649a8cf55..ef75ec86f865 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -512,6 +512,38 @@ static inline void tlb_end_vma(struct mmu_gather *tl=
b, struct vm_area_struct *vm
 }
 #endif
=20
+/*
+ * tlb_flush_{pte|pmd|pud|p4d}_range() adjust the tlb->start and tlb->en=
d,
+ * and set corresponding cleared_*.
+ */
+static inline void tlb_flush_pte_range(struct mmu_gather *tlb,
+				     unsigned long address, unsigned long size)
+{
+	__tlb_adjust_range(tlb, address, size);
+	tlb->cleared_ptes =3D 1;
+}
+
+static inline void tlb_flush_pmd_range(struct mmu_gather *tlb,
+				     unsigned long address, unsigned long size)
+{
+	__tlb_adjust_range(tlb, address, size);
+	tlb->cleared_pmds =3D 1;
+}
+
+static inline void tlb_flush_pud_range(struct mmu_gather *tlb,
+				     unsigned long address, unsigned long size)
+{
+	__tlb_adjust_range(tlb, address, size);
+	tlb->cleared_puds =3D 1;
+}
+
+static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
+				     unsigned long address, unsigned long size)
+{
+	__tlb_adjust_range(tlb, address, size);
+	tlb->cleared_p4ds =3D 1;
+}
+
 #ifndef __tlb_remove_tlb_entry
 #define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 #endif
@@ -525,19 +557,17 @@ static inline void tlb_end_vma(struct mmu_gather *t=
lb, struct vm_area_struct *vm
  */
 #define tlb_remove_tlb_entry(tlb, ptep, address)		\
 	do {							\
-		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
-		tlb->cleared_ptes =3D 1;				\
+		tlb_flush_pte_range(tlb, address, PAGE_SIZE);	\
 		__tlb_remove_tlb_entry(tlb, ptep, address);	\
 	} while (0)
=20
 #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
 	do {							\
 		unsigned long _sz =3D huge_page_size(h);		\
-		__tlb_adjust_range(tlb, address, _sz);		\
 		if (_sz =3D=3D PMD_SIZE)				\
-			tlb->cleared_pmds =3D 1;			\
+			tlb_flush_pmd_range(tlb, address, _sz);	\
 		else if (_sz =3D=3D PUD_SIZE)			\
-			tlb->cleared_puds =3D 1;			\
+			tlb_flush_pud_range(tlb, address, _sz);	\
 		__tlb_remove_tlb_entry(tlb, ptep, address);	\
 	} while (0)
=20
@@ -551,8 +581,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb=
, struct vm_area_struct *vm
=20
 #define tlb_remove_pmd_tlb_entry(tlb, pmdp, address)			\
 	do {								\
-		__tlb_adjust_range(tlb, address, HPAGE_PMD_SIZE);	\
-		tlb->cleared_pmds =3D 1;					\
+		tlb_flush_pmd_range(tlb, address, HPAGE_PMD_SIZE);	\
 		__tlb_remove_pmd_tlb_entry(tlb, pmdp, address);		\
 	} while (0)
=20
@@ -566,8 +595,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb=
, struct vm_area_struct *vm
=20
 #define tlb_remove_pud_tlb_entry(tlb, pudp, address)			\
 	do {								\
-		__tlb_adjust_range(tlb, address, HPAGE_PUD_SIZE);	\
-		tlb->cleared_puds =3D 1;					\
+		tlb_flush_pud_range(tlb, address, HPAGE_PUD_SIZE);	\
 		__tlb_remove_pud_tlb_entry(tlb, pudp, address);		\
 	} while (0)
=20
@@ -592,9 +620,8 @@ static inline void tlb_end_vma(struct mmu_gather *tlb=
, struct vm_area_struct *vm
 #ifndef pte_free_tlb
 #define pte_free_tlb(tlb, ptep, address)			\
 	do {							\
-		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
+		tlb_flush_pmd_range(tlb, address, PAGE_SIZE);	\
 		tlb->freed_tables =3D 1;				\
-		tlb->cleared_pmds =3D 1;				\
 		__pte_free_tlb(tlb, ptep, address);		\
 	} while (0)
 #endif
@@ -602,9 +629,8 @@ static inline void tlb_end_vma(struct mmu_gather *tlb=
, struct vm_area_struct *vm
 #ifndef pmd_free_tlb
 #define pmd_free_tlb(tlb, pmdp, address)			\
 	do {							\
-		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
+		tlb_flush_pud_range(tlb, address, PAGE_SIZE);	\
 		tlb->freed_tables =3D 1;				\
-		tlb->cleared_puds =3D 1;				\
 		__pmd_free_tlb(tlb, pmdp, address);		\
 	} while (0)
 #endif
@@ -612,9 +638,8 @@ static inline void tlb_end_vma(struct mmu_gather *tlb=
, struct vm_area_struct *vm
 #ifndef pud_free_tlb
 #define pud_free_tlb(tlb, pudp, address)			\
 	do {							\
-		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
+		tlb_flush_p4d_range(tlb, address, PAGE_SIZE);	\
 		tlb->freed_tables =3D 1;				\
-		tlb->cleared_p4ds =3D 1;				\
 		__pud_free_tlb(tlb, pudp, address);		\
 	} while (0)
 #endif
--=20
2.19.1
