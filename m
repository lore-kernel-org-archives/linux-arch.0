From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v7 02/11] qspinlock, x86: Enable x86-64 to use queue
	spinlock
Date: Wed, 19 Mar 2014 16:24:05 -0400
Message-ID: <20140319202405.GA11210@phenom.dumpdata.com>
References: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com>
	<1395260049-30839-3-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1395260049-30839-3-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Boris Ostrovsky <boris.ostrovsky>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 19, 2014 at 04:14:00PM -0400, Waiman Long wrote:
> This patch makes the necessary changes at the x86 architecture
> specific layer to enable the use of queue spinlock for x86-64. As
> x86-32 machines are typically not multi-socket. The benefit of queue
> spinlock may not be apparent. So queue spinlock is not enabled.
> 
> Currently, there is some incompatibilities between the para-virtualized
> spinlock code (which hard-codes the use of ticket spinlock) and the
> queue spinlock. Therefore, the use of queue spinlock is disabled when
> the para-virtualized spinlock is enabled.

And how does this patch do that? I think that comment is obsolete?

> 
> The arch/x86/include/asm/qspinlock.h header file includes some x86
> specific optimization which will make the queue spinlock code perform
> better than the generic implementation.
> 
> Signed-off-by: Waiman Long <Waiman.Long@hp.com>
> Acked-by: Rik van Riel <riel@redhat.com>
> ---
>  arch/x86/Kconfig                      |    1 +
>  arch/x86/include/asm/qspinlock.h      |   41 +++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/spinlock.h       |    5 ++++
>  arch/x86/include/asm/spinlock_types.h |    4 +++
>  4 files changed, 51 insertions(+), 0 deletions(-)
>  create mode 100644 arch/x86/include/asm/qspinlock.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0af5250..de573f9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -17,6 +17,7 @@ config X86_64
>  	depends on 64BIT
>  	select X86_DEV_DMA_OPS
>  	select ARCH_USE_CMPXCHG_LOCKREF
> +	select ARCH_USE_QUEUE_SPINLOCK
>  
>  ### Arch settings
>  config X86
> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
> new file mode 100644
> index 0000000..44cefee
> --- /dev/null
> +++ b/arch/x86/include/asm/qspinlock.h
> @@ -0,0 +1,41 @@
> +#ifndef _ASM_X86_QSPINLOCK_H
> +#define _ASM_X86_QSPINLOCK_H
> +
> +#include <asm-generic/qspinlock_types.h>
> +
> +#if !defined(CONFIG_X86_OOSTORE) && !defined(CONFIG_X86_PPRO_FENCE)
> +
> +#define _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS
> +
> +/*
> + * x86-64 specific queue spinlock union structure
> + */
> +union arch_qspinlock {
> +	struct qspinlock slock;
> +	u8		 lock;	/* Lock bit	*/
> +};
> +
> +#define	queue_spin_unlock queue_spin_unlock
> +/**
> + * queue_spin_unlock - release a queue spinlock
> + * @lock : Pointer to queue spinlock structure
> + *
> + * No special memory barrier other than a compiler one is needed for the
> + * x86 architecture. A compiler barrier is added at the end to make sure
> + * that the clearing the lock bit is done ASAP without artificial delay
> + * due to compiler optimization.
> + */
> +static inline void queue_spin_unlock(struct qspinlock *lock)
> +{
> +	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
> +
> +	barrier();
> +	ACCESS_ONCE(qlock->lock) = 0;
> +	barrier();
> +}
> +
> +#endif /* !CONFIG_X86_OOSTORE && !CONFIG_X86_PPRO_FENCE */
> +
> +#include <asm-generic/qspinlock.h>
> +
> +#endif /* _ASM_X86_QSPINLOCK_H */
> diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
> index 0f62f54..958d20f 100644
> --- a/arch/x86/include/asm/spinlock.h
> +++ b/arch/x86/include/asm/spinlock.h
> @@ -42,6 +42,10 @@
>  extern struct static_key paravirt_ticketlocks_enabled;
>  static __always_inline bool static_key_false(struct static_key *key);
>  
> +#ifdef CONFIG_QUEUE_SPINLOCK
> +#include <asm/qspinlock.h>
> +#else
> +
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
>  
>  static inline void __ticket_enter_slowpath(arch_spinlock_t *lock)
> @@ -180,6 +184,7 @@ static __always_inline void arch_spin_lock_flags(arch_spinlock_t *lock,
>  {
>  	arch_spin_lock(lock);
>  }
> +#endif /* CONFIG_QUEUE_SPINLOCK */
>  
>  static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
>  {
> diff --git a/arch/x86/include/asm/spinlock_types.h b/arch/x86/include/asm/spinlock_types.h
> index 4f1bea1..7960268 100644
> --- a/arch/x86/include/asm/spinlock_types.h
> +++ b/arch/x86/include/asm/spinlock_types.h
> @@ -23,6 +23,9 @@ typedef u32 __ticketpair_t;
>  
>  #define TICKET_SHIFT	(sizeof(__ticket_t) * 8)
>  
> +#ifdef CONFIG_QUEUE_SPINLOCK
> +#include <asm-generic/qspinlock_types.h>
> +#else
>  typedef struct arch_spinlock {
>  	union {
>  		__ticketpair_t head_tail;
> @@ -33,6 +36,7 @@ typedef struct arch_spinlock {
>  } arch_spinlock_t;
>  
>  #define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
> +#endif /* CONFIG_QUEUE_SPINLOCK */
>  
>  #include <asm/rwlock.h>
>  
> -- 
> 1.7.1
> 
