Return-Path: <leonardo@linux.ibm.com>
From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v6 08/11] powerpc/kvm/book3s_hv: Use functions to track lockless pgtbl walks
Date: Thu,  6 Feb 2020 00:08:57 -0300
Message-ID: <20200206030900.147032-9-leonardo@linux.ibm.com>
In-Reply-To: <20200206030900.147032-1-leonardo@linux.ibm.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Leonardo Bras <leonardo@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200206030857.-3uiAKD-t77a5TRIRxqUjaTkmrU_qZOwhDvFeLUTQmk@z>

Applies the new functions for tracking all book3s_hv related
functions that do lockless pagetable walks.

Adds comments explaining that some lockless pagetable walks don't need
protection due to guest pgd not being a target of THP collapse/split, or
due to being called from Realmode + MSR_EE = 0

kvmppc_do_h_enter: Fixes where local_irq_restore() must be placed (after
the last usage of ptep).

Given that some of these functions can be called in real mode, and others
always are, we use __{begin,end}_lockless_pgtbl_walk so we can decide when
to disable interrupts.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_nested.c | 22 ++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 28 ++++++++++++++++++----------
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index dc97e5be76f6..a398061d5778 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -803,7 +803,11 @@ static void kvmhv_update_nest_rmap_rc(struct kvm *kvm, u64 n_rmap,
 	if (!gp)
 		return;
 
-	/* Find the pte */
+	/* Find the pte:
+	 * We are walking the nested guest (partition-scoped) page table here.
+	 * We can do this without disabling irq because the Linux MM
+	 * subsystem doesn't do THP splits and collapses on this tree.
+	 */
 	ptep = __find_linux_pte(gp->shadow_pgtable, gpa, NULL, &shift);
 	/*
 	 * If the pte is present and the pfn is still the same, update the pte.
@@ -853,7 +857,11 @@ static void kvmhv_remove_nest_rmap(struct kvm *kvm, u64 n_rmap,
 	if (!gp)
 		return;
 
-	/* Find and invalidate the pte */
+	/* Find and invalidate the pte:
+	 * We are walking the nested guest (partition-scoped) page table here.
+	 * We can do this without disabling irq because the Linux MM
+	 * subsystem doesn't do THP splits and collapses on this tree.
+	 */
 	ptep = __find_linux_pte(gp->shadow_pgtable, gpa, NULL, &shift);
 	/* Don't spuriously invalidate ptes if the pfn has changed */
 	if (ptep && pte_present(*ptep) && ((pte_val(*ptep) & mask) == hpa))
@@ -921,6 +929,11 @@ static bool kvmhv_invalidate_shadow_pte(struct kvm_vcpu *vcpu,
 	int shift;
 
 	spin_lock(&kvm->mmu_lock);
+	/*
+	 * We are walking the nested guest (partition-scoped) page table here.
+	 * We can do this without disabling irq because the Linux MM
+	 * subsystem doesn't do THP splits and collapses on this tree.
+	 */
 	ptep = __find_linux_pte(gp->shadow_pgtable, gpa, NULL, &shift);
 	if (!shift)
 		shift = PAGE_SHIFT;
@@ -1362,6 +1375,11 @@ static long int __kvmhv_nested_page_fault(struct kvm_run *run,
 	/* See if can find translation in our partition scoped tables for L1 */
 	pte = __pte(0);
 	spin_lock(&kvm->mmu_lock);
+	/*
+	 * We are walking the secondary (partition-scoped) page table here.
+	 * We can do this without disabling irq because the Linux MM
+	 * subsystem doesn't do THP splits and collapses on this tree.
+	 */
 	pte_p = __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 	if (!shift)
 		shift = PAGE_SHIFT;
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 220305454c23..fd4d8f174f09 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -210,7 +210,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	pte_t *ptep;
 	unsigned int writing;
 	unsigned long mmu_seq;
-	unsigned long rcbits, irq_flags = 0;
+	unsigned long rcbits, irq_mask = 0;
 
 	if (kvm_is_radix(kvm))
 		return H_FUNCTION;
@@ -252,8 +252,8 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	 * If we had a page table table change after lookup, we would
 	 * retry via mmu_notifier_retry.
 	 */
-	if (!realmode)
-		local_irq_save(irq_flags);
+	irq_mask = __begin_lockless_pgtbl_walk(!realmode);
+
 	/*
 	 * If called in real mode we have MSR_EE = 0. Otherwise
 	 * we disable irq above.
@@ -272,8 +272,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		 * to <= host page size, if host is using hugepage
 		 */
 		if (host_pte_size < psize) {
-			if (!realmode)
-				local_irq_restore(flags);
+			__end_lockless_pgtbl_walk(irq_mask, !realmode);
 			return H_PARAMETER;
 		}
 		pte = kvmppc_read_update_linux_pte(ptep, writing);
@@ -287,8 +286,6 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 			pa |= gpa & ~PAGE_MASK;
 		}
 	}
-	if (!realmode)
-		local_irq_restore(irq_flags);
 
 	ptel &= HPTE_R_KEY | HPTE_R_PP0 | (psize-1);
 	ptel |= pa;
@@ -302,8 +299,10 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 	/*If we had host pte mapping then  Check WIMG */
 	if (ptep && !hpte_cache_flags_ok(ptel, is_ci)) {
-		if (is_ci)
+		if (is_ci) {
+			__end_lockless_pgtbl_walk(irq_mask, !realmode);
 			return H_PARAMETER;
+		}
 		/*
 		 * Allow guest to map emulated device memory as
 		 * uncacheable, but actually make it cacheable.
@@ -311,6 +310,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		ptel &= ~(HPTE_R_W|HPTE_R_I|HPTE_R_G);
 		ptel |= HPTE_R_M;
 	}
+	__end_lockless_pgtbl_walk(irq_mask, !realmode);
 
 	/* Find and lock the HPTEG slot to use */
  do_insert:
@@ -907,11 +907,19 @@ static int kvmppc_get_hpa(struct kvm_vcpu *vcpu, unsigned long gpa,
 	/* Translate to host virtual address */
 	hva = __gfn_to_hva_memslot(memslot, gfn);
 
-	/* Try to find the host pte for that virtual address */
+	/* Try to find the host pte for that virtual address :
+	 * Called by hcall_real_table (real mode + MSR_EE=0)
+	 * Interrupts are disabled here.
+	 */
+	__begin_lockless_pgtbl_walk(false);
 	ptep = __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
-	if (!ptep)
+	if (!ptep) {
+		__end_lockless_pgtbl_walk(0, false);
 		return H_TOO_HARD;
+	}
 	pte = kvmppc_read_update_linux_pte(ptep, writing);
+	__end_lockless_pgtbl_walk(0, false);
+
 	if (!pte_present(pte))
 		return H_TOO_HARD;
 
-- 
2.24.1
