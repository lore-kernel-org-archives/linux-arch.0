Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-mail02.westnet.com.au ([203.10.1.243]:10854 "EHLO
	outbound-mail02.westnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754039Ab3HEBuX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 Aug 2013 21:50:23 -0400
Message-ID: <51FF01E7.5020105@uclinux.org>
Date: Mon, 05 Aug 2013 11:37:43 +1000
From: Greg Ungerer <gerg@uclinux.org>
MIME-Version: 1.0
Subject: Re: [PATCH] arch: m68k: include: asm: define 'VM_DATA_DEFAULT_FLAGS'
 no matter whether has 'NOMMU' or not.
References: <51C548E2.1060104@asianux.com> <51D0ECC2.3020101@asianux.com>
In-Reply-To: <51D0ECC2.3020101@asianux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "dhowells@redhat.com" <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, davej@redhat.com, Arnd Bergmann <arnd@arndb.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20130805013743.I8-a_BDUQIvskl3ylGi2F6BXXYpu5dX_hA0kvjTVUiI@z>

Hi Chen Gang,

On 01/07/13 12:43, Chen Gang wrote:
> Hello Maintainers:
> 
> Please help check the patch whether OK or not, when you have time.
> 
> Thanks.
> 
> On 06/22/2013 02:49 PM, Chen Gang wrote:
>>
>> Define 'VM_DATA_DEFAULT_FLAGS' when 'NOMMU' to pass compiling.
>>
>> So move it from "include/asm/page_mm.h to "include/asm/page.h"
>>
>> The related make:
>>
>>   make ARCH=m68k randconfig
>>   make ARCH=m68k menuconfig
>>     choose cross compiler
>>     disable MMU support
>>   make ARCH=m68k V=1 EXTRA_CFLAGS=-W
>>
>> The related error:
>>
>>   security/selinux/hooks.c: In function ‘selinux_init’:
>>   security/selinux/hooks.c:5821:21: error: ‘VM_DATA_DEFAULT_FLAGS’ undeclared (first use in this function)
>>
>> (the attachment is the related .config file)
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>

I am fine with this:

Acked-by: Greg Ungerer <gerg@uclinux.org>

Do you want me to add this to the m68knommu git tree, and push to
Linus?

Regards
Greg


>> ---
>>  arch/m68k/include/asm/page.h    |    3 +++
>>  arch/m68k/include/asm/page_mm.h |    3 ---
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
>> index 7c360da..38b024a 100644
>> --- a/arch/m68k/include/asm/page.h
>> +++ b/arch/m68k/include/asm/page.h
>> @@ -48,6 +48,9 @@ extern unsigned long _ramend;
>>  #include <asm/page_no.h>
>>  #endif
>>  
>> +#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
>> +				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>> +
>>  #include <asm-generic/getorder.h>
>>  
>>  #endif /* _M68K_PAGE_H */
>> diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
>> index 89f2014..5029f73 100644
>> --- a/arch/m68k/include/asm/page_mm.h
>> +++ b/arch/m68k/include/asm/page_mm.h
>> @@ -173,7 +173,4 @@ static inline __attribute_const__ int __virt_to_node_shift(void)
>>  
>>  #endif /* __ASSEMBLY__ */
>>  
>> -#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
>> -				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>> -
>>  #endif /* _M68K_PAGE_MM_H */
>>
> 
> 

