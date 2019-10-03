From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v5 09/11] powerpc/kvm/book3s_64: Applies counting method to
 monitor lockless pgtbl walks
Date: Wed,  2 Oct 2019 22:33:23 -0300
Message-ID: <20191003013325.2614-10-leonardo@linux.ibm.com>
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

Applies the counting-based method for monitoring all book3s_64-related
functions that do lockless pagetable walks.

Adds comments explaining that some lockless pagetable walks don't need
protection due to guest pgd not being a target of THP collapse/split, or
due to being called from Realmode + MSR_EE = 0.

Given that some of these functions always are called in realmode,  we use
__{begin,end}_lockless_pgtbl_walk so we can decide when to disable
interrupts.

local_irq_{save,restore} is already inside {begin,end}_lockless_pgtbl_walk,
so there is no need to repeat it here.

Variable that saves the	irq mask was renamed from flags to irq_mask so it
doesn't lose meaning now it's not directly passed to local_irq_* functions.

There are also a function that uses local_irq_{en,dis}able, so the return
value of begin_lockless_pgtbl_walk() is ignored and we pass IRQS_ENABLED to
end_lockless_pgtbl_walk() to mimic the effect of local_irq_enable().

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c    |  6 ++---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 34 +++++++++++++++++++++++---
 arch/powerpc/kvm/book3s_64_vio_hv.c    |  7 +++++-
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 9a75f0e1933b..d8f374c979f5 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -615,12 +615,12 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		/* if the guest wants write access, see if that is OK */
 		if (!writing && hpte_is_writable(r)) {
 			pte_t *ptep, pte;
-			unsigned long flags;
+			unsigned long irq_mask;
 			/*
 			 * We need to protect against page table destruction
 			 * hugepage split and collapse.
 			 */
-			local_irq_save(flags);
+			irq_mask = begin_lockless_pgtbl_walk(kvm->mm);
 			ptep = find_current_mm_pte(current->mm->pgd,
 						   hva, NULL, NULL);
 			if (ptep) {
@@ -628,7 +628,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				if (__pte_write(pte))
 					write_ok = 1;
 			}
-			local_irq_restore(flags);
+			end_lockless_pgtbl_walk(kvm->mm, irq_mask);
 		}
 	}
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 2d415c36a61d..8ba9742e2fc8 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -813,20 +813,20 @@ int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
 	 * Read the PTE from the process' radix tree and use that
 	 * so we get the shift and attribute bits.
 	 */
-	local_irq_disable();
+	begin_lockless_pgtbl_walk(kvm->mm);
 	ptep = __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
 	/*
 	 * If the PTE disappeared temporarily due to a THP
 	 * collapse, just return and let the guest try again.
 	 */
 	if (!ptep) {
-		local_irq_enable();
+		end_lockless_pgtbl_walk(kvm->mm, IRQS_ENABLED);
 		if (page)
 			put_page(page);
 		return RESUME_GUEST;
 	}
 	pte = *ptep;
-	local_irq_enable();
+	end_lockless_pgtbl_walk(kvm->mm, IRQS_ENABLED);
 
 	/* If we're logging dirty pages, always map single pages */
 	large_enable = !(memslot->flags & KVM_MEM_LOG_DIRTY_PAGES);
@@ -972,10 +972,16 @@ int kvm_unmap_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	unsigned long gpa = gfn << PAGE_SHIFT;
 	unsigned int shift;
 
+	/*
+	 * We are walking the secondary (partition-scoped) page table here.
+	 * We can do this without disabling irq because the Linux MM
+	 * subsystem doesn't do THP splits and collapses on this tree.
+	 */
 	ptep = __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 	if (ptep && pte_present(*ptep))
 		kvmppc_unmap_pte(kvm, ptep, gpa, shift, memslot,
 				 kvm->arch.lpid);
+
 	return 0;				
 }
 
@@ -989,6 +995,11 @@ int kvm_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	int ref = 0;
 	unsigned long old, *rmapp;
 
+	/*
+	 * We are walking the secondary (partition-scoped) page table here.
+	 * We can do this without disabling irq because the Linux MM
+	 * subsystem doesn't do THP splits and collapses on this tree.
+	 */
 	ptep = __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 	if (ptep && pte_present(*ptep) && pte_young(*ptep)) {
 		old = kvmppc_radix_update_pte(kvm, ptep, _PAGE_ACCESSED, 0,
@@ -1013,6 +1024,11 @@ int kvm_test_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	unsigned int shift;
 	int ref = 0;
 
+	/*
+	 * We are walking the secondary (partition-scoped) page table here.
+	 * We can do this without disabling irq because the Linux MM
+	 * subsystem doesn't do THP splits and collapses on this tree.
+	 */
 	ptep = __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 	if (ptep && pte_present(*ptep) && pte_young(*ptep))
 		ref = 1;
@@ -1030,6 +1046,11 @@ static int kvm_radix_test_clear_dirty(struct kvm *kvm,
 	int ret = 0;
 	unsigned long old, *rmapp;
 
+	/*
+	 * We are walking the secondary (partition-scoped) page table here.
+	 * We can do this without disabling irq because the Linux MM
+	 * subsystem doesn't do THP splits and collapses on this tree.
+	 */
 	ptep = __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 	if (ptep && pte_present(*ptep) && pte_dirty(*ptep)) {
 		ret = 1;
@@ -1046,6 +1067,7 @@ static int kvm_radix_test_clear_dirty(struct kvm *kvm,
 					       1UL << shift);
 		spin_unlock(&kvm->mmu_lock);
 	}
+
 	return ret;
 }
 
@@ -1085,6 +1107,12 @@ void kvmppc_radix_flush_memslot(struct kvm *kvm,
 	gpa = memslot->base_gfn << PAGE_SHIFT;
 	spin_lock(&kvm->mmu_lock);
 	for (n = memslot->npages; n; --n) {
+		/*
+		 * We are walking the secondary (partition-scoped) page table
+		 * here.
+		 * We can do this without disabling irq because the Linux MM
+		 * subsystem doesn't do THP splits and collapses on this tree.
+		 */
 		ptep = __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 		if (ptep && pte_present(*ptep))
 			kvmppc_unmap_pte(kvm, ptep, gpa, shift, memslot,
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index ab6eeb8e753e..0091c3d0ce89 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -441,6 +441,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 static long kvmppc_rm_ua_to_hpa(struct kvm_vcpu *vcpu,
 		unsigned long ua, unsigned long *phpa)
 {
+	struct kvm *kvm = vcpu->kvm;
 	pte_t *ptep, pte;
 	unsigned shift = 0;
 
@@ -453,10 +454,14 @@ static long kvmppc_rm_ua_to_hpa(struct kvm_vcpu *vcpu,
 	 * to exit which will agains result in the below page table walk
 	 * to finish.
 	 */
+	__begin_lockless_pgtbl_walk(kvm->mm, false);
 	ptep = __find_linux_pte(vcpu->arch.pgdir, ua, NULL, &shift);
-	if (!ptep || !pte_present(*ptep))
+	if (!ptep || !pte_present(*ptep)) {
+		__end_lockless_pgtbl_walk(kvm->mm, 0, false);
 		return -ENXIO;
+	}
 	pte = *ptep;
+	__end_lockless_pgtbl_walk(kvm->mm, 0, false);
 
 	if (!shift)
 		shift = PAGE_SHIFT;
-- 
2.20.1
