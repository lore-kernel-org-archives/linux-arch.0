Return-Path: <SRS0=sCZJ=AQ=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44784 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728071AbgGETAb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Jul 2020 15:00:31 -0400
Subject: Re: [PATCH v2 5/6] powerpc/pseries: implement paravirt qspinlocks for
 SPLPAR
References: <20200703073516.1354108-1-npiggin@gmail.com>
 <20200703073516.1354108-6-npiggin@gmail.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <81d9981b-8a20-729c-b861-c7229e40bb65@redhat.com>
Date: Sun, 5 Jul 2020 15:00:21 -0400
MIME-Version: 1.0
In-Reply-To: <20200703073516.1354108-6-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200705190021.MKNwyKvrO3MAQjCma4RwVIAgEqs6Dud8ZvHh7Ph_lZc@z>

On 7/3/20 3:35 AM, Nicholas Piggin wrote:
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/include/asm/paravirt.h           | 28 ++++++++++
>   arch/powerpc/include/asm/qspinlock.h          | 55 +++++++++++++++++++
>   arch/powerpc/include/asm/qspinlock_paravirt.h |  5 ++
>   arch/powerpc/platforms/pseries/Kconfig        |  5 ++
>   arch/powerpc/platforms/pseries/setup.c        |  6 +-
>   include/asm-generic/qspinlock.h               |  2 +
>   6 files changed, 100 insertions(+), 1 deletion(-)
>   create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
>
> diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
> index 7a8546660a63..f2d51f929cf5 100644
> --- a/arch/powerpc/include/asm/paravirt.h
> +++ b/arch/powerpc/include/asm/paravirt.h
> @@ -29,6 +29,16 @@ static inline void yield_to_preempted(int cpu, u32 yield_count)
>   {
>   	plpar_hcall_norets(H_CONFER, get_hard_smp_processor_id(cpu), yield_count);
>   }
> +
> +static inline void prod_cpu(int cpu)
> +{
> +	plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
> +}
> +
> +static inline void yield_to_any(void)
> +{
> +	plpar_hcall_norets(H_CONFER, -1, 0);
> +}
>   #else
>   static inline bool is_shared_processor(void)
>   {
> @@ -45,6 +55,19 @@ static inline void yield_to_preempted(int cpu, u32 yield_count)
>   {
>   	___bad_yield_to_preempted(); /* This would be a bug */
>   }
> +
> +extern void ___bad_yield_to_any(void);
> +static inline void yield_to_any(void)
> +{
> +	___bad_yield_to_any(); /* This would be a bug */
> +}
> +
> +extern void ___bad_prod_cpu(void);
> +static inline void prod_cpu(int cpu)
> +{
> +	___bad_prod_cpu(); /* This would be a bug */
> +}
> +
>   #endif
>   
>   #define vcpu_is_preempted vcpu_is_preempted
> @@ -57,5 +80,10 @@ static inline bool vcpu_is_preempted(int cpu)
>   	return false;
>   }
>   
> +static inline bool pv_is_native_spin_unlock(void)
> +{
> +     return !is_shared_processor();
> +}
> +
>   #endif /* __KERNEL__ */
>   #endif /* __ASM_PARAVIRT_H */
> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
> index c49e33e24edd..0960a0de2467 100644
> --- a/arch/powerpc/include/asm/qspinlock.h
> +++ b/arch/powerpc/include/asm/qspinlock.h
> @@ -3,9 +3,36 @@
>   #define _ASM_POWERPC_QSPINLOCK_H
>   
>   #include <asm-generic/qspinlock_types.h>
> +#include <asm/paravirt.h>
>   
>   #define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
>   
> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
> +extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> +extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> +
> +static __always_inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> +{
> +	if (!is_shared_processor())
> +		native_queued_spin_lock_slowpath(lock, val);
> +	else
> +		__pv_queued_spin_lock_slowpath(lock, val);
> +}

In a previous mail, I said that:

You may need to match the use of __pv_queued_spin_lock_slowpath() with 
the corresponding __pv_queued_spin_unlock(), e.g.

#define queued_spin_unlock queued_spin_unlock
static inline queued_spin_unlock(struct qspinlock *lock)
{
         if (!is_shared_processor())
                 smp_store_release(&lock->locked, 0);
         else
                 __pv_queued_spin_unlock(lock);
}

Otherwise, pv_kick() will never be called.

Maybe PowerPC HMT is different that the shared cpus can still process 
instruction, though slower, that cpu kicking like what was done in kvm 
is not really necessary. If that is the case, I think we should document 
that.

Cheers,
Longman
