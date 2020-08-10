Return-Path: <SRS0=Y13L=BU=kvack.org=owner-linux-mm@kernel.org>
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v3 6/8] mm: Move vmap_range from lib/ioremap.c to mm/vmalloc.c
Date: Mon, 10 Aug 2020 12:27:30 +1000
Message-ID: <20200810022732.1150009-7-npiggin@gmail.com>
In-Reply-To: <20200810022732.1150009-1-npiggin@gmail.com>
References: <20200810022732.1150009-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Zefan Li <lizefan@huawei.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200810022730.tK34zLdz_joZyoRI2wgT7AlJcbZ0faxnM6G-dGYnWZE@z>

This is a generic kernel virtual memory mapper, not specific to ioremap.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/vmalloc.h |   2 +
 mm/ioremap.c            | 192 ----------------------------------------
 mm/vmalloc.c            | 191 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+), 192 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 787d77ad7536..e3590e93bfff 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -181,6 +181,8 @@ extern struct vm_struct *remove_vm_area(const void *a=
ddr);
 extern struct vm_struct *find_vm_area(const void *addr);
=20
 #ifdef CONFIG_MMU
+extern int vmap_range(unsigned long addr, unsigned long end, phys_addr_t=
 phys_addr, pgprot_t prot,
+			unsigned int max_page_shift);
 extern int map_kernel_range_noflush(unsigned long start, unsigned long s=
ize,
 				    pgprot_t prot, struct page **pages);
 int map_kernel_range(unsigned long start, unsigned long size, pgprot_t p=
rot,
diff --git a/mm/ioremap.c b/mm/ioremap.c
index b0032dbadaf7..cdda0e022740 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -28,198 +28,6 @@ early_param("nohugeiomap", set_nohugeiomap);
 static const bool iomap_allow_huge =3D false;
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
=20
-static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long =
end,
-			phys_addr_t phys_addr, pgprot_t prot, pgtbl_mod_mask *mask)
-{
-	pte_t *pte;
-	u64 pfn;
-
-	pfn =3D phys_addr >> PAGE_SHIFT;
-	pte =3D pte_alloc_kernel_track(pmd, addr, mask);
-	if (!pte)
-		return -ENOMEM;
-	do {
-		BUG_ON(!pte_none(*pte));
-		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
-		pfn++;
-	} while (pte++, addr +=3D PAGE_SIZE, addr !=3D end);
-	*mask |=3D PGTBL_PTE_MODIFIED;
-	return 0;
-}
-
-static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned lo=
ng end,
-			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift)
-{
-	if (max_page_shift < PMD_SHIFT)
-		return 0;
-
-	if (!arch_vmap_pmd_supported(prot))
-		return 0;
-
-	if ((end - addr) !=3D PMD_SIZE)
-		return 0;
-
-	if (!IS_ALIGNED(addr, PMD_SIZE))
-		return 0;
-
-	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
-		return 0;
-
-	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
-		return 0;
-
-	return pmd_set_huge(pmd, phys_addr, prot);
-}
-
-static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long =
end,
-			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift,
-			pgtbl_mod_mask *mask)
-{
-	pmd_t *pmd;
-	unsigned long next;
-
-	pmd =3D pmd_alloc_track(&init_mm, pud, addr, mask);
-	if (!pmd)
-		return -ENOMEM;
-	do {
-		next =3D pmd_addr_end(addr, end);
-
-		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot, max_page_shift=
)) {
-			*mask |=3D PGTBL_PMD_MODIFIED;
-			continue;
-		}
-
-		if (vmap_pte_range(pmd, addr, next, phys_addr, prot, mask))
-			return -ENOMEM;
-	} while (pmd++, phys_addr +=3D (next - addr), addr =3D next, addr !=3D =
end);
-	return 0;
-}
-
-static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned lo=
ng end,
-			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift)
-{
-	if (max_page_shift < PUD_SHIFT)
-		return 0;
-
-	if (!arch_vmap_pud_supported(prot))
-		return 0;
-
-	if ((end - addr) !=3D PUD_SIZE)
-		return 0;
-
-	if (!IS_ALIGNED(addr, PUD_SIZE))
-		return 0;
-
-	if (!IS_ALIGNED(phys_addr, PUD_SIZE))
-		return 0;
-
-	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
-		return 0;
-
-	return pud_set_huge(pud, phys_addr, prot);
-}
-
-static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long =
end,
-			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift,
-			pgtbl_mod_mask *mask)
-{
-	pud_t *pud;
-	unsigned long next;
-
-	pud =3D pud_alloc_track(&init_mm, p4d, addr, mask);
-	if (!pud)
-		return -ENOMEM;
-	do {
-		next =3D pud_addr_end(addr, end);
-
-		if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot, max_page_shift=
)) {
-			*mask |=3D PGTBL_PUD_MODIFIED;
-			continue;
-		}
-
-		if (vmap_pmd_range(pud, addr, next, phys_addr, prot, max_page_shift, m=
ask))
-			return -ENOMEM;
-	} while (pud++, phys_addr +=3D (next - addr), addr =3D next, addr !=3D =
end);
-	return 0;
-}
-
-static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned lo=
ng end,
-			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift)
-{
-	if (max_page_shift < P4D_SHIFT)
-		return 0;
-
-	if (!arch_vmap_p4d_supported(prot))
-		return 0;
-
-	if ((end - addr) !=3D P4D_SIZE)
-		return 0;
-
-	if (!IS_ALIGNED(addr, P4D_SIZE))
-		return 0;
-
-	if (!IS_ALIGNED(phys_addr, P4D_SIZE))
-		return 0;
-
-	if (p4d_present(*p4d) && !p4d_free_pud_page(p4d, addr))
-		return 0;
-
-	return p4d_set_huge(p4d, phys_addr, prot);
-}
-
-static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long =
end,
-			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift,
-			pgtbl_mod_mask *mask)
-{
-	p4d_t *p4d;
-	unsigned long next;
-
-	p4d =3D p4d_alloc_track(&init_mm, pgd, addr, mask);
-	if (!p4d)
-		return -ENOMEM;
-	do {
-		next =3D p4d_addr_end(addr, end);
-
-		if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot, max_page_shift=
)) {
-			*mask |=3D PGTBL_P4D_MODIFIED;
-			continue;
-		}
-
-		if (vmap_pud_range(p4d, addr, next, phys_addr, prot, max_page_shift, m=
ask))
-			return -ENOMEM;
-	} while (p4d++, phys_addr +=3D (next - addr), addr =3D next, addr !=3D =
end);
-	return 0;
-}
-
-static int vmap_range(unsigned long addr, unsigned long end, phys_addr_t=
 phys_addr, pgprot_t prot,
-			unsigned int max_page_shift)
-{
-	pgd_t *pgd;
-	unsigned long start;
-	unsigned long next;
-	int err;
-	pgtbl_mod_mask mask =3D 0;
-
-	might_sleep();
-	BUG_ON(addr >=3D end);
-
-	start =3D addr;
-	pgd =3D pgd_offset_k(addr);
-	do {
-		next =3D pgd_addr_end(addr, end);
-		err =3D vmap_p4d_range(pgd, addr, next, phys_addr, prot, max_page_shif=
t, &mask);
-		if (err)
-			break;
-	} while (pgd++, phys_addr +=3D (next - addr), addr =3D next, addr !=3D =
end);
-
-	flush_cache_vmap(start, end);
-
-	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
-		arch_sync_kernel_mappings(start, end);
-
-	return err;
-}
-
 int ioremap_page_range(unsigned long addr, unsigned long end, phys_addr_=
t phys_addr, pgprot_t prot)
 {
 	unsigned int max_page_shift =3D PAGE_SHIFT;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3a1e45fd1626..129f10545bb1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -71,6 +71,197 @@ static void free_work(struct work_struct *w)
 }
=20
 /*** Page table manipulation functions ***/
+static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long =
end,
+			phys_addr_t phys_addr, pgprot_t prot, pgtbl_mod_mask *mask)
+{
+	pte_t *pte;
+	u64 pfn;
+
+	pfn =3D phys_addr >> PAGE_SHIFT;
+	pte =3D pte_alloc_kernel_track(pmd, addr, mask);
+	if (!pte)
+		return -ENOMEM;
+	do {
+		BUG_ON(!pte_none(*pte));
+		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
+		pfn++;
+	} while (pte++, addr +=3D PAGE_SIZE, addr !=3D end);
+	*mask |=3D PGTBL_PTE_MODIFIED;
+	return 0;
+}
+
+static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned lo=
ng end,
+			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift)
+{
+	if (max_page_shift < PMD_SHIFT)
+		return 0;
+
+	if (!arch_vmap_pmd_supported(prot))
+		return 0;
+
+	if ((end - addr) !=3D PMD_SIZE)
+		return 0;
+
+	if (!IS_ALIGNED(addr, PMD_SIZE))
+		return 0;
+
+	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
+		return 0;
+
+	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
+		return 0;
+
+	return pmd_set_huge(pmd, phys_addr, prot);
+}
+
+static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long =
end,
+			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift,
+			pgtbl_mod_mask *mask)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pmd =3D pmd_alloc_track(&init_mm, pud, addr, mask);
+	if (!pmd)
+		return -ENOMEM;
+	do {
+		next =3D pmd_addr_end(addr, end);
+
+		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot, max_page_shift=
)) {
+			*mask |=3D PGTBL_PMD_MODIFIED;
+			continue;
+		}
+
+		if (vmap_pte_range(pmd, addr, next, phys_addr, prot, mask))
+			return -ENOMEM;
+	} while (pmd++, phys_addr +=3D (next - addr), addr =3D next, addr !=3D =
end);
+	return 0;
+}
+
+static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned lo=
ng end,
+			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift)
+{
+	if (max_page_shift < PUD_SHIFT)
+		return 0;
+
+	if (!arch_vmap_pud_supported(prot))
+		return 0;
+
+	if ((end - addr) !=3D PUD_SIZE)
+		return 0;
+
+	if (!IS_ALIGNED(addr, PUD_SIZE))
+		return 0;
+
+	if (!IS_ALIGNED(phys_addr, PUD_SIZE))
+		return 0;
+
+	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
+		return 0;
+
+	return pud_set_huge(pud, phys_addr, prot);
+}
+
+static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long =
end,
+			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift,
+			pgtbl_mod_mask *mask)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pud =3D pud_alloc_track(&init_mm, p4d, addr, mask);
+	if (!pud)
+		return -ENOMEM;
+	do {
+		next =3D pud_addr_end(addr, end);
+
+		if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot, max_page_shift=
)) {
+			*mask |=3D PGTBL_PUD_MODIFIED;
+			continue;
+		}
+
+		if (vmap_pmd_range(pud, addr, next, phys_addr, prot, max_page_shift, m=
ask))
+			return -ENOMEM;
+	} while (pud++, phys_addr +=3D (next - addr), addr =3D next, addr !=3D =
end);
+	return 0;
+}
+
+static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned lo=
ng end,
+			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift)
+{
+	if (max_page_shift < P4D_SHIFT)
+		return 0;
+
+	if (!arch_vmap_p4d_supported(prot))
+		return 0;
+
+	if ((end - addr) !=3D P4D_SIZE)
+		return 0;
+
+	if (!IS_ALIGNED(addr, P4D_SIZE))
+		return 0;
+
+	if (!IS_ALIGNED(phys_addr, P4D_SIZE))
+		return 0;
+
+	if (p4d_present(*p4d) && !p4d_free_pud_page(p4d, addr))
+		return 0;
+
+	return p4d_set_huge(p4d, phys_addr, prot);
+}
+
+static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long =
end,
+			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift,
+			pgtbl_mod_mask *mask)
+{
+	p4d_t *p4d;
+	unsigned long next;
+
+	p4d =3D p4d_alloc_track(&init_mm, pgd, addr, mask);
+	if (!p4d)
+		return -ENOMEM;
+	do {
+		next =3D p4d_addr_end(addr, end);
+
+		if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot, max_page_shift=
)) {
+			*mask |=3D PGTBL_P4D_MODIFIED;
+			continue;
+		}
+
+		if (vmap_pud_range(p4d, addr, next, phys_addr, prot, max_page_shift, m=
ask))
+			return -ENOMEM;
+	} while (p4d++, phys_addr +=3D (next - addr), addr =3D next, addr !=3D =
end);
+	return 0;
+}
+
+int vmap_range(unsigned long addr, unsigned long end, phys_addr_t phys_a=
ddr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	pgd_t *pgd;
+	unsigned long start;
+	unsigned long next;
+	int err;
+	pgtbl_mod_mask mask =3D 0;
+
+	might_sleep();
+	BUG_ON(addr >=3D end);
+
+	start =3D addr;
+	pgd =3D pgd_offset_k(addr);
+	do {
+		next =3D pgd_addr_end(addr, end);
+		err =3D vmap_p4d_range(pgd, addr, next, phys_addr, prot, max_page_shif=
t, &mask);
+		if (err)
+			break;
+	} while (pgd++, phys_addr +=3D (next - addr), addr =3D next, addr !=3D =
end);
+
+	flush_cache_vmap(start, end);
+
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+		arch_sync_kernel_mappings(start, end);
+
+	return err;
+}
=20
 static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned lo=
ng end,
 			     pgtbl_mod_mask *mask)
--=20
2.23.0
