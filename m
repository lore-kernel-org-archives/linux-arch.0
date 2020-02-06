Return-Path: <leonardo@linux.ibm.com>
From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v6 11/11] powerpc/mm/book3s64/pgtable: Uses counting method to skip serializing
Date: Thu,  6 Feb 2020 00:09:00 -0300
Message-ID: <20200206030900.147032-12-leonardo@linux.ibm.com>
In-Reply-To: <20200206030900.147032-1-leonardo@linux.ibm.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Leonardo Bras <leonardo@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200206030900.uiAsp0cVDLzvYRwZV3jm2x2ulm-eddrUMvis0jHRNZc@z>

For each cpu in cpumask, checks if it's running a lockless pagetable
walk. Then, run serialize_against_pte_lookup() only on these cpus.

serialize_agains_pte_lookup() can take a long while when there are a
lot of cpus in cpumask.

This method is intended to reduce this waiting, while not impacting
too much on the lockless pagetable walk.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/mm/book3s64/pgtable.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index bb138b628f86..4822ff1aac4b 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -96,8 +96,22 @@ static DEFINE_PER_CPU(int, lockless_pgtbl_walk_counter);
  */
 void serialize_against_pte_lookup(struct mm_struct *mm)
 {
+	int cpu;
+	struct cpumask cm;
+
 	smp_mb();
-	smp_call_function_many(mm_cpumask(mm), do_nothing, NULL, 1);
+
+	/*
+	 * Fills a new cpumask only with cpus that are currently doing a
+	 * lockless pagetable walk. This reduces time spent in this function.
+	 */
+	cpumask_clear(&cm);
+	for_each_cpu(cpu, mm_cpumask((mm))) {
+		if (per_cpu(lockless_pgtbl_walk_counter, cpu) > 0)
+			cpumask_set_cpu(cpu, &cm);
+	}
+
+	smp_call_function_many(&cm, do_nothing, NULL, 1);
 }
 
 /* begin_lockless_pgtbl_walk: Must be inserted before a function call that does
-- 
2.24.1
