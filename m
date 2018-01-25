From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 16/36] nds32: DMA mapping API
Date: Thu, 25 Jan 2018 21:48:01 +0800
Message-ID: <CAEbi=3cifP5owmV0qPoC0_7z6NMi56tAqM+C9JdbqjzMTAUWig@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <ecd1742c718c5b45983486cf9dfb44adb6e06923.1515766253.git.green.hu@gmail.com>
 <CAK8P3a0-Vf9CRZzdXCxpuQoWgMhYWgO6Hy2KuP-gOKttoSGESA@mail.gmail.com>
 <CAEbi=3cYynvFS2GDzj5Oav_5LtHPdBfBWh9c=mFT0PxeOLX9sQ@mail.gmail.com>
 <CAEbi=3d46tXacnnU+RJGMw+KR1O=NaVjO+NW3cxUjAN==V51iw@mail.gmail.com>
 <CAK8P3a30W1ph-6Owuf9yZF-bKg_bx6dJKCtiF_aRAYu9NVO3DQ@mail.gmail.com>
 <CAEbi=3fwCnFXmYKPEiDiqoGFujqRD0bPrPAgqtiTkO_vuX25dQ@mail.gmail.com> <CAK8P3a0YrwAXH8n83wf=34zmN44KgJu-JVXfQWhuquNxVmZ8Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a0YrwAXH8n83wf=34zmN44KgJu-JVXfQWhuquNxVmZ8Sw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Networking <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Guo Ren <ren_guo-Y+KPrCd2zL4@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Hi, Arnd:

2018-01-25 18:42 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
> On Thu, Jan 25, 2018 at 4:45 AM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> 2018-01-24 19:36 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
>>> On Tue, Jan 23, 2018 at 12:52 PM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>> 2018-01-23 16:23 GMT+08:00 Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>>> 2018-01-18 18:26 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
>>>>>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>
>>> That looks reasonable enough, but it does depend on a number of factors,
>>> and the dma-mapping.h implementation is not just about cache flushes.
>>>
>>> As I don't know the microarchitecture, can you answer these questions:
>>>
>>> - are caches always write-back, or could they be write-through?
>> Yes, we can config it to write-back or write-through.
>
> Ok. If a WT-cache is common enough, you could optimize for that
> case by skipping the explicit writeback here and just doing a synchronizing
> instruction. Usually if the cache is configurable, one would pick the
> writeback option though, so it's probably not important.

Thank you for this suggestion.
We have optimized in cpu_dcache_wb_range() and it will be called from
cpu_dma_wb_range().
It will do nothing if it is a write-through config cache.

>>> - is the CPU physical address always the same as the address visible to the
>>>   device?
>> Yes, it is always the same unless the CPU uses local memory. The
>> physical address of local memory will overlap the original bus
>> address.
>> I think the local memory case can be ignored because we don't use it for now.
>
> Ok, makes sense.
>
>>> - are there devices that can only see a subset of the physical memory?
>> All devices are able to see the whole physical memory in our current
>> SoC, but I think other SoC may support such kind of HW behavior.
>
> This is one area that might need a more complex implementation then,
> depending on what devices are used in other SoCs. For network or
> storage devices, it's usually sufficient to configure a DMA mask
> from the "dma-ranges" property of the parent bus in the device tree,
> the kernel code will then use bounce buffers.
>
> For other types of drivers, using the streaming DMA interfaces
> can require using the swiotlb helper that performs the bounce
> buffering at in place of the cache operations. With a bit of luck,
> you won't ever need to worry about it, just mentioning it here in
> case you run into that problem later.
>
> The consistent_sync() implementaiton you showed earlier should be
> good enough then.  With that change,
>
> Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

Thank you. :)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
