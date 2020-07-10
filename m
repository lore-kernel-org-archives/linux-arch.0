From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Fri, 10 Jul 2020 10:02:20 -0400 (EDT)
Message-ID: <1650470150.8264.1594389740219.JavaMail.zimbra@efficios.com>
References: <20200710015646.2020871-1-npiggin@gmail.com> <20200710015646.2020871-5-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.26.124]:57782 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgGJOCW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 10:02:22 -0400
In-Reply-To: <20200710015646.2020871-5-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, x86 <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mm <linux-mm@kvack.org>, Anton Blanchard <anton@ozlabs.org>

----- On Jul 9, 2020, at 9:56 PM, Nicholas Piggin npiggin@gmail.com wrote:

> And get rid of the generic sync_core_before_usermode facility.
> 
> This helper is the wrong way around I think. The idea that membarrier
> state requires a core sync before returning to user is the easy one
> that does not need hiding behind membarrier calls. The gap in core
> synchronization due to x86's sysret/sysexit and lazy tlb mode, is the
> tricky detail that is better put in x86 lazy tlb code.
> 
> Consider if an arch did not synchronize core in switch_mm either, then
> membarrier_mm_sync_core_before_usermode would be in the wrong place
> but arch specific mmu context functions would still be the right place.
> There is also a exit_lazy_tlb case that is not covered by this call, which
> could be a bugs (kthread use mm the membarrier process's mm then context
> switch back to the process without switching mm or lazy mm switch).
> 
> This makes lazy tlb code a bit more modular.

I agree that moving this logic to exit_lazy_tlb is much more modular and
cleaner.

Thanks,

Mathieu


> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> .../membarrier-sync-core/arch-support.txt     |  6 +++-
> arch/x86/include/asm/mmu_context.h            | 35 +++++++++++++++++++
> arch/x86/include/asm/sync_core.h              | 28 ---------------
> include/linux/sched/mm.h                      | 14 --------
> include/linux/sync_core.h                     | 21 -----------
> kernel/cpu.c                                  |  4 ++-
> kernel/kthread.c                              |  2 +-
> kernel/sched/core.c                           | 16 ++++-----
> 8 files changed, 51 insertions(+), 75 deletions(-)
> delete mode 100644 arch/x86/include/asm/sync_core.h
> delete mode 100644 include/linux/sync_core.h
> 
> diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> index 52ad74a25f54..bd43fb1f5986 100644
> --- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> +++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> @@ -5,6 +5,10 @@
> #
> # Architecture requirements
> #
> +# If your architecture returns to user-space through non-core-serializing
> +# instructions, you need to ensure these are done in switch_mm and
> exit_lazy_tlb
> +# (if lazy tlb switching is implemented).
> +#
> # * arm/arm64/powerpc
> #
> # Rely on implicit context synchronization as a result of exception return
> @@ -24,7 +28,7 @@
> # instead on write_cr3() performed by switch_mm() to provide core serialization
> # after changing the current mm, and deal with the special case of kthread ->
> # uthread (temporarily keeping current mm into active_mm) by issuing a
> -# sync_core_before_usermode() in that specific case.
> +# serializing instruction in exit_lazy_mm() in that specific case.
> #
>     -----------------------
>     |         arch |status|
> diff --git a/arch/x86/include/asm/mmu_context.h
> b/arch/x86/include/asm/mmu_context.h
> index 255750548433..5263863a9be8 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -6,6 +6,7 @@
> #include <linux/atomic.h>
> #include <linux/mm_types.h>
> #include <linux/pkeys.h>
> +#include <linux/sched/mm.h>
> 
> #include <trace/events/tlb.h>
> 
> @@ -95,6 +96,40 @@ static inline void switch_ldt(struct mm_struct *prev, struct
> mm_struct *next)
> #define enter_lazy_tlb enter_lazy_tlb
> extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
> 
> +#ifdef CONFIG_MEMBARRIER
> +/*
> + * Ensure that a core serializing instruction is issued before returning
> + * to user-mode, if a SYNC_CORE was requested. x86 implements return to
> + * user-space through sysexit, sysrel, and sysretq, which are not core
> + * serializing.
> + *
> + * See the membarrier comment in finish_task_switch as to why this is done
> + * in exit_lazy_tlb.
> + */
> +#define exit_lazy_tlb exit_lazy_tlb
> +static inline void exit_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
> +{
> +	/* Switching mm is serializing with write_cr3 */
> +        if (tsk->mm != mm)
> +                return;
> +
> +        if (likely(!(atomic_read(&mm->membarrier_state) &
> +                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE)))
> +                return;
> +
> +	/* With PTI, we unconditionally serialize before running user code. */
> +	if (static_cpu_has(X86_FEATURE_PTI))
> +		return;
> +	/*
> +	 * Return from interrupt and NMI is done through iret, which is core
> +	 * serializing.
> +	 */
> +	if (in_irq() || in_nmi())
> +		return;
> +	sync_core();
> +}
> +#endif
> +
> /*
>  * Init a new mm.  Used on mm copies, like at fork()
>  * and on mm's that are brand-new, like at execve().
> diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
> deleted file mode 100644
> index c67caafd3381..000000000000
> --- a/arch/x86/include/asm/sync_core.h
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_X86_SYNC_CORE_H
> -#define _ASM_X86_SYNC_CORE_H
> -
> -#include <linux/preempt.h>
> -#include <asm/processor.h>
> -#include <asm/cpufeature.h>
> -
> -/*
> - * Ensure that a core serializing instruction is issued before returning
> - * to user-mode. x86 implements return to user-space through sysexit,
> - * sysrel, and sysretq, which are not core serializing.
> - */
> -static inline void sync_core_before_usermode(void)
> -{
> -	/* With PTI, we unconditionally serialize before running user code. */
> -	if (static_cpu_has(X86_FEATURE_PTI))
> -		return;
> -	/*
> -	 * Return from interrupt and NMI is done through iret, which is core
> -	 * serializing.
> -	 */
> -	if (in_irq() || in_nmi())
> -		return;
> -	sync_core();
> -}
> -
> -#endif /* _ASM_X86_SYNC_CORE_H */
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 480a4d1b7dd8..9b026264b445 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -7,7 +7,6 @@
> #include <linux/sched.h>
> #include <linux/mm_types.h>
> #include <linux/gfp.h>
> -#include <linux/sync_core.h>
> 
> /*
>  * Routines for handling mm_structs
> @@ -364,16 +363,6 @@ enum {
> #include <asm/membarrier.h>
> #endif
> 
> -static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct
> *mm)
> -{
> -	if (current->mm != mm)
> -		return;
> -	if (likely(!(atomic_read(&mm->membarrier_state) &
> -		     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE)))
> -		return;
> -	sync_core_before_usermode();
> -}
> -
> extern void membarrier_exec_mmap(struct mm_struct *mm);
> 
> #else
> @@ -387,9 +376,6 @@ static inline void membarrier_arch_switch_mm(struct
> mm_struct *prev,
> static inline void membarrier_exec_mmap(struct mm_struct *mm)
> {
> }
> -static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct
> *mm)
> -{
> -}
> #endif
> 
> #endif /* _LINUX_SCHED_MM_H */
> diff --git a/include/linux/sync_core.h b/include/linux/sync_core.h
> deleted file mode 100644
> index 013da4b8b327..000000000000
> --- a/include/linux/sync_core.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINUX_SYNC_CORE_H
> -#define _LINUX_SYNC_CORE_H
> -
> -#ifdef CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
> -#include <asm/sync_core.h>
> -#else
> -/*
> - * This is a dummy sync_core_before_usermode() implementation that can be used
> - * on all architectures which return to user-space through core serializing
> - * instructions.
> - * If your architecture returns to user-space through non-core-serializing
> - * instructions, you need to write your own functions.
> - */
> -static inline void sync_core_before_usermode(void)
> -{
> -}
> -#endif
> -
> -#endif /* _LINUX_SYNC_CORE_H */
> -
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6ff2578ecf17..134688d79589 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -572,7 +572,9 @@ static int finish_cpu(unsigned int cpu)
> 
> 	/*
> 	 * idle_task_exit() will have switched to &init_mm, now
> -	 * clean up any remaining active_mm state.
> +	 * clean up any remaining active_mm state. exit_lazy_tlb
> +	 * is not done, if an arch did any accounting in these
> +	 * functions it would have to be added.
> 	 */
> 	if (mm != &init_mm)
> 		idle->active_mm = &init_mm;
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index e813d92f2eab..6f93c649aa97 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1251,9 +1251,9 @@ void kthread_use_mm(struct mm_struct *mm)
> 	finish_arch_post_lock_switch();
> #endif
> 
> +	exit_lazy_tlb(active_mm, tsk);
> 	if (active_mm != mm)
> 		mmdrop(active_mm);
> -	exit_lazy_tlb(active_mm, tsk);
> 
> 	to_kthread(tsk)->oldfs = get_fs();
> 	set_fs(USER_DS);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index debc917bc69b..31e22c79826c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3294,22 +3294,19 @@ static struct rq *finish_task_switch(struct task_struct
> *prev)
> 	kcov_finish_switch(current);
> 
> 	fire_sched_in_preempt_notifiers(current);
> +
> 	/*
> 	 * When switching through a kernel thread, the loop in
> 	 * membarrier_{private,global}_expedited() may have observed that
> 	 * kernel thread and not issued an IPI. It is therefore possible to
> 	 * schedule between user->kernel->user threads without passing though
> -	 * switch_mm(). Membarrier requires a barrier after storing to
> -	 * rq->curr, before returning to userspace, so provide them here:
> -	 *
> -	 * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, implicitly
> -	 *   provided by mmdrop(),
> -	 * - a sync_core for SYNC_CORE.
> +	 * switch_mm(). Membarrier requires a full barrier after storing to
> +	 * rq->curr, before returning to userspace, for
> +	 * {PRIVATE,GLOBAL}_EXPEDITED. This is implicitly provided by mmdrop().
> 	 */
> -	if (mm) {
> -		membarrier_mm_sync_core_before_usermode(mm);
> +	if (mm)
> 		mmdrop(mm);
> -	}
> +
> 	if (unlikely(prev_state == TASK_DEAD)) {
> 		if (prev->sched_class->task_dead)
> 			prev->sched_class->task_dead(prev);
> @@ -6292,6 +6289,7 @@ void idle_task_exit(void)
> 	BUG_ON(current != this_rq()->idle);
> 
> 	if (mm != &init_mm) {
> +		/* enter_lazy_tlb is not done because we're about to go down */
> 		switch_mm(mm, &init_mm, current);
> 		finish_arch_post_lock_switch();
> 	}
> --
> 2.23.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
