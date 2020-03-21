Return-Path: <SRS0=wNVN=5G=kvack.org=owner-linux-mm@kernel.org>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [RFC PATCH v3 3/4] arm64: tlb: Use translation level hint in vm_flags
Date: Sat, 21 Mar 2020 20:16:20 +0800
Message-ID: <20200321121621.1600-4-yezhenyu2@huawei.com>
In-Reply-To: <20200321121621.1600-1-yezhenyu2@huawei.com>
References: <20200321121621.1600-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, maz@kernel.org, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200321121620.5aXSs_kV5flh5PI4SddamVQK7Aj80FNc8IOw76PDaEk@z>

This patch used the VM_LEVEL flags in vma->vm_flags to set the
TTL field in tlbi instruction.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/mmu.h      |  2 ++
 arch/arm64/include/asm/tlbflush.h | 14 ++++++++------
 arch/arm64/mm/mmu.c               | 14 ++++++++++++++
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index e4d862420bb4..b3f410fee512 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -88,6 +88,8 @@ extern void create_pgd_mapping(struct mm_struct *mm, ph=
ys_addr_t phys,
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t p=
rot);
 extern void mark_linear_text_alias_ro(void);
 extern bool kaslr_requires_kpti(void);
+extern unsigned int get_vma_level(struct vm_area_struct *vma);
+
=20
 #define INIT_MM_CONTEXT(name)	\
 	.pgd =3D init_pg_dir,
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/t=
lbflush.h
index d141c080e494..93bb09fdfafd 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -218,10 +218,11 @@ static inline void flush_tlb_page_nosync(struct vm_=
area_struct *vma,
 					 unsigned long uaddr)
 {
 	unsigned long addr =3D __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
+	unsigned int level =3D get_vma_level(vma);
=20
 	dsb(ishst);
-	__tlbi_level(vale1is, addr, 0);
-	__tlbi_user_level(vale1is, addr, 0);
+	__tlbi_level(vale1is, addr, level);
+	__tlbi_user_level(vale1is, addr, level);
 }
=20
 static inline void flush_tlb_page(struct vm_area_struct *vma,
@@ -242,6 +243,7 @@ static inline void __flush_tlb_range(struct vm_area_s=
truct *vma,
 				     unsigned long stride, bool last_level)
 {
 	unsigned long asid =3D ASID(vma->vm_mm);
+	unsigned int level =3D get_vma_level(vma);
 	unsigned long addr;
=20
 	start =3D round_down(start, stride);
@@ -261,11 +263,11 @@ static inline void __flush_tlb_range(struct vm_area=
_struct *vma,
 	dsb(ishst);
 	for (addr =3D start; addr < end; addr +=3D stride) {
 		if (last_level) {
-			__tlbi_level(vale1is, addr, 0);
-			__tlbi_user_level(vale1is, addr, 0);
+			__tlbi_level(vale1is, addr, level);
+			__tlbi_user_level(vale1is, addr, level);
 		} else {
-			__tlbi_level(vae1is, addr, 0);
-			__tlbi_user_level(vae1is, addr, 0);
+			__tlbi_level(vae1is, addr, level);
+			__tlbi_user_level(vae1is, addr, level);
 		}
 	}
 	dsb(ish);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 128f70852bf3..e6a1221cd86b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -60,6 +60,20 @@ static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss _=
_maybe_unused;
=20
 static DEFINE_SPINLOCK(swapper_pgdir_lock);
=20
+inline unsigned int get_vma_level(struct vm_area_struct *vma)
+{
+	unsigned int level =3D 0;
+	if (vma->vm_flags & VM_LEVEL_PUD)
+		level =3D 1;
+	else if (vma->vm_flags & VM_LEVEL_PMD)
+		level =3D 2;
+	else if (vma->vm_flags & VM_LEVEL_PTE)
+		level =3D 3;
+
+	vma->vm_flags &=3D ~(VM_LEVEL_PUD | VM_LEVEL_PMD | VM_LEVEL_PTE);
+	return level;
+}
+
 void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
 {
 	pgd_t *fixmap_pgdp;
--=20
2.19.1
