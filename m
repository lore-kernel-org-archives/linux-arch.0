Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbeH2Npe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Aug 2018 09:45:34 -0400
Date: Wed, 29 Aug 2018 18:49:25 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 2/6] x86/mm: temporary mm struct
Message-ID: <20180829184925.64caee4dadf705080373f84f@kernel.org>
In-Reply-To: <20180829081147.184610-3-namit@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
        <20180829081147.184610-3-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20180829094925.1qoqhJLwwPurn1vf9pEvqoEKQlxNdV-oxhJGTg8RUec@z>

On Wed, 29 Aug 2018 01:11:43 -0700
Nadav Amit <namit@vmware.com> wrote:

> From: Andy Lutomirski <luto@kernel.org>
> 
> Sometimes we want to set a temporary page-table entries (PTEs) in one of
> the cores, without allowing other cores to use - even speculatively -
> these mappings. There are two benefits for doing so:
> 
> (1) Security: if sensitive PTEs are set, temporary mm prevents their use
> in other cores. This hardens the security as it prevents exploding a
> dangling pointer to overwrite sensitive data using the sensitive PTE.
> 
> (2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
> remote page-tables.
> 
> To do so a temporary mm_struct can be used. Mappings which are private
> for this mm can be set in the userspace part of the address-space.
> During the whole time in which the temporary mm is loaded, interrupts
> must be disabled.
> 
> The first use-case for temporary PTEs, which will follow, is for poking
> the kernel text.
> 
> [ Commit message was written by Nadav ]
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/include/asm/mmu_context.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index eeeb9289c764..96afc8c0cf15 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -338,4 +338,24 @@ static inline unsigned long __get_current_cr3_fast(void)
>  	return cr3;
>  }
>  
> +typedef struct {
> +	struct mm_struct *prev;
> +} temporary_mm_state_t;
> +
> +static inline temporary_mm_state_t use_temporary_mm(struct mm_struct *mm)
> +{
> +	temporary_mm_state_t state;
> +
> +	lockdep_assert_irqs_disabled();
> +	state.prev = this_cpu_read(cpu_tlbstate.loaded_mm);
> +	switch_mm_irqs_off(NULL, mm, current);
> +	return state;
> +}

Hmm, why don't we return mm_struct *prev directly?

Thank you,

> +
> +static inline void unuse_temporary_mm(temporary_mm_state_t prev)
> +{
> +	lockdep_assert_irqs_disabled();
> +	switch_mm_irqs_off(NULL, prev.prev, current);
> +}
> +
>  #endif /* _ASM_X86_MMU_CONTEXT_H */
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
