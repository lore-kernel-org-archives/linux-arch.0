From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 13/31] nds32: DMA mapping API
Date: Wed, 8 Nov 2017 10:09:31 +0100
Message-ID: <CAK8P3a11a+So5DUZwv+geT2WMYpMG-FPt9=nKZFyYLQ0Gs55qw@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <763e6a252de1ad8ccd28344fd0676ae2f92f796d.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <763e6a252de1ad8ccd28344fd0676ae2f92f796d.1510118606.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:

> +static void consistent_sync(void *vaddr, size_t size, int direction)
> +{
> +       unsigned long start = (unsigned long)vaddr;
> +       unsigned long end = start + size;
> +
> +       switch (direction) {
> +       case DMA_FROM_DEVICE:   /* invalidate only */
> +               cpu_dma_inval_range(start, end);
> +               break;
> +       case DMA_TO_DEVICE:     /* writeback only */
> +               cpu_dma_wb_range(start, end);
> +               break;
> +       case DMA_BIDIRECTIONAL: /* writeback and invalidate */
> +               cpu_dma_wbinval_range(start, end);
> +               break;
> +       default:
> +               BUG();
> +       }
> +}

> +
> +static void
> +nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
> +                             size_t size, enum dma_data_direction dir)
> +{
> +       consistent_sync((void *)dma_to_virt(dev, handle), size, dir);
> +}
> +
> +static void
> +nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
> +                                size_t size, enum dma_data_direction dir)
> +{
> +       consistent_sync((void *)dma_to_virt(dev, handle), size, dir);
> +}

You do the same cache operations for _to_cpu and _to_device, which
usually works,
but is more expensive than you need. It's better to take the ownership into
account and only do what you need.

     Arnd
