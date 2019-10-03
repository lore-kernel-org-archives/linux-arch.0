From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v5 01/11] asm-generic/pgtable: Adds generic functions to
 monitor lockless pgtable walks
Date: Wed,  2 Oct 2019 22:33:15 -0300
Message-ID: <20191003013325.2614-2-leonardo@linux.ibm.com>
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

Some methods rely on irq enable/disable, but that can be slow on
cases with a lot of cpus are used for the process, given all these cpus
have to run a IPI.

In order to speedup some cases, I propose a refcount-based approach,
that counts the number of lockless pagetable walks happening on the
process. If this count is zero, it skips the irq-oriented method.

Given that there are lockless pagetable walks on generic code, it's
necessary to create documented generic functions that may be enough for
most archs and but let open to arch-specific implemenations.

This method does not exclude the current irq-oriented method. It works as a
complement to skip unnecessary waiting.

begin_lockless_pgtbl_walk(mm)
        Insert before starting any lockless pgtable walk
end_lockless_pgtbl_walk(mm)
        Insert after the end of any lockless pgtable walk
        (Mostly after the ptep is last used)
running_lockless_pgtbl_walk(mm)
        Returns the number of lockless pgtable walks running

While there is no config option, the method is disabled and these functions
are only doing what was already needed to lockless pagetable walks
(disabling interrupt). A memory barrier was also added just to make sure
there is no speculative read outside the interrupt disabled area.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 include/asm-generic/pgtable.h | 58 +++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h      | 11 +++++++
 kernel/fork.c                 |  3 ++
 3 files changed, 72 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 818691846c90..3043ea9812d5 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1171,6 +1171,64 @@ static inline bool arch_has_pfn_modify_check(void)
 #endif
 #endif
 
+#ifndef __HAVE_ARCH_LOCKLESS_PGTBL_WALK_CONTROL
+static inline unsigned long begin_lockless_pgtbl_walk(struct mm_struct *mm)
+{
+	unsigned long irq_mask;
+
+	if (IS_ENABLED(CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING))
+		atomic_inc(&mm->lockless_pgtbl_walkers);
+
+	/*
+	 * Interrupts must be disabled during the lockless page table walk.
+	 * That's because the deleting or splitting involves flushing TLBs,
+	 * which in turn issues interrupts, that will block when disabled.
+	 */
+	local_irq_save(irq_mask);
+
+	/*
+	 * This memory barrier pairs with any code that is either trying to
+	 * delete page tables, or split huge pages. Without this barrier,
+	 * the page tables could be read speculatively outside of interrupt
+	 * disabling.
+	 */
+	smp_mb();
+
+	return irq_mask;
+}
+
+static inline void end_lockless_pgtbl_walk(struct mm_struct *mm,
+					   unsigned long irq_mask)
+{
+	/*
+	 * This memory barrier pairs with any code that is either trying to
+	 * delete page tables, or split huge pages. Without this barrier,
+	 * the page tables could be read speculatively outside of interrupt
+	 * disabling.
+	 */
+	smp_mb();
+
+	/*
+	 * Interrupts must be disabled during the lockless page table walk.
+	 * That's because the deleting or splitting involves flushing TLBs,
+	 * which in turn issues interrupts, that will block when disabled.
+	 */
+	local_irq_restore(irq_mask);
+
+	if (IS_ENABLED(CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING))
+		atomic_dec(&mm->lockless_pgtbl_walkers);
+}
+
+static inline int running_lockless_pgtbl_walk(struct mm_struct *mm)
+{
+	if (IS_ENABLED(CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING))
+		return atomic_read(&mm->lockless_pgtbl_walkers);
+
+	/* If disabled, must return > 0, so it falls back to sync method */
+	return 1;
+}
+#endif
+
 /*
  * On some architectures it depends on the mm if the p4d/pud or pmd
  * layer of the page table hierarchy is folded or not.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2222fa795284..277462f0b4fd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -521,6 +521,17 @@ struct mm_struct {
 		struct work_struct async_put_work;
 	} __randomize_layout;
 
+#ifdef CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING
+	/*
+	 * Number of callers who are doing a lockless walk of the
+	 * page tables. Typically arches might enable this in order to
+	 * help optimize performance, by possibly avoiding expensive
+	 * IPIs at the wrong times.
+	 */
+	atomic_t lockless_pgtbl_walkers;
+
+#endif
+
 	/*
 	 * The mm_cpumask needs to be at the end of mm_struct, because it
 	 * is dynamically sized based on nr_cpu_ids.
diff --git a/kernel/fork.c b/kernel/fork.c
index f9572f416126..2cbca867f5a5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1029,6 +1029,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 #endif
 	mm_init_uprobes_state(mm);
 
+#ifdef CONFIG_LOCKLESS_PAGE_TABLE_WALK_TRACKING
+	atomic_set(&mm->lockless_pgtbl_walkers, 0);
+#endif
 	if (current->mm) {
 		mm->flags = current->mm->flags & MMF_INIT_MASK;
 		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
-- 
2.20.1
