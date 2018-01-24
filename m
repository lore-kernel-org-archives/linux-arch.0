Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41466 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933060AbeAXLgT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jan 2018 06:36:19 -0500
MIME-Version: 1.0
In-Reply-To: <CAEbi=3d46tXacnnU+RJGMw+KR1O=NaVjO+NW3cxUjAN==V51iw@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <ecd1742c718c5b45983486cf9dfb44adb6e06923.1515766253.git.green.hu@gmail.com>
 <CAK8P3a0-Vf9CRZzdXCxpuQoWgMhYWgO6Hy2KuP-gOKttoSGESA@mail.gmail.com>
 <CAEbi=3cYynvFS2GDzj5Oav_5LtHPdBfBWh9c=mFT0PxeOLX9sQ@mail.gmail.com> <CAEbi=3d46tXacnnU+RJGMw+KR1O=NaVjO+NW3cxUjAN==V51iw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 24 Jan 2018 12:36:17 +0100
Message-ID: <CAK8P3a30W1ph-6Owuf9yZF-bKg_bx6dJKCtiF_aRAYu9NVO3DQ@mail.gmail.com>
Subject: Re: [PATCH v6 16/36] nds32: DMA mapping API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180124113617.qaWlV6_LK6AyhGNuQ150vOeHfTjxFL0UGrS_haIn9w8@z>

On Tue, Jan 23, 2018 at 12:52 PM, Greentime Hu <green.hu@gmail.com> wrote:
> Hi, Arnd:
>
> 2018-01-23 16:23 GMT+08:00 Greentime Hu <green.hu@gmail.com>:
>> Hi, Arnd:
>>
>> 2018-01-18 18:26 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>>> From: Greentime Hu <greentime@andestech.com>
>>>>
>>>> This patch adds support for the DMA mapping API. It uses dma_map_ops for
>>>> flexibility.
>>>>
>>>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>>>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>>>
>>> I'm still unhappy about the way the cache flushes are done here as discussed
>>> before. It's not a show-stopped, but no Ack from me.
>>
>> How about this implementation?

> I am not sure if I understand it correctly.
> I list all the combinations.
>
> RAM to DEVICE
>     before DMA => writeback cache
>     after DMA => nop
>
> DEVICE to RAM
>     before DMA => nop
>     after DMA => invalidate cache
>
> static void consistent_sync(void *vaddr, size_t size, int direction, int master)
> {
>         unsigned long start = (unsigned long)vaddr;
>         unsigned long end = start + size;
>
>         if (master == FOR_CPU) {
>                 switch (direction) {
>                 case DMA_TO_DEVICE:
>                         break;
>                 case DMA_FROM_DEVICE:
>                 case DMA_BIDIRECTIONAL:
>                         cpu_dma_inval_range(start, end);
>                         break;
>                 default:
>                         BUG();
>                 }
>         } else {
>                 /* FOR_DEVICE */
>                 switch (direction) {
>                 case DMA_FROM_DEVICE:
>                         break;
>                 case DMA_TO_DEVICE:
>                 case DMA_BIDIRECTIONAL:
>                         cpu_dma_wb_range(start, end);
>                         break;
>                 default:
>                         BUG();
>                 }
>         }
> }

That looks reasonable enough, but it does depend on a number of factors,
and the dma-mapping.h implementation is not just about cache flushes.

As I don't know the microarchitecture, can you answer these questions:

- are caches always write-back, or could they be write-through?
- can the cache be shared with another CPU or a device?
- if the cache is shared, is it always coherent, never coherent, or
either of them?
- could the same memory be visible at different physical addresses
  and have conflicting caches?
- is the CPU physical address always the same as the address visible to the
  device?
- are there devices that can only see a subset of the physical memory?
- can there be an IOMMU?
- are there write-buffers in the CPU that might need to get flushed before
  flushing the cache?
- could cache lines be loaded speculatively or with read-ahead while
  a buffer is owned by a device?

        Arnd
