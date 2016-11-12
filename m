Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34756 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934854AbcKLBtQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Nov 2016 20:49:16 -0500
Received: by mail-qt0-f171.google.com with SMTP id n6so19877529qtd.1
        for <linux-arch@vger.kernel.org>; Fri, 11 Nov 2016 17:49:16 -0800 (PST)
Date: Fri, 11 Nov 2016 20:49:13 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH RFC] mm: Add debug_virt_to_phys()
In-Reply-To: <20161112004449.30566-1-f.fainelli@gmail.com>
Message-ID: <alpine.LFD.2.20.1611112034520.1618@knanqh.ubzr>
References: <20161112004449.30566-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Chris Brandt <chris.brandt@renesas.com>, Pratyush Anand <panand@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Neeraj Upadhyay <neeraju@codeaurora.org>, Laura Abbott <labbott@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Jerome Marchand <jmarchan@redhat.com>, Konstantin Khlebnikov <koct9i@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Message-ID: <20161112014913.1viBvhg6QZWgpWK6JcklWfc-OPBlUbSUc2GdeI1aS_0@z>

On Fri, 11 Nov 2016, Florian Fainelli wrote:

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
[...]

Why don't you do something more like:

 static inline phys_addr_t virt_to_phys(const volatile void *x)
 {
+        debug_virt_to_phys(x);
         return __virt_to_phys((unsigned long)(x));
 }

[...]

static inline void debug_virt_to_phys(const void *address)
{
#ifdef CONFIG_DEBUG_VM
        BUG_ON(is_vmalloc_addr(address));
#endif
}

?


Nicolas
