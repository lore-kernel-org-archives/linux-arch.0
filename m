Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34926 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbfC2P7m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Mar 2019 11:59:42 -0400
Date: Fri, 29 Mar 2019 15:59:37 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 5/5] arm64: compat: Reduce address limit
Message-ID: <20190329155937.GA48010@arrakis.emea.arm.com>
References: <20190319151542.19557-1-vincenzo.frascino@arm.com>
 <20190319151542.19557-6-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319151542.19557-6-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Jann Horn <jannh@google.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190329155937.lxfclHCFJLK6160Ds8UvGapzx6Mcs1oddpzZG_50hNI@z>

On Tue, Mar 19, 2019 at 03:15:42PM +0000, Vincenzo Frascino wrote:
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
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/processor.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 07c873fce961..4c689740940d 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -57,7 +57,7 @@
>  #define TASK_SIZE_64		(UL(1) << vabits_user)
>  
>  #ifdef CONFIG_COMPAT
> -#define TASK_SIZE_32		UL(0x100000000)
> +#define TASK_SIZE_32		(UL(0x100000000) - PAGE_SIZE)
>  #define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
>  				TASK_SIZE_32 : TASK_SIZE_64)
>  #define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \

So what I meant with the previous comment, can we have this:

#ifndef CONFIG_ARM64_64K_PAGES
#define TASK_SIZE_32		(UK(0x100000000) - PAGE_SIZE)
#endif

and still have a vectors page with 64K configuration? Assuming that it
is not unmapped, an mmap() wouldn't return the 0xffff0000 page to break
the C99 requirements. There is the case of user unmapping the vectors
page (which seems to be allowed based on my reading of the code) and
then getting an mmap() at the end for the 32-bit address range but I
really don't think we should cover for this case.

Another option which I think would cover the unmap case as well in all
configurations is to handle the limit in arch_get_mmap_end(). We already
define this to handle mmap limitation on 52-bit user VA but you can make
it handle compat tasks (and probably turn it into a static inline
function).

The other patches for splitting the vectors page in two are still valid
(to be on par with arm32) but they would not be required for this fix.

-- 
Catalin
