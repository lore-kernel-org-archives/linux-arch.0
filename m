Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39750 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfEAVsL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2019 17:48:11 -0400
Date: Wed, 1 May 2019 23:48:05 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4/5] x86: don't use asm-generic/ptrace.h
Message-ID: <20190501214805.GA54736@gmail.com>
References: <20190501173943.5688-1-hch@lst.de>
 <20190501173943.5688-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501173943.5688-5-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190501214805.LfNZnudQIZU7GoEIRdjDOKFFEJz5IJOg3Lif2a1tZjs@z>


* Christoph Hellwig <hch@lst.de> wrote:

> Doing the indirection through macros for the regs accessors just
> makes them harder to read, so implement the helpers directly.
> 
> Note that only the helpers actually used are implemented now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/ptrace.h | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
> index 8a7fc0cca2d1..9b81ef539eb3 100644
> --- a/arch/x86/include/asm/ptrace.h
> +++ b/arch/x86/include/asm/ptrace.h
> @@ -98,7 +98,6 @@ struct cpuinfo_x86;
>  struct task_struct;
>  
>  extern unsigned long profile_pc(struct pt_regs *regs);
> -#define profile_pc profile_pc
>  
>  extern unsigned long
>  convert_ip_to_linear(struct task_struct *child, struct pt_regs *regs);
> @@ -175,11 +174,31 @@ static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
>  }
>  #endif
>  
> -#define GET_IP(regs) ((regs)->ip)
> -#define GET_FP(regs) ((regs)->bp)
> -#define GET_USP(regs) ((regs)->sp)
> +static inline unsigned long instruction_pointer(struct pt_regs *regs)
> +{
> +	return regs->ip;
> +}
> +static inline void instruction_pointer_set(struct pt_regs *regs,

Nit: missing newline between inline functions.

> +		unsigned long val)
> +{
> +	regs->ip = val;
> +}
> +
> +static inline unsigned long frame_pointer(struct pt_regs *regs)
> +{
> +	return regs->bp;
> +}
>  
> -#include <asm-generic/ptrace.h>
> +static inline unsigned long user_stack_pointer(struct pt_regs *regs)
> +{
> +	return regs->sp;
> +}
> +
> +static inline void user_stack_pointer_set(struct pt_regs *regs,
> +		unsigned long val)
> +{
> +	regs->sp = val;
> +}

Other than that:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
