From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v6 03/11] powerpc/mm: Adds arch-specificic functions to track lockless pgtable walks
Date: Thu,  6 Feb 2020 00:08:52 -0300
Message-ID: <20200206030900.147032-4-leonardo@linux.ibm.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-ppc-owner@vger.kernel.org>
In-Reply-To: <20200206030900.147032-1-leonardo@linux.ibm.com>
Sender: kvm-ppc-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Leonardo Bras <leonardo@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@su>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On powerpc, we need to do some lockless pagetable walks from functions
that already have disabled interrupts, specially from real mode with
MSR[EE=0].

In these contexts, disabling/enabling interrupts can be very troubling.

So, this arch-specific implementation features functions with an extra
argument that allows interrupt enable/disable to be skipped:
__begin_lockless_pgtbl_walk() and __end_lockless_pgtbl_walk().

Functions similar to the generic ones are also exported, by calling
the above functions with parameter {en,dis}able_irq = true.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  6 ++
 arch/powerpc/mm/book3s64/pgtable.c           | 86 +++++++++++++++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 201a69e6a355..78f6ffb1bb3e 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1375,5 +1375,11 @@ static inline bool pgd_is_leaf(pgd_t pgd)
 	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
 }
 
+#define __HAVE_ARCH_LOCKLESS_PGTBL_WALK_CONTROL
+unsigned long begin_lockless_pgtbl_walk(void);
+unsigned long __begin_lockless_pgtbl_walk(bool disable_irq);
+void end_lockless_pgtbl_walk(unsigned long irq_mask);
+void __end_lockless_pgtbl_walk(unsigned long irq_mask, bool enable_irq);
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 2bf7e1b4fd82..535613030363 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -82,6 +82,7 @@ static void do_nothing(void *unused)
 {
 
 }
+
 /*
  * Serialize against find_current_mm_pte which does lock-less
  * lookup in page tables with local interrupts disabled. For huge pages
@@ -98,6 +99,89 @@ void serialize_against_pte_lookup(struct mm_struct *mm)
 	smp_call_function_many(mm_cpumask(mm), do_nothing, NULL, 1);
 }
 
+/* begin_lockless_pgtbl_walk: Must be inserted before a function call that does
+ *   lockless pagetable walks, such as __find_linux_pte().
+ * This version allows setting disable_irq=false, so irqs are not touched, which
+ *   is quite useful for running when ints are already disabled (like real-mode)
+ */
+inline
+unsigned long __begin_lockless_pgtbl_walk(bool disable_irq)
+{
+	unsigned long irq_mask = 0;
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
+ * This version is used by generic code, and always assume irqs will be disabled
+ */
+unsigned long begin_lockless_pgtbl_walk(void)
+{
+	return __begin_lockless_pgtbl_walk(true);
+}
+EXPORT_SYMBOL(begin_lockless_pgtbl_walk);
+
+/*
+ * __end_lockless_pgtbl_walk: Must be inserted after the last use of a pointer
+ *   returned by a lockless pagetable walk, such as __find_linux_pte()
+ * This version allows setting enable_irq=false, so irqs are not touched, which
+ *   is quite useful for running when ints are already disabled (like real-mode)
+ */
+inline void __end_lockless_pgtbl_walk(unsigned long irq_mask, bool enable_irq)
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
+}
+EXPORT_SYMBOL(__end_lockless_pgtbl_walk);
+
+/*
+ * end_lockless_pgtbl_walk: Must be inserted after the last use of a pointer
+ *   returned by a lockless pagetable walk, such as __find_linux_pte()
+ * This version is used by generic code, and always assume irqs will be enabled
+ */
+void end_lockless_pgtbl_walk(unsigned long irq_mask)
+{
+	__end_lockless_pgtbl_walk(irq_mask, true);
+}
+EXPORT_SYMBOL(end_lockless_pgtbl_walk);
+
 /*
  * We use this to invalidate a pmdp entry before switching from a
  * hugepte to regular pmd entry.
@@ -487,7 +571,7 @@ static int __init setup_disable_tlbie(char *str)
 	tlbie_capable = false;
 	tlbie_enabled = false;
 
-        return 1;
+	return 1;
 }
 __setup("disable_tlbie", setup_disable_tlbie);
 
-- 
2.24.1
