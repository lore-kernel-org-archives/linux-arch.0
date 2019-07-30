Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45241 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfG3Nni (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jul 2019 09:43:38 -0400
MIME-Version: 1.0
References: <1564488945-20149-1-git-send-email-guoren@kernel.org> <1564488945-20149-4-git-send-email-guoren@kernel.org>
In-Reply-To: <1564488945-20149-4-git-send-email-guoren@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 30 Jul 2019 15:43:20 +0200
Message-ID: <CAK8P3a0v3oVS5cCkORxA7na+VE7ofTQRxiv5o5xNf5v=esnN9A@mail.gmail.com>
Subject: Re: [PATCH 4/4] csky: Add dma_inv_range for DMA_FROM_DEVICE
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190730134320.Wx8ZNQvDfJuKFLoW4xldGv2gtOhbCLEjRl17XvMEAcI@z>

On Tue, Jul 30, 2019 at 2:16 PM <guoren@kernel.org> wrote:
> From: Guo Ren <ren_guo@c-sky.com>

> diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> index 3f1ff9d..d8f0f81 100644
> --- a/arch/csky/mm/dma-mapping.c
> +++ b/arch/csky/mm/dma-mapping.c
> @@ -72,6 +72,8 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
>                 cache_op(paddr, size, dma_wb_range);
>                 break;
>         case DMA_FROM_DEVICE:
> +               cache_op(paddr, size, dma_inv_range);
> +               break;
>         case DMA_BIDIRECTIONAL:
>                 cache_op(paddr, size, dma_wbinv_range);
>                 break;
> @@ -88,6 +90,8 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
>                 cache_op(paddr, size, dma_wb_range);
>                 break;
>         case DMA_FROM_DEVICE:
> +               cache_op(paddr, size, dma_inv_range);
> +               break;
>         case DMA_BIDIRECTIONAL:
>                 cache_op(paddr, size, dma_wbinv_range);
>                 break;

When syncing 'for_cpu', you should not need to write back, because
there won't be any dirty cache lines.

If you have a CPU core that does not do speculative loads, you also don't
need to invalidate here, because you have already done that in the
_for_device() case, the only reason to invalidate the CPU cache
again is if a speculative load created a stale cache line that now
shadows the data received from the device.

        Arnd
