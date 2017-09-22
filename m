From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH v3 1/2] membarrier: Provide register expedited
 private command
Date: Fri, 22 Sep 2017 11:22:06 +0800
Message-ID: <20170922032206.GE10893@tardis>
References: <20170919221342.29915-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:56559 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbdIVDXg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2017 23:23:36 -0400
Content-Disposition: inline
In-Reply-To: <20170919221342.29915-1-mathieu.desnoyers@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Andrew Hunter <ahh@google.com>, Maged Michael <maged.michael@gmail.com>, gromer@google.com, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

On Tue, Sep 19, 2017 at 06:13:41PM -0400, Mathieu Desnoyers wrote:
> Provide a new command allowing processes to register their intent to use
> the private expedited command.
>=20
> This allows PowerPC to skip the full memory barrier in switch_mm(), and
> only issue the barrier when scheduling into a task belonging to a
> process that has registered to use expedited private.
>=20
> Processes are now required to register before using
> MEMBARRIER_CMD_PRIVATE_EXPEDITED, otherwise that command returns EPERM.
>=20

Sorry I'm late for the party, but I couldn't stop thinking whether we
could avoid the register thing at all, because the registering makes
sys_membarrier() more complex(both for the interface and the
implementation). So how about we trade-off a little bit by taking
some(not all) the rq->locks?

The idea is in membarrier_private_expedited(), we go through all ->curr
on each CPU and=20

1)	If it's a userspace task and its ->mm is matched, we send an ipi

2)	If it's a kernel task, we skip

	(Because there will be a smp_mb() implied by mmdrop(), when it
	switchs to userspace task).

3)	If it's a userspace task and its ->mm is not matched, we take
	the corresponding rq->lock and check rq->curr again, if its ->mm
	matched, we send an ipi, otherwise we do nothing.

	(Because if we observe rq->curr is not matched with rq->lock
	held, when a task having matched ->mm schedules in, the rq->lock
	pairing along with the smp_mb__after_spinlock() will guarantee
	it observes all memory ops before sys_membarrir()).

membarrier_private_expedited() will look like this if we choose this
way:

void membarrier_private_expedited()
{
	int cpu;
	bool fallback =3D false;
	cpumask_var_t tmpmask;
	struct rq_flags rf;


	if (num_online_cpus() =3D=3D 1)
		return;

	smp_mb();

	if (!zalloc_cpumask_var(&tmpmask, GFP_NOWAIT)) {
		/* Fallback for OOM. */
		fallback =3D true;
	}

	cpus_read_lock();
	for_each_online_cpu(cpu) {
		struct task_struct *p;

		if (cpu =3D=3D raw_smp_processor_id())
			continue;

		rcu_read_lock();
		p =3D task_rcu_dereference(&cpu_rq(cpu)->curr);

		if (!p) {
			rcu_read_unlock();
			continue;
		}

		if (p->mm =3D=3D current->mm) {
			if (!fallback)
				__cpumask_set_cpu(cpu, tmpmask);
			else
				smp_call_function_single(cpu, ipi_mb, NULL, 1);
		}

		if (p->mm =3D=3D current->mm || !p->mm) {
			rcu_read_unlock();
			continue;
		}

		rcu_read_unlock();
	=09
		/*
		 * This should be a arch-specific code, as we don't
		 * need it at else place other than some archs without
		 * a smp_mb() in switch_mm() (i.e. powerpc)
		 */
		rq_lock_irq(cpu_rq(cpu), &rf);
		if (p->mm =3D=3D current->mm) {
			if (!fallback)
				__cpumask_set_cpu(cpu, tmpmask);
			else
				smp_call_function_single(cpu, ipi_mb, NULL, 1);
		}
		rq_unlock_irq(cpu_rq(cpu), &rf);
	}
	if (!fallback) {
		smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
		free_cpumask_var(tmpmask);
	}
	cpus_read_unlock();

	smp_mb();
}

Thoughts?

Regards,
Boqun

> Changes since v1:
> - Use test_ti_thread_flag(next, ...) instead of test_thread_flag() in
>   powerpc membarrier_arch_sched_in(), given that we want to specifically
>   check the next thread state.
> - Add missing ARCH_HAS_MEMBARRIER_HOOKS in Kconfig.
> - Use task_thread_info() to pass thread_info from task to
>   *_ti_thread_flag().
>=20
> Changes since v2:
> - Move membarrier_arch_sched_in() call to finish_task_switch().
> - Check for NULL t->mm in membarrier_arch_fork().
> - Use membarrier_sched_in() in generic code, which invokes the
>   arch-specific membarrier_arch_sched_in(). This fixes allnoconfig
>   build on PowerPC.
> - Move asm/membarrier.h include under CONFIG_MEMBARRIER, fixing
>   allnoconfig build on PowerPC.
> - Build and runtime tested on PowerPC.
>=20
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: Andrew Hunter <ahh@google.com>
> CC: Maged Michael <maged.michael@gmail.com>
> CC: gromer@google.com
> CC: Avi Kivity <avi@scylladb.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: Dave Watson <davejwatson@fb.com>
> CC: Alan Stern <stern@rowland.harvard.edu>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: linux-arch@vger.kernel.org
> ---
>  MAINTAINERS                            |  2 ++
>  arch/powerpc/Kconfig                   |  1 +
>  arch/powerpc/include/asm/membarrier.h  | 40 +++++++++++++++++++++++++
>  arch/powerpc/include/asm/thread_info.h |  3 ++
>  arch/powerpc/kernel/Makefile           |  2 ++
>  arch/powerpc/kernel/membarrier.c       | 45 ++++++++++++++++++++++++++++
>  fs/exec.c                              |  1 +
>  include/linux/mm_types.h               |  3 ++
>  include/linux/sched/mm.h               | 55 ++++++++++++++++++++++++++++=
++++++
>  include/uapi/linux/membarrier.h        | 23 +++++++++-----
>  init/Kconfig                           |  3 ++
>  kernel/fork.c                          |  2 ++
>  kernel/sched/core.c                    | 16 ++--------
>  kernel/sched/membarrier.c              | 25 +++++++++++++---
>  14 files changed, 197 insertions(+), 24 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/membarrier.h
>  create mode 100644 arch/powerpc/kernel/membarrier.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2281af4b41b6..fe6d34d8a2e0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8805,6 +8805,8 @@ L:	linux-kernel@vger.kernel.org
>  S:	Supported
>  F:	kernel/sched/membarrier.c
>  F:	include/uapi/linux/membarrier.h
> +F:	arch/powerpc/kernel/membarrier.c
> +F:	arch/powerpc/include/asm/membarrier.h
> =20
>  MEMORY MANAGEMENT
>  L:	linux-mm@kvack.org
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 809c468edab1..6f44c5f74f71 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -138,6 +138,7 @@ config PPC
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> +	select ARCH_HAS_MEMBARRIER_HOOKS
>  	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE
>  	select ARCH_HAS_SG_CHAIN
>  	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
> diff --git a/arch/powerpc/include/asm/membarrier.h b/arch/powerpc/include=
/asm/membarrier.h
> new file mode 100644
> index 000000000000..ee208455674d
> --- /dev/null
> +++ b/arch/powerpc/include/asm/membarrier.h
> @@ -0,0 +1,40 @@
> +#ifndef _ASM_POWERPC_MEMBARRIER_H
> +#define _ASM_POWERPC_MEMBARRIER_H
> +
> +static inline void membarrier_arch_sched_in(struct task_struct *prev,
> +		struct task_struct *next)
> +{
> +	/*
> +	 * Only need the full barrier when switching between processes.
> +	 */
> +	if (likely(!test_ti_thread_flag(task_thread_info(next),
> +			TIF_MEMBARRIER_PRIVATE_EXPEDITED)
> +				|| prev->mm =3D=3D next->mm))
> +		return;
> +
> +	/*
> +	 * The membarrier system call requires a full memory barrier
> +	 * after storing to rq->curr, before going back to user-space.
> +	 */
> +	smp_mb();
> +}
> +static inline void membarrier_arch_fork(struct task_struct *t,
> +		unsigned long clone_flags)
> +{
> +	/*
> +	 * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
> +	 * fork is protected by siglock. membarrier_arch_fork is called
> +	 * with siglock held.
> +	 */
> +	if (t->mm && t->mm->membarrier_private_expedited)
> +		set_ti_thread_flag(task_thread_info(t),
> +				TIF_MEMBARRIER_PRIVATE_EXPEDITED);
> +}
> +static inline void membarrier_arch_execve(struct task_struct *t)
> +{
> +	clear_ti_thread_flag(task_thread_info(t),
> +			TIF_MEMBARRIER_PRIVATE_EXPEDITED);
> +}
> +void membarrier_arch_register_private_expedited(struct task_struct *t);
> +
> +#endif /* _ASM_POWERPC_MEMBARRIER_H */
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/includ=
e/asm/thread_info.h
> index a941cc6fc3e9..2a208487724b 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -100,6 +100,7 @@ static inline struct thread_info *current_thread_info=
(void)
>  #if defined(CONFIG_PPC64)
>  #define TIF_ELF2ABI		18	/* function descriptors must die! */
>  #endif
> +#define TIF_MEMBARRIER_PRIVATE_EXPEDITED	19	/* membarrier */
> =20
>  /* as above, but as bit values */
>  #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
> @@ -119,6 +120,8 @@ static inline struct thread_info *current_thread_info=
(void)
>  #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
>  #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
>  #define _TIF_NOHZ		(1<<TIF_NOHZ)
> +#define _TIF_MEMBARRIER_PRIVATE_EXPEDITED \
> +				(1<<TIF_MEMBARRIER_PRIVATE_EXPEDITED)
>  #define _TIF_SYSCALL_DOTRACE	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
>  				 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | \
>  				 _TIF_NOHZ)
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 91960f83039c..2dd4b9e3313a 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -135,6 +135,8 @@ endif
>  obj-$(CONFIG_EPAPR_PARAVIRT)	+=3D epapr_paravirt.o epapr_hcalls.o
>  obj-$(CONFIG_KVM_GUEST)		+=3D kvm.o kvm_emul.o
> =20
> +obj-$(CONFIG_MEMBARRIER)	+=3D membarrier.o
> +
>  # Disable GCOV & sanitizers in odd or sensitive code
>  GCOV_PROFILE_prom_init.o :=3D n
>  UBSAN_SANITIZE_prom_init.o :=3D n
> diff --git a/arch/powerpc/kernel/membarrier.c b/arch/powerpc/kernel/memba=
rrier.c
> new file mode 100644
> index 000000000000..b0d79a5f5981
> --- /dev/null
> +++ b/arch/powerpc/kernel/membarrier.c
> @@ -0,0 +1,45 @@
> +/*
> + * Copyright (C) 2010-2017 Mathieu Desnoyers <mathieu.desnoyers@efficios=
=2Ecom>
> + *
> + * membarrier system call - PowerPC architecture code
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/sched/mm.h>
> +#include <linux/sched/signal.h>
> +#include <linux/thread_info.h>
> +#include <linux/spinlock.h>
> +#include <linux/rcupdate.h>
> +
> +void membarrier_arch_register_private_expedited(struct task_struct *p)
> +{
> +	struct task_struct *t;
> +
> +	if (get_nr_threads(p) =3D=3D 1) {
> +		set_thread_flag(TIF_MEMBARRIER_PRIVATE_EXPEDITED);
> +		return;
> +	}
> +	/*
> +	 * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
> +	 * fork is protected by siglock.
> +	 */
> +	spin_lock(&p->sighand->siglock);
> +	for_each_thread(p, t)
> +		set_ti_thread_flag(task_thread_info(t),
> +				TIF_MEMBARRIER_PRIVATE_EXPEDITED);
> +	spin_unlock(&p->sighand->siglock);
> +	/*
> +	 * Ensure all future scheduler executions will observe the new
> +	 * thread flag state for this process.
> +	 */
> +	synchronize_sched();
> +}
> diff --git a/fs/exec.c b/fs/exec.c
> index ac34d9724684..b2448f2731b3 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1802,6 +1802,7 @@ static int do_execveat_common(int fd, struct filena=
me *filename,
>  	/* execve succeeded */
>  	current->fs->in_exec =3D 0;
>  	current->in_execve =3D 0;
> +	membarrier_execve(current);
>  	acct_update_integrals(current);
>  	task_numa_free(current);
>  	free_bprm(bprm);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 46f4ecf5479a..5e0fe8ce053b 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -445,6 +445,9 @@ struct mm_struct {
>  	unsigned long flags; /* Must use atomic bitops to access the bits */
> =20
>  	struct core_state *core_state; /* coredumping support */
> +#ifdef CONFIG_MEMBARRIER
> +	int membarrier_private_expedited;
> +#endif
>  #ifdef CONFIG_AIO
>  	spinlock_t			ioctx_lock;
>  	struct kioctx_table __rcu	*ioctx_table;
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 766cc47c4d7c..b88f85c8474e 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -210,4 +210,59 @@ static inline void memalloc_noreclaim_restore(unsign=
ed int flags)
>  	current->flags =3D (current->flags & ~PF_MEMALLOC) | flags;
>  }
> =20
> +#ifdef CONFIG_MEMBARRIER
> +
> +#ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
> +#include <asm/membarrier.h>
> +#else
> +static inline void membarrier_arch_sched_in(struct task_struct *prev,
> +		struct task_struct *next)
> +{
> +}
> +static inline void membarrier_arch_fork(struct task_struct *t,
> +		unsigned long clone_flags)
> +{
> +}
> +static inline void membarrier_arch_execve(struct task_struct *t)
> +{
> +}
> +static inline void membarrier_arch_register_private_expedited(
> +		struct task_struct *p)
> +{
> +}
> +#endif
> +
> +static inline void membarrier_sched_in(struct task_struct *prev,
> +		struct task_struct *next)
> +{
> +	membarrier_arch_sched_in(prev, next);
> +}
> +static inline void membarrier_fork(struct task_struct *t,
> +		unsigned long clone_flags)
> +{
> +	if (!current->mm || !t->mm)
> +		return;
> +	t->mm->membarrier_private_expedited =3D
> +		current->mm->membarrier_private_expedited;
> +	membarrier_arch_fork(t, clone_flags);
> +}
> +static inline void membarrier_execve(struct task_struct *t)
> +{
> +	t->mm->membarrier_private_expedited =3D 0;
> +	membarrier_arch_execve(t);
> +}
> +#else
> +static inline void membarrier_sched_in(struct task_struct *prev,
> +		struct task_struct *next)
> +{
> +}
> +static inline void membarrier_fork(struct task_struct *t,
> +		unsigned long clone_flags)
> +{
> +}
> +static inline void membarrier_execve(struct task_struct *t)
> +{
> +}
> +#endif
> +
>  #endif /* _LINUX_SCHED_MM_H */
> diff --git a/include/uapi/linux/membarrier.h b/include/uapi/linux/membarr=
ier.h
> index 6d47b3249d8a..4e01ad7ffe98 100644
> --- a/include/uapi/linux/membarrier.h
> +++ b/include/uapi/linux/membarrier.h
> @@ -52,21 +52,30 @@
>   *                          (non-running threads are de facto in such a
>   *                          state). This only covers threads from the
>   *                          same processes as the caller thread. This
> - *                          command returns 0. The "expedited" commands
> - *                          complete faster than the non-expedited ones,
> - *                          they never block, but have the downside of
> - *                          causing extra overhead.
> + *                          command returns 0 on success. The
> + *                          "expedited" commands complete faster than
> + *                          the non-expedited ones, they never block,
> + *                          but have the downside of causing extra
> + *                          overhead. A process needs to register its
> + *                          intent to use the private expedited command
> + *                          prior to using it, otherwise this command
> + *                          returns -EPERM.
> + * @MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED:
> + *                          Register the process intent to use
> + *                          MEMBARRIER_CMD_PRIVATE_EXPEDITED. Always
> + *                          returns 0.
>   *
>   * Command to be passed to the membarrier system call. The commands need=
 to
>   * be a single bit each, except for MEMBARRIER_CMD_QUERY which is assign=
ed to
>   * the value 0.
>   */
>  enum membarrier_cmd {
> -	MEMBARRIER_CMD_QUERY			=3D 0,
> -	MEMBARRIER_CMD_SHARED			=3D (1 << 0),
> +	MEMBARRIER_CMD_QUERY				=3D 0,
> +	MEMBARRIER_CMD_SHARED				=3D (1 << 0),
>  	/* reserved for MEMBARRIER_CMD_SHARED_EXPEDITED (1 << 1) */
>  	/* reserved for MEMBARRIER_CMD_PRIVATE (1 << 2) */
> -	MEMBARRIER_CMD_PRIVATE_EXPEDITED	=3D (1 << 3),
> +	MEMBARRIER_CMD_PRIVATE_EXPEDITED		=3D (1 << 3),
> +	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED	=3D (1 << 4),
>  };
> =20
>  #endif /* _UAPI_LINUX_MEMBARRIER_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index 78cb2461012e..a3dc6a66f0d1 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1400,6 +1400,9 @@ config MEMBARRIER
> =20
>  	  If unsure, say Y.
> =20
> +config ARCH_HAS_MEMBARRIER_HOOKS
> +	bool
> +
>  config EMBEDDED
>  	bool "Embedded system"
>  	option allnoconfig_y
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 10646182440f..bd4a93915e08 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1840,6 +1840,8 @@ static __latent_entropy struct task_struct *copy_pr=
ocess(
>  	 */
>  	copy_seccomp(p);
> =20
> +	membarrier_fork(p, clone_flags);
> +
>  	/*
>  	 * Process group and session signals need to be delivered to just the
>  	 * parent before the fork or both the parent and the child after the
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7977b25acf54..08095bb1cfe6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2643,17 +2643,8 @@ static struct rq *finish_task_switch(struct task_s=
truct *prev)
>  	 */
>  	prev_state =3D prev->state;
>  	vtime_task_switch(prev);
> +	membarrier_sched_in(prev, current);
>  	perf_event_task_sched_in(prev, current);
> -	/*
> -	 * The membarrier system call requires a full memory barrier
> -	 * after storing to rq->curr, before going back to user-space.
> -	 *
> -	 * TODO: This smp_mb__after_unlock_lock can go away if PPC end
> -	 * up adding a full barrier to switch_mm(), or we should figure
> -	 * out if a smp_mb__after_unlock_lock is really the proper API
> -	 * to use.
> -	 */
> -	smp_mb__after_unlock_lock();
>  	finish_lock_switch(rq, prev);
>  	finish_arch_post_lock_switch();
> =20
> @@ -3363,9 +3354,8 @@ static void __sched notrace __schedule(bool preempt)
>  		 * care of this barrier. For weakly ordered machines for
>  		 * which spin_unlock() acts as a RELEASE barrier (only
>  		 * arm64 and PowerPC), arm64 has a full barrier in
> -		 * switch_to(), and PowerPC has
> -		 * smp_mb__after_unlock_lock() before
> -		 * finish_lock_switch().
> +		 * switch_to(), and PowerPC has a full barrier in
> +		 * membarrier_arch_sched_in().
>  		 */
>  		++*switch_count;
> =20
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index a92fddc22747..00a2618a36ba 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -26,21 +26,25 @@
>   * except MEMBARRIER_CMD_QUERY.
>   */
>  #define MEMBARRIER_CMD_BITMASK	\
> -	(MEMBARRIER_CMD_SHARED | MEMBARRIER_CMD_PRIVATE_EXPEDITED)
> +	(MEMBARRIER_CMD_SHARED | MEMBARRIER_CMD_PRIVATE_EXPEDITED	\
> +	| MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED)
> =20
>  static void ipi_mb(void *info)
>  {
>  	smp_mb();	/* IPIs should be serializing but paranoid. */
>  }
> =20
> -static void membarrier_private_expedited(void)
> +static int membarrier_private_expedited(void)
>  {
>  	int cpu;
>  	bool fallback =3D false;
>  	cpumask_var_t tmpmask;
> =20
> +	if (!current->mm->membarrier_private_expedited)
> +		return -EPERM;
> +
>  	if (num_online_cpus() =3D=3D 1)
> -		return;
> +		return 0;
> =20
>  	/*
>  	 * Matches memory barriers around rq->curr modification in
> @@ -94,6 +98,17 @@ static void membarrier_private_expedited(void)
>  	 * rq->curr modification in scheduler.
>  	 */
>  	smp_mb();	/* exit from system call is not a mb */
> +	return 0;
> +}
> +
> +static void membarrier_register_private_expedited(void)
> +{
> +	struct task_struct *p =3D current;
> +
> +	if (READ_ONCE(p->mm->membarrier_private_expedited))
> +		return;
> +	WRITE_ONCE(p->mm->membarrier_private_expedited, 1);
> +	membarrier_arch_register_private_expedited(p);
>  }
> =20
>  /**
> @@ -144,7 +159,9 @@ SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
>  			synchronize_sched();
>  		return 0;
>  	case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
> -		membarrier_private_expedited();
> +		return membarrier_private_expedited();
> +	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED:
> +		membarrier_register_private_expedited();
>  		return 0;
>  	default:
>  		return -EINVAL;
> --=20
> 2.11.0
>=20

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlnEgcsACgkQSXnow7UH
+rjoQAf+I8BlwZwWcQxMNynX0PCYO/zuD3SHEu8kaWf9HjLd5Ut4YxmnOBDnZFGg
MVv0i8gwhqYKRNhayLR0p8Z478R6xAeAxVOv+9GdR6xS/CkDwhofEA9GWlrR27cD
pC7Hza+vnyDkNE64MhZKKE/eD+0qgNHppiVaTtspMWCvm20yTO6nkYHYsLqSQ+eQ
yO1zij6OeOopYCiWs2skFJ8u+rhWq5TqGaYeOzZ1iH/qcqa28Pc32m7waj8ziiCu
RJbiHsx+TQ75NOVTEOA6mB4tbG6VsPsZfh0ccco0cLN+TvrejoqysteU0g8K7fS6
8ANLk7U/1+a8jNcaEAY7ZYE19TfFYw==
=5KCk
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
