From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v5 08/11] powerpc/kvm/book3s_hv: Applies counting method to
 monitor lockless pgtbl walks
Date: Wed,  2 Oct 2019 22:33:22 -0300
Message-ID: <20191003013325.2614-9-leonardo@linux.ibm.com>
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

Applies the counting-based method for monitoring all book3s_hv related
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
 arch/powerpc/kvm/book3s_hv_nested.c | 22 ++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 32 ++++++++++++++++-------------
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index cdf30c6eaf54..89944c699fd6 100644
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
index 220305454c23..a8be42f5be1e 100644
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
@@ -252,12 +252,8 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	 * If we had a page table table change after lookup, we would
 	 * retry via mmu_notifier_retry.
 	 */
-	if (!realmode)
-		local_irq_save(irq_flags);
-	/*
-	 * If called in real mode we have MSR_EE = 0. Otherwise
-	 * we disable irq above.
-	 */
+	irq_mask = __begin_lockless_pgtbl_walk(kvm->mm, !realmode);
+
 	ptep = __find_linux_pte(pgdir, hva, NULL, &hpage_shift);
 	if (ptep) {
 		pte_t pte;
@@ -272,8 +268,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		 * to <= host page size, if host is using hugepage
 		 */
 		if (host_pte_size < psize) {
-			if (!realmode)
-				local_irq_restore(flags);
+			__end_lockless_pgtbl_walk(kvm->mm, irq_mask, !realmode);
 			return H_PARAMETER;
 		}
 		pte = kvmppc_read_update_linux_pte(ptep, writing);
@@ -287,8 +282,6 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 			pa |= gpa & ~PAGE_MASK;
 		}
 	}
-	if (!realmode)
-		local_irq_restore(irq_flags);
 
 	ptel &= HPTE_R_KEY | HPTE_R_PP0 | (psize-1);
 	ptel |= pa;
@@ -302,8 +295,10 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 	/*If we had host pte mapping then  Check WIMG */
 	if (ptep && !hpte_cache_flags_ok(ptel, is_ci)) {
-		if (is_ci)
+		if (is_ci) {
+			__end_lockless_pgtbl_walk(kvm->mm, irq_mask, !realmode);
 			return H_PARAMETER;
+		}
 		/*
 		 * Allow guest to map emulated device memory as
 		 * uncacheable, but actually make it cacheable.
@@ -311,6 +306,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		ptel &= ~(HPTE_R_W|HPTE_R_I|HPTE_R_G);
 		ptel |= HPTE_R_M;
 	}
+	__end_lockless_pgtbl_walk(kvm->mm, irq_mask, !realmode);
 
 	/* Find and lock the HPTEG slot to use */
  do_insert:
@@ -907,11 +903,19 @@ static int kvmppc_get_hpa(struct kvm_vcpu *vcpu, unsigned long gpa,
 	/* Translate to host virtual address */
 	hva = __gfn_to_hva_memslot(memslot, gfn);
 
-	/* Try to find the host pte for that virtual address */
+	/* Try to find the host pte for that virtual address :
+	 * Called by hcall_real_table (real mode + MSR_EE=0)
+	 * Interrupts are disabled here.
+	 */
+	__begin_lockless_pgtbl_walk(kvm->mm, false);
 	ptep = __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
-	if (!ptep)
+	if (!ptep) {
+		__end_lockless_pgtbl_walk(kvm->mm, 0, false);
 		return H_TOO_HARD;
+	}
 	pte = kvmppc_read_update_linux_pte(ptep, writing);
+	__end_lockless_pgtbl_walk(kvm->mm, 0, false);
+
 	if (!pte_present(pte))
 		return H_TOO_HARD;
 
-- 
2.20.1
