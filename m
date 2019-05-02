Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:56759 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfEBDab (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 May 2019 23:30:31 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/5] powerpc: don't use asm-generic/ptrace.h
In-Reply-To: <20190501173943.5688-3-hch@lst.de>
References: <20190501173943.5688-1-hch@lst.de> <20190501173943.5688-3-hch@lst.de>
Date: Thu, 02 May 2019 13:30:26 +1000
Message-ID: <87ftpxa5yl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190502033026.-kLatLSg9XS9q4VKUm8NIWLpkSWD2AbEzWaU33ZsCiA@z>

Christoph Hellwig <hch@lst.de> writes:

> Doing the indirection through macros for the regs accessors just
> makes them harder to read, so implement the helpers directly.
>
> Note that only the helpers actually used are implemented now.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/include/asm/ptrace.h | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)

Looks fine, thanks.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index 64271e562fed..5d30944f1f6b 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -108,18 +108,33 @@ struct pt_regs
>  
>  #ifndef __ASSEMBLY__
>  
> -#define GET_IP(regs)		((regs)->nip)
> -#define GET_USP(regs)		((regs)->gpr[1])
> -#define GET_FP(regs)		(0)
> -#define SET_FP(regs, val)
> +static inline unsigned long instruction_pointer(struct pt_regs *regs)
> +{
> +	return regs->nip;
> +}
> +
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +		unsigned long val)
> +{
> +	regs->nip = val;
> +}
> +
> +static inline unsigned long user_stack_pointer(struct pt_regs *regs)
> +{
> +	return regs->gpr[1];
> +}
> +
> +static inline unsigned long frame_pointer(struct pt_regs *regs)
> +{
> +	return 0;
> +}
>  
>  #ifdef CONFIG_SMP
>  extern unsigned long profile_pc(struct pt_regs *regs);
> -#define profile_pc profile_pc
> +#else
> +#define profile_pc(regs) instruction_pointer(regs)
>  #endif
>  
> -#include <asm-generic/ptrace.h>
> -
>  #define kernel_stack_pointer(regs) ((regs)->gpr[1])
>  static inline int is_syscall_success(struct pt_regs *regs)
>  {
> -- 
> 2.20.1
