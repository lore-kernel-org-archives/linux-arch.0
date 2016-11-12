From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC] mm: Add debug_virt_to_phys()
Date: Fri, 11 Nov 2016 19:39:14 -0800
Message-ID: <55bd0bb5-c11c-12bc-7d73-520ae3901f03@gmail.com>
References: <20161112004449.30566-1-f.fainelli@gmail.com>
 <alpine.LFD.2.20.1611112034520.1618@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.20.1611112034520.1618@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Chris Brandt <chris.brandt@renesas.com>, Pratyush Anand <panand@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Neeraj Upadhyay <neeraju@codeaurora.org>, Laura Abbott <labbott@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Jerome Marchand <jmarchan@redhat.com>, Konstantin Khlebnikov <koct9i@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, moderated list:ARM P
List-Id: linux-arch.vger.kernel.org

Le 11/11/2016 à 17:49, Nicolas Pitre a écrit :
> On Fri, 11 Nov 2016, Florian Fainelli wrote:
> 
>> When CONFIG_DEBUG_VM is turned on, virt_to_phys() maps to
>> debug_virt_to_phys() which helps catch vmalloc space addresses being
>> passed. This is helpful in debugging bogus drivers that just assume
>> linear mappings all over the place.
>>
>> For ARM, ARM64, Unicore32 and Microblaze, the architectures define
>> __virt_to_phys() as being the functional implementation of the address
>> translation, so we special case the debug stub to call into
>> __virt_to_phys directly.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/arm/include/asm/memory.h      |  4 ++++
>>  arch/arm64/include/asm/memory.h    |  4 ++++
>>  include/asm-generic/memory_model.h |  4 ++++
>>  mm/debug.c                         | 15 +++++++++++++++
>>  4 files changed, 27 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
>> index 76cbd9c674df..448dec9b8b00 100644
>> --- a/arch/arm/include/asm/memory.h
>> +++ b/arch/arm/include/asm/memory.h
>> @@ -260,11 +260,15 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
>>   * translation for translating DMA addresses.  Use the driver
>>   * DMA support - see dma-mapping.h.
>>   */
>> +#ifndef CONFIG_DEBUG_VM
>>  #define virt_to_phys virt_to_phys
>>  static inline phys_addr_t virt_to_phys(const volatile void *x)
>>  {
>>  	return __virt_to_phys((unsigned long)(x));
>>  }
>> +#else
>> +#define virt_to_phys debug_virt_to_phys
>> +#endif
> [...]
> 
> Why don't you do something more like:
> 
>  static inline phys_addr_t virt_to_phys(const volatile void *x)
>  {
> +        debug_virt_to_phys(x);
>          return __virt_to_phys((unsigned long)(x));
>  }
> 
> [...]
> 
> static inline void debug_virt_to_phys(const void *address)
> {
> #ifdef CONFIG_DEBUG_VM
>         BUG_ON(is_vmalloc_addr(address));
> #endif
> }
> 
> ?

This is how I started doing it initially, but to get the
is_vmalloc_addr() definition, we need to include linux/mm.h and then
everything falls apart because of the include and dependencies chain. We
could open code the is_vmalloc_addr() check because that's simple
enough, but we still need VMALLOC_START and VMALLOC_END and to get there
we need to include pgtable.h, and there are still some inclusion
problems in doing so.

The other reason was to avoid putting the same checks in architecture
specific code, except for those like ARM/ARM64/Unicore32/Microblaze
where I could not find a simple way to undefined virt_to_phys and
redefine it to debug_virt_to_phys.

Do you see an other way around this? Thanks!
-- 
Florian
