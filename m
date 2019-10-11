Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35647 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfJKPbG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Oct 2019 11:31:06 -0400
Received: by mail-yw1-f67.google.com with SMTP id r134so3625832ywg.2
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2019 08:31:05 -0700 (PDT)
Subject: Re: [PATCH v2 08/12] arm64: BTI: Decode BYTPE bits when printing
 PSTATE
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-9-git-send-email-Dave.Martin@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <18c9318c-d122-b534-b526-318935d9e2cc@linaro.org>
Date: Fri, 11 Oct 2019 11:31:02 -0400
MIME-Version: 1.0
In-Reply-To: <1570733080-21015-9-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, =?UTF-8?Q?Kristina_Mart=c5=a1enko?= <kristina.martsenko@arm.com>, Mark Brown <broonie@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Sudakshina Das <sudi.das@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20191011153102.D3_rL3d3kEgXv4tt-rOpPBl-xdNt9sdoQZ1YhEveGEc@z>

On 10/10/19 2:44 PM, Dave Martin wrote:
>  #define PSR_IL_BIT		(1 << 20)
> -#define PSR_BTYPE_CALL		(2 << PSR_BTYPE_SHIFT)
> +
> +/* Convenience names for the values of PSTATE.BTYPE */
> +#define PSR_BTYPE_NONE		(0b00 << PSR_BTYPE_SHIFT)
> +#define PSR_BTYPE_JC		(0b01 << PSR_BTYPE_SHIFT)
> +#define PSR_BTYPE_C		(0b10 << PSR_BTYPE_SHIFT)
> +#define PSR_BTYPE_J		(0b11 << PSR_BTYPE_SHIFT)

It'd be nice to sort this patch earlier, so that ...

> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 4a3bd32..452ac5b 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -732,7 +732,7 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
>  
>  	if (system_supports_bti()) {
>  		regs->pstate &= ~PSR_BTYPE_MASK;
> -		regs->pstate |= PSR_BTYPE_CALL;
> +		regs->pstate |= PSR_BTYPE_C;
>  	}
>  
>  	if (ka->sa.sa_flags & SA_RESTORER)

... setup_return does not need to be adjusted a second time.

I don't see any other conflicts vs patch 5.


r~
