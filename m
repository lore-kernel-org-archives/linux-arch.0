Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34513 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfG3PWU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jul 2019 11:22:20 -0400
MIME-Version: 1.0
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
 <1564488945-20149-4-git-send-email-guoren@kernel.org> <CAK8P3a0v3oVS5cCkORxA7na+VE7ofTQRxiv5o5xNf5v=esnN9A@mail.gmail.com>
 <CAJF2gTQC0e3zGxtCdwvZpen=Gj8CtgjNYCuy3hSupDXt3KM0Zg@mail.gmail.com>
In-Reply-To: <CAJF2gTQC0e3zGxtCdwvZpen=Gj8CtgjNYCuy3hSupDXt3KM0Zg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 30 Jul 2019 17:22:03 +0200
Message-ID: <CAK8P3a0miz=yghtqK+1=1APGf4R1-NW64TJTtGiO5pOPBQNgKg@mail.gmail.com>
Subject: Re: [PATCH 4/4] csky: Add dma_inv_range for DMA_FROM_DEVICE
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190730152203.IpsYBScWJsJEhb8-BHEUolmoICI7iI9mBAxvyumR8yc@z>

On Tue, Jul 30, 2019 at 5:11 PM Guo Ren <guoren@kernel.org> wrote:
> > > diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> > >                 cache_op(paddr, size, dma_wb_range);
> > >                 break;
> > >         case DMA_FROM_DEVICE:
> > > +               cache_op(paddr, size, dma_inv_range);
> > > +               break;
> > >         case DMA_BIDIRECTIONAL:
> > >                 cache_op(paddr, size, dma_wbinv_range);
> > >                 break;
> >
> > When syncing 'for_cpu', you should not need to write back, because
> > there won't be any dirty cache lines.
>
> I just follow the dma_data_direction param, seems dir param and
> function are a little bit duplicated. And our cpu won't clear clean
> cache line into memory, so dma_wb_page won't cause problem.
> Seems arch_sync_dma_for_cpu with dir=DMA_TO_DEVICE is
> self-contradictory.

Right, you generally don't need to do cache management for that
combination.

There might be other things to do here though, e.g. with a strict
iommu implementation one could tear down the i/o page table
entry to prevent the device from accessing a buffer while that is
owned by the cpu.

> Do you want me modfiy like these:
> @@ -88,6 +90,8 @@ void arch_sync_dma_for_cpu(struct device *dev,
> phys_addr_t paddr,
>         case DMA_TO_DEVICE:
>         case DMA_FROM_DEVICE:
>         case DMA_BIDIRECTIONAL:
>                cache_op(paddr, size, dma_inv_range);
>                break;
>
> @@ -72,6 +72,8 @@ void arch_sync_dma_for_device(struct device *dev,
> phys_addr_t paddr,
>         case DMA_TO_DEVICE:
>                 cache_op(paddr, size, dma_wb_range);
>                 break;
>         case DMA_FROM_DEVICE:
>         case DMA_BIDIRECTIONAL:
>                 cache_op(paddr, size, dma_wbinv_range);
>                 break;
>
> >
> > If you have a CPU core that does not do speculative loads, you also don't
> > need to invalidate here, because you have already done that in the
> > _for_device() case, the only reason to invalidate the CPU cache
> > again is if a speculative load created a stale cache line that now
> > shadows the data received from the device.
> Our CPU support speculative loads :)

Ok, then you both invalidations are indeed needed.
I was guessing that CK610 had no speculation.

       Arnd
