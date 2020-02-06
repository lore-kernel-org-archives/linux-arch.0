Return-Path: <leonardo@linux.ibm.com>
From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v6 05/11] powerpc/perf: Use functions to track lockless pgtbl walks
Date: Thu,  6 Feb 2020 00:08:54 -0300
Message-ID: <20200206030900.147032-6-leonardo@linux.ibm.com>
In-Reply-To: <20200206030900.147032-1-leonardo@linux.ibm.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Leonardo Bras <leonardo@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200206030854.Dv3VOq9VBkAXFuhRKL3QoD_CNKWRF958Ojs9SaS8spc@z>

Applies the new functions used for tracking lockless pgtable walks on
read_user_stack_slow.

local_irq_{save,restore} is already inside {begin,end}_lockless_pgtbl_walk,
so there is no need to repeat it here.

Variable that saves the irq mask was renamed from flags to irq_mask so it
doesn't lose meaning now it's not directly passed to local_irq_* functions.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/perf/callchain.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index cbc251981209..fd9979e69f36 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -116,14 +116,14 @@ static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
 	unsigned shift;
 	unsigned long addr = (unsigned long) ptr;
 	unsigned long offset;
-	unsigned long pfn, flags;
+	unsigned long pfn, irq_mask;
 	void *kaddr;
 
 	pgdir = current->mm->pgd;
 	if (!pgdir)
 		return -EFAULT;
 
-	local_irq_save(flags);
+	irq_mask = begin_lockless_pgtbl_walk();
 	ptep = find_current_mm_pte(pgdir, addr, NULL, &shift);
 	if (!ptep)
 		goto err_out;
@@ -145,7 +145,7 @@ static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
 	memcpy(buf, kaddr + offset, nb);
 	ret = 0;
 err_out:
-	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(irq_mask);
 	return ret;
 }
 
-- 
2.24.1
