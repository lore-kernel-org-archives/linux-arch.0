From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v4 6/8] locking/qrwlock: make use of acquire/release/relaxed
 atomics
Date: Mon, 03 Aug 2015 16:49:26 -0400
Message-ID: <55BFD3D6.8000905@hp.com>
References: <1438621351-15912-1-git-send-email-will.deacon@arm.com> <1438621351-15912-7-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438621351-15912-7-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On 08/03/2015 01:02 PM, Will Deacon wrote:
> The qrwlock implementation is slightly heavy in its use of memory
> barriers, mainly through the use of cmpxchg and _return atomics, which
> imply full barrier semantics.
>
> This patch modifies the qrwlock code to use the more relaxed atomic
> routines so that we can reduce the unnecessary barrier overhead on
> weakly-ordered architectures.
>
> Signed-off-by: Will Deacon<will.deacon@arm.com>
> ---
>   include/asm-generic/qrwlock.h | 13 ++++++-------
>   kernel/locking/qrwlock.c      | 23 +++++++++++++++--------
>   2 files changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
> index eb673dde8879..54a8e65e18b6 100644
> --- a/include/asm-generic/qrwlock.h
> +++ b/include/asm-generic/qrwlock.h
> @@ -68,7 +68,7 @@ static inline int queued_read_trylock(struct qrwlock *lock)
>
>   	cnts = atomic_read(&lock->cnts);
>   	if (likely(!(cnts&  _QW_WMASK))) {
> -		cnts = (u32)atomic_add_return(_QR_BIAS,&lock->cnts);
> +		cnts = (u32)atomic_add_return_acquire(_QR_BIAS,&lock->cnts);
>   		if (likely(!(cnts&  _QW_WMASK)))
>   			return 1;
>   		atomic_sub(_QR_BIAS,&lock->cnts);
> @@ -89,8 +89,8 @@ static inline int queued_write_trylock(struct qrwlock *lock)
>   	if (unlikely(cnts))
>   		return 0;
>
> -	return likely(atomic_cmpxchg(&lock->cnts,
> -				     cnts, cnts | _QW_LOCKED) == cnts);
> +	return likely(atomic_cmpxchg_acquire(&lock->cnts,
> +					     cnts, cnts | _QW_LOCKED) == cnts);
>   }
>   /**
>    * queued_read_lock - acquire read lock of a queue rwlock
> @@ -100,7 +100,7 @@ static inline void queued_read_lock(struct qrwlock *lock)
>   {
>   	u32 cnts;
>
> -	cnts = atomic_add_return(_QR_BIAS,&lock->cnts);
> +	cnts = atomic_add_return_acquire(_QR_BIAS,&lock->cnts);
>   	if (likely(!(cnts&  _QW_WMASK)))
>   		return;
>
> @@ -115,7 +115,7 @@ static inline void queued_read_lock(struct qrwlock *lock)
>   static inline void queued_write_lock(struct qrwlock *lock)
>   {
>   	/* Optimize for the unfair lock case where the fair flag is 0. */
> -	if (atomic_cmpxchg(&lock->cnts, 0, _QW_LOCKED) == 0)
> +	if (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0)
>   		return;
>
>   	queued_write_lock_slowpath(lock);
> @@ -130,8 +130,7 @@ static inline void queued_read_unlock(struct qrwlock *lock)
>   	/*
>   	 * Atomically decrement the reader count
>   	 */
> -	smp_mb__before_atomic();
> -	atomic_sub(_QR_BIAS,&lock->cnts);
> +	(void)atomic_sub_return_release(_QR_BIAS,&lock->cnts);
>   }
>
>   /**
> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> index d9c36c5f5711..fb4ef2d636f2 100644
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -55,7 +55,7 @@ rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
>   {
>   	while ((cnts&  _QW_WMASK) == _QW_LOCKED) {
>   		cpu_relax_lowlatency();
> -		cnts = smp_load_acquire((u32 *)&lock->cnts);
> +		cnts = atomic_read_acquire(&lock->cnts);
>   	}
>   }
>
> @@ -74,8 +74,9 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
>   		 * Readers in interrupt context will get the lock immediately
>   		 * if the writer is just waiting (not holding the lock yet).
>   		 * The rspin_until_writer_unlock() function returns immediately
> -		 * in this case. Otherwise, they will spin until the lock
> -		 * is available without waiting in the queue.
> +		 * in this case. Otherwise, they will spin (with ACQUIRE
> +		 * semantics) until the lock is available without waiting in
> +		 * the queue.
>   		 */
>   		rspin_until_writer_unlock(lock, cnts);
>   		return;
> @@ -97,7 +98,13 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
>   	while (atomic_read(&lock->cnts)&  _QW_WMASK)
>   		cpu_relax_lowlatency();
>
> -	cnts = atomic_add_return(_QR_BIAS,&lock->cnts) - _QR_BIAS;
> +	cnts = atomic_add_return_relaxed(_QR_BIAS,&lock->cnts) - _QR_BIAS;
> +
> +	/*
> +	 * The ACQUIRE semantics of the spinning code ensure that
> +	 * accesses can't leak upwards out of our subsequent critical
> +	 * section.
> +	 */

Maybe you should be more specific to mention the arch_spin_lock() call 
above. Other than that,

Reviewed-by: Waiman Long <Waiman.Long@hp.com>
