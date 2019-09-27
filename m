Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728712AbfI0Xlj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 19:41:39 -0400
From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v4 10/11] powerpc/book3s_64: Enables counting method to monitor lockless pgtbl walk
Date: Fri, 27 Sep 2019 20:40:07 -0300
Message-ID: <20190927234008.11513-11-leonardo@linux.ibm.com>
In-Reply-To: <20190927234008.11513-1-leonardo@linux.ibm.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Nicholas Piggin <npiggin@gmail.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Mike Rapoport <rppt@linux.ibm.com>, YueHaibing <yuehaibing@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Keith Busch <keith.busch@intel.com>
Message-ID: <20190927234007.BcTpzRQtVM1ryid_NI64PP7igYReFiQFP4d0Shg53vc@z>

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
