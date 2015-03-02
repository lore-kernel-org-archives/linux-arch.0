From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 3/4] arm64: add support for memtest
Date: Mon, 2 Mar 2015 18:56:07 +0000
Message-ID: <20150302185607.GG7919@arm.com>
References: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
 <1425308145-20769-4-git-send-email-vladimir.murzin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48389 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753614AbbCBS4H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Mar 2015 13:56:07 -0500
Content-Disposition: inline
In-Reply-To: <1425308145-20769-4-git-send-email-vladimir.murzin@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vladimir Murzin <Vladimir.Murzin@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>

On Mon, Mar 02, 2015 at 02:55:44PM +0000, Vladimir Murzin wrote:
> Add support for memtest command line option.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm64/mm/init.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index ae85da6..597831b 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -190,6 +190,8 @@ void __init bootmem_init(void)
>  	min = PFN_UP(memblock_start_of_DRAM());
>  	max = PFN_DOWN(memblock_end_of_DRAM());
>  
> +	early_memtest(min << PAGE_SHIFT, max << PAGE_SHIFT);
> +
>  	/*
>  	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
>  	 * done after the fixed reservations.

This is really neat, thanks for doing this Vladimir!

  Acked-by: Will Deacon <will.deacon@arm.com>

For the series, modulo Baruch's comments about Documentation updates.

Will
