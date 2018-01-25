From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v6 16/36] nds32: DMA mapping API
Date: Thu, 25 Jan 2018 11:45:18 +0800
Message-ID: <CAEbi=3fwCnFXmYKPEiDiqoGFujqRD0bPrPAgqtiTkO_vuX25dQ@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <ecd1742c718c5b45983486cf9dfb44adb6e06923.1515766253.git.green.hu@gmail.com>
 <CAK8P3a0-Vf9CRZzdXCxpuQoWgMhYWgO6Hy2KuP-gOKttoSGESA@mail.gmail.com>
 <CAEbi=3cYynvFS2GDzj5Oav_5LtHPdBfBWh9c=mFT0PxeOLX9sQ@mail.gmail.com>
 <CAEbi=3d46tXacnnU+RJGMw+KR1O=NaVjO+NW3cxUjAN==V51iw@mail.gmail.com> <CAK8P3a30W1ph-6Owuf9yZF-bKg_bx6dJKCtiF_aRAYu9NVO3DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44465 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933198AbeAYDp7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jan 2018 22:45:59 -0500
In-Reply-To: <CAK8P3a30W1ph-6Owuf9yZF-bKg_bx6dJKCtiF_aRAYu9NVO3DQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>

Hi, Arnd:

2018-01-24 19:36 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Tue, Jan 23, 2018 at 12:52 PM, Greentime Hu <green.hu@gmail.com> wrote:
>> Hi, Arnd:
>>
>> 2018-01-23 16:23 GMT+08:00 Greentime Hu <green.hu@gmail.com>:
>>> Hi, Arnd:
>>>
>>> 2018-01-18 18:26 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>>>> From: Greentime Hu <greentime@andestech.com>
>>>>>
>>>>> This patch adds support for the DMA mapping API. It uses dma_map_ops for
>>>>> flexibility.
>>>>>
>>>>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>>>>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>>>>
>>>> I'm still unhappy about the way the cache flushes are done here as discussed
>>>> before. It's not a show-stopped, but no Ack from me.
>>>
>>> How about this implementation?
>
>> I am not sure if I understand it correctly.
>> I list all the combinations.
>>
>> RAM to DEVICE
>>     before DMA => writeback cache
>>     after DMA => nop
>>
>> DEVICE to RAM
>>     before DMA => nop
>>     after DMA => invalidate cache
>>
>> static void consistent_sync(void *vaddr, size_t size, int direction, int master)
>> {
>>         unsigned long start = (unsigned long)vaddr;
>>         unsigned long end = start + size;
>>
>>         if (master == FOR_CPU) {
>>                 switch (direction) {
>>                 case DMA_TO_DEVICE:
>>                         break;
>>                 case DMA_FROM_DEVICE:
>>                 case DMA_BIDIRECTIONAL:
>>                         cpu_dma_inval_range(start, end);
>>                         break;
>>                 default:
>>                         BUG();
>>                 }
>>         } else {
>>                 /* FOR_DEVICE */
>>                 switch (direction) {
>>                 case DMA_FROM_DEVICE:
>>                         break;
>>                 case DMA_TO_DEVICE:
>>                 case DMA_BIDIRECTIONAL:
>>                         cpu_dma_wb_range(start, end);
>>                         break;
>>                 default:
>>                         BUG();
>>                 }
>>         }
>> }
>
> That looks reasonable enough, but it does depend on a number of factors,
> and the dma-mapping.h implementation is not just about cache flushes.
>
> As I don't know the microarchitecture, can you answer these questions:
>
> - are caches always write-back, or could they be write-through?
Yes, we can config it to write-back or write-through.

> - can the cache be shared with another CPU or a device?
No, we don't support it.

> - if the cache is shared, is it always coherent, never coherent, or
> either of them?
We don't support SMP and the device will access memory through bus. I
think the cache is not shared.

> - could the same memory be visible at different physical addresses
>   and have conflicting caches?
We currently don't have such kind of SoC memory map.

> - is the CPU physical address always the same as the address visible to the
>   device?
Yes, it is always the same unless the CPU uses local memory. The
physical address of local memory will overlap the original bus
address.
I think the local memory case can be ignored because we don't use it for now.

> - are there devices that can only see a subset of the physical memory?
All devices are able to see the whole physical memory in our current
SoC, but I think other SoC may support such kind of HW behavior.

> - can there be an IOMMU?
No.

> - are there write-buffers in the CPU that might need to get flushed before
>   flushing the cache?
Yes, there are write-buffers in front of CPU caches but it should be
transparent to SW. We don't need to flush it.

> - could cache lines be loaded speculatively or with read-ahead while
>   a buffer is owned by a device?
No.
