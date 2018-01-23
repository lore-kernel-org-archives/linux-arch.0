From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 16/36] nds32: DMA mapping API
Date: Tue, 23 Jan 2018 19:52:55 +0800
Message-ID: <CAEbi=3d46tXacnnU+RJGMw+KR1O=NaVjO+NW3cxUjAN==V51iw@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <ecd1742c718c5b45983486cf9dfb44adb6e06923.1515766253.git.green.hu@gmail.com>
 <CAK8P3a0-Vf9CRZzdXCxpuQoWgMhYWgO6Hy2KuP-gOKttoSGESA@mail.gmail.com> <CAEbi=3cYynvFS2GDzj5Oav_5LtHPdBfBWh9c=mFT0PxeOLX9sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEbi=3cYynvFS2GDzj5Oav_5LtHPdBfBWh9c=mFT0PxeOLX9sQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Networking <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Guo Ren <ren_guo-Y+KPrCd2zL4@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Hi, Arnd:

2018-01-23 16:23 GMT+08:00 Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi, Arnd:
>
> 2018-01-18 18:26 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>>
>>> This patch adds support for the DMA mapping API. It uses dma_map_ops for
>>> flexibility.
>>>
>>> Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>> Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
