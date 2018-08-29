From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 4/6] x86/alternatives: initializing temporary mm for
 patching
Date: Wed, 29 Aug 2018 22:21:49 +0900
Message-ID: <20180829222149.adfeee806322a332bb1e4ab9@kernel.org>
References: <20180829081147.184610-1-namit@vmware.com>
        <20180829081147.184610-5-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829081147.184610-5-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 29 Aug 2018 01:11:45 -0700
Nadav Amit <namit@vmware.com> wrote:

> To prevent improper use of the PTEs that are used for text patching, we
> want to use a temporary mm struct. We initailize it by copying the init
> mm.
> 
> The address that will be used for patching is taken from the lower area
> that is usually used for the task memory. Doing so prevents the need to
> frequently synchronize the temporary-mm (e.g., when BPF programs are
> installed), since different PGDs are used for the task memory.
> 
> Finally, we randomize the address of the PTEs to harden against exploits
> that use these PTEs.
> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/include/asm/pgtable.h       |  4 ++++
>  arch/x86/include/asm/text-patching.h |  2 ++
>  arch/x86/mm/init_64.c                | 35 ++++++++++++++++++++++++++++
>  include/asm-generic/pgtable.h        |  4 ++++
>  init/main.c                          |  1 +
>  5 files changed, 46 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index e4ffa565a69f..c65d2b146ff6 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1022,6 +1022,10 @@ static inline void __meminit init_trampoline_default(void)
>  	/* Default trampoline pgd value */
>  	trampoline_pgd_entry = init_top_pgt[pgd_index(__PAGE_OFFSET)];
>  }
> +
> +void __init poking_init(void);
> +#define poking_init poking_init

Would we need this macro?

> +
>  # ifdef CONFIG_RANDOMIZE_MEMORY
>  void __meminit init_trampoline(void);
>  # else
> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
> index e85ff65c43c3..ffe7902cc326 100644
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -38,5 +38,7 @@ extern void *text_poke(void *addr, const void *opcode, size_t len);
>  extern int poke_int3_handler(struct pt_regs *regs);
>  extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
>  extern int after_bootmem;
> +extern __ro_after_init struct mm_struct *poking_mm;
> +extern __ro_after_init unsigned long poking_addr;
>  
>  #endif /* _ASM_X86_TEXT_PATCHING_H */
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index dd519f372169..ed4a46a89946 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -33,6 +33,7 @@
>  #include <linux/nmi.h>
>  #include <linux/gfp.h>
>  #include <linux/kcore.h>
> +#include <linux/sched/mm.h>
>  
>  #include <asm/processor.h>
>  #include <asm/bios_ebda.h>
> @@ -54,6 +55,7 @@
>  #include <asm/init.h>
>  #include <asm/uv/uv.h>
>  #include <asm/setup.h>
> +#include <asm/text-patching.h>
>  
>  #include "mm_internal.h"
>  
> @@ -1389,6 +1391,39 @@ unsigned long memory_block_size_bytes(void)
>  	return memory_block_size_probed;
>  }
>  
> +/*
> + * Initialize an mm_struct to be used during poking and a pointer to be used
> + * during patching. If anything fails during initialization, poking will be done
> + * using the fixmap, which is unsafe, so warn the user about it.
> + */
> +void __init poking_init(void)
> +{
> +	unsigned long poking_addr;
> +
> +	poking_mm = copy_init_mm();
> +	if (!poking_mm)
> +		goto error;
> +
> +	/*
> +	 * Randomize the poking address, but make sure that the following page
> +	 * will be mapped at the same PMD. We need 2 pages, so find space for 3,
> +	 * and adjust the address if the PMD ends after the first one.
> +	 */
> +	poking_addr = TASK_UNMAPPED_BASE +
> +		(kaslr_get_random_long("Poking") & PAGE_MASK) %
> +		(TASK_SIZE - TASK_UNMAPPED_BASE - 3 * PAGE_SIZE);
> +
> +	if (((poking_addr + PAGE_SIZE) & ~PMD_MASK) == 0)
> +		poking_addr += PAGE_SIZE;
> +
> +	return;
> +error:
> +	if (poking_mm)
> +		mmput(poking_mm);
> +	poking_mm = NULL;

At this point, only poking_mm == NULL case jumps into error. So we don't
need above 3 lines.

> +	pr_err("x86/mm: error setting a separate poking address space\n");
> +}
> +
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
>  /*
>   * Initialise the sparsemem vmemmap using huge-pages at the PMD level.
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 88ebc6102c7c..c66579d0ee67 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -1111,6 +1111,10 @@ static inline bool arch_has_pfn_modify_check(void)
>  
>  #ifndef PAGE_KERNEL_EXEC
>  # define PAGE_KERNEL_EXEC PAGE_KERNEL
> +
> +#ifndef poking_init
> +static inline void poking_init(void) { }
> +#endif

Hmm, this seems a bit tricky. Maybe we can make an __weak function
in init/main.c.

Thank you,

>  #endif
>  
>  #endif /* !__ASSEMBLY__ */
> diff --git a/init/main.c b/init/main.c
> index 18f8f0140fa0..6754ff2687c8 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -725,6 +725,7 @@ asmlinkage __visible void __init start_kernel(void)
>  	taskstats_init_early();
>  	delayacct_init();
>  
> +	poking_init();
>  	check_bugs();
>  
>  	acpi_subsystem_init();
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
