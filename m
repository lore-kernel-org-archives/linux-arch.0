From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v2] asm-generic: simd: allow SIMD in process context with
 BH disabled
Date: Thu, 1 Jun 2017 17:48:46 +0100
Message-ID: <20170601164839.GE30160@e103592.cambridge.arm.com>
References: <20170601095532.16632-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751218AbdFAQs4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Jun 2017 12:48:56 -0400
Content-Disposition: inline
In-Reply-To: <20170601095532.16632-1-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arch@vger.kernel.org, Jason@zx2c4.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org

On Thu, Jun 01, 2017 at 09:55:32AM +0000, Ard Biesheuvel wrote:
> asm-generic supplies a header asm/simd.h which exports a single function
> may_use_simd(), which conveys whether the current context allows the SIMD
> register file or instructions to be used.
> 
> This header is included by crypto code shared between x86 and ARM/arm64,
> and which offloads SIMD processing to process context if required. The
> generic asm/simd.h is shared between ARM and arm64 at the moment, while
> x86 has its own implementation.
> 
> On arm64, we currently mostly ignore may_use_simd(), because arm64 allows
> kernel mode NEON in any context. However, this is due to change shortly
> when support for SVE is merged, at which point we will introduce an arm64
> specific implementation of asm/simd.h as well.
> 
> That leaves ARM, which only allows kernel mode NEON in process context,
> which makes the current generic implementation of may_use_simd() seem
> appropriate. However, given that in_interrupt() will return true when
> running in process context with bottom halves disabled, we may end up
> falling back to less optimized code unnecessarily, given that kernel
> mode NEON is perfectly usable in that case.
> 
> So redefine may_use_simd() to disallow SIMD only when running in NMI,
> hardirq or softirq context.
> 
> While we're at it, add some missing header file decorations such as
> a license header and include guards.
> 
> Reported-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Dave Martin <Dave.Martin@arm.com>
(for SVE interactions)

Cheers
---Dave

> ---
> v2: add !in_nmi() to may_use_simd() condition
>     include <linux/compiler.h> for __must_check
>     remove too elaborate comment
> 
>  include/asm-generic/simd.h | 22 +++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/asm-generic/simd.h b/include/asm-generic/simd.h
> index f57eb7b5c23b..ded4156421ff 100644
> --- a/include/asm-generic/simd.h
> +++ b/include/asm-generic/simd.h
> @@ -1,14 +1,30 @@
> +/*
> + * Copyright (C) 2013 - 2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
>  
> -#include <linux/hardirq.h>
> +#ifndef __ASM_SIMD_H
> +#define __ASM_SIMD_H
> +
> +#include <linux/compiler.h>
> +#include <linux/preempt.h>
> +#include <linux/types.h>
>  
>  /*
>   * may_use_simd - whether it is allowable at this time to issue SIMD
>   *                instructions or access the SIMD register file
>   *
>   * As architectures typically don't preserve the SIMD register file when
> - * taking an interrupt, !in_interrupt() should be a reasonable default.
> + * taking an interrupt, it is reasonable to define the default behavior
> + * of 'may_use_simd()' to be 'SIMD is only allowed when not handling any
> + * kind of interrupt'.
>   */
>  static __must_check inline bool may_use_simd(void)
>  {
> -	return !in_interrupt();
> +	return !in_nmi() && !in_irq() && !in_serving_softirq();
>  }
> +
> +#endif
> -- 
> 2.9.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
