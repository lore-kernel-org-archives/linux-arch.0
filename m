From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 4/4] csky: Add dma_inv_range for DMA_FROM_DEVICE
Date: Tue, 30 Jul 2019 23:11:25 +0800
Message-ID: <CAJF2gTQC0e3zGxtCdwvZpen=Gj8CtgjNYCuy3hSupDXt3KM0Zg@mail.gmail.com>
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
 <1564488945-20149-4-git-send-email-guoren@kernel.org> <CAK8P3a0v3oVS5cCkORxA7na+VE7ofTQRxiv5o5xNf5v=esnN9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0v3oVS5cCkORxA7na+VE7ofTQRxiv5o5xNf5v=esnN9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Thx Arnd,

On Tue, Jul 30, 2019 at 9:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 30, 2019 at 2:16 PM <guoren@kernel.org> wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
>
> > diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> > index 3f1ff9d..d8f0f81 100644
> > --- a/arch/csky/mm/dma-mapping.c
> > +++ b/arch/csky/mm/dma-mapping.c
> > @@ -72,6 +72,8 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> >                 cache_op(paddr, size, dma_wb_range);
> >                 break;
> >         case DMA_FROM_DEVICE:
> > +               cache_op(paddr, size, dma_inv_range);
> > +               break;
> >         case DMA_BIDIRECTIONAL:
> >                 cache_op(paddr, size, dma_wbinv_range);
> >                 break;
> > @@ -88,6 +90,8 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
> >                 cache_op(paddr, size, dma_wb_range);
> >                 break;
> >         case DMA_FROM_DEVICE:
> > +               cache_op(paddr, size, dma_inv_range);
> > +               break;
> >         case DMA_BIDIRECTIONAL:
> >                 cache_op(paddr, size, dma_wbinv_range);
> >                 break;
>
> When syncing 'for_cpu', you should not need to write back, because
> there won't be any dirty cache lines.
I just follow the dma_data_direction param, seems dir param and
function are a little bit duplicated. And our cpu won't clear clean
cache line into memory, so dma_wb_page won't cause problem.
Seems arch_sync_dma_for_cpu with dir=DMA_TO_DEVICE is self-contradictory.

Do you want me modfiy like these:
@@ -88,6 +90,8 @@ void arch_sync_dma_for_cpu(struct device *dev,
phys_addr_t paddr,
        case DMA_TO_DEVICE:
        case DMA_FROM_DEVICE:
        case DMA_BIDIRECTIONAL:
               cache_op(paddr, size, dma_inv_range);
               break;

@@ -72,6 +72,8 @@ void arch_sync_dma_for_device(struct device *dev,
phys_addr_t paddr,
        case DMA_TO_DEVICE:
                cache_op(paddr, size, dma_wb_range);
                break;
        case DMA_FROM_DEVICE:
        case DMA_BIDIRECTIONAL:
                cache_op(paddr, size, dma_wbinv_range);
                break;

>
> If you have a CPU core that does not do speculative loads, you also don't
> need to invalidate here, because you have already done that in the
> _for_device() case, the only reason to invalidate the CPU cache
> again is if a speculative load created a stale cache line that now
> shadows the data received from the device.
Our CPU support speculative loads :)

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
