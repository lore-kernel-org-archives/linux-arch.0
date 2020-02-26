Return-Path: <SRS0=hCVk=4O=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34866 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgBZViz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 16:38:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so229684plt.2
        for <linux-arch@vger.kernel.org>; Wed, 26 Feb 2020 13:38:55 -0800 (PST)
Date: Wed, 26 Feb 2020 13:38:53 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v7 11/11] arm64: mm: Display guarded pages in ptdump
Message-ID: <202002261338.9890367C@keescook>
References: <20200226155714.43937-1-broonie@kernel.org>
 <20200226155714.43937-12-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226155714.43937-12-broonie@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <20200226213853.tai05mkZaNB2TMyJFbxfragGREb5FGANsURbJ8vf7yg@z>

On Wed, Feb 26, 2020 at 03:57:14PM +0000, Mark Brown wrote:
> v8.5-BTI introduces the GP field in stage 1 translation tables which
> indicates that blocks and pages with it set are guarded pages for which
> branch target identification checks should be performed. Decode this
> when dumping the page tables to aid debugging.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/mm/dump.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index 860c00ec8bd3..78163b7a7dde 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -145,6 +145,11 @@ static const struct prot_bits pte_bits[] = {
>  		.val	= PTE_UXN,
>  		.set	= "UXN",
>  		.clear	= "   ",
> +	}, {
> +		.mask	= PTE_GP,
> +		.val	= PTE_GP,
> +		.set	= "GP",
> +		.clear	= "  ",
>  	}, {
>  		.mask	= PTE_ATTRINDX_MASK,
>  		.val	= PTE_ATTRINDX(MT_DEVICE_nGnRnE),
> -- 
> 2.20.1
> 

-- 
Kees Cook
