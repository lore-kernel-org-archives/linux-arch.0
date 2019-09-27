From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v4 11/11] powerpc/mm/book3s64/pgtable: Uses counting method to skip serializing
Date: Fri, 27 Sep 2019 20:40:08 -0300
Message-ID: <20190927234008.11513-12-leonardo@linux.ibm.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190927234008.11513-1-leonardo@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Nicholas Piggin <npiggin@gmail.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Mike Rapoport <rppt@linux.ibm.com>, YueHaibing <yuehaibing@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziep>
List-Id: linux-arch.vger.kernel.org

Skips slow part of serialize_against_pte_lookup if there is no running
lockless pagetable walk.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/mm/book3s64/pgtable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 6ba6195bff1b..27966481f2a6 100644
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
