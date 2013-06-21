From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 16/16] x86: locks: remove unused arch_*_relax
 operations
Date: Fri, 21 Jun 2013 22:48:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1306212247460.4013@ionos.tec.linutronix.de>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com> <1371835057-19335-17-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41465 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946077Ab3FUUsE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jun 2013 16:48:04 -0400
In-Reply-To: <1371835057-19335-17-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Fri, 21 Jun 2013, Will Deacon wrote:

> The arch_{spin,read,write}_relax macros are not used anywhere in the
> kernel and are typically just aliases for cpu_relax().
> 
> This patch removes the unused definitions for x86.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>


> ---
>  arch/x86/include/asm/spinlock.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
> index 33692ea..1088d8d 100644
> --- a/arch/x86/include/asm/spinlock.h
> +++ b/arch/x86/include/asm/spinlock.h
> @@ -229,10 +229,6 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
>  #undef WRITE_LOCK_SUB
>  #undef WRITE_LOCK_CMP
>  
> -#define arch_spin_relax(lock)	cpu_relax()
> -#define arch_read_relax(lock)	cpu_relax()
> -#define arch_write_relax(lock)	cpu_relax()
> -
>  /* The {read|write|spin}_lock() on x86 are full memory barriers. */
>  static inline void smp_mb__after_lock(void) { }
>  #define ARCH_HAS_SMP_MB_AFTER_LOCK
> -- 
> 1.8.2.2
> 
> 
