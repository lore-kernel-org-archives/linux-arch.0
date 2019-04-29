Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41169 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfD2Ik0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Apr 2019 04:40:26 -0400
MIME-Version: 1.0
References: <20190427153222.GA9613@jerusalem> <20190427202150.GB9613@jerusalem>
 <CAMuHMdXNCxHP=BWPOy70LjNJoMH+zy7yYOHj29gYt79_5=4ffg@mail.gmail.com>
 <CAK8P3a2F6KW3M7ZaK=WL8429j_z=y_wXrx6rthxni8vBmsMPyg@mail.gmail.com>
 <c75092d5-0bbf-cd8e-d0a2-ff1384ac5a48@linux-m68k.org> <CAK8P3a16O57dvUYUPVZJpvZ7Hm6WA-jc_svQHTAEdDpbyLRv7w@mail.gmail.com>
 <50f49e95-95f3-4fdb-bcf6-6165382a5168@linux-m68k.org>
In-Reply-To: <50f49e95-95f3-4fdb-bcf6-6165382a5168@linux-m68k.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 29 Apr 2019 10:40:09 +0200
Message-ID: <CAK8P3a2+EHhLkhde31xa3Qt_wHDCn4hjZ8d8XpCmqEm+z37XYg@mail.gmail.com>
Subject: Re: endianness swapped
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Angelo Dureghello <angelo@sysam.it>, Logan Gunthorpe <logang@deltatee.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Greg KH <gregkh@linuxfoundation.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190429084009.KWbgoQ9PsxwHuaaFH2i8Mo-r5n7ou6AHn6p02JbxOfs@z>

On Mon, Apr 29, 2019 at 9:04 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 29/4/19 4:44 am, Arnd Bergmann wrote:
> > Is there a complete list of coldfire on-chip device drivers?
> >
> > Looking at some of the drivers:
> >
> > - drivers/i2c/busses/i2c-imx.c uses only 8-bit accesses and works either way,
> >    same for drivers/tty/serial/mcf.c
> > - drivers/spi/spi-coldfire-qspi.c is apparently coldfire-only and could use
> >    ioread32be for a portable to do big-endian register access.
> > - edma-common has a wrapper to support both big-endian and little-endian
> >    configurations in the same kernel image, but the mcf interrupt handler
> >    is hardcoded to the (normally) little-endian ioread32 function.
> > - drivers/net/ethernet/freescale/fec_main.c is shared between coldfire
> >    and i.MX (but not mpc52xx), and is hardcoded to readl/writel, and
> >    would need the same trick as edma to make it portable.
>
> That matches up with what we list out in arch/m68k/coldfire/devices.c.
> I can't think of any other drivers.

Ok

> There is a lot of use readl/writel and friends in the architecture
> specific code too, in arch/m68k/coldfire. At first I used __raw_readl/
> __raw_writel to always get native endianess. But quote a few uses of
> readl/writel have crept in over the years.

I generally recommend avoiding the __raw_ accessors altogether
except for very special cases (e.g. copying from device memory
into main RAM in fixed-size units). On most architectures these
days, MMIO registers require additional properties that are
provided by readl() but not __raw_readl(), in particular atomicity
and ordering against other memory accesses and spinlocks.
Presumably m68k is similar to i386 here in that the __raw_ version
already provides all those guarantees due to the way the architecture
is defined.

What tends to work best in cases like this is to have a bus specific
wrapper around readl/ioread32/ioread32be that does exactly what
is needed for the bus that a device is on. As we concluded earlier,
it's easy enough to define coldfire specific ioread32be etc that
do what we want here, but it also sounds like it would not be hard
to change arch/m68k/coldfire/*.c, drivers/net/ethernet/freescale/fec*
and drivers/dma/*edma*.c to use big-endian accessors, and
then make coldfire use the generic readl/writel and
ioread32be/iowrite32be.

      Arnd
