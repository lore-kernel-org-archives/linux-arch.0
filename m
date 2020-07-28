Return-Path: <SRS0=h896=BH=kvack.org=owner-linux-mm@kernel.org>
Date: Tue, 28 Jul 2020 12:54:10 +0200
From: peterz@infradead.org
Subject: Re: [PATCH 23/24] x86: use asm-generic/mmu_context.h for no-op
 implementations
Message-ID: <20200728105410.GU119549@hirez.programming.kicks-ass.net>
References: <20200728033405.78469-1-npiggin@gmail.com>
 <20200728033405.78469-24-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728033405.78469-24-npiggin@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200728105410.hEcI8SCgORqii4885OptWUj579flgeG76XYGtcOfFas@z>

On Tue, Jul 28, 2020 at 01:34:04PM +1000, Nicholas Piggin wrote:
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/include/asm/mmu_context.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 47562147e70b..255750548433 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -92,12 +92,14 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
>  }
>  #endif
>  
> +#define enter_lazy_tlb enter_lazy_tlb
>  extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
>  
>  /*
>   * Init a new mm.  Used on mm copies, like at fork()
>   * and on mm's that are brand-new, like at execve().
>   */
> +#define init_new_context init_new_context
>  static inline int init_new_context(struct task_struct *tsk,
>  				   struct mm_struct *mm)
>  {
> @@ -117,6 +119,8 @@ static inline int init_new_context(struct task_struct *tsk,
>  	init_new_context_ldt(mm);
>  	return 0;
>  }
> +
> +#define destroy_context destroy_context
>  static inline void destroy_context(struct mm_struct *mm)
>  {
>  	destroy_context_ldt(mm);
> @@ -215,4 +219,6 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
>  
>  unsigned long __get_current_cr3_fast(void);
>  
> +#include <asm-generic/mmu_context.h>
> +
>  #endif /* _ASM_X86_MMU_CONTEXT_H */
> -- 
> 2.23.0
> 
