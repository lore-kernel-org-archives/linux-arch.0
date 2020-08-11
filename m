Return-Path: <SRS0=iceZ=BV=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail29.static.mailgun.info ([104.130.122.29]:29845 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgHKSfB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Aug 2020 14:35:01 -0400
Reply-To: <bcain@codeaurora.org>
From: "Brian Cain" <bcain@codeaurora.org>
References: <20200728033405.78469-1-npiggin@gmail.com> <20200728033405.78469-8-npiggin@gmail.com>
In-Reply-To: <20200728033405.78469-8-npiggin@gmail.com>
Subject: RE: [PATCH 07/24] hexagon: use asm-generic/mmu_context.h for no-op implementations
Date: Tue, 11 Aug 2020 13:34:52 -0500
Message-ID: <037d01d6700e$1af0a580$50d1f080$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Nicholas Piggin' <npiggin@gmail.com>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 'Arnd Bergmann' <arnd@arndb.de>, linux-hexagon@vger.kernel.org
Message-ID: <20200811183452.Jvax36VMAMhbpeJ99MLBkHVmfQac9qts0SMd4_puBDQ@z>


> -----Original Message-----
> From: linux-arch-owner@vger.kernel.org <linux-arch-owner@vger.kernel.org>
> On Behalf Of Nicholas Piggin

Acked-by: Brian Cain <bcain@codeaurora.org>

 
> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/hexagon/include/asm/mmu_context.h | 33 ++++----------------------
>  1 file changed, 5 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/hexagon/include/asm/mmu_context.h
> b/arch/hexagon/include/asm/mmu_context.h
> index cdc4adc0300a..81947764c47d 100644
> --- a/arch/hexagon/include/asm/mmu_context.h
> +++ b/arch/hexagon/include/asm/mmu_context.h
> @@ -15,39 +15,13 @@
>  #include <asm/pgalloc.h>
>  #include <asm/mem-layout.h>
> 
> -static inline void destroy_context(struct mm_struct *mm) -{ -}
> -
>  /*
>   * VM port hides all TLB management, so "lazy TLB" isn't very
>   * meaningful.  Even for ports to architectures with visble TLBs,
>   * this is almost invariably a null function.
> + *
> + * mm->context is set up by pgd_alloc, so no init_new_context required.
>   */
> -static inline void enter_lazy_tlb(struct mm_struct *mm,
> -	struct task_struct *tsk)
> -{
> -}
> -
> -/*
> - * Architecture-specific actions, if any, for memory map deactivation.
> - */
> -static inline void deactivate_mm(struct task_struct *tsk,
> -	struct mm_struct *mm)
> -{
> -}
> -
> -/**
> - * init_new_context - initialize context related info for new mm_struct
> instance
> - * @tsk: pointer to a task struct
> - * @mm: pointer to a new mm struct
> - */
> -static inline int init_new_context(struct task_struct *tsk,
> -					struct mm_struct *mm)
> -{
> -	/* mm->context is set up by pgd_alloc */
> -	return 0;
> -}
> 
>  /*
>   *  Switch active mm context
> @@ -74,6 +48,7 @@ static inline void switch_mm(struct mm_struct *prev,
> struct mm_struct *next,
>  /*
>   *  Activate new memory map for task
>   */
> +#define activate_mm activate_mm
>  static inline void activate_mm(struct mm_struct *prev, struct mm_struct
> *next)  {
>  	unsigned long flags;
> @@ -86,4 +61,6 @@ static inline void activate_mm(struct mm_struct *prev,
> struct mm_struct *next)
>  /*  Generic hooks for arch_dup_mmap and arch_exit_mmap  */  #include
> <asm-generic/mm_hooks.h>
> 
> +#include <asm-generic/mmu_context.h>
> +
>  #endif
> --
> 2.23.0
