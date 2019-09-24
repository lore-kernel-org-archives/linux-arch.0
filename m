Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392562AbfIXV0O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Sep 2019 17:26:14 -0400
From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v3 10/11] powerpc/book3s_64: Enables counting method to monitor lockless pgtbl walk
Date: Tue, 24 Sep 2019 18:24:27 -0300
Message-ID: <20190924212427.7734-11-leonardo@linux.ibm.com>
In-Reply-To: <20190924212427.7734-1-leonardo@linux.ibm.com>
References: <20190924212427.7734-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Nicholas Piggin <npiggin@gmail.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Mike Rapoport <rppt@linux.ibm.com>, YueHaibing <yuehaibing@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Keith Busch <keith.busch@intel.com>
Message-ID: <20190924212427.ClPNkAqQ5USUKJrW_rg1l-h0Xnjys2m5Js5Wiabub5Y@z>

Enables count-based monitoring method for lockless pagetable walks on
PowerPC book3s_64.

Other architectures/platforms fallback to using generic dummy functions.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 8308f32e9782..eb9b26a4a483 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1370,5 +1370,10 @@ static inline bool pgd_is_leaf(pgd_t pgd)
 	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
 }
 
+#define __HAVE_ARCH_LOCKLESS_PGTBL_WALK_COUNTER
+void start_lockless_pgtbl_walk(struct mm_struct *mm);
+void end_lockless_pgtbl_walk(struct mm_struct *mm);
+int running_lockless_pgtbl_walk(struct mm_struct *mm);
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
-- 
2.20.1
