From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 16/36] nds32: DMA mapping API
Date: Thu, 25 Jan 2018 11:42:38 +0100
Message-ID: <CAK8P3a0YrwAXH8n83wf=34zmN44KgJu-JVXfQWhuquNxVmZ8Sw@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <ecd1742c718c5b45983486cf9dfb44adb6e06923.1515766253.git.green.hu@gmail.com>
 <CAK8P3a0-Vf9CRZzdXCxpuQoWgMhYWgO6Hy2KuP-gOKttoSGESA@mail.gmail.com>
 <CAEbi=3cYynvFS2GDzj5Oav_5LtHPdBfBWh9c=mFT0PxeOLX9sQ@mail.gmail.com>
 <CAEbi=3d46tXacnnU+RJGMw+KR1O=NaVjO+NW3cxUjAN==V51iw@mail.gmail.com>
 <CAK8P3a30W1ph-6Owuf9yZF-bKg_bx6dJKCtiF_aRAYu9NVO3DQ@mail.gmail.com> <CAEbi=3fwCnFXmYKPEiDiqoGFujqRD0bPrPAgqtiTkO_vuX25dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36213 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeAYKmk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jan 2018 05:42:40 -0500
In-Reply-To: <CAEbi=3fwCnFXmYKPEiDiqoGFujqRD0bPrPAgqtiTkO_vuX25dQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>

On Thu, Jan 25, 2018 at 4:45 AM, Greentime Hu <green.hu@gmail.com> wrote:
> 2018-01-24 19:36 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Tue, Jan 23, 2018 at 12:52 PM, Greentime Hu <green.hu@gmail.com> wrote:
>>> 2018-01-23 16:23 GMT+08:00 Greentime Hu <green.hu@gmail.com>:
>>>> 2018-01-18 18:26 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>>>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>
>> That looks reasonable enough, but it does depend on a number of factors,
>> and the dma-mapping.h implementation is not just about cache flushes.
>>
>> As I don't know the microarchitecture, can you answer these questions:
>>
>> - are caches always write-back, or could they be write-through?
> Yes, we can config it to write-back or write-through.

Ok. If a WT-cache is common enough, you could optimize for that
case by skipping the explicit writeback here and just doing a synchronizing
instruction. Usually if the cache is configurable, one would pick the
writeback option though, so it's probably not important.

>> - is the CPU physical address always the same as the address visible to the
>>   device?
> Yes, it is always the same unless the CPU uses local memory. The
> physical address of local memory will overlap the original bus
> address.
> I think the local memory case can be ignored because we don't use it for now.

Ok, makes sense.

>> - are there devices that can only see a subset of the physical memory?
> All devices are able to see the whole physical memory in our current
> SoC, but I think other SoC may support such kind of HW behavior.

This is one area that might need a more complex implementation then,
depending on what devices are used in other SoCs. For network or
storage devices, it's usually sufficient to configure a DMA mask
from the "dma-ranges" property of the parent bus in the device tree,
the kernel code will then use bounce buffers.

For other types of drivers, using the streaming DMA interfaces
can require using the swiotlb helper that performs the bounce
buffering at in place of the cache operations. With a bit of luck,
you won't ever need to worry about it, just mentioning it here in
case you run into that problem later.

The consistent_sync() implementaiton you showed earlier should be
good enough then.  With that change,

Acked-by: Arnd Bergmann <arnd@arndb.de>
