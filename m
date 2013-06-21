From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 12/16] powerpc: locks: remove unused arch_*_relax
 operations
Date: Sat, 22 Jun 2013 08:16:00 +1000
Message-ID: <1371852960.3944.79.camel@pasglop>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
	 <1371835057-19335-13-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59394 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423527Ab3FUWQI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Jun 2013 18:16:08 -0400
In-Reply-To: <1371835057-19335-13-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org

On Fri, 2013-06-21 at 18:17 +0100, Will Deacon wrote:
> The arch_{spin,read,write}_relax macros are not used anywhere in the
> kernel and are typically just aliases for cpu_relax().
> 
> This patch removes the unused definitions for PowerPC.
> 
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/powerpc/include/asm/spinlock.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> index 5b23f91..2d4a841 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -291,9 +291,5 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
>  #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
>  #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
>  
> -#define arch_spin_relax(lock)	__spin_yield(lock)
> -#define arch_read_relax(lock)	__rw_yield(lock)
> -#define arch_write_relax(lock)	__rw_yield(lock)
> -
>  #endif /* __KERNEL__ */
>  #endif /* __ASM_SPINLOCK_H */
