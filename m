Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728558AbfI0XlS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 19:41:18 -0400
From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v4 05/11] powerpc/perf: Applies counting method to monitor lockless pgtbl walks
Date: Fri, 27 Sep 2019 20:40:02 -0300
Message-ID: <20190927234008.11513-6-leonardo@linux.ibm.com>
In-Reply-To: <20190927234008.11513-1-leonardo@linux.ibm.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Nicholas Piggin <npiggin@gmail.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Mike Rapoport <rppt@linux.ibm.com>, YueHaibing <yuehaibing@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Keith Busch <keith.busch@intel.com>
Message-ID: <20190927234002.OkEB1dO-Yg-6rgn4uOGYCnGB2X-OIMVocildJ0_Qpg4@z>

Applies the counting-based method for monitoring lockless pgtable walks on
read_user_stack_slow.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/perf/callchain.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index c84bbd4298a0..9d76194a2a8f 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -113,16 +113,18 @@ static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
 	int ret = -EFAULT;
 	pgd_t *pgdir;
 	pte_t *ptep, pte;
+	struct mm_struct *mm = current->mm;
 	unsigned shift;
 	unsigned long addr = (unsigned long) ptr;
 	unsigned long offset;
 	unsigned long pfn, flags;
 	void *kaddr;
 
-	pgdir = current->mm->pgd;
+	pgdir = mm->pgd;
 	if (!pgdir)
 		return -EFAULT;
 
+	start_lockless_pgtbl_walk(mm);
 	local_irq_save(flags);
 	ptep = find_current_mm_pte(pgdir, addr, NULL, &shift);
 	if (!ptep)
@@ -146,6 +148,7 @@ static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
 	ret = 0;
 err_out:
 	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm);
 	return ret;
 }
 
-- 
2.20.1
