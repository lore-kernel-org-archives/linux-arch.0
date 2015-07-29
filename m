Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37197 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbbG2WV6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jul 2015 18:21:58 -0400
Received: by wibud3 with SMTP id ud3so44682916wib.0
        for <linux-arch@vger.kernel.org>; Wed, 29 Jul 2015 15:21:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150727080347.GA18599@lst.de>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150725024015.8664.42950.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150727080347.GA18599@lst.de>
Date: Wed, 29 Jul 2015 15:21:56 -0700
Message-ID: <CAPcyv4icZ4aWgPeYnmuj0eeK6wm36A=D2qHW0e3FJBvzpeEWaQ@mail.gmail.com>
Subject: Re: [PATCH v2 24/25] arch: remove ioremap_wt, replace with arch_memremap
From: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, "Kani, Toshimitsu" <toshi.kani@hp.com>, Arnd Bergmann <arnd@arndb.de>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Russell King <rmk+kernel@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20150729222156.iWieDFhWYyweTFbNOEMYxr1tH7cmM2vG3CaGovceaIU@z>

On Mon, Jul 27, 2015 at 1:03 AM, Christoph Hellwig <hch@lst.de> wrote:
>> +++ b/arch/frv/include/asm/io.h
>> @@ -17,8 +17,6 @@
>>
>>  #ifdef __KERNEL__
>>
>> -#define ARCH_HAS_IOREMAP_WT
>> -
>>  #include <linux/types.h>
>>  #include <asm/virtconvert.h>
>>  #include <asm/string.h>
>> @@ -267,20 +265,17 @@ static inline void __iomem *ioremap_nocache(unsigned long physaddr, unsigned lon
>>       return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
>>  }
>>
>> -static inline void __iomem *ioremap_wt(unsigned long physaddr, unsigned long size)
>> -{
>> -     return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
>> -}
>> -
>> -static inline void __iomem *ioremap_fullcache(unsigned long physaddr, unsigned long size)
>> -{
>> -     return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
>> -}
>
>
>> +void *arch_memremap(resource_size_t offset, size_t size, unsigned long flags)
>> +{
>> +     return (void *) offset;
>> +}
>> +EXPORT_SYMBOL(arch_memremap);
>
> This doesn't look like a correct replacement.

It doesn't, but frv jumps through a lot of hoops to give the illusion
it actually supports different mapping types only to do this simple
case in the end.  Given we don't want fallback semantics I will simply
remove these false wrappers in the next revision of the patches.

> Also shouldn't the replacements of ioremap_fullcache or ioremap_wc be
> in the previous patch?
>
> A few more similar issues pop up for other architectures as well.

I went ahead and moved the deletion of ioremap_cached() and
ioremap_fullcache() to their own patches.
