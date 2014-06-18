From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 10/11] qspinlock: Paravirt support
Date: Wed, 18 Jun 2014 14:04:28 +0200
Message-ID: <53A1804C.4070304@redhat.com>
References: <20140615124657.264658593@chello.nl>
	<20140615130154.213923590@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140615130154.213923590@chello.nl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Waiman.Long@hp.com, tglx@linutronix.de, mingo@kernel.org
Cc: linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Il 15/06/2014 14:47, Peter Zijlstra ha scritto:
>
>
>  #if !defined(CONFIG_X86_OOSTORE) && !defined(CONFIG_X86_PPRO_FENCE)
>
> -#define	queue_spin_unlock queue_spin_unlock
>  /**
>   * queue_spin_unlock - release a queue spinlock
>   * @lock : Pointer to queue spinlock structure
>   *
>   * An effective smp_store_release() on the least-significant byte.
>   */
> -static inline void queue_spin_unlock(struct qspinlock *lock)
> +static inline void native_queue_unlock(struct qspinlock *lock)
>  {
>  	barrier();
>  	ACCESS_ONCE(*(u8 *)lock) = 0;
>  }
>
> +#else
> +
> +static inline void native_queue_unlock(struct qspinlock *lock)
> +{
> +	atomic_dec(&lock->val);
> +}
> +
>  #endif /* !CONFIG_X86_OOSTORE && !CONFIG_X86_PPRO_FENCE */


Should be (part of) an earlier patch?  Also, does it get wrong if 
(CONFIG_X86_OOSTORE || CONFIG_X86_PPRO_FENCE) && paravirt patches the 
unlock to a single movb?  Of course the paravirt spinlocks could simply 
depend on !CONFIG_X86_OOSTORE && !CONFIG_X86_PPRO_FENCE.

> +
> +#define INVALID_HEAD	-1
> +#define NO_HEAD		nr_cpu_ids
> +

-2, like Waiman said.

Paolo
