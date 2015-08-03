From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v4 5/8] locking/qrwlock: implement queue_write_unlock
 using smp_store_release
Date: Mon, 03 Aug 2015 16:44:40 -0400
Message-ID: <55BFD2B8.7020509@hp.com>
References: <1438621351-15912-1-git-send-email-will.deacon@arm.com> <1438621351-15912-6-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g2t2354.austin.hp.com ([15.217.128.53]:53327 "EHLO
	g2t2354.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741AbbHCUor (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Aug 2015 16:44:47 -0400
In-Reply-To: <1438621351-15912-6-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, mingo@kernel.org

On 08/03/2015 01:02 PM, Will Deacon wrote:
> Since 536fa402221f ("compiler: Allow 1- and 2-byte smp_load_acquire()
> and smp_store_release()"), smp_store_release supports byte accesses, so
> use that in writer unlock and remove the conditional macro override.
>
> Signed-off-by: Will Deacon<will.deacon@arm.com>
> ---
>   arch/x86/include/asm/qrwlock.h | 10 ----------
>   include/asm-generic/qrwlock.h  |  9 +--------
>   2 files changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/arch/x86/include/asm/qrwlock.h b/arch/x86/include/asm/qrwlock.h
> index a8810bf135ab..c537cbb038a7 100644
> --- a/arch/x86/include/asm/qrwlock.h
> +++ b/arch/x86/include/asm/qrwlock.h
> @@ -2,16 +2,6 @@
>   #define _ASM_X86_QRWLOCK_H
>
>   #include<asm-generic/qrwlock_types.h>
> -
> -#ifndef CONFIG_X86_PPRO_FENCE
> -#define queued_write_unlock queued_write_unlock
> -static inline void queued_write_unlock(struct qrwlock *lock)
> -{
> -        barrier();
> -        ACCESS_ONCE(*(u8 *)&lock->cnts) = 0;
> -}
> -#endif
> -
>   #include<asm-generic/qrwlock.h>
>
>   #endif /* _ASM_X86_QRWLOCK_H */
> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
> index deb9e8b0eb9e..eb673dde8879 100644
> --- a/include/asm-generic/qrwlock.h
> +++ b/include/asm-generic/qrwlock.h
> @@ -134,21 +134,14 @@ static inline void queued_read_unlock(struct qrwlock *lock)
>   	atomic_sub(_QR_BIAS,&lock->cnts);
>   }
>
> -#ifndef queued_write_unlock
>   /**
>    * queued_write_unlock - release write lock of a queue rwlock
>    * @lock : Pointer to queue rwlock structure
>    */
>   static inline void queued_write_unlock(struct qrwlock *lock)
>   {
> -	/*
> -	 * If the writer field is atomic, it can be cleared directly.
> -	 * Otherwise, an atomic subtraction will be used to clear it.
> -	 */
> -	smp_mb__before_atomic();
> -	atomic_sub(_QW_LOCKED,&lock->cnts);
> +	smp_store_release((u8 *)&lock->cnts, 0);
>   }
> -#endif
>
>   /*
>    * Remapping rwlock architecture specific functions to the corresponding

Reviewed-by: Waiman Long <Waiman.Long@hp.com>
