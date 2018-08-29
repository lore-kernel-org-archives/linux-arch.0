Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729155AbeH2To3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Aug 2018 15:44:29 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A841206B2
        for <linux-arch@vger.kernel.org>; Wed, 29 Aug 2018 15:46:57 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id b19-v6so5785940wme.3
        for <linux-arch@vger.kernel.org>; Wed, 29 Aug 2018 08:46:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180829081147.184610-3-namit@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com> <20180829081147.184610-3-namit@vmware.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 29 Aug 2018 08:46:35 -0700
Message-ID: <CALCETrX39hY28W9aFsFHGWO7f0qjzpwk5YDMFvfzLXON=PqPdw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] x86/mm: temporary mm struct
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20180829154635.duGzNqBmPWxuzc3zoRGeKx8vDtMGN1uDbNV0n5HdoCY@z>

Rik, this is the patch I was referring to.

On Wed, Aug 29, 2018 at 1:11 AM, Nadav Amit <namit@vmware.com> wrote:
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
>         return cr3;
>  }
>
> +typedef struct {
> +       struct mm_struct *prev;
> +} temporary_mm_state_t;
> +
> +static inline temporary_mm_state_t use_temporary_mm(struct mm_struct *mm)
> +{
> +       temporary_mm_state_t state;
> +
> +       lockdep_assert_irqs_disabled();
> +       state.prev = this_cpu_read(cpu_tlbstate.loaded_mm);
> +       switch_mm_irqs_off(NULL, mm, current);
> +       return state;
> +}
> +
> +static inline void unuse_temporary_mm(temporary_mm_state_t prev)
> +{
> +       lockdep_assert_irqs_disabled();
> +       switch_mm_irqs_off(NULL, prev.prev, current);
> +}
> +
>  #endif /* _ASM_X86_MMU_CONTEXT_H */
> --
> 2.17.1
>
