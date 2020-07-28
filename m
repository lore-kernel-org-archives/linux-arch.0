From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 06/24] csky: use asm-generic/mmu_context.h for no-op implementations
Date: Tue, 28 Jul 2020 12:09:58 +0800
Message-ID: <CAJF2gTT-SmgFjyU5H75=xYihwKK5tSggGXP=D_4am06-wdLM4w@mail.gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com> <20200728033405.78469-7-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgG1EKL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jul 2020 00:10:11 -0400
In-Reply-To: <20200728033405.78469-7-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, linux-csky@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Tue, Jul 28, 2020 at 11:34 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/csky/include/asm/mmu_context.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
> index abdf1f1cb6ec..b227d29393a8 100644
> --- a/arch/csky/include/asm/mmu_context.h
> +++ b/arch/csky/include/asm/mmu_context.h
> @@ -24,11 +24,6 @@
>  #define cpu_asid(mm)           (atomic64_read(&mm->context.asid) & ASID_MASK)
>
>  #define init_new_context(tsk,mm)       ({ atomic64_set(&(mm)->context.asid, 0); 0; })
> -#define activate_mm(prev,next)         switch_mm(prev, next, current)
> -
> -#define destroy_context(mm)            do {} while (0)
> -#define enter_lazy_tlb(mm, tsk)                do {} while (0)
> -#define deactivate_mm(tsk, mm)         do {} while (0)
>
>  void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
>
> @@ -46,4 +41,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
>
>         flush_icache_deferred(next);
>  }
> +
> +#include <asm-generic/mmu_context.h>
> +
>  #endif /* __ASM_CSKY_MMU_CONTEXT_H */
> --
> 2.23.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
