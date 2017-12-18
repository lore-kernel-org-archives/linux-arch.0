Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34552 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdLRLWM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Dec 2017 06:22:12 -0500
MIME-Version: 1.0
In-Reply-To: <20171218090848.GA5823@gary-OptiPlex-3050>
References: <cover.1512723245.git.green.hu@gmail.com> <0964714c3dcac46ac700085717b0f414b7978112.1512723245.git.green.hu@gmail.com>
 <20171218090848.GA5823@gary-OptiPlex-3050>
From: Greentime Hu <green.hu@gmail.com>
Date: Mon, 18 Dec 2017 19:21:30 +0800
Message-ID: <CAEbi=3dy+KGgftWOrbBpVPDZURiYVYwAyGWzd9z4T7RQYAk2FA@mail.gmail.com>
Subject: Re: [PATCH v3 07/33] nds32: MMU initialization
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171218112130.fKPyS372fDrp4AgLlEXfdckOxyoALHzaJLo1a5IOtSA@z>

Hi, Guo Ren:

2017-12-18 17:08 GMT+08:00 Guo Ren <ren_guo@c-sky.com>:
> Hi Greentime,
>
> On Fri, Dec 08, 2017 at 05:11:50PM +0800, Greentime Hu wrote:
> [...]
>>
>> diff --git a/arch/nds32/mm/highmem.c b/arch/nds32/mm/highmem.c
> [...]
>> +void *kmap(struct page *page)
>> +{
>> +     unsigned long vaddr;
>> +     might_sleep();
>> +     if (!PageHighMem(page))
>> +             return page_address(page);
>> +     vaddr = (unsigned long)kmap_high(page);
> Here should invalid the cpu_mmu_tlb's entry, Or invalid it in the
> set_pte().
>
> eg:
> vaddr0 = kmap(page0)
> *vaddr0 = val0 //It will cause tlb-miss, and hard-refill to MMU-tlb
> kunmap(page0)
> vaddr1 = kmap(page1) // Mostly vaddr1 = vaddr0
> val = vaddr1; //No tlb-miss and it will get page0's val not page1, because
>                 last expired vaddr0's entry is left in CPU-MMU-tlb.
>

Thanks.
I will add __nds32__tlbop_inv(vaddr); to invalidate this mapping
before retrun vaddr.
