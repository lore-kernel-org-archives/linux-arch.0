Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:52072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfBSNl7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2019 08:41:59 -0500
Date: Tue, 19 Feb 2019 14:41:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 06/18] asm-generic/tlb: Conditionally provide
 tlb_migrate_finish()
Message-ID: <20190219134147.GZ32494@hirez.programming.kicks-ass.net>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.207580251@infradead.org>
 <20190219124738.GD8501@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219124738.GD8501@fuggles.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com, tony.luck@intel.com
Message-ID: <20190219134147.7kSMZ4rZ5lyf0jUJEZ-GcqCj_zmA2D3Qt_6HIIQtl3E@z>

On Tue, Feb 19, 2019 at 12:47:38PM +0000, Will Deacon wrote:
> Fine for now, but I agree that we should drop the hook altogether. AFAICT,
> this only exists to help an ia64 optimisation which looks suspicious to
> me since it uses:
> 
>     mm == current->active_mm && atomic_read(&mm->mm_users) == 1
> 
> to identify a "single-threaded fork()" and therefore perform only local TLB
> invalidation. Even if this was the right thing to do, it's not clear to me
> that tlb_migrate_finish() is called on the right CPU anyway.
> 
> So I'd be keen to remove this hook before it spreads, but in the meantime:

Agreed :-)

The obvious slash and kill patch ... untested

---
 Documentation/core-api/cachetlb.rst |   10 ----------
 arch/ia64/include/asm/machvec.h     |    8 --------
 arch/ia64/include/asm/machvec_sn2.h |    2 --
 arch/ia64/include/asm/tlb.h         |    2 --
 arch/ia64/sn/kernel/sn2/sn2_smp.c   |    7 -------
 arch/nds32/include/asm/tlbflush.h   |    1 -
 include/asm-generic/tlb.h           |    4 ----
 kernel/sched/core.c                 |    1 -
 8 files changed, 35 deletions(-)

--- a/Documentation/core-api/cachetlb.rst
+++ b/Documentation/core-api/cachetlb.rst
@@ -101,16 +101,6 @@ invoke one of the following flush method
 	translations for software managed TLB configurations.
 	The sparc64 port currently does this.
 
-6) ``void tlb_migrate_finish(struct mm_struct *mm)``
-
-	This interface is called at the end of an explicit
-	process migration. This interface provides a hook
-	to allow a platform to update TLB or context-specific
-	information for the address space.
-
-	The ia64 sn2 platform is one example of a platform
-	that uses this interface.
-
 Next, we have the cache flushing interfaces.  In general, when Linux
 is changing an existing virtual-->physical mapping to a new value,
 the sequence will be in one of the following forms::
--- a/arch/ia64/include/asm/machvec.h
+++ b/arch/ia64/include/asm/machvec.h
@@ -30,7 +30,6 @@ typedef void ia64_mv_irq_init_t (void);
 typedef void ia64_mv_send_ipi_t (int, int, int, int);
 typedef void ia64_mv_timer_interrupt_t (int, void *);
 typedef void ia64_mv_global_tlb_purge_t (struct mm_struct *, unsigned long, unsigned long, unsigned long);
-typedef void ia64_mv_tlb_migrate_finish_t (struct mm_struct *);
 typedef u8 ia64_mv_irq_to_vector (int);
 typedef unsigned int ia64_mv_local_vector_to_irq (u8);
 typedef char *ia64_mv_pci_get_legacy_mem_t (struct pci_bus *);
@@ -96,7 +95,6 @@ machvec_noop_bus (struct pci_bus *bus)
 
 extern void machvec_setup (char **);
 extern void machvec_timer_interrupt (int, void *);
-extern void machvec_tlb_migrate_finish (struct mm_struct *);
 
 # if defined (CONFIG_IA64_HP_SIM)
 #  include <asm/machvec_hpsim.h>
@@ -124,7 +122,6 @@ extern void machvec_tlb_migrate_finish (
 #  define platform_send_ipi	ia64_mv.send_ipi
 #  define platform_timer_interrupt	ia64_mv.timer_interrupt
 #  define platform_global_tlb_purge	ia64_mv.global_tlb_purge
-#  define platform_tlb_migrate_finish	ia64_mv.tlb_migrate_finish
 #  define platform_dma_init		ia64_mv.dma_init
 #  define platform_dma_get_ops		ia64_mv.dma_get_ops
 #  define platform_irq_to_vector	ia64_mv.irq_to_vector
@@ -167,7 +164,6 @@ struct ia64_machine_vector {
 	ia64_mv_send_ipi_t *send_ipi;
 	ia64_mv_timer_interrupt_t *timer_interrupt;
 	ia64_mv_global_tlb_purge_t *global_tlb_purge;
-	ia64_mv_tlb_migrate_finish_t *tlb_migrate_finish;
 	ia64_mv_dma_init *dma_init;
 	ia64_mv_dma_get_ops *dma_get_ops;
 	ia64_mv_irq_to_vector *irq_to_vector;
@@ -206,7 +202,6 @@ struct ia64_machine_vector {
 	platform_send_ipi,			\
 	platform_timer_interrupt,		\
 	platform_global_tlb_purge,		\
-	platform_tlb_migrate_finish,		\
 	platform_dma_init,			\
 	platform_dma_get_ops,			\
 	platform_irq_to_vector,			\
@@ -270,9 +265,6 @@ extern const struct dma_map_ops *dma_get
 #ifndef platform_global_tlb_purge
 # define platform_global_tlb_purge	ia64_global_tlb_purge /* default to architected version */
 #endif
-#ifndef platform_tlb_migrate_finish
-# define platform_tlb_migrate_finish	machvec_noop_mm
-#endif
 #ifndef platform_kernel_launch_event
 # define platform_kernel_launch_event	machvec_noop
 #endif
--- a/arch/ia64/include/asm/machvec_sn2.h
+++ b/arch/ia64/include/asm/machvec_sn2.h
@@ -34,7 +34,6 @@ extern ia64_mv_irq_init_t sn_irq_init;
 extern ia64_mv_send_ipi_t sn2_send_IPI;
 extern ia64_mv_timer_interrupt_t sn_timer_interrupt;
 extern ia64_mv_global_tlb_purge_t sn2_global_tlb_purge;
-extern ia64_mv_tlb_migrate_finish_t	sn_tlb_migrate_finish;
 extern ia64_mv_irq_to_vector sn_irq_to_vector;
 extern ia64_mv_local_vector_to_irq sn_local_vector_to_irq;
 extern ia64_mv_pci_get_legacy_mem_t sn_pci_get_legacy_mem;
@@ -77,7 +76,6 @@ extern ia64_mv_pci_fixup_bus_t		sn_pci_f
 #define platform_send_ipi		sn2_send_IPI
 #define platform_timer_interrupt	sn_timer_interrupt
 #define platform_global_tlb_purge       sn2_global_tlb_purge
-#define platform_tlb_migrate_finish	sn_tlb_migrate_finish
 #define platform_pci_fixup		sn_pci_fixup
 #define platform_inb			__sn_inb
 #define platform_inw			__sn_inw
--- a/arch/ia64/include/asm/tlb.h
+++ b/arch/ia64/include/asm/tlb.h
@@ -47,8 +47,6 @@
 #include <asm/tlbflush.h>
 #include <asm/machvec.h>
 
-#define tlb_migrate_finish(mm)	platform_tlb_migrate_finish(mm)
-
 #include <asm-generic/tlb.h>
 
 #endif /* _ASM_IA64_TLB_H */
--- a/arch/ia64/sn/kernel/sn2/sn2_smp.c
+++ b/arch/ia64/sn/kernel/sn2/sn2_smp.c
@@ -120,13 +120,6 @@ void sn_migrate(struct task_struct *task
 		cpu_relax();
 }
 
-void sn_tlb_migrate_finish(struct mm_struct *mm)
-{
-	/* flush_tlb_mm is inefficient if more than 1 users of mm */
-	if (mm == current->mm && mm && atomic_read(&mm->mm_users) == 1)
-		flush_tlb_mm(mm);
-}
-
 static void
 sn2_ipi_flush_all_tlb(struct mm_struct *mm)
 {
--- a/arch/nds32/include/asm/tlbflush.h
+++ b/arch/nds32/include/asm/tlbflush.h
@@ -42,6 +42,5 @@ void local_flush_tlb_page(struct vm_area
 
 void update_mmu_cache(struct vm_area_struct *vma,
 		      unsigned long address, pte_t * pte);
-void tlb_migrate_finish(struct mm_struct *mm);
 
 #endif
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -604,8 +604,4 @@ static inline void tlb_end_vma(struct mm
 
 #endif /* CONFIG_MMU */
 
-#ifndef tlb_migrate_finish
-#define tlb_migrate_finish(mm) do {} while (0)
-#endif
-
 #endif /* _ASM_GENERIC__TLB_H */
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1151,7 +1151,6 @@ static int __set_cpus_allowed_ptr(struct
 		/* Need help from migration thread: drop lock and wait. */
 		task_rq_unlock(rq, p, &rf);
 		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
-		tlb_migrate_finish(p->mm);
 		return 0;
 	} else if (task_on_rq_queued(p)) {
 		/*
