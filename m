Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2633537AbfIXV0L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Sep 2019 17:26:11 -0400
From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v3 09/11] powerpc/kvm/book3s_64: Applies counting method to monitor lockless pgtbl walks
Date: Tue, 24 Sep 2019 18:24:26 -0300
Message-ID: <20190924212427.7734-10-leonardo@linux.ibm.com>
In-Reply-To: <20190924212427.7734-1-leonardo@linux.ibm.com>
References: <20190924212427.7734-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Nicholas Piggin <npiggin@gmail.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Mike Rapoport <rppt@linux.ibm.com>, YueHaibing <yuehaibing@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Keith Busch <keith.busch@intel.com>
Message-ID: <20190924212426.xUVonMjQWZuQO_hfRHKLvSjbOH-4GdM5lz3SMrLF-wE@z>

Applies the counting-based method for monitoring all book3s_64-related
functions that do lockless pagetable walks.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c    |  2 ++
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 20 ++++++++++++++++++--
 arch/powerpc/kvm/book3s_64_vio_hv.c    |  4 ++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 9a75f0e1933b..fcd3dad1297f 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -620,6 +620,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			 * We need to protect against page table destruction
 			 * hugepage split and collapse.
 			 */
+			start_lockless_pgtbl_walk(kvm->mm);
 			local_irq_save(flags);
 			ptep = find_current_mm_pte(current->mm->pgd,
 						   hva, NULL, NULL);
@@ -629,6 +630,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 					write_ok = 1;
 			}
 			local_irq_restore(flags);
+			end_lockless_pgtbl_walk(kvm->mm);
 		}
 	}
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 2d415c36a61d..d46f8258d8d6 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -741,6 +741,7 @@ bool kvmppc_hv_handle_set_rc(struct kvm *kvm, pgd_t *pgtable, bool writing,
 	unsigned long pgflags;
 	unsigned int shift;
 	pte_t *ptep;
+	bool ret = false;
 
 	/*
 	 * Need to set an R or C bit in the 2nd-level tables;
@@ -755,12 +756,14 @@ bool kvmppc_hv_handle_set_rc(struct kvm *kvm, pgd_t *pgtable, bool writing,
 	 * We can do this without disabling irq because the Linux MM
 	 * subsystem doesn't do THP splits and collapses on this tree.
 	 */
+	start_lockless_pgtbl_walk(kvm->mm);
 	ptep = __find_linux_pte(pgtable, gpa, NULL, &shift);
 	if (ptep && pte_present(*ptep) && (!writing || pte_write(*ptep))) {
 		kvmppc_radix_update_pte(kvm, ptep, 0, pgflags, gpa, shift);
-		return true;
+		ret = true;
 	}
-	return false;
+	end_lockless_pgtbl_walk(kvm->mm);
+	return ret;
 }
 
 int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
@@ -813,6 +816,7 @@ int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
 	 * Read the PTE from the process' radix tree and use that
 	 * so we get the shift and attribute bits.
 	 */
+	start_lockless_pgtbl_walk(kvm->mm);
 	local_irq_disable();
 	ptep = __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
 	/*
@@ -821,12 +825,14 @@ int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
 	 */
 	if (!ptep) {
 		local_irq_enable();
+		end_lockless_pgtbl_walk(kvm->mm);
 		if (page)
 			put_page(page);
 		return RESUME_GUEST;
 	}
 	pte = *ptep;
 	local_irq_enable();
+	end_lockless_pgtbl_walk(kvm->mm);
 
 	/* If we're logging dirty pages, always map single pages */
 	large_enable = !(memslot->flags & KVM_MEM_LOG_DIRTY_PAGES);
@@ -972,10 +978,12 @@ int kvm_unmap_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	unsigned long gpa = gfn << PAGE_SHIFT;
 	unsigned int shift;
 
+	start_lockless_pgtbl_walk(kvm->mm);
 	ptep = __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 	if (ptep && pte_present(*ptep))
 		kvmppc_unmap_pte(kvm, ptep, gpa, shift, memslot,
 				 kvm->arch.lpid);
+	end_lockless_pgtbl_walk(kvm->mm);
 	return 0;				
 }
 
@@ -989,6 +997,7 @@ int kvm_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	int ref = 0;
 	unsigned long old, *rmapp;
 
+	start_lockless_pgtbl_walk(kvm->mm);
 	ptep = __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 	if (ptep && pte_present(*ptep) && pte_young(*ptep)) {
 		old = kvmppc_radix_update_pte(kvm, ptep, _PAGE_ACCESSED, 0,
@@ -1001,6 +1010,7 @@ int kvm_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 					       1UL << shift);
 		ref = 1;
 	}
+	end_lockless_pgtbl_walk(kvm->mm);
 	return ref;
 }
 
@@ -1013,9 +1023,11 @@ int kvm_test_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	unsigned int shift;
 	int ref = 0;
 
+	start_lockless_pgtbl_walk(kvm->mm);
 	ptep = __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 	if (ptep && pte_present(*ptep) && pte_young(*ptep))
 		ref = 1;
+	end_lockless_pgtbl_walk(kvm->mm);
 	return ref;
 }
 
@@ -1030,6 +1042,7 @@ static int kvm_radix_test_clear_dirty(struct kvm *kvm,
 	int ret = 0;
 	unsigned long old, *rmapp;
 
+	start_lockless_pgtbl_walk(kvm->mm);
 	ptep = __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 	if (ptep && pte_present(*ptep) && pte_dirty(*ptep)) {
 		ret = 1;
@@ -1046,6 +1059,7 @@ static int kvm_radix_test_clear_dirty(struct kvm *kvm,
 					       1UL << shift);
 		spin_unlock(&kvm->mmu_lock);
 	}
+	end_lockless_pgtbl_walk(kvm->mm);
 	return ret;
 }
 
@@ -1084,6 +1098,7 @@ void kvmppc_radix_flush_memslot(struct kvm *kvm,
 
 	gpa = memslot->base_gfn << PAGE_SHIFT;
 	spin_lock(&kvm->mmu_lock);
+	start_lockless_pgtbl_walk(kvm->mm);
 	for (n = memslot->npages; n; --n) {
 		ptep = __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 		if (ptep && pte_present(*ptep))
@@ -1091,6 +1106,7 @@ void kvmppc_radix_flush_memslot(struct kvm *kvm,
 					 kvm->arch.lpid);
 		gpa += PAGE_SIZE;
 	}
+	end_lockless_pgtbl_walk(kvm->mm);
 	spin_unlock(&kvm->mmu_lock);
 }
 
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index b4f20f13b860..d7ea44f28993 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -431,6 +431,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 static long kvmppc_rm_ua_to_hpa(struct kvm_vcpu *vcpu,
 		unsigned long ua, unsigned long *phpa)
 {
+	struct kvm *kvm = vcpu->kvm;
 	pte_t *ptep, pte;
 	unsigned shift = 0;
 
@@ -443,10 +444,13 @@ static long kvmppc_rm_ua_to_hpa(struct kvm_vcpu *vcpu,
 	 * to exit which will agains result in the below page table walk
 	 * to finish.
 	 */
+
+	start_lockless_pgtbl_walk(kvm->mm);
 	ptep = __find_linux_pte(vcpu->arch.pgdir, ua, NULL, &shift);
 	if (!ptep || !pte_present(*ptep))
 		return -ENXIO;
 	pte = *ptep;
+	end_lockless_pgtbl_walk(kvm->mm);
 
 	if (!shift)
 		shift = PAGE_SHIFT;
-- 
2.20.1
