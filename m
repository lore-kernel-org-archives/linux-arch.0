Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbfDBPcI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Apr 2019 11:32:08 -0400
Date: Tue, 2 Apr 2019 16:32:01 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] arm64: compat: Reduce address limit
Message-ID: <20190402153201.GA18557@fuggles.cambridge.arm.com>
References: <20190401113014.20866-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401113014.20866-1-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Jann Horn <jannh@google.com>, stable@vger.kernel.org
Message-ID: <20190402153201.VwdmkFjAOllO5pP7Z1Q9IJxY2XHxjyp6dR7LYd2o2gw@z>

On Mon, Apr 01, 2019 at 12:30:14PM +0100, Vincenzo Frascino wrote:
> Currently, compat tasks running on arm64 can allocate memory up to
> TASK_SIZE_32 (UL(0x100000000)).
> 
> This means that mmap() allocations, if we treat them as returning an
> array, are not compliant with the sections 6.5.8 of the C standard
> (C99) which states that: "If the expression P points to an element of
> an array object and the expression Q points to the last element of the
> same array object, the pointer expression Q+1 compares greater than P".
> 
> Redefine TASK_SIZE_32 to address the issue.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: <stable@vger.kernel.org>
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/processor.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 5d9ce62bdebd..9c831d9d3cd2 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -57,7 +57,15 @@
>  #define TASK_SIZE_64		(UL(1) << vabits_user)
>  
>  #ifdef CONFIG_COMPAT
> +#ifdef CONFIG_ARM64_64K_PAGES
> +/*
> + * With CONFIG_ARM64_64K_PAGES enabled, the last page is occupied
> + * by the compact vectors page.

s/compact/compat/

Will
