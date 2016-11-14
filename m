From: Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH RFC] mm: Add debug_virt_to_phys()
Date: Mon, 14 Nov 2016 10:45:29 -0800
Message-ID: <aee5072c-4e09-547e-2f58-7b2106bced3c@redhat.com>
References: <20161112004449.30566-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35865 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753954AbcKNSpg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Nov 2016 13:45:36 -0500
Received: by mail-qk0-f174.google.com with SMTP id n21so106832072qka.3
        for <linux-arch@vger.kernel.org>; Mon, 14 Nov 2016 10:45:35 -0800 (PST)
In-Reply-To: <20161112004449.30566-1-f.fainelli@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nicolas.pitre@linaro.org>, Chris Brandt <chris.brandt@renesas.com>, Pratyush Anand <panand@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Neeraj Upadhyay <neeraju@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Jerome Marchand <jmarchan@redhat.com>, Konstantin Khlebnikov <koct9i@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "moderated list:ARM PORT" <linux-arm-kernel@>

On 11/11/2016 04:44 PM, Florian Fainelli wrote:
> When CONFIG_DEBUG_VM is turned on, virt_to_phys() maps to
> debug_virt_to_phys() which helps catch vmalloc space addresses being
> passed. This is helpful in debugging bogus drivers that just assume
> linear mappings all over the place.
> 
> For ARM, ARM64, Unicore32 and Microblaze, the architectures define
> __virt_to_phys() as being the functional implementation of the address
> translation, so we special case the debug stub to call into
> __virt_to_phys directly.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/include/asm/memory.h      |  4 ++++
>  arch/arm64/include/asm/memory.h    |  4 ++++
>  include/asm-generic/memory_model.h |  4 ++++
>  mm/debug.c                         | 15 +++++++++++++++
>  4 files changed, 27 insertions(+)
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 76cbd9c674df..448dec9b8b00 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -260,11 +260,15 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
>   * translation for translating DMA addresses.  Use the driver
>   * DMA support - see dma-mapping.h.
>   */
> +#ifndef CONFIG_DEBUG_VM
>  #define virt_to_phys virt_to_phys
>  static inline phys_addr_t virt_to_phys(const volatile void *x)
>  {
>  	return __virt_to_phys((unsigned long)(x));
>  }
> +#else
> +#define virt_to_phys debug_virt_to_phys
> +#endif
>  
>  #define phys_to_virt phys_to_virt
>  static inline void *phys_to_virt(phys_addr_t x)
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b71086d25195..c9e436b28523 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -186,11 +186,15 @@ extern u64			kimage_voffset;
>   * translation for translating DMA addresses.  Use the driver
>   * DMA support - see dma-mapping.h.
>   */
> +#ifndef CONFIG_DEBUG_VM
>  #define virt_to_phys virt_to_phys
>  static inline phys_addr_t virt_to_phys(const volatile void *x)
>  {
>  	return __virt_to_phys((unsigned long)(x));
>  }
> +#else
> +#define virt_to_phys debug_virt_to_phys
> +#endif
>  
>  #define phys_to_virt phys_to_virt
>  static inline void *phys_to_virt(phys_addr_t x)
> diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
> index 5148150cc80b..426085757258 100644
> --- a/include/asm-generic/memory_model.h
> +++ b/include/asm-generic/memory_model.h
> @@ -80,6 +80,10 @@
>  #define page_to_pfn __page_to_pfn
>  #define pfn_to_page __pfn_to_page
>  
> +#ifdef CONFIG_DEBUG_VM
> +unsigned long debug_virt_to_phys(volatile void *address);
> +#endif /* CONFIG_DEBUG_VM */
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif
> diff --git a/mm/debug.c b/mm/debug.c
> index 9feb699c5d25..72b2ca9b11f4 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -161,4 +161,19 @@ void dump_mm(const struct mm_struct *mm)
>  	);
>  }
>  
> +#include <asm/memory.h>
> +#include <linux/mm.h>
> +
> +unsigned long debug_virt_to_phys(volatile void *address)
> +{
> +	BUG_ON(is_vmalloc_addr((const void *)address));
> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_UNICORE32) || \
> +	defined(CONFIG_MICROBLAZE)
> +	return __virt_to_phys(address);
> +#else
> +	return virt_to_phys(address);
> +#endif
> +}
> +EXPORT_SYMBOL(debug_virt_to_phys);
> +
>  #endif		/* CONFIG_DEBUG_VM */
> 

is_vmalloc_addr is necessary but not sufficient. This misses
cases like module addresses. The x86 version (CONFIG_DEBUG_VIRTUAL)
bounds checks against the known linear map to catch all cases.
I'm for a generic approach to this if it can catch all cases
that an architecture specific version would catch.

Thanks,
Laura
