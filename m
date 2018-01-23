Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35271 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbeAWIYJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jan 2018 03:24:09 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0-Vf9CRZzdXCxpuQoWgMhYWgO6Hy2KuP-gOKttoSGESA@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <ecd1742c718c5b45983486cf9dfb44adb6e06923.1515766253.git.green.hu@gmail.com>
 <CAK8P3a0-Vf9CRZzdXCxpuQoWgMhYWgO6Hy2KuP-gOKttoSGESA@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Tue, 23 Jan 2018 16:23:27 +0800
Message-ID: <CAEbi=3cYynvFS2GDzj5Oav_5LtHPdBfBWh9c=mFT0PxeOLX9sQ@mail.gmail.com>
Subject: Re: [PATCH v6 16/36] nds32: DMA mapping API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180123082327.BFmEbZes6RVD3BkKukdAT4nCJomtS20IWrjPBfudrvk@z>

Hi, Arnd:

2018-01-18 18:26 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> This patch adds support for the DMA mapping API. It uses dma_map_ops for
>> flexibility.
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>
> I'm still unhappy about the way the cache flushes are done here as discussed
> before. It's not a show-stopped, but no Ack from me.

How about this implementation?

static void
nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
                              size_t size, enum dma_data_direction dir)
{
        switch (direction) {
        case DMA_TO_DEVICE:     /* writeback only */
                break;
        case DMA_FROM_DEVICE:   /* invalidate only */
        case DMA_BIDIRECTIONAL: /* writeback and invalidate */
                cpu_dma_inval_range(start, end);
                break;
        default:
                BUG();
        }
}

static void
nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
                                 size_t size, enum dma_data_direction dir)
{
        switch (direction) {
        case DMA_FROM_DEVICE:   /* invalidate only */
                break;
        case DMA_TO_DEVICE:     /* writeback only */
        case DMA_BIDIRECTIONAL: /* writeback and invalidate */
                cpu_dma_wb_range(start, end);
                break;
        default:
                BUG();
        }
}
