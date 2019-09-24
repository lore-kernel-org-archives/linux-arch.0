Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2441445AbfIXVZ6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Sep 2019 17:25:58 -0400
From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v3 06/11] powerpc/mm/book3s64/hash: Applies counting method to monitor lockless pgtbl walks
Date: Tue, 24 Sep 2019 18:24:23 -0300
Message-ID: <20190924212427.7734-7-leonardo@linux.ibm.com>
In-Reply-To: <20190924212427.7734-1-leonardo@linux.ibm.com>
References: <20190924212427.7734-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Nicholas Piggin <npiggin@gmail.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Mike Rapoport <rppt@linux.ibm.com>, YueHaibing <yuehaibing@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Keith Busch <keith.busch@intel.com>
Message-ID: <20190924212423.TVXPNNi3mNVao6PKeaaPEj2AnLmPeGNuPtItT9JB9Ts@z>

Applies the counting-based method for monitoring all hash-related functions
that do lockless pagetable walks.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/mm/book3s64/hash_tlb.c   | 2 ++
 arch/powerpc/mm/book3s64/hash_utils.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
index 4a70d8dd39cd..5e5213c3f7c4 100644
--- a/arch/powerpc/mm/book3s64/hash_tlb.c
+++ b/arch/powerpc/mm/book3s64/hash_tlb.c
@@ -209,6 +209,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 	 * to being hashed). This is not the most performance oriented
 	 * way to do things but is fine for our needs here.
 	 */
+	start_lockless_pgtbl_walk(mm);
 	local_irq_save(flags);
 	arch_enter_lazy_mmu_mode();
 	for (; start < end; start += PAGE_SIZE) {
@@ -230,6 +231,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 	}
 	arch_leave_lazy_mmu_mode();
 	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm);
 }
 
 void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index b8ad14bb1170..299946cedc3a 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1322,6 +1322,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 #endif /* CONFIG_PPC_64K_PAGES */
 
 	/* Get PTE and page size from page tables */
+	start_lockless_pgtbl_walk(mm);
 	ptep = find_linux_pte(pgdir, ea, &is_thp, &hugeshift);
 	if (ptep == NULL || !pte_present(*ptep)) {
 		DBG_LOW(" no PTE !\n");
@@ -1438,6 +1439,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 	DBG_LOW(" -> rc=%d\n", rc);
 
 bail:
+	end_lockless_pgtbl_walk(mm);
 	exception_exit(prev_state);
 	return rc;
 }
@@ -1547,10 +1549,12 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	vsid = get_user_vsid(&mm->context, ea, ssize);
 	if (!vsid)
 		return;
+
 	/*
 	 * Hash doesn't like irqs. Walking linux page table with irq disabled
 	 * saves us from holding multiple locks.
 	 */
+	start_lockless_pgtbl_walk(mm);
 	local_irq_save(flags);
 
 	/*
@@ -1597,6 +1601,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 				   pte_val(*ptep));
 out_exit:
 	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm);
 }
 
 #ifdef CONFIG_PPC_MEM_KEYS
@@ -1613,11 +1618,13 @@ u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address)
 	if (!mm || !mm->pgd)
 		return 0;
 
+	start_lockless_pgtbl_walk(mm);
 	local_irq_save(flags);
 	ptep = find_linux_pte(mm->pgd, address, NULL, NULL);
 	if (ptep)
 		pkey = pte_to_pkey_bits(pte_val(READ_ONCE(*ptep)));
 	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm);
 
 	return pkey;
 }
-- 
2.20.1
