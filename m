From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] arc: fix iounmap prototype
Date: Fri, 19 Jan 2018 11:31:44 -0800
Message-ID: <afb933d6-e325-dc5f-b844-8d3a3df3fd13@synopsys.com>
References: <20180102110141.1853608-1-arnd@arndb.de>
 <CAMuHMdVrb56oxz-UuxXAT5c-97J42f+JJ0EY+G6d2vLucDTu5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:58961 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756040AbeASTcV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jan 2018 14:32:21 -0500
In-Reply-To: <CAMuHMdVrb56oxz-UuxXAT5c-97J42f+JJ0EY+G6d2vLucDTu5Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 01/02/2018 06:23 AM, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Tue, Jan 2, 2018 at 12:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> The missing 'volatile' keyword on the iounmap argument leads to lots of
>> harmless warnings in an allmodconfig build:
>>
>> sound/pci/echoaudio/echoaudio.c:1879:10: warning: passing argument 1 of 'iounmap' discards 'volatile' qualifier f
>> pointer target type [-Wdiscarded-qualifiers]
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Arnd, do you agree to Geert's comments - if you are busy I can respin a v2 ?

Thx,
-Vineet

>> ---
>>   arch/arc/include/asm/io.h | 4 ++--
>>   arch/arc/mm/ioremap.c     | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
>> index c22b181e8206..2c9b98fabf82 100644
>> --- a/arch/arc/include/asm/io.h
>> +++ b/arch/arc/include/asm/io.h
>> @@ -30,11 +30,11 @@ static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
>>          return (void __iomem *)port;
>>   }
>>
>> -static inline void ioport_unmap(void __iomem *addr)
>> +static inline void ioport_unmap(volatile void __iomem *addr)
>>   {
>>   }
>>
>> -extern void iounmap(const void __iomem *addr);
>> +extern void iounmap(const volatile void __iomem *addr);
> 
> Note that include/asm-generic/io.h also lacks the volatiles?
> 
>>
>>   #define ioremap_nocache(phy, sz)       ioremap(phy, sz)
>>   #define ioremap_wc(phy, sz)            ioremap(phy, sz)
>> diff --git a/arch/arc/mm/ioremap.c b/arch/arc/mm/ioremap.c
>> index 9881bd740ccc..94d0116063a8 100644
>> --- a/arch/arc/mm/ioremap.c
>> +++ b/arch/arc/mm/ioremap.c
>> @@ -95,7 +95,7 @@ void __iomem *ioremap_prot(phys_addr_t paddr, unsigned long size,
>>   EXPORT_SYMBOL(ioremap_prot);
>>
>>
>> -void iounmap(const void __iomem *addr)
>> +void iounmap(volatile const void __iomem *addr)
> 
> const volatile?
> 
>>   {
>>          /* weird double cast to handle phys_addr_t > 32 bits */
>>          if (arc_uncached_addr_space((phys_addr_t)(u32)addr))
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
