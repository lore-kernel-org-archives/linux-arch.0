Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633530AbfIXV0J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Sep 2019 17:26:09 -0400
From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v3 07/11] powerpc/kvm/e500: Applies counting method to monitor lockless pgtbl walks
Date: Tue, 24 Sep 2019 18:24:24 -0300
Message-ID: <20190924212427.7734-8-leonardo@linux.ibm.com>
In-Reply-To: <20190924212427.7734-1-leonardo@linux.ibm.com>
References: <20190924212427.7734-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Nicholas Piggin <npiggin@gmail.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Mike Rapoport <rppt@linux.ibm.com>, YueHaibing <yuehaibing@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Keith Busch <keith.busch@intel.com>
Message-ID: <20190924212424.LdILvTK43PBdkVBnN32h7TGa-BXjHSuJIxB3mDmiDDc@z>

Applies the counting-based method for monitoring lockless pgtable walks on
kvmppc_e500_shadow_map().

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/kvm/e500_mmu_host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 321db0fdb9db..a1b8bfe20bc8 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -473,6 +473,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	 * We are holding kvm->mmu_lock so a notifier invalidate
 	 * can't run hence pfn won't change.
 	 */
+	start_lockless_pgtbl_walk(kvm->mm);
 	local_irq_save(flags);
 	ptep = find_linux_pte(pgdir, hva, NULL, NULL);
 	if (ptep) {
@@ -484,12 +485,15 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 			local_irq_restore(flags);
 		} else {
 			local_irq_restore(flags);
+			end_lockless_pgtbl_walk(kvm->mm);
 			pr_err_ratelimited("%s: pte not present: gfn %lx,pfn %lx\n",
 					   __func__, (long)gfn, pfn);
 			ret = -EINVAL;
 			goto out;
 		}
 	}
+	end_lockless_pgtbl_walk(kvm->mm);
+
 	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
 
 	kvmppc_e500_setup_stlbe(&vcpu_e500->vcpu, gtlbe, tsize,
-- 
2.20.1
