Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:46073 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeAWLxh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jan 2018 06:53:37 -0500
MIME-Version: 1.0
In-Reply-To: <CAEbi=3cYynvFS2GDzj5Oav_5LtHPdBfBWh9c=mFT0PxeOLX9sQ@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <ecd1742c718c5b45983486cf9dfb44adb6e06923.1515766253.git.green.hu@gmail.com>
 <CAK8P3a0-Vf9CRZzdXCxpuQoWgMhYWgO6Hy2KuP-gOKttoSGESA@mail.gmail.com> <CAEbi=3cYynvFS2GDzj5Oav_5LtHPdBfBWh9c=mFT0PxeOLX9sQ@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Tue, 23 Jan 2018 19:52:55 +0800
Message-ID: <CAEbi=3d46tXacnnU+RJGMw+KR1O=NaVjO+NW3cxUjAN==V51iw@mail.gmail.com>
Subject: Re: [PATCH v6 16/36] nds32: DMA mapping API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180123115255.zRpqnzGtcd5ZZ8q7LdKZmSwhDJaNFKCLpZIBRtXpI64@z>

Hi, Arnd:

2018-01-23 16:23 GMT+08:00 Greentime Hu <green.hu@gmail.com>:
> Hi, Arnd:
>
> 2018-01-18 18:26 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>> From: Greentime Hu <greentime@andestech.com>
>>>
>>> This patch adds support for the DMA mapping API. It uses dma_map_ops for
>>> flexibility.
>>>
>>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>>
>> I'm still unhappy about the way the cache flushes are done here as discussed
>> before. It's not a show-stopped, but no Ack from me.
>
> How about this implementation?
>
> static void
> nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
>                               size_t size, enum dma_data_direction dir)
> {
>         switch (direction) {
>         case DMA_TO_DEVICE:     /* writeback only */
>                 break;
>         case DMA_FROM_DEVICE:   /* invalidate only */
>         case DMA_BIDIRECTIONAL: /* writeback and invalidate */
>                 cpu_dma_inval_range(start, end);
>                 break;
>         default:
>                 BUG();
>         }
> }
>
> static void
> nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
>                                  size_t size, enum dma_data_direction dir)
> {
>         switch (direction) {
>         case DMA_FROM_DEVICE:   /* invalidate only */
>                 break;
>         case DMA_TO_DEVICE:     /* writeback only */
>         case DMA_BIDIRECTIONAL: /* writeback and invalidate */
>                 cpu_dma_wb_range(start, end);
>                 break;
>         default:
>                 BUG();
>         }
> }

I am not sure if I understand it correctly.
I list all the combinations.

RAM to DEVICE
    before DMA => writeback cache
    after DMA => nop

DEVICE to RAM
    before DMA => nop
    after DMA => invalidate cache

static void consistent_sync(void *vaddr, size_t size, int direction, int master)
{
        unsigned long start = (unsigned long)vaddr;
        unsigned long end = start + size;

        if (master == FOR_CPU) {
                switch (direction) {
                case DMA_TO_DEVICE:
                        break;
                case DMA_FROM_DEVICE:
                case DMA_BIDIRECTIONAL:
                        cpu_dma_inval_range(start, end);
                        break;
                default:
                        BUG();
                }
        } else {
                /* FOR_DEVICE */
                switch (direction) {
                case DMA_FROM_DEVICE:
                        break;
                case DMA_TO_DEVICE:
                case DMA_BIDIRECTIONAL:
                        cpu_dma_wb_range(start, end);
                        break;
                default:
                        BUG();
                }
        }
}

static void
nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
                              size_t size, enum dma_data_direction dir)
{
        consistent_sync((void *)phys_to_virt(handle), size, dir, FOR_CPU);
}

static void
nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
                                 size_t size, enum dma_data_direction dir)
{
        consistent_sync((void *)phys_to_virt(handle), size, dir, FOR_DEVICE);
}

static dma_addr_t nds32_dma_map_page(struct device *dev, struct page *page,
                                     unsigned long offset, size_t size,
                                     enum dma_data_direction dir,
                                     unsigned long attrs)
{
        if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
                consistent_sync((void *)(page_address(page) + offset),
size, dir, FOR_DEVICE);
        return page_to_phys(page) + offset;
}

static void nds32_dma_unmap_page(struct device *dev, dma_addr_t handle,
                                 size_t size, enum dma_data_direction dir,
                                 unsigned long attrs)
{
        if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
                consistent_sync(phys_to_virt(handle), size, dir, FOR_CPU);
}
