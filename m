From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 18/28] ARC: add smp barriers around atomics per
 memory-barrriers.txt
Date: Tue, 9 Jun 2015 14:30:24 +0200
Message-ID: <20150609123024.GX3644@twins.programming.kicks-ass.net>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-19-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52402 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbbFIMab (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 08:30:31 -0400
Content-Disposition: inline
In-Reply-To: <1433850508-26317-19-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, arc-linux-dev@synopsys.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Tue, Jun 09, 2015 at 05:18:18PM +0530, Vineet Gupta wrote:

Please try and provide at least _some_ Changelog body.

<snip all atomic ops that return values>

> diff --git a/arch/arc/include/asm/spinlock.h b/arch/arc/include/asm/spinlock.h
> index b6a8c2dfbe6e..8af8eaad4999 100644
> --- a/arch/arc/include/asm/spinlock.h
> +++ b/arch/arc/include/asm/spinlock.h
> @@ -22,24 +22,32 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>  {
>  	unsigned int tmp = __ARCH_SPIN_LOCK_LOCKED__;
>  
> +	smp_mb();
> +
>  	__asm__ __volatile__(
>  	"1:	ex  %0, [%1]		\n"
>  	"	breq  %0, %2, 1b	\n"
>  	: "+&r" (tmp)
>  	: "r"(&(lock->slock)), "ir"(__ARCH_SPIN_LOCK_LOCKED__)
>  	: "memory");
> +
> +	smp_mb();
>  }
>  
>  static inline int arch_spin_trylock(arch_spinlock_t *lock)
>  {
>  	unsigned int tmp = __ARCH_SPIN_LOCK_LOCKED__;
>  
> +	smp_mb();
> +
>  	__asm__ __volatile__(
>  	"1:	ex  %0, [%1]		\n"
>  	: "+r" (tmp)
>  	: "r"(&(lock->slock))
>  	: "memory");
>  
> +	smp_mb();
> +
>  	return (tmp == __ARCH_SPIN_LOCK_UNLOCKED__);
>  }
>  

Both these are only required to provide an ACQUIRE barrier, if all you
have is smp_mb(), the second is sufficient.

Also note that a failed trylock is not required to provide _any_ barrier
at all.

> @@ -47,6 +55,8 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
>  {
>  	unsigned int tmp = __ARCH_SPIN_LOCK_UNLOCKED__;
>  
> +	smp_mb();
> +
>  	__asm__ __volatile__(
>  	"	ex  %0, [%1]		\n"
>  	: "+r" (tmp)

This requires a RELEASE barrier, again, if all you have is smp_mb(),
this is indeed correct.

Describing some of this would make for a fine Changelog body :-)
