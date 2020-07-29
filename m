From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH 14/24] openrisc: use asm-generic/mmu_context.h for no-op
 implementations
Date: Wed, 29 Jul 2020 20:45:54 +0900
Message-ID: <20200729114554.GG80756@lianli.shorne-pla.net>
References: <20200728033405.78469-1-npiggin@gmail.com>
 <20200728033405.78469-15-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2Lp6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jul 2020 07:45:58 -0400
Content-Disposition: inline
In-Reply-To: <20200728033405.78469-15-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org

On Tue, Jul 28, 2020 at 01:33:55PM +1000, Nicholas Piggin wrote:
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/openrisc/include/asm/mmu_context.h | 8 +++-----
>  arch/openrisc/mm/tlb.c                  | 2 ++
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/openrisc/include/asm/mmu_context.h b/arch/openrisc/include/asm/mmu_context.h
> index ced577542e29..a6702384c77d 100644
> --- a/arch/openrisc/include/asm/mmu_context.h
> +++ b/arch/openrisc/include/asm/mmu_context.h
> @@ -17,13 +17,13 @@
>  
>  #include <asm-generic/mm_hooks.h>
>  
> +#define init_new_context init_new_context
>  extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
> +#define destroy_context destroy_context
>  extern void destroy_context(struct mm_struct *mm);
>  extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  		      struct task_struct *tsk);
>  
> -#define deactivate_mm(tsk, mm)	do { } while (0)
> -
>  #define activate_mm(prev, next) switch_mm((prev), (next), NULL)
>  
>  /* current active pgd - this is similar to other processors pgd
> @@ -32,8 +32,6 @@ extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  
>  extern volatile pgd_t *current_pgd[]; /* defined in arch/openrisc/mm/fault.c */
>  
> -static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
> -{
> -}
> +#include <asm-generic/mmu_context.h>

This looks ok.

>  #endif
> diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
> index 4b680aed8f5f..821aab4cf3be 100644
> --- a/arch/openrisc/mm/tlb.c
> +++ b/arch/openrisc/mm/tlb.c
> @@ -159,6 +159,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>   * instance.
>   */
>  
> +#define init_new_context init_new_context
>  int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  {
>  	mm->context = NO_CONTEXT;
> @@ -170,6 +171,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>   * drops it.
>   */
>  
> +#define destroy_context destroy_context
>  void destroy_context(struct mm_struct *mm)
>  {
>  	flush_tlb_mm(mm);

I don't think we need the #define's in the .c file.  Do we?

-Stafford

> -- 
> 2.23.0
> 
