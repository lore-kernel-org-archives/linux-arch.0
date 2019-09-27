Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42378 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728558AbfI0XlX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 19:41:23 -0400
From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v4 04/11] powerpc/mce_power: Applies counting method to monitor lockless pgtbl walks
Date: Fri, 27 Sep 2019 20:40:01 -0300
Message-ID: <20190927234008.11513-5-leonardo@linux.ibm.com>
In-Reply-To: <20190927234008.11513-1-leonardo@linux.ibm.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Nicholas Piggin <npiggin@gmail.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Mike Rapoport <rppt@linux.ibm.com>, YueHaibing <yuehaibing@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Keith Busch <keith.busch@intel.com>
Message-ID: <20190927234001.yqvfR-ZTmOS_O2_OVusLtH6FjJXe1e12HJQPKjXwKgs@z>

Applies the counting-based method for monitoring lockless pgtable walks on
addr_to_pfn().

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/kernel/mce_power.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index a814d2dfb5b0..0f2f87da4cd1 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -27,6 +27,7 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 {
 	pte_t *ptep;
 	unsigned long flags;
+	unsigned long pfn;
 	struct mm_struct *mm;
 
 	if (user_mode(regs))
@@ -34,15 +35,21 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 	else
 		mm = &init_mm;
 
+	start_lockless_pgtbl_walk(mm);
 	local_irq_save(flags);
 	if (mm == current->mm)
 		ptep = find_current_mm_pte(mm->pgd, addr, NULL, NULL);
 	else
 		ptep = find_init_mm_pte(addr, NULL);
-	local_irq_restore(flags);
+
 	if (!ptep || pte_special(*ptep))
-		return ULONG_MAX;
-	return pte_pfn(*ptep);
+		pfn = ULONG_MAX;
+	else
+		pfn = pte_pfn(*ptep);
+
+	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm);
+	return pfn;
 }
 
 /* flush SLBs and reload */
-- 
2.20.1
