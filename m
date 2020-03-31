Return-Path: <SRS0=PUSD=5Q=kvack.org=owner-linux-mm@kernel.org>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [RFC PATCH v5 5/8] mm: tlb: Pass struct mmu_gather to flush_pud_tlb_range
Date: Tue, 31 Mar 2020 22:29:24 +0800
Message-ID: <20200331142927.1237-6-yezhenyu2@huawei.com>
In-Reply-To: <20200331142927.1237-1-yezhenyu2@huawei.com>
References: <20200331142927.1237-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, corbet@lwn.net, vgupta@synopsys.com, tony.luck@intel.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200331142924.9Lo-yJLX2YKiRCiTtDrPr9yU5cfRRTWWF8JD4i3Xcbk@z>

Preparations to support for passing struct mmu_gather to
flush_tlb_range.  See in future patches.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 include/asm-generic/pgtable.h | 4 ++--
 mm/pgtable-generic.c          | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.=
h
index 32d4661e5a56..1c67a744877e 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1161,10 +1161,10 @@ static inline int pmd_free_pte_page(pmd_t *pmd, u=
nsigned long addr)
  * e.g. see arch/arc: flush_pmd_tlb_range
  */
 #define flush_pmd_tlb_range(tlb, vma, addr, end)	flush_tlb_range(vma, ad=
dr, end)
-#define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, e=
nd)
+#define flush_pud_tlb_range(tlb, vma, addr, end)	flush_tlb_range(vma, ad=
dr, end)
 #else
 #define flush_pmd_tlb_range(tlb, vma, addr, end)	BUILD_BUG()
-#define flush_pud_tlb_range(vma, addr, end)	BUILD_BUG()
+#define flush_pud_tlb_range(tlb, vma, addr, end)	BUILD_BUG()
 #endif
 #endif
=20
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 96c9cf77bfb5..9ab9d8f698ea 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -166,11 +166,17 @@ pud_t pudp_huge_clear_flush(struct vm_area_struct *=
vma, unsigned long address,
 			    pud_t *pudp)
 {
 	pud_t pud;
+	struct mmu_gather tlb;
+	unsigned long tlb_start =3D address;
+	unsigned long tlb_end =3D address + HPAGE_PUD_SIZE;
=20
 	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
 	VM_BUG_ON(!pud_trans_huge(*pudp) && !pud_devmap(*pudp));
 	pud =3D pudp_huge_get_and_clear(vma->vm_mm, address, pudp);
-	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
+	tlb_gather_mmu(&tlb, vma->vm_mm, tlb_start, tlb_end);
+	tlb.cleared_puds =3D 1;
+	flush_pud_tlb_range(&tlb, vma, tlb_start, tlb_end);
+	tlb_finish_mmu(&tlb, tlb_start, tlb_end);
 	return pud;
 }
 #endif
--=20
2.19.1
