From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 17/24] riscv: use asm-generic/mmu_context.h for no-op implementations
Date: Thu, 30 Jul 2020 14:20:39 -0700 (PDT)
Message-ID: <mhng-5c1b7324-11f8-4334-bfc4-6fc1920aeaa3@palmerdabbelt-glaptop1>
References: <20200728033405.78469-18-npiggin@gmail.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200728033405.78469-18-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-arch@vger.kernel.org, npiggin@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, 27 Jul 2020 20:33:58 PDT (-0700), npiggin@gmail.com wrote:
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/riscv/include/asm/mmu_context.h | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
> index 67c463812e2d..250defa06f3a 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -13,34 +13,16 @@
>  #include <linux/mm.h>
>  #include <linux/sched.h>
>
> -static inline void enter_lazy_tlb(struct mm_struct *mm,
> -	struct task_struct *task)
> -{
> -}
> -
> -/* Initialize context-related info for a new mm_struct */
> -static inline int init_new_context(struct task_struct *task,
> -	struct mm_struct *mm)
> -{
> -	return 0;
> -}
> -
> -static inline void destroy_context(struct mm_struct *mm)
> -{
> -}
> -
>  void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	struct task_struct *task);
>
> +#define activate_mm activate_mm
>  static inline void activate_mm(struct mm_struct *prev,
>  			       struct mm_struct *next)
>  {
>  	switch_mm(prev, next, NULL);
>  }
>
> -static inline void deactivate_mm(struct task_struct *task,
> -	struct mm_struct *mm)
> -{
> -}
> +#include <asm-generic/mmu_context.h>
>
>  #endif /* _ASM_RISCV_MMU_CONTEXT_H */

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

I'm assuming this is going in along with the others.  Thanks!
