From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 01/14] ARC: locks: remove redundant arch_*_relax
 operations
Date: Thu, 16 Jan 2014 18:55:18 +0000
Message-ID: <20140116185518.GL30257@mudshark.cambridge.arm.com>
References: <1384274872-26849-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43040 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750937AbaAPSzZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Jan 2014 13:55:25 -0500
Content-Disposition: inline
In-Reply-To: <1384274872-26849-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Hi Andrew,

On Tue, Nov 12, 2013 at 04:47:39PM +0000, Will Deacon wrote:
> Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
> remove the redundant definitions for ARC.
> 
> Acked-by: Vineet Gupta <vgupta@synopsys.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arc/include/asm/spinlock.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arc/include/asm/spinlock.h b/arch/arc/include/asm/spinlock.h
> index b6a8c2dfbe6e..a7211e411018 100644
> --- a/arch/arc/include/asm/spinlock.h
> +++ b/arch/arc/include/asm/spinlock.h
> @@ -144,8 +144,4 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
>  #define arch_read_lock_flags(lock, flags)	arch_read_lock(lock)
>  #define arch_write_lock_flags(lock, flags)	arch_write_lock(lock)
>  
> -#define arch_spin_relax(lock)	cpu_relax()
> -#define arch_read_relax(lock)	cpu_relax()
> -#define arch_write_relax(lock)	cpu_relax()
> -
>  #endif /* __ASM_SPINLOCK_H */

I've not heard anything on these patches and I don't think they've been
picked up anywhere either (at least, judging by the state of -next).

Shall I resend the series? It's a pretty mechanical clean-up.

Cheers,

Will
