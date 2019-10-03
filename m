From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v5 02/11] powerpc/mm: Adds counting method to monitor lockless
 pgtable walks
Date: Wed,  2 Oct 2019 22:33:16 -0300
Message-ID: <20191003013325.2614-3-leonardo@linux.ibm.com>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20191003013325.2614-1-leonardo@linux.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Allison Randal <allison@lohutok.net>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Leonardo Bras <leonardo@linux.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, Ralph Campbell <rcampbe>
List-Id: linux-arch.vger.kernel.org

It's necessary to monitor lockless pagetable walks, in order to avoid doing
THP splitting/collapsing during them.

On powerpc, we need to do some lockless pagetable walks from functions
that already have disabled interrupts, specially from real mode with
MSR[EE=0].

In these contexts, disabling/enabling interrupts can be very troubling.

So, this arch-specific implementation features functions with an extra
argument that allows interrupt enable/disable to be skipped:
__begin_lockless_pgtbl_walk() and __end_lockless_pgtbl_walk().

Functions similar to the generic ones are also exported, by calling
the above functions with parameter *able_irq = false.

While there is no config option, the method is disabled and these functions
are only doing what was already needed to lockless pagetable walks
(disabling interrupt). A memory barrier was also added just to make sure
there is no speculative read outside the interrupt disabled area.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |   9 ++
 arch/powerpc/mm/book3s64/pgtable.c           | 117 +++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index b01624e5c467..8330b35cd28d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1372,5 +1372,14 @@ static inline bool pgd_is_leaf(pgd_t pgd)
 	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
 }
 
+#define __HAVE_ARCH_LOCKLESS_PGTBL_WALK_CONTROL
+unsigned long begin_lockless_pgtbl_walk(struct mm_struct *mm);
+unsigned long __begin_lockless_pgtbl_walk(struct mm_struct *mm,
+					  bool disable_irq);
+void end_lockless_pgtbl_walk(struct mm_struct *mm, unsigned long irq_mask);
+void __end_lockless_pgtbl_walk(struct mm_struct *mm, unsigned long irq_mask,
+			       bool enable_irq);
+int running_lockless_pgtbl_walk(struct mm_struct *mm);
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 75483b40fcb1..ae557fdce9a3 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -98,6 +98,123 @@ void serialize_against_pte_lookup(struct mm_struct *mm)
 	smp_call_function_many(mm_cpumask(mm), do_nothing, NULL, 1);
 }
 
+/*
+ * Counting method to monitor lockless pagetable walks:
+ * Uses begin_lockless_pgtbl_walk and end_lockless_pgtbl_walk to track the
+ * number of lockless pgtable walks happening, and
+ * running_lockless_pgtbl_walk to return this value.
+ */
+
+/* begin_lockless_pgtbl_walk: Must be inserted before a function call that does
+ *   lockless pagetable walks, such as __find_linux_pte().
+ * This version allows setting disable_irq=false, so irqs are not touched, which
+ *   is quite useful for running when ints are already disabled (like real-mode)
+ */
+
+inline unsigned long __begin_lockless_pgtbl_walk(struct mm_struct *mm,
+						 bool disable_irq)
+{
+	unsigned long irq_mask = 0;
+
+	if (IS_ENABLED(CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING))
+		atomic_inc(&mm->lockless_pgtbl_walkers);
+
+	/*
+	 * Interrupts must be disabled during the lockless page table walk.
+	 * That's because the deleting or splitting involves flushing TLBs,
+	 * which in turn issues interrupts, that will block when disabled.
+	 *
+	 * When this function is called from realmode with MSR[EE=0],
+	 * it's not needed to touch irq, since it's already disabled.
+	 */
+	if (disable_irq)
+		local_irq_save(irq_mask);
+
+	/*
+	 * This memory barrier pairs with any code that is either trying to
+	 * delete page tables, or split huge pages. Without this barrier,
+	 * the page tables could be read speculatively outside of interrupt
+	 * disabling or reference counting.
+	 */
+	smp_mb();
+
+	return irq_mask;
+}
+EXPORT_SYMBOL(__begin_lockless_pgtbl_walk);
+
+/* begin_lockless_pgtbl_walk: Must be inserted before a function call that does
+ *   lockless pagetable walks, such as __find_linux_pte().
+ * This version is used by generic code, and always assume irqs being disabled
+ */
+unsigned long begin_lockless_pgtbl_walk(struct mm_struct *mm)
+{
+	return __begin_lockless_pgtbl_walk(mm, true);
+}
+EXPORT_SYMBOL(begin_lockless_pgtbl_walk);
+
+/*
+ * __end_lockless_pgtbl_walk: Must be inserted after the last use of a pointer
+ *   returned by a lockless pagetable walk, such as __find_linux_pte()
+ * This version allows setting enable_irq=false, so irqs are not touched, which
+ *   is quite useful for running when ints are already disabled (like real-mode)
+ */
+inline void __end_lockless_pgtbl_walk(struct mm_struct *mm,
+				      unsigned long irq_mask, bool enable_irq)
+{
+	/*
+	 * This memory barrier pairs with any code that is either trying to
+	 * delete page tables, or split huge pages. Without this barrier,
+	 * the page tables could be read speculatively outside of interrupt
+	 * disabling or reference counting.
+	 */
+	smp_mb();
+
+	/*
+	 * Interrupts must be disabled during the lockless page table walk.
+	 * That's because the deleting or splitting involves flushing TLBs,
+	 * which in turn issues interrupts, that will block when disabled.
+	 *
+	 * When this function is called from realmode with MSR[EE=0],
+	 * it's not needed to touch irq, since it's already disabled.
+	 */
+	if (enable_irq)
+		local_irq_restore(irq_mask);
+
+	if (IS_ENABLED(CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING))
+		atomic_dec(&mm->lockless_pgtbl_walkers);
+}
+EXPORT_SYMBOL(__end_lockless_pgtbl_walk);
+
+/*
+ * end_lockless_pgtbl_walk: Must be inserted after the last use of a pointer
+ *   returned by a lockless pagetable walk, such as __find_linux_pte()
+ * This version is used by generic code, and always assume irqs being enabled
+ */
+
+void end_lockless_pgtbl_walk(struct mm_struct *mm, unsigned long irq_mask)
+{
+	__end_lockless_pgtbl_walk(mm, irq_mask, true);
+}
+EXPORT_SYMBOL(end_lockless_pgtbl_walk);
+
+/*
+ * running_lockless_pgtbl_walk: Returns the number of lockless pagetable walks
+ *   currently running. If it returns 0, there is no running pagetable walk, and
+ *   THP split/collapse can be safely done. This can be used to avoid more
+ *   expensive approaches like serialize_against_pte_lookup()
+ */
+int running_lockless_pgtbl_walk(struct mm_struct *mm)
+{
+	if (IS_ENABLED(CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING))
+		return atomic_read(&mm->lockless_pgtbl_walkers);
+
+	/* If disabled, must return > 0, so it fallback to sync method
+	 * (serialize_against_pte_lookup)
+	 */
+	return 1;
+}
+EXPORT_SYMBOL(running_lockless_pgtbl_walk);
+
 /*
  * We use this to invalidate a pmdp entry before switching from a
  * hugepte to regular pmd entry.
-- 
2.20.1
