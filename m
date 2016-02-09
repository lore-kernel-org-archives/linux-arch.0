From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] asm-generic: Fix build when __set_fixmap is absent
Date: Tue, 9 Feb 2016 17:27:16 +0000
Message-ID: <20160209172716.GJ16122@e104818-lin.cambridge.arm.com>
References: <20160209143554.GA9332@leverpostej>
 <201602100053.LjML6D6b%fengguang.wu@intel.com>
 <20160209163333.GA22110@leverpostej>
 <20160209165234.GI16122@e104818-lin.cambridge.arm.com>
 <20160209172125.GA4348@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160209172125.GA4348@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, Laura Abbott <labbott@fedoraproject.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 09, 2016 at 05:21:26PM +0000, Mark Rutland wrote:
> From 6d283603d18071690dc138e4a0591a445a1d1e30 Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Tue, 9 Feb 2016 17:08:26 +0000
> Subject: [PATCH] asm-generic: make __set_fixmap_offset a macro again
> 
> Turning __set_fixmap_offset into a static inline breaks the build for
> several architectures. Fixing this properly requires updates to a number
> of architectures to make them agree on the prototype of __set_fixmap.
> 
> For the timebeing, restore __set_fixmap_offset to its prior state as a
> macro function, reverting commit ac4c0ac73485867c ("asm-generic: make
> __set_fixmap_offset a static inline"). To avoid the original issue with
> namespace clashes, 'addr' is prefixed with a liberal sprinking of
> underscores.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  include/asm-generic/fixmap.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
> index f9c27b6..827e4d3 100644
> --- a/include/asm-generic/fixmap.h
> +++ b/include/asm-generic/fixmap.h
> @@ -70,13 +70,13 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
>  #endif
>  
>  /* Return a pointer with offset calculated */
> -static inline unsigned long __set_fixmap_offset(enum fixed_addresses idx,
> -						phys_addr_t phys,
> -						pgprot_t flags)
> -{
> -	__set_fixmap(idx, phys, flags);
> -	return fix_to_virt(idx) + (phys & (PAGE_SIZE - 1));
> -}
> +#define __set_fixmap_offset(idx, phys, flags)				\
> +({									\
> +	unsigned long ________addr;					\
> +	__set_fixmap(idx, phys, flags);					\
> +	________addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));	\
> +	________addr;							\
> +})
>  
>  #define set_fixmap_offset(idx, phys) \
>  	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
> -- 
> 1.9.1

It looks fine to me.

-- 
Catalin
