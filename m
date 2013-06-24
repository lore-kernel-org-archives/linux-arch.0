From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [RFC PATCH 06/16] cris: locks: remove unused arch_*_relax
 operations
Date: Mon, 24 Jun 2013 08:41:28 +0200
Message-ID: <20130624064128.GQ23735@axis.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
 <1371835057-19335-7-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from anubis.se.axis.com ([195.60.68.12]:47364 "EHLO
	anubis.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab3FXGsB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2013 02:48:01 -0400
Content-Disposition: inline
In-Reply-To: <1371835057-19335-7-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jespern@axis.com>

On Fri, Jun 21, 2013 at 07:17:27PM +0200, Will Deacon wrote:
> The arch_{spin,read,write}_relax macros are not used anywhere in the
> kernel and are typically just aliases for cpu_relax().
> 
> This patch removes the unused definitions for Cris.
> 
> Cc: Mikael Starvik <starvik@axis.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/cris/include/arch-v32/arch/spinlock.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/cris/include/arch-v32/arch/spinlock.h b/arch/cris/include/arch-v32/arch/spinlock.h
> index f132755..bf94cc6 100644
> --- a/arch/cris/include/arch-v32/arch/spinlock.h
> +++ b/arch/cris/include/arch-v32/arch/spinlock.h
> @@ -124,8 +124,4 @@ static  inline int arch_write_trylock(arch_rwlock_t *rw)
>  #define _raw_read_lock_flags(lock, flags) _raw_read_lock(lock)
>  #define _raw_write_lock_flags(lock, flags) _raw_write_lock(lock)
>  
> -#define arch_spin_relax(lock)	cpu_relax()
> -#define arch_read_relax(lock)	cpu_relax()
> -#define arch_write_relax(lock)	cpu_relax()
> -
>  #endif /* __ASM_ARCH_SPINLOCK_H */
> -- 
> 1.8.2.2

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
