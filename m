From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v3 05/11] powerpc/perf: Applies counting method to monitor lockless pgtbl walks
Date: Tue, 24 Sep 2019 18:24:22 -0300
Message-ID: <20190924212427.7734-6-leonardo@linux.ibm.com>
References: <20190924212427.7734-1-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190924212427.7734-1-leonardo@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Nicholas Piggin <npiggin@gmail.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Mike Rapoport <rppt@linux.ibm.com>, YueHaibing <yuehaibing@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziep>
List-Id: linux-arch.vger.kernel.org

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
