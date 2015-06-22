From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 3/3] locking/qrwlock: Don't contend with readers when
 setting _QW_WAITING
Date: Mon, 22 Jun 2015 17:21:23 +0100
Message-ID: <20150622162123.GI1583@arm.com>
References: <1434729002-57724-1-git-send-email-Waiman.Long@hp.com>
 <1434729002-57724-4-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49136 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbbFVQV2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Jun 2015 12:21:28 -0400
Content-Disposition: inline
In-Reply-To: <1434729002-57724-4-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

Hi Waiman,

On Fri, Jun 19, 2015 at 04:50:02PM +0100, Waiman Long wrote:
> The current cmpxchg() loop in setting the _QW_WAITING flag for writers
> in queue_write_lock_slowpath() will contend with incoming readers
> causing possibly extra cmpxchg() operations that are wasteful. This
> patch changes the code to do a byte cmpxchg() to eliminate contention
> with new readers.

[...]

> diff --git a/arch/x86/include/asm/qrwlock.h b/arch/x86/include/asm/qrwlock.h
> index a8810bf..5678b0a 100644
> --- a/arch/x86/include/asm/qrwlock.h
> +++ b/arch/x86/include/asm/qrwlock.h
> @@ -7,8 +7,7 @@
>  #define queued_write_unlock queued_write_unlock
>  static inline void queued_write_unlock(struct qrwlock *lock)
>  {
> -        barrier();
> -        ACCESS_ONCE(*(u8 *)&lock->cnts) = 0;
> +	smp_store_release(&lock->wmode, 0);
>  }
>  #endif

I reckon you could actually use this in the asm-generic header and remove
the x86 arch version altogether. Most architectures support single-copy
atomic byte access and those that don't (alpha?) can just not use qrwlock
(or override write_unlock with atomic_sub).

I already have a patch making this change, so I'm happy either way.

> diff --git a/include/asm-generic/qrwlock_types.h b/include/asm-generic/qrwlock_types.h
> index 4d76f24..d614cde 100644
> --- a/include/asm-generic/qrwlock_types.h
> +++ b/include/asm-generic/qrwlock_types.h
> @@ -3,13 +3,29 @@
>  
>  #include <linux/types.h>
>  #include <asm/spinlock_types.h>
> +#include <asm/byteorder.h>
>  
>  /*
>   * The queue read/write lock data structure
> + *
> + * The 32-bit count is divided into an 8-bit writer mode byte
> + * (least significant byte) and a 24-bit reader count.
> + *
>   */
>  
>  typedef struct qrwlock {
> -	atomic_t		cnts;
> +	union {
> +		atomic_t	cnts;
> +		struct {
> +#ifdef __LITTLE_ENDIAN
> +			u8	wmode;		/* Writer mode  */
> +			u8	rcnt[3];	/* Reader count */
> +#else
> +			u8	rcnt[3];	/* Reader count */
> +			u8	wmode;		/* Writer mode  */
> +#endif
> +		};
> +	};
>  	arch_spinlock_t		lock;
>  } arch_rwlock_t;
>  
> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> index 26ca0ca..a7ac2c5 100644
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -108,10 +108,8 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
>  	 * or wait for a previous writer to go away.
>  	 */
>  	for (;;) {
> -		cnts = atomic_read(&lock->cnts);
> -		if (!(cnts & _QW_WMASK) &&
> -		    (atomic_cmpxchg(&lock->cnts, cnts,
> -				    cnts | _QW_WAITING) == cnts))
> +		if (!READ_ONCE(lock->wmode) &&
> +		   (cmpxchg(&lock->wmode, 0, _QW_WAITING) == 0))
>  			break;

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
