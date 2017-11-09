From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 13/31] nds32: DMA mapping API
Date: Thu, 9 Nov 2017 15:12:05 +0800
Message-ID: <CAEbi=3ebX94-eHa56+ktvbp3Obbe_Uwva8tiPrZvQT-x+QnZzQ@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <763e6a252de1ad8ccd28344fd0676ae2f92f796d.1510118606.git.green.hu@gmail.com>
 <CAK8P3a11a+So5DUZwv+geT2WMYpMG-FPt9=nKZFyYLQ0Gs55qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:46184 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752549AbdKIHMq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Nov 2017 02:12:46 -0500
In-Reply-To: <CAK8P3a11a+So5DUZwv+geT2WMYpMG-FPt9=nKZFyYLQ0Gs55qw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, deanbo422@gmail.com

2017-11-08 17:09 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>
>> +static void consistent_sync(void *vaddr, size_t size, int direction)
>> +{
>> +       unsigned long start = (unsigned long)vaddr;
>> +       unsigned long end = start + size;
>> +
>> +       switch (direction) {
>> +       case DMA_FROM_DEVICE:   /* invalidate only */
>> +               cpu_dma_inval_range(start, end);
>> +               break;
>> +       case DMA_TO_DEVICE:     /* writeback only */
>> +               cpu_dma_wb_range(start, end);
>> +               break;
>> +       case DMA_BIDIRECTIONAL: /* writeback and invalidate */
>> +               cpu_dma_wbinval_range(start, end);
>> +               break;
>> +       default:
>> +               BUG();
>> +       }
>> +}
>
>> +
>> +static void
>> +nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
>> +                             size_t size, enum dma_data_direction dir)
>> +{
>> +       consistent_sync((void *)dma_to_virt(dev, handle), size, dir);
>> +}
>> +
>> +static void
>> +nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
>> +                                size_t size, enum dma_data_direction dir)
>> +{
>> +       consistent_sync((void *)dma_to_virt(dev, handle), size, dir);
>> +}
>
> You do the same cache operations for _to_cpu and _to_device, which
> usually works,
> but is more expensive than you need. It's better to take the ownership into
> account and only do what you need.
>

Thanks.

Like this?

static void
nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
                              size_t size, enum dma_data_direction dir)
{
        consistent_sync((void *)dma_to_virt(dev, handle), size,
DMA_FROM_DEVICE);
}

static void
nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
                                 size_t size, enum dma_data_direction dir)
{
        consistent_sync((void *)dma_to_virt(dev, handle), size,
DMA_TO_DEVICE);
}
