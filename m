From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC PATCH 02/16] arc: locks: remove unused arch_*_relax operations
Date: Mon, 24 Jun 2013 09:42:25 +0530
Message-ID: <51C7C729.2080601@synopsys.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com> <1371835057-19335-3-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:44378 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab3FXEMi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2013 00:12:38 -0400
In-Reply-To: <1371835057-19335-3-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org

Hi Will,

On 06/21/2013 10:47 PM, Will Deacon wrote:
> The arch_{spin,read,write}_relax macros are not used anywhere in the
> kernel and are typically just aliases for cpu_relax().
>
> This patch removes the unused definitions for Arc.

For consistency sake, can you please uppercase to ARC in changelog above. Same
goes for arc prefix in patch subject.

>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Vineet Gupta <vgupta@synopsys.com>

Thx,
-Vineet
> ---
>  arch/arc/include/asm/spinlock.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/arc/include/asm/spinlock.h b/arch/arc/include/asm/spinlock.h
> index f158197..fddced5 100644
> --- a/arch/arc/include/asm/spinlock.h
> +++ b/arch/arc/include/asm/spinlock.h
> @@ -137,8 +137,4 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
>  #define arch_read_lock_flags(lock, flags)	arch_read_lock(lock)
>  #define arch_write_lock_flags(lock, flags)	arch_write_lock(lock)
>  
> -#define arch_spin_relax(lock)	cpu_relax()
> -#define arch_read_relax(lock)	cpu_relax()
> -#define arch_write_relax(lock)	cpu_relax()
> -
>  #endif /* __ASM_SPINLOCK_H */
