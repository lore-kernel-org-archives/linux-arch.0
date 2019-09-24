Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633554AbfIXV0W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Sep 2019 17:26:22 -0400
From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v3 11/11] powerpc/mm/book3s64/pgtable: Uses counting method to skip serializing
Date: Tue, 24 Sep 2019 18:24:28 -0300
Message-ID: <20190924212427.7734-12-leonardo@linux.ibm.com>
In-Reply-To: <20190924212427.7734-1-leonardo@linux.ibm.com>
References: <20190924212427.7734-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Nicholas Piggin <npiggin@gmail.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Mike Rapoport <rppt@linux.ibm.com>, YueHaibing <yuehaibing@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Keith Busch <keith.busch@intel.com>
Message-ID: <20190924212428.i_yyuibtz5V9-24_hnGpNVNpYwQsdORu_YRb9SVJwQ8@z>

Skips slow part of serialize_against_pte_lookup if there is no running
lockless pagetable walk.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/mm/book3s64/pgtable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 0b86884a8097..e2aa6572f03f 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -95,7 +95,8 @@ static void do_nothing(void *unused)
 void serialize_against_pte_lookup(struct mm_struct *mm)
 {
 	smp_mb();
-	smp_call_function_many(mm_cpumask(mm), do_nothing, NULL, 1);
+	if (running_lockless_pgtbl_walk(mm))
+		smp_call_function_many(mm_cpumask(mm), do_nothing, NULL, 1);
 }
 
 /*
-- 
2.20.1
