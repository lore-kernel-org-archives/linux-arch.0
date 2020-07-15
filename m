From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 2/3] arm64: enable tlbi range instructions
Date: Wed, 15 Jul 2020 13:10:23 +0100
Message-ID: <20200715121023.GC2519@gaia>
References: <20200715071945.897-1-yezhenyu2@huawei.com>
 <20200715071945.897-3-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgGOMK3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 08:10:29 -0400
Content-Disposition: inline
In-Reply-To: <20200715071945.897-3-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com

On Wed, Jul 15, 2020 at 03:19:44PM +0800, Zhenyu Ye wrote:
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index a0d94d063fa8..4e823b97c92e 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -82,11 +82,18 @@ endif
>  # compiler to generate them and consequently to break the single image contract
>  # we pass it only to the assembler. This option is utilized only in case of non
>  # integrated assemblers.
> +ifneq ($(CONFIG_AS_HAS_ARMV8_4), y)
>  branch-prot-flags-$(CONFIG_AS_HAS_PAC) += -Wa,-march=armv8.3-a
>  endif
> +endif

I couldn't find a clear statement in the gas documentation on what
happens if multiple -march options are passed. I think it's safer to
avoid this here.

>  KBUILD_CFLAGS += $(branch-prot-flags-y)
>  
> +ifeq ($(CONFIG_AS_HAS_ARMV8_4), y)
> +# make sure to pass the newest target architecture to -march.
> +KBUILD_CFLAGS	+= -Wa,-march=armv8.4-a
> +endif

I have a suspicion both of these options will break the LLVM integrated
assembler but we don't officially support it on arm64 yet (-Wa, doesn't
seem to get passed to the integrated asm).

Thanks for the re-spin.

-- 
Catalin
