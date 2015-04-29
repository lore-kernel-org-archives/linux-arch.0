From: David Howells <dhowells@redhat.com>
Subject: [PATCH 06/13] Make a bunch of mm funcs return bool when they're
 returning a boolean value
Date: Wed, 29 Apr 2015 20:22:09 +0100
Message-ID: <20150429192209.24909.30162.stgit@warthog.procyon.org.uk>
References: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Make a bunch of mm funcs return bool when they're really returning a boolean
value.  A lot of these end up building on test_bit() and co. anyway.

Note that this covers:

 (1) PTE/PMD/PUD/PGD testing functions, such as pte_dirty().

 (2) PTE/PMD/PUD/PGD modification functions that return boolean values, such
     as ptep_clear_flush_young() and pmd_set_huge().

 (3) *set_page_dirty() functions, including the address_space_operations func
     pointer of that name.

 (4) Various hugepages test functions, eg. is_file_hugepages().

 (5) page->flags testing and modify-test functions, eg. PageUptodate().

 (6) mapping_tagged() and radix_tree_tagged().  More of the radix tree code
     could probably converted than just this.

 (7) Various other mm functions that return boolean values,
     eg. vma_wants_writenotify().

Note that a lot of these functions are inline, so changing to returning a bool
usually has no impact since if() is going to convert the result to bool
anyway.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/pgtable.h             |  110 ++++++++++++++--------------
 arch/x86/mm/pgtable.c                      |   62 ++++++++--------
 drivers/staging/lustre/lustre/llite/rw26.c |    2 -
 fs/afs/internal.h                          |    2 -
 fs/afs/write.c                             |    2 -
 fs/buffer.c                                |    4 +
 fs/ceph/addr.c                             |    6 +-
 fs/ext3/inode.c                            |    2 -
 fs/ext4/inode.c                            |    2 -
 fs/gfs2/aops.c                             |    4 +
 fs/libfs.c                                 |    4 +
 include/asm-generic/pgtable.h              |   32 ++++----
 include/linux/buffer_head.h                |    8 +-
 include/linux/fs.h                         |    4 +
 include/linux/hugetlb.h                    |   16 ++--
 include/linux/hugetlb_inline.h             |    6 +-
 include/linux/mm.h                         |   14 ++--
 include/linux/page-flags.h                 |   28 ++++---
 include/linux/radix-tree.h                 |    2 -
 include/linux/suspend.h                    |    2 -
 include/linux/swap.h                       |    2 -
 kernel/power/snapshot.c                    |    8 +-
 lib/radix-tree.c                           |    4 +
 mm/mmap.c                                  |   16 ++--
 mm/page-writeback.c                        |   44 ++++++-----
 mm/page_io.c                               |    2 -
 26 files changed, 194 insertions(+), 194 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index fe57e7a98839..be3712885a9f 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -90,47 +90,47 @@ extern struct mm_struct *pgd_page_get_mm(struct page *page);
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
-static inline int pte_dirty(pte_t pte)
+static inline bool pte_dirty(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_DIRTY;
 }
 
-static inline int pte_young(pte_t pte)
+static inline bool pte_young(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_ACCESSED;
 }
 
-static inline int pmd_dirty(pmd_t pmd)
+static inline bool pmd_dirty(pmd_t pmd)
 {
 	return pmd_flags(pmd) & _PAGE_DIRTY;
 }
 
-static inline int pmd_young(pmd_t pmd)
+static inline bool pmd_young(pmd_t pmd)
 {
 	return pmd_flags(pmd) & _PAGE_ACCESSED;
 }
 
-static inline int pte_write(pte_t pte)
+static inline bool pte_write(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_RW;
 }
 
-static inline int pte_huge(pte_t pte)
+static inline bool pte_huge(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_PSE;
 }
 
-static inline int pte_global(pte_t pte)
+static inline bool pte_global(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_GLOBAL;
 }
 
-static inline int pte_exec(pte_t pte)
+static inline bool pte_exec(pte_t pte)
 {
 	return !(pte_flags(pte) & _PAGE_NX);
 }
 
-static inline int pte_special(pte_t pte)
+static inline bool pte_special(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_SPECIAL;
 }
@@ -152,23 +152,23 @@ static inline unsigned long pud_pfn(pud_t pud)
 
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 
-static inline int pmd_large(pmd_t pte)
+static inline bool pmd_large(pmd_t pte)
 {
 	return pmd_flags(pte) & _PAGE_PSE;
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline int pmd_trans_splitting(pmd_t pmd)
+static inline bool pmd_trans_splitting(pmd_t pmd)
 {
 	return pmd_val(pmd) & _PAGE_SPLITTING;
 }
 
-static inline int pmd_trans_huge(pmd_t pmd)
+static inline bool pmd_trans_huge(pmd_t pmd)
 {
 	return pmd_val(pmd) & _PAGE_PSE;
 }
 
-static inline int has_transparent_hugepage(void)
+static inline bool has_transparent_hugepage(void)
 {
 	return cpu_has_pse;
 }
@@ -298,12 +298,12 @@ static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 }
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
-static inline int pte_soft_dirty(pte_t pte)
+static inline bool pte_soft_dirty(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_SOFT_DIRTY;
 }
 
-static inline int pmd_soft_dirty(pmd_t pmd)
+static inline bool pmd_soft_dirty(pmd_t pmd)
 {
 	return pmd_flags(pmd) & _PAGE_SOFT_DIRTY;
 }
@@ -383,15 +383,15 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
 
 #define canon_pgprot(p) __pgprot(massage_pgprot(p))
 
-static inline int is_new_memtype_allowed(u64 paddr, unsigned long size,
-					 enum page_cache_mode pcm,
-					 enum page_cache_mode new_pcm)
+static inline bool is_new_memtype_allowed(u64 paddr, unsigned long size,
+					  enum page_cache_mode pcm,
+					  enum page_cache_mode new_pcm)
 {
 	/*
 	 * PAT type is always WB for untracked ranges, so no need to check.
 	 */
 	if (x86_platform.is_untracked_pat_range(paddr, paddr + size))
-		return 1;
+		return true;
 
 	/*
 	 * Certain new memtypes are not allowed with certain
@@ -403,10 +403,10 @@ static inline int is_new_memtype_allowed(u64 paddr, unsigned long size,
 	     new_pcm == _PAGE_CACHE_MODE_WB) ||
 	    (pcm == _PAGE_CACHE_MODE_WC &&
 	     new_pcm == _PAGE_CACHE_MODE_WB)) {
-		return 0;
+		return false;
 	}
 
-	return 1;
+	return true;
 }
 
 pmd_t *populate_extra_pmd(unsigned long vaddr);
@@ -424,18 +424,18 @@ pte_t *populate_extra_pte(unsigned long vaddr);
 #include <linux/mmdebug.h>
 #include <linux/log2.h>
 
-static inline int pte_none(pte_t pte)
+static inline bool pte_none(pte_t pte)
 {
 	return !pte.pte;
 }
 
 #define __HAVE_ARCH_PTE_SAME
-static inline int pte_same(pte_t a, pte_t b)
+static inline bool pte_same(pte_t a, pte_t b)
 {
 	return a.pte == b.pte;
 }
 
-static inline int pte_present(pte_t a)
+static inline bool pte_present(pte_t a)
 {
 	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
 }
@@ -453,12 +453,12 @@ static inline bool pte_accessible(struct mm_struct *mm, pte_t a)
 	return false;
 }
 
-static inline int pte_hidden(pte_t pte)
+static inline bool pte_hidden(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_HIDDEN;
 }
 
-static inline int pmd_present(pmd_t pmd)
+static inline bool pmd_present(pmd_t pmd)
 {
 	/*
 	 * Checking for _PAGE_PSE is needed too because
@@ -474,20 +474,20 @@ static inline int pmd_present(pmd_t pmd)
  * These work without NUMA balancing but the kernel does not care. See the
  * comment in include/asm-generic/pgtable.h
  */
-static inline int pte_protnone(pte_t pte)
+static inline bool pte_protnone(pte_t pte)
 {
 	return (pte_flags(pte) & (_PAGE_PROTNONE | _PAGE_PRESENT))
 		== _PAGE_PROTNONE;
 }
 
-static inline int pmd_protnone(pmd_t pmd)
+static inline bool pmd_protnone(pmd_t pmd)
 {
 	return (pmd_flags(pmd) & (_PAGE_PROTNONE | _PAGE_PRESENT))
 		== _PAGE_PROTNONE;
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-static inline int pmd_none(pmd_t pmd)
+static inline bool pmd_none(pmd_t pmd)
 {
 	/* Only check low word on 32-bit platforms, since it might be
 	   out of sync with upper half. */
@@ -541,7 +541,7 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 	return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
 }
 
-static inline int pmd_bad(pmd_t pmd)
+static inline bool pmd_bad(pmd_t pmd)
 {
 	return (pmd_flags(pmd) & ~_PAGE_USER) != _KERNPG_TABLE;
 }
@@ -552,12 +552,12 @@ static inline unsigned long pages_to_mb(unsigned long npg)
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
-static inline int pud_none(pud_t pud)
+static inline bool pud_none(pud_t pud)
 {
 	return native_pud_val(pud) == 0;
 }
 
-static inline int pud_present(pud_t pud)
+static inline bool pud_present(pud_t pud)
 {
 	return pud_flags(pud) & _PAGE_PRESENT;
 }
@@ -579,25 +579,25 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
 	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);
 }
 
-static inline int pud_large(pud_t pud)
+static inline bool pud_large(pud_t pud)
 {
 	return (pud_val(pud) & (_PAGE_PSE | _PAGE_PRESENT)) ==
 		(_PAGE_PSE | _PAGE_PRESENT);
 }
 
-static inline int pud_bad(pud_t pud)
+static inline bool pud_bad(pud_t pud)
 {
 	return (pud_flags(pud) & ~(_KERNPG_TABLE | _PAGE_USER)) != 0;
 }
 #else
-static inline int pud_large(pud_t pud)
+static inline bool pud_large(pud_t pud)
 {
-	return 0;
+	return false;
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 2 */
 
 #if CONFIG_PGTABLE_LEVELS > 3
-static inline int pgd_present(pgd_t pgd)
+static inline bool pgd_present(pgd_t pgd)
 {
 	return pgd_flags(pgd) & _PAGE_PRESENT;
 }
@@ -624,12 +624,12 @@ static inline pud_t *pud_offset(pgd_t *pgd, unsigned long address)
 	return (pud_t *)pgd_page_vaddr(*pgd) + pud_index(address);
 }
 
-static inline int pgd_bad(pgd_t pgd)
+static inline bool pgd_bad(pgd_t pgd)
 {
 	return (pgd_flags(pgd) & ~_PAGE_USER) != _KERNPG_TABLE;
 }
 
-static inline int pgd_none(pgd_t pgd)
+static inline bool pgd_none(pgd_t pgd)
 {
 	return !native_pgd_val(pgd);
 }
@@ -724,17 +724,17 @@ static inline void native_set_pmd_at(struct mm_struct *mm, unsigned long addr,
 struct vm_area_struct;
 
 #define  __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
-extern int ptep_set_access_flags(struct vm_area_struct *vma,
-				 unsigned long address, pte_t *ptep,
-				 pte_t entry, int dirty);
+extern bool ptep_set_access_flags(struct vm_area_struct *vma,
+				  unsigned long address, pte_t *ptep,
+				  pte_t entry, int dirty);
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-extern int ptep_test_and_clear_young(struct vm_area_struct *vma,
-				     unsigned long addr, pte_t *ptep);
+extern bool ptep_test_and_clear_young(struct vm_area_struct *vma,
+				      unsigned long addr, pte_t *ptep);
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-extern int ptep_clear_flush_young(struct vm_area_struct *vma,
-				  unsigned long address, pte_t *ptep);
+extern bool ptep_clear_flush_young(struct vm_area_struct *vma,
+				   unsigned long address, pte_t *ptep);
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
@@ -776,17 +776,17 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm,
 #define mk_pmd(page, pgprot)   pfn_pmd(page_to_pfn(page), (pgprot))
 
 #define  __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
-extern int pmdp_set_access_flags(struct vm_area_struct *vma,
-				 unsigned long address, pmd_t *pmdp,
-				 pmd_t entry, int dirty);
+extern bool pmdp_set_access_flags(struct vm_area_struct *vma,
+				  unsigned long address, pmd_t *pmdp,
+				  pmd_t entry, int dirty);
 
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
-extern int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-				     unsigned long addr, pmd_t *pmdp);
+extern bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
+				      unsigned long addr, pmd_t *pmdp);
 
 #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
-extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
-				  unsigned long address, pmd_t *pmdp);
+extern bool pmdp_clear_flush_young(struct vm_area_struct *vma,
+				   unsigned long address, pmd_t *pmdp);
 
 
 #define __HAVE_ARCH_PMDP_SPLITTING_FLUSH
@@ -794,7 +794,7 @@ extern void pmdp_splitting_flush(struct vm_area_struct *vma,
 				 unsigned long addr, pmd_t *pmdp);
 
 #define __HAVE_ARCH_PMD_WRITE
-static inline int pmd_write(pmd_t pmd)
+static inline bool pmd_write(pmd_t pmd)
 {
 	return pmd_flags(pmd) & _PAGE_RW;
 }
@@ -864,7 +864,7 @@ static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
 	return pte_set_flags(pte, _PAGE_SWP_SOFT_DIRTY);
 }
 
-static inline int pte_swp_soft_dirty(pte_t pte)
+static inline bool pte_swp_soft_dirty(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_SWP_SOFT_DIRTY;
 }
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 0b97d2c75df3..c0cb80953fd5 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -406,11 +406,11 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
  * to also make the pte writeable at the same time the dirty bit is
  * set. In that case we do actually need to write the PTE.
  */
-int ptep_set_access_flags(struct vm_area_struct *vma,
-			  unsigned long address, pte_t *ptep,
-			  pte_t entry, int dirty)
+bool ptep_set_access_flags(struct vm_area_struct *vma,
+			   unsigned long address, pte_t *ptep,
+			   pte_t entry, int dirty)
 {
-	int changed = !pte_same(*ptep, entry);
+	bool changed = !pte_same(*ptep, entry);
 
 	if (changed && dirty) {
 		*ptep = entry;
@@ -421,11 +421,11 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-int pmdp_set_access_flags(struct vm_area_struct *vma,
-			  unsigned long address, pmd_t *pmdp,
-			  pmd_t entry, int dirty)
+bool pmdp_set_access_flags(struct vm_area_struct *vma,
+			   unsigned long address, pmd_t *pmdp,
+			   pmd_t entry, int dirty)
 {
-	int changed = !pmd_same(*pmdp, entry);
+	bool changed = !pmd_same(*pmdp, entry);
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
@@ -444,10 +444,10 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
 }
 #endif
 
-int ptep_test_and_clear_young(struct vm_area_struct *vma,
-			      unsigned long addr, pte_t *ptep)
+bool ptep_test_and_clear_young(struct vm_area_struct *vma,
+			       unsigned long addr, pte_t *ptep)
 {
-	int ret = 0;
+	bool ret = false;
 
 	if (pte_young(*ptep))
 		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
@@ -460,10 +460,10 @@ int ptep_test_and_clear_young(struct vm_area_struct *vma,
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-			      unsigned long addr, pmd_t *pmdp)
+bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
+			       unsigned long addr, pmd_t *pmdp)
 {
-	int ret = 0;
+	bool ret = 0;
 
 	if (pmd_young(*pmdp))
 		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
@@ -476,8 +476,8 @@ int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 }
 #endif
 
-int ptep_clear_flush_young(struct vm_area_struct *vma,
-			   unsigned long address, pte_t *ptep)
+bool ptep_clear_flush_young(struct vm_area_struct *vma,
+			    unsigned long address, pte_t *ptep)
 {
 	/*
 	 * On x86 CPUs, clearing the accessed bit without a TLB flush
@@ -496,10 +496,10 @@ int ptep_clear_flush_young(struct vm_area_struct *vma,
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-int pmdp_clear_flush_young(struct vm_area_struct *vma,
-			   unsigned long address, pmd_t *pmdp)
+bool pmdp_clear_flush_young(struct vm_area_struct *vma,
+			    unsigned long address, pmd_t *pmdp)
 {
-	int young;
+	bool young;
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
@@ -563,7 +563,7 @@ void native_set_fixmap(enum fixed_addresses idx, phys_addr_t phys,
 }
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
+bool pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 {
 	u8 mtrr;
 
@@ -573,7 +573,7 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 	 */
 	mtrr = mtrr_type_lookup(addr, addr + PUD_SIZE);
 	if ((mtrr != MTRR_TYPE_WRBACK) && (mtrr != 0xFF))
-		return 0;
+		return false;
 
 	prot = pgprot_4k_2_large(prot);
 
@@ -581,10 +581,10 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 		(u64)addr >> PAGE_SHIFT,
 		__pgprot(pgprot_val(prot) | _PAGE_PSE)));
 
-	return 1;
+	return true;
 }
 
-int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
+bool pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 {
 	u8 mtrr;
 
@@ -594,7 +594,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 	 */
 	mtrr = mtrr_type_lookup(addr, addr + PMD_SIZE);
 	if ((mtrr != MTRR_TYPE_WRBACK) && (mtrr != 0xFF))
-		return 0;
+		return false;
 
 	prot = pgprot_4k_2_large(prot);
 
@@ -602,26 +602,26 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 		(u64)addr >> PAGE_SHIFT,
 		__pgprot(pgprot_val(prot) | _PAGE_PSE)));
 
-	return 1;
+	return true;
 }
 
-int pud_clear_huge(pud_t *pud)
+bool pud_clear_huge(pud_t *pud)
 {
 	if (pud_large(*pud)) {
 		pud_clear(pud);
-		return 1;
+		return true;
 	}
 
-	return 0;
+	return false;
 }
 
-int pmd_clear_huge(pmd_t *pmd)
+bool pmd_clear_huge(pmd_t *pmd)
 {
 	if (pmd_large(*pmd)) {
 		pmd_clear(pmd);
-		return 1;
+		return true;
 	}
 
-	return 0;
+	return false;
 }
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
diff --git a/drivers/staging/lustre/lustre/llite/rw26.c b/drivers/staging/lustre/lustre/llite/rw26.c
index c6c824356464..0e85e9914d1e 100644
--- a/drivers/staging/lustre/lustre/llite/rw26.c
+++ b/drivers/staging/lustre/lustre/llite/rw26.c
@@ -161,7 +161,7 @@ static int ll_releasepage(struct page *vmpage, RELEASEPAGE_ARG_TYPE gfp_mask)
 	return result;
 }
 
-static int ll_set_page_dirty(struct page *vmpage)
+static bool ll_set_page_dirty(struct page *vmpage)
 {
 #if 0
 	struct cl_page    *page = vvp_vmpage_page_transient(vmpage);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 71d5982312f3..243730ae48ea 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -736,7 +736,7 @@ extern int afs_volume_release_fileserver(struct afs_vnode *,
 /*
  * write.c
  */
-extern int afs_set_page_dirty(struct page *);
+extern bool afs_set_page_dirty(struct page *);
 extern void afs_put_writeback(struct afs_writeback *);
 extern int afs_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned flags,
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 0714abcd7f32..771d13d6bbd0 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -22,7 +22,7 @@ static int afs_write_back_from_locked_page(struct afs_writeback *wb,
 /*
  * mark a page as having been made dirty and thus needing writeback
  */
-int afs_set_page_dirty(struct page *page)
+bool afs_set_page_dirty(struct page *page)
 {
 	_enter("");
 	return __set_page_dirty_nobuffers(page);
diff --git a/fs/buffer.c b/fs/buffer.c
index c7a5602d01ee..f101beeff0fa 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -665,9 +665,9 @@ static void __set_page_dirty(struct page *page,
  * FIXME: may need to call ->reservepage here as well.  That's rather up to the
  * address_space though.
  */
-int __set_page_dirty_buffers(struct page *page)
+bool __set_page_dirty_buffers(struct page *page)
 {
-	int newly_dirty;
+	bool newly_dirty;
 	struct address_space *mapping = page_mapping(page);
 
 	if (unlikely(!mapping))
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e162bcd105ee..b9e81bb01d71 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -66,13 +66,13 @@ static inline struct ceph_snap_context *page_snap_context(struct page *page)
  * Dirty a page.  Optimistically adjust accounting, on the assumption
  * that we won't race with invalidate.  If we do, readjust.
  */
-static int ceph_set_page_dirty(struct page *page)
+static bool ceph_set_page_dirty(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode;
 	struct ceph_inode_info *ci;
 	struct ceph_snap_context *snapc;
-	int ret;
+	bool ret;
 
 	if (unlikely(!mapping))
 		return !TestSetPageDirty(page);
@@ -81,7 +81,7 @@ static int ceph_set_page_dirty(struct page *page)
 		dout("%p set_page_dirty %p idx %lu -- already dirty\n",
 		     mapping->host, page, page->index);
 		BUG_ON(!PagePrivate(page));
-		return 0;
+		return false;
 	}
 
 	inode = mapping->host;
diff --git a/fs/ext3/inode.c b/fs/ext3/inode.c
index 2ee2dc4351d1..53bc6c04b2fd 100644
--- a/fs/ext3/inode.c
+++ b/fs/ext3/inode.c
@@ -1925,7 +1925,7 @@ out:
  * So what we do is to mark the page "pending dirty" and next time writepage
  * is called, propagate that into the buffers appropriately.
  */
-static int ext3_journalled_set_page_dirty(struct page *page)
+static bool ext3_journalled_set_page_dirty(struct page *page)
 {
 	SetPageChecked(page);
 	return __set_page_dirty_nobuffers(page);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index cbd0654a2675..3de08847b02f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3237,7 +3237,7 @@ static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
  * So what we do is to mark the page "pending dirty" and next time writepage
  * is called, propagate that into the buffers appropriately.
  */
-static int ext4_journalled_set_page_dirty(struct page *page)
+static bool ext4_journalled_set_page_dirty(struct page *page)
 {
 	SetPageChecked(page);
 	return __set_page_dirty_nobuffers(page);
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 5551fea0afd7..9763c94b8164 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -925,10 +925,10 @@ failed:
  * gfs2_set_page_dirty - Page dirtying function
  * @page: The page to dirty
  *
- * Returns: 1 if it dirtyed the page, or 0 otherwise
+ * Returns: true if it dirtied the page, or false otherwise
  */
  
-static int gfs2_set_page_dirty(struct page *page)
+static bool gfs2_set_page_dirty(struct page *page)
 {
 	SetPageChecked(page);
 	return __set_page_dirty_buffers(page);
diff --git a/fs/libfs.c b/fs/libfs.c
index cb1fb4b9b637..60b145368d74 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1037,9 +1037,9 @@ EXPORT_SYMBOL(kfree_put_link);
  * nop .set_page_dirty method so that people can use .page_mkwrite on
  * anon inodes.
  */
-static int anon_set_page_dirty(struct page *page)
+static bool anon_set_page_dirty(struct page *page)
 {
-	return 0;
+	return false;
 };
 
 /*
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 39f1d6a2b04d..a9891a6bb075 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -624,7 +624,7 @@ static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
  * version above, is also needed when THP is disabled because the page
  * fault can populate the pmd from under us).
  */
-static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
+static inline bool pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
 {
 	pmd_t pmdval = pmd_read_atomic(pmd);
 	/*
@@ -645,12 +645,12 @@ static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
 	barrier();
 #endif
 	if (pmd_none(pmdval) || pmd_trans_huge(pmdval))
-		return 1;
+		return true;
 	if (unlikely(pmd_bad(pmdval))) {
 		pmd_clear_bad(pmd);
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 /*
@@ -666,12 +666,12 @@ static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
  * become null, but then a page fault can map in a THP and not a
  * regular page).
  */
-static inline int pmd_trans_unstable(pmd_t *pmd)
+static inline bool pmd_trans_unstable(pmd_t *pmd)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	return pmd_none_or_trans_huge_or_clear_bad(pmd);
 #else
-	return 0;
+	return false;
 #endif
 }
 
@@ -684,12 +684,12 @@ static inline int pmd_trans_unstable(pmd_t *pmd)
  * is the responsibility of the caller to distinguish between PROT_NONE
  * protections and NUMA hinting fault protections.
  */
-static inline int pte_protnone(pte_t pte)
+static inline bool pte_protnone(pte_t pte)
 {
 	return 0;
 }
 
-static inline int pmd_protnone(pmd_t pmd)
+static inline bool pmd_protnone(pmd_t pmd)
 {
 	return 0;
 }
@@ -698,24 +698,24 @@ static inline int pmd_protnone(pmd_t pmd)
 #endif /* CONFIG_MMU */
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot);
-int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
-int pud_clear_huge(pud_t *pud);
-int pmd_clear_huge(pmd_t *pmd);
+bool pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot);
+bool pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
+bool pud_clear_huge(pud_t *pud);
+bool pmd_clear_huge(pmd_t *pmd);
 #else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
-static inline int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
+static inline bool pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 {
 	return 0;
 }
-static inline int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
+static inline bool pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 {
 	return 0;
 }
-static inline int pud_clear_huge(pud_t *pud)
+static inline bool pud_clear_huge(pud_t *pud)
 {
 	return 0;
 }
-static inline int pmd_clear_huge(pmd_t *pmd)
+static inline bool pmd_clear_huge(pmd_t *pmd)
 {
 	return 0;
 }
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 73b45225a7ca..7ef0881ec8ba 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -90,7 +90,7 @@ static inline void clear_buffer_##name(struct buffer_head *bh)		\
 {									\
 	clear_bit(BH_##bit, &(bh)->b_state);				\
 }									\
-static inline int buffer_##name(const struct buffer_head *bh)		\
+static inline bool buffer_##name(const struct buffer_head *bh)		\
 {									\
 	return test_bit(BH_##bit, &(bh)->b_state);			\
 }
@@ -99,11 +99,11 @@ static inline int buffer_##name(const struct buffer_head *bh)		\
  * test_set_buffer_foo() and test_clear_buffer_foo()
  */
 #define TAS_BUFFER_FNS(bit, name)					\
-static inline int test_set_buffer_##name(struct buffer_head *bh)	\
+static inline bool test_set_buffer_##name(struct buffer_head *bh)	\
 {									\
 	return test_and_set_bit(BH_##bit, &(bh)->b_state);		\
 }									\
-static inline int test_clear_buffer_##name(struct buffer_head *bh)	\
+static inline bool test_clear_buffer_##name(struct buffer_head *bh)	\
 {									\
 	return test_and_clear_bit(BH_##bit, &(bh)->b_state);		\
 }									\
@@ -381,7 +381,7 @@ __bread(struct block_device *bdev, sector_t block, unsigned size)
 	return __bread_gfp(bdev, block, size, __GFP_MOVABLE);
 }
 
-extern int __set_page_dirty_buffers(struct page *page);
+extern bool __set_page_dirty_buffers(struct page *page);
 
 #else /* CONFIG_BLOCK */
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 35ec87e490b1..8171af3cffd1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -371,7 +371,7 @@ struct address_space_operations {
 	int (*writepages)(struct address_space *, struct writeback_control *);
 
 	/* Set a page dirty.  Return true if this dirtied it */
-	int (*set_page_dirty)(struct page *page);
+	bool (*set_page_dirty)(struct page *page);
 
 	int (*readpages)(struct file *filp, struct address_space *mapping,
 			struct list_head *pages, unsigned nr_pages);
@@ -490,7 +490,7 @@ struct block_device {
 #define PAGECACHE_TAG_WRITEBACK	1
 #define PAGECACHE_TAG_TOWRITE	2
 
-int mapping_tagged(struct address_space *mapping, int tag);
+bool mapping_tagged(struct address_space *mapping, int tag);
 
 static inline void i_mmap_lock_write(struct address_space *mapping)
 {
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 205026175c42..02f7552a343a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -255,20 +255,20 @@ struct file *hugetlb_file_setup(const char *name, size_t size, vm_flags_t acct,
 				struct user_struct **user, int creat_flags,
 				int page_size_log);
 
-static inline int is_file_hugepages(struct file *file)
+static inline bool is_file_hugepages(struct file *file)
 {
 	if (file->f_op == &hugetlbfs_file_operations)
-		return 1;
+		return true;
 	if (is_file_shm_hugepages(file))
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 
 #else /* !CONFIG_HUGETLBFS */
 
-#define is_file_hugepages(file)			0
+#define is_file_hugepages(file)			false
 static inline struct file *
 hugetlb_file_setup(const char *name, size_t size, vm_flags_t acctflag,
 		struct user_struct **user, int creat_flags,
@@ -442,12 +442,12 @@ static inline pgoff_t basepage_index(struct page *page)
 
 extern void dissolve_free_huge_pages(unsigned long start_pfn,
 				     unsigned long end_pfn);
-static inline int hugepage_migration_supported(struct hstate *h)
+static inline bool hugepage_migration_supported(struct hstate *h)
 {
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 	return huge_page_shift(h) == PMD_SHIFT;
 #else
-	return 0;
+	return false;
 #endif
 }
 
@@ -498,7 +498,7 @@ static inline pgoff_t basepage_index(struct page *page)
 	return page->index;
 }
 #define dissolve_free_huge_pages(s, e)	do {} while (0)
-#define hugepage_migration_supported(h)	0
+#define hugepage_migration_supported(h)	false
 
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
diff --git a/include/linux/hugetlb_inline.h b/include/linux/hugetlb_inline.h
index 2bb681fbeb35..4256d9d95f9a 100644
--- a/include/linux/hugetlb_inline.h
+++ b/include/linux/hugetlb_inline.h
@@ -5,14 +5,14 @@
 
 #include <linux/mm.h>
 
-static inline int is_vm_hugetlb_page(struct vm_area_struct *vma)
+static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
 {
-	return !!(vma->vm_flags & VM_HUGETLB);
+	return vma->vm_flags & VM_HUGETLB;
 }
 
 #else
 
-static inline int is_vm_hugetlb_page(struct vm_area_struct *vma)
+static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
 {
 	return 0;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0755b9fd03a7..69daba13f560 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1207,15 +1207,15 @@ extern int try_to_release_page(struct page * page, gfp_t gfp_mask);
 extern void do_invalidatepage(struct page *page, unsigned int offset,
 			      unsigned int length);
 
-int __set_page_dirty_nobuffers(struct page *page);
-int __set_page_dirty_no_writeback(struct page *page);
-int redirty_page_for_writepage(struct writeback_control *wbc,
+bool __set_page_dirty_nobuffers(struct page *page);
+bool __set_page_dirty_no_writeback(struct page *page);
+bool redirty_page_for_writepage(struct writeback_control *wbc,
 				struct page *page);
 void account_page_dirtied(struct page *page, struct address_space *mapping);
 void account_page_cleaned(struct page *page, struct address_space *mapping);
-int set_page_dirty(struct page *page);
-int set_page_dirty_lock(struct page *page);
-int clear_page_dirty_for_io(struct page *page);
+bool set_page_dirty(struct page *page);
+bool set_page_dirty_lock(struct page *page);
+bool clear_page_dirty_for_io(struct page *page);
 
 int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 
@@ -1351,7 +1351,7 @@ static inline void sync_mm_rss(struct mm_struct *mm)
 }
 #endif
 
-int vma_wants_writenotify(struct vm_area_struct *vma);
+bool vma_wants_writenotify(struct vm_area_struct *vma);
 
 extern pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
 			       spinlock_t **ptl);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f34e040b34e9..7601ec9ac2b9 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -138,7 +138,7 @@ enum pageflags {
  * Macros to create function definitions for page flags
  */
 #define TESTPAGEFLAG(uname, lname)					\
-static inline int Page##uname(const struct page *page)			\
+static inline bool Page##uname(const struct page *page)			\
 			{ return test_bit(PG_##lname, &page->flags); }
 
 #define SETPAGEFLAG(uname, lname)					\
@@ -158,15 +158,15 @@ static inline void __ClearPage##uname(struct page *page)		\
 			{ __clear_bit(PG_##lname, &page->flags); }
 
 #define TESTSETFLAG(uname, lname)					\
-static inline int TestSetPage##uname(struct page *page)			\
+static inline bool TestSetPage##uname(struct page *page)			\
 		{ return test_and_set_bit(PG_##lname, &page->flags); }
 
 #define TESTCLEARFLAG(uname, lname)					\
-static inline int TestClearPage##uname(struct page *page)		\
+static inline bool TestClearPage##uname(struct page *page)		\
 		{ return test_and_clear_bit(PG_##lname, &page->flags); }
 
 #define __TESTCLEARFLAG(uname, lname)					\
-static inline int __TestClearPage##uname(struct page *page)		\
+static inline bool __TestClearPage##uname(struct page *page)		\
 		{ return __test_and_clear_bit(PG_##lname, &page->flags); }
 
 #define PAGEFLAG(uname, lname) TESTPAGEFLAG(uname, lname)		\
@@ -179,7 +179,7 @@ static inline int __TestClearPage##uname(struct page *page)		\
 	TESTSETFLAG(uname, lname) TESTCLEARFLAG(uname, lname)
 
 #define TESTPAGEFLAG_FALSE(uname)					\
-static inline int Page##uname(const struct page *page) { return 0; }
+static inline bool Page##uname(const struct page *page) { return false; }
 
 #define SETPAGEFLAG_NOOP(uname)						\
 static inline void SetPage##uname(struct page *page) {  }
@@ -191,13 +191,13 @@ static inline void ClearPage##uname(struct page *page) {  }
 static inline void __ClearPage##uname(struct page *page) {  }
 
 #define TESTSETFLAG_FALSE(uname)					\
-static inline int TestSetPage##uname(struct page *page) { return 0; }
+static inline bool TestSetPage##uname(struct page *page) { return false; }
 
 #define TESTCLEARFLAG_FALSE(uname)					\
-static inline int TestClearPage##uname(struct page *page) { return 0; }
+static inline bool TestClearPage##uname(struct page *page) { return false; }
 
 #define __TESTCLEARFLAG_FALSE(uname)					\
-static inline int __TestClearPage##uname(struct page *page) { return 0; }
+static inline bool __TestClearPage##uname(struct page *page) { return false; }
 
 #define PAGEFLAG_FALSE(uname) TESTPAGEFLAG_FALSE(uname)			\
 	SETPAGEFLAG_NOOP(uname) CLEARPAGEFLAG_NOOP(uname)
@@ -309,7 +309,7 @@ PAGEFLAG_FALSE(HWPoison)
 #define PAGE_MAPPING_KSM	2
 #define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_KSM)
 
-static inline int PageAnon(struct page *page)
+static inline bool PageAnon(struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_ANON) != 0;
 }
@@ -321,7 +321,7 @@ static inline int PageAnon(struct page *page)
  * is found in VM_MERGEABLE vmas.  It's a PageAnon page, pointing not to any
  * anon_vma, but to that page's node of the stable tree.
  */
-static inline int PageKsm(struct page *page)
+static inline bool PageKsm(struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
 				(PAGE_MAPPING_ANON | PAGE_MAPPING_KSM);
@@ -332,9 +332,9 @@ TESTPAGEFLAG_FALSE(Ksm)
 
 u64 stable_page_flags(struct page *page);
 
-static inline int PageUptodate(struct page *page)
+static inline bool PageUptodate(struct page *page)
 {
-	int ret = test_bit(PG_uptodate, &(page)->flags);
+	bool ret = test_bit(PG_uptodate, &(page)->flags);
 
 	/*
 	 * Must ensure that the data we read out of the page is loaded
@@ -369,8 +369,8 @@ static inline void SetPageUptodate(struct page *page)
 
 CLEARPAGEFLAG(Uptodate, uptodate)
 
-int test_clear_page_writeback(struct page *page);
-int __test_set_page_writeback(struct page *page, bool keep_write);
+bool test_clear_page_writeback(struct page *page);
+bool __test_set_page_writeback(struct page *page, bool keep_write);
 
 #define test_set_page_writeback(page)			\
 	__test_set_page_writeback(page, false)
diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 33170dbd9db4..a525cb56e6b2 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -298,7 +298,7 @@ unsigned long radix_tree_range_tag_if_tagged(struct radix_tree_root *root,
 		unsigned long *first_indexp, unsigned long last_index,
 		unsigned long nr_to_tag,
 		unsigned int fromtag, unsigned int totag);
-int radix_tree_tagged(struct radix_tree_root *root, unsigned int tag);
+bool radix_tree_tagged(struct radix_tree_root *root, unsigned int tag);
 unsigned long radix_tree_locate_item(struct radix_tree_root *root, void *item);
 
 static inline void radix_tree_preload_end(void)
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 5efe743ce1e8..dc1bc6337303 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -337,7 +337,7 @@ static inline void __init register_nosave_region_late(unsigned long b, unsigned
 {
 	__register_nosave_region(b, e, 1);
 }
-extern int swsusp_page_is_forbidden(struct page *);
+extern bool swsusp_page_is_forbidden(struct page *);
 extern void swsusp_set_page_free(struct page *);
 extern void swsusp_unset_page_free(struct page *);
 extern unsigned long get_safe_page(gfp_t gfp_mask);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index cee108cbe2d5..4e40fda37629 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -376,7 +376,7 @@ extern int swap_writepage(struct page *page, struct writeback_control *wbc);
 extern void end_swap_bio_write(struct bio *bio, int err);
 extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	void (*end_write_func)(struct bio *, int));
-extern int swap_set_page_dirty(struct page *page);
+extern bool swap_set_page_dirty(struct page *page);
 extern void end_swap_bio_read(struct bio *bio, int err);
 
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 5235dd4e1e2f..24c36faa8b51 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -38,7 +38,7 @@
 
 #include "power.h"
 
-static int swsusp_page_is_free(struct page *);
+static bool swsusp_page_is_free(struct page *);
 static void swsusp_set_page_forbidden(struct page *);
 static void swsusp_unset_page_forbidden(struct page *);
 
@@ -734,7 +734,7 @@ static void memory_bm_clear_current(struct memory_bitmap *bm)
 	clear_bit(bit, bm->cur.node->data);
 }
 
-static int memory_bm_test_bit(struct memory_bitmap *bm, unsigned long pfn)
+static bool memory_bm_test_bit(struct memory_bitmap *bm, unsigned long pfn)
 {
 	void *addr;
 	unsigned int bit;
@@ -892,7 +892,7 @@ void swsusp_set_page_free(struct page *page)
 		memory_bm_set_bit(free_pages_map, page_to_pfn(page));
 }
 
-static int swsusp_page_is_free(struct page *page)
+static bool swsusp_page_is_free(struct page *page)
 {
 	return free_pages_map ?
 		memory_bm_test_bit(free_pages_map, page_to_pfn(page)) : 0;
@@ -910,7 +910,7 @@ static void swsusp_set_page_forbidden(struct page *page)
 		memory_bm_set_bit(forbidden_pages_map, page_to_pfn(page));
 }
 
-int swsusp_page_is_forbidden(struct page *page)
+bool swsusp_page_is_forbidden(struct page *page)
 {
 	return forbidden_pages_map ?
 		memory_bm_test_bit(forbidden_pages_map, page_to_pfn(page)) : 0;
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 3d2aa27b845b..f5c45c13d7f1 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1422,9 +1422,9 @@ EXPORT_SYMBOL(radix_tree_delete);
  *	@root:		radix tree root
  *	@tag:		tag to test
  */
-int radix_tree_tagged(struct radix_tree_root *root, unsigned int tag)
+bool radix_tree_tagged(struct radix_tree_root *root, unsigned int tag)
 {
-	return root_tag_get(root, tag);
+	return root_tag_get(root, tag) != 0;
 }
 EXPORT_SYMBOL(radix_tree_tagged);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index bb50cacc3ea5..8c399caf4e4f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1476,31 +1476,31 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
  * to the private version (using protection_map[] without the
  * VM_SHARED bit).
  */
-int vma_wants_writenotify(struct vm_area_struct *vma)
+bool vma_wants_writenotify(struct vm_area_struct *vma)
 {
 	vm_flags_t vm_flags = vma->vm_flags;
 
 	/* If it was private or non-writable, the write bit is already clear */
 	if ((vm_flags & (VM_WRITE|VM_SHARED)) != ((VM_WRITE|VM_SHARED)))
-		return 0;
+		return false;
 
 	/* The backer wishes to know when pages are first written to? */
 	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
-		return 1;
+		return true;
 
 	/* The open routine did something to the protections that pgprot_modify
 	 * won't preserve? */
 	if (pgprot_val(vma->vm_page_prot) !=
 	    pgprot_val(vm_pgprot_modify(vma->vm_page_prot, vm_flags)))
-		return 0;
+		return false;
 
 	/* Do we need to track softdirty? */
 	if (IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) && !(vm_flags & VM_SOFTDIRTY))
-		return 1;
+		return true;
 
 	/* Specialty mapping? */
 	if (vm_flags & VM_PFNMAP)
-		return 0;
+		return false;
 
 	/* Can the mapping track the dirty pages? */
 	return vma->vm_file && vma->vm_file->f_mapping &&
@@ -1511,14 +1511,14 @@ int vma_wants_writenotify(struct vm_area_struct *vma)
  * We account for memory if it's a private writeable mapping,
  * not hugepages and VM_NORESERVE wasn't set.
  */
-static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
+static inline bool accountable_mapping(struct file *file, vm_flags_t vm_flags)
 {
 	/*
 	 * hugetlb has its own accounting separate from the core VM
 	 * VM_HUGETLB may not be set yet so we cannot check for that flag.
 	 */
 	if (file && is_file_hugepages(file))
-		return 0;
+		return false;
 
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
 }
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 5daf5568b9e1..99081a7cdb33 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2081,11 +2081,11 @@ EXPORT_SYMBOL(write_one_page);
 /*
  * For address_spaces which do not use buffers nor write back.
  */
-int __set_page_dirty_no_writeback(struct page *page)
+bool __set_page_dirty_no_writeback(struct page *page)
 {
 	if (!PageDirty(page))
 		return !TestSetPageDirty(page);
-	return 0;
+	return false;
 }
 
 /*
@@ -2141,14 +2141,14 @@ EXPORT_SYMBOL(account_page_cleaned);
  * hold the page lock, but e.g. zap_pte_range() calls with the page mapped and
  * the pte lock held, which also locks out truncation.
  */
-int __set_page_dirty_nobuffers(struct page *page)
+bool __set_page_dirty_nobuffers(struct page *page)
 {
 	if (!TestSetPageDirty(page)) {
 		struct address_space *mapping = page_mapping(page);
 		unsigned long flags;
 
 		if (!mapping)
-			return 1;
+			return true;
 
 		spin_lock_irqsave(&mapping->tree_lock, flags);
 		BUG_ON(page_mapping(page) != mapping);
@@ -2161,9 +2161,9 @@ int __set_page_dirty_nobuffers(struct page *page)
 			/* !PageAnon && !swapper_space */
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 		}
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 EXPORT_SYMBOL(__set_page_dirty_nobuffers);
 
@@ -2190,9 +2190,9 @@ EXPORT_SYMBOL(account_page_redirty);
  * page for some reason, it should redirty the locked page via
  * redirty_page_for_writepage() and it should then unlock the page and return 0
  */
-int redirty_page_for_writepage(struct writeback_control *wbc, struct page *page)
+bool redirty_page_for_writepage(struct writeback_control *wbc, struct page *page)
 {
-	int ret;
+	bool ret;
 
 	wbc->pages_skipped++;
 	ret = __set_page_dirty_nobuffers(page);
@@ -2212,12 +2212,12 @@ EXPORT_SYMBOL(redirty_page_for_writepage);
  * If the mapping doesn't provide a set_page_dirty a_op, then
  * just fall through and assume that it wants buffer_heads.
  */
-int set_page_dirty(struct page *page)
+bool set_page_dirty(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
 
 	if (likely(mapping)) {
-		int (*spd)(struct page *) = mapping->a_ops->set_page_dirty;
+		bool (*spd)(struct page *) = mapping->a_ops->set_page_dirty;
 		/*
 		 * readahead/lru_deactivate_page could remain
 		 * PG_readahead/PG_reclaim due to race with end_page_writeback
@@ -2238,9 +2238,9 @@ int set_page_dirty(struct page *page)
 	}
 	if (!PageDirty(page)) {
 		if (!TestSetPageDirty(page))
-			return 1;
+			return true;
 	}
-	return 0;
+	return false;
 }
 EXPORT_SYMBOL(set_page_dirty);
 
@@ -2254,9 +2254,9 @@ EXPORT_SYMBOL(set_page_dirty);
  *
  * In other cases, the page should be locked before running set_page_dirty().
  */
-int set_page_dirty_lock(struct page *page)
+bool set_page_dirty_lock(struct page *page)
 {
-	int ret;
+	bool ret;
 
 	lock_page(page);
 	ret = set_page_dirty(page);
@@ -2279,7 +2279,7 @@ EXPORT_SYMBOL(set_page_dirty_lock);
  * This incoherency between the page's dirty flag and radix-tree tag is
  * unfortunate, but it only exists while the page is locked.
  */
-int clear_page_dirty_for_io(struct page *page)
+bool clear_page_dirty_for_io(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
 
@@ -2325,19 +2325,19 @@ int clear_page_dirty_for_io(struct page *page)
 			dec_zone_page_state(page, NR_FILE_DIRTY);
 			dec_bdi_stat(inode_to_bdi(mapping->host),
 					BDI_RECLAIMABLE);
-			return 1;
+			return true;
 		}
-		return 0;
+		return false;
 	}
 	return TestClearPageDirty(page);
 }
 EXPORT_SYMBOL(clear_page_dirty_for_io);
 
-int test_clear_page_writeback(struct page *page)
+bool test_clear_page_writeback(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
 	struct mem_cgroup *memcg;
-	int ret;
+	bool ret;
 
 	memcg = mem_cgroup_begin_page_stat(page);
 	if (mapping) {
@@ -2368,11 +2368,11 @@ int test_clear_page_writeback(struct page *page)
 	return ret;
 }
 
-int __test_set_page_writeback(struct page *page, bool keep_write)
+bool __test_set_page_writeback(struct page *page, bool keep_write)
 {
 	struct address_space *mapping = page_mapping(page);
 	struct mem_cgroup *memcg;
-	int ret;
+	bool ret;
 
 	memcg = mem_cgroup_begin_page_stat(page);
 	if (mapping) {
@@ -2414,7 +2414,7 @@ EXPORT_SYMBOL(__test_set_page_writeback);
  * Return true if any of the pages in the mapping are marked with the
  * passed tag.
  */
-int mapping_tagged(struct address_space *mapping, int tag)
+bool mapping_tagged(struct address_space *mapping, int tag)
 {
 	return radix_tree_tagged(&mapping->page_tree, tag);
 }
diff --git a/mm/page_io.c b/mm/page_io.c
index 6424869e275e..73034fb7c51b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -368,7 +368,7 @@ out:
 	return ret;
 }
 
-int swap_set_page_dirty(struct page *page)
+bool swap_set_page_dirty(struct page *page)
 {
 	struct swap_info_struct *sis = page_swap_info(page);
 
