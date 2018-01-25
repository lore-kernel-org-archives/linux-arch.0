Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38045 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeAYNsn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jan 2018 08:48:43 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0YrwAXH8n83wf=34zmN44KgJu-JVXfQWhuquNxVmZ8Sw@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <ecd1742c718c5b45983486cf9dfb44adb6e06923.1515766253.git.green.hu@gmail.com>
 <CAK8P3a0-Vf9CRZzdXCxpuQoWgMhYWgO6Hy2KuP-gOKttoSGESA@mail.gmail.com>
 <CAEbi=3cYynvFS2GDzj5Oav_5LtHPdBfBWh9c=mFT0PxeOLX9sQ@mail.gmail.com>
 <CAEbi=3d46tXacnnU+RJGMw+KR1O=NaVjO+NW3cxUjAN==V51iw@mail.gmail.com>
 <CAK8P3a30W1ph-6Owuf9yZF-bKg_bx6dJKCtiF_aRAYu9NVO3DQ@mail.gmail.com>
 <CAEbi=3fwCnFXmYKPEiDiqoGFujqRD0bPrPAgqtiTkO_vuX25dQ@mail.gmail.com> <CAK8P3a0YrwAXH8n83wf=34zmN44KgJu-JVXfQWhuquNxVmZ8Sw@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Thu, 25 Jan 2018 21:48:01 +0800
Message-ID: <CAEbi=3cifP5owmV0qPoC0_7z6NMi56tAqM+C9JdbqjzMTAUWig@mail.gmail.com>
Subject: Re: [PATCH v6 16/36] nds32: DMA mapping API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180125134801.G6RKRiN3PoSYBGyjnuFwzSQyY8_ozSui3CSvji8fKu4@z>

Hi, Arnd:

2018-01-25 18:42 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Thu, Jan 25, 2018 at 4:45 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> 2018-01-24 19:36 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Tue, Jan 23, 2018 at 12:52 PM, Greentime Hu <green.hu@gmail.com> wrote:
>>>> 2018-01-23 16:23 GMT+08:00 Greentime Hu <green.hu@gmail.com>:
>>>>> 2018-01-18 18:26 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>>>>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
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
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thank you. :)
