From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v5 06/11] powerpc/mm/book3s64/hash: Applies counting method to
 monitor lockless pgtbl walks
Date: Wed,  2 Oct 2019 22:33:20 -0300
Message-ID: <20191003013325.2614-7-leonardo@linux.ibm.com>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20191003013325.2614-1-leonardo@linux.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Allison Randal <allison@lohutok.net>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Leonardo Bras <leonardo@linux.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, Ralph Campbell <rcampbe>
List-Id: linux-arch.vger.kernel.org

Applies the counting-based method for monitoring all hash-related functions
that do lockless pagetable walks.

hash_page_mm: Adds comment that explain that there is no need to
local_int_disable/save given that it is only called from DataAccess
interrupt, so interrupts are already disabled.

local_irq_{save,restore} is already inside {begin,end}_lockless_pgtbl_walk,
so there is no need to repeat it here.

Variable that saves the	irq mask was renamed from flags to irq_mask so it
doesn't lose meaning now it's not directly passed to local_irq_* functions.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/mm/book3s64/hash_tlb.c   |  6 +++---
 arch/powerpc/mm/book3s64/hash_utils.c | 27 +++++++++++++++++----------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
index 4a70d8dd39cd..b0ef67d8c88a 100644
--- a/arch/powerpc/mm/book3s64/hash_tlb.c
+++ b/arch/powerpc/mm/book3s64/hash_tlb.c
@@ -194,7 +194,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 {
 	bool is_thp;
 	int hugepage_shift;
-	unsigned long flags;
+	unsigned long irq_mask;
 
 	start = _ALIGN_DOWN(start, PAGE_SIZE);
 	end = _ALIGN_UP(end, PAGE_SIZE);
@@ -209,7 +209,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 	 * to being hashed). This is not the most performance oriented
 	 * way to do things but is fine for our needs here.
 	 */
-	local_irq_save(flags);
+	irq_mask = begin_lockless_pgtbl_walk(mm);
 	arch_enter_lazy_mmu_mode();
 	for (; start < end; start += PAGE_SIZE) {
 		pte_t *ptep = find_current_mm_pte(mm->pgd, start, &is_thp,
@@ -229,7 +229,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 			hpte_need_flush(mm, start, ptep, pte, hugepage_shift);
 	}
 	arch_leave_lazy_mmu_mode();
-	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm, irq_mask);
 }
 
 void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 6c123760164e..7a01a12a19bb 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1313,12 +1313,16 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 		ea &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
 #endif /* CONFIG_PPC_64K_PAGES */
 
-	/* Get PTE and page size from page tables */
+	/* Get PTE and page size from page tables :
+	 * Called in from DataAccess interrupt (data_access_common: 0x300),
+	 * interrupts are disabled here.
+	 */
+	__begin_lockless_pgtbl_walk(mm, false);
 	ptep = find_linux_pte(pgdir, ea, &is_thp, &hugeshift);
 	if (ptep == NULL || !pte_present(*ptep)) {
 		DBG_LOW(" no PTE !\n");
 		rc = 1;
-		goto bail;
+		goto bail_pgtbl_walk;
 	}
 
 	/* Add _PAGE_PRESENT to the required access perm */
@@ -1331,7 +1335,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 	if (!check_pte_access(access, pte_val(*ptep))) {
 		DBG_LOW(" no access !\n");
 		rc = 1;
-		goto bail;
+		goto bail_pgtbl_walk;
 	}
 
 	if (hugeshift) {
@@ -1355,7 +1359,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 		if (current->mm == mm)
 			check_paca_psize(ea, mm, psize, user_region);
 
-		goto bail;
+		goto bail_pgtbl_walk;
 	}
 
 #ifndef CONFIG_PPC_64K_PAGES
@@ -1429,6 +1433,8 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 #endif
 	DBG_LOW(" -> rc=%d\n", rc);
 
+bail_pgtbl_walk:
+	__end_lockless_pgtbl_walk(mm, 0, false);
 bail:
 	exception_exit(prev_state);
 	return rc;
@@ -1517,7 +1523,7 @@ static void hash_preload(struct mm_struct *mm, unsigned long ea,
 	unsigned long vsid;
 	pgd_t *pgdir;
 	pte_t *ptep;
-	unsigned long flags;
+	unsigned long irq_mask;
 	int rc, ssize, update_flags = 0;
 	unsigned long access = _PAGE_PRESENT | _PAGE_READ | (is_exec ? _PAGE_EXEC : 0);
 
@@ -1539,11 +1545,12 @@ static void hash_preload(struct mm_struct *mm, unsigned long ea,
 	vsid = get_user_vsid(&mm->context, ea, ssize);
 	if (!vsid)
 		return;
+
 	/*
 	 * Hash doesn't like irqs. Walking linux page table with irq disabled
 	 * saves us from holding multiple locks.
 	 */
-	local_irq_save(flags);
+	irq_mask = begin_lockless_pgtbl_walk(mm);
 
 	/*
 	 * THP pages use update_mmu_cache_pmd. We don't do
@@ -1588,7 +1595,7 @@ static void hash_preload(struct mm_struct *mm, unsigned long ea,
 				   mm_ctx_user_psize(&mm->context),
 				   pte_val(*ptep));
 out_exit:
-	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm, irq_mask);
 }
 
 /*
@@ -1651,16 +1658,16 @@ u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address)
 {
 	pte_t *ptep;
 	u16 pkey = 0;
-	unsigned long flags;
+	unsigned long irq_mask;
 
 	if (!mm || !mm->pgd)
 		return 0;
 
-	local_irq_save(flags);
+	irq_mask = begin_lockless_pgtbl_walk(mm);
 	ptep = find_linux_pte(mm->pgd, address, NULL, NULL);
 	if (ptep)
 		pkey = pte_to_pkey_bits(pte_val(READ_ONCE(*ptep)));
-	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm, irq_mask);
 
 	return pkey;
 }
-- 
2.20.1
