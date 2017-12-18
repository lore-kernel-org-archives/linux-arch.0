From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 07/33] nds32: MMU initialization
Date: Mon, 18 Dec 2017 19:21:30 +0800
Message-ID: <CAEbi=3dy+KGgftWOrbBpVPDZURiYVYwAyGWzd9z4T7RQYAk2FA@mail.gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com> <0964714c3dcac46ac700085717b0f414b7978112.1512723245.git.green.hu@gmail.com>
 <20171218090848.GA5823@gary-OptiPlex-3050>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171218090848.GA5823@gary-OptiPlex-3050>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guo Ren <ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Hi, Guo Ren:

2017-12-18 17:08 GMT+08:00 Guo Ren <ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org>:
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
