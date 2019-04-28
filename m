Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ec2-18-194-220-216.eu-central-1.compute.amazonaws.com ([18.194.220.216]:33308
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfD1Vj6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Apr 2019 17:39:58 -0400
Date: Sun, 28 Apr 2019 23:31:02 +0200
From: Angelo Dureghello <angelo@sysam.it>
Subject: Re: endianness swapped
Message-ID: <20190428213102.GA27051@jerusalem>
References: <20190427153222.GA9613@jerusalem>
 <20190427202150.GB9613@jerusalem>
 <CAMuHMdXNCxHP=BWPOy70LjNJoMH+zy7yYOHj29gYt79_5=4ffg@mail.gmail.com>
 <CAK8P3a2F6KW3M7ZaK=WL8429j_z=y_wXrx6rthxni8vBmsMPyg@mail.gmail.com>
 <c75092d5-0bbf-cd8e-d0a2-ff1384ac5a48@linux-m68k.org>
 <CAK8P3a16O57dvUYUPVZJpvZ7Hm6WA-jc_svQHTAEdDpbyLRv7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a16O57dvUYUPVZJpvZ7Hm6WA-jc_svQHTAEdDpbyLRv7w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Logan Gunthorpe <logang@deltatee.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Greg KH <gregkh@linuxfoundation.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190428213102.bQguS96q2XPzaGTr0iDvaN8P5oUG7qHW38lcNZe5-zQ@z>

Hi all,

On Sun, Apr 28, 2019 at 08:44:03PM +0200, Arnd Bergmann wrote:
> On Sun, Apr 28, 2019 at 3:59 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
> > On 28/4/19 7:21 pm, Arnd Bergmann wrote:
> > > On Sun, Apr 28, 2019 at 10:46 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > >> On Sat, Apr 27, 2019 at 10:22 PM Angelo Dureghello <angelo@sysam.it> wrote:
> > >>> On Sat, Apr 27, 2019 at 05:32:22PM +0200, Angelo Dureghello wrote:
> > >
> > > Coldfire makes the behavior of readw()/readl() depend on the
> > > MMIO address, presumably since that was the easiest way to
> > > get drivers working originally, but it breaks the assumption
> > > in the asm-generic code.
> >
> > Yes, that is right.
> >
> > There is a number of common hardware modules that Freescale have
> > used in the ColdFire SoC parts and in their ARM based parts (iMX
> > families). The ARM parts are pretty much always little endian, and
> > the ColdFire is always big endian. The hardware registers in those
> > hardware blocks are always accessed in native endian of the processor.
> 
> In later Freescale/NXP ARM SoCs (i.MX and Layerscape), we
> also get a lot of devices pulled over from PowerPC, with random
> endianess. In some cases, the same device that had big-endian
> registers originally ends up in two different ARM products and one of
> them uses big-endian while the other one uses little-endian registers.
> 

Yes, this seems confirmed also from the drivers/dma/fsl-edma-common.h
comment:

/*
 * R/W functions for big- or little-endian registers:
 * The eDMA controller's endian is independent of the CPU core's endian.
 * For the big-endian IP module, the offset for 8-bit or 16-bit registers
 * should also be swapped opposite to that in little-endian IP.
 */

> > So the address range checks are to deal with those internal
> > hardware blocks (i2c, spi, dma, etc), since we know those are
> > at fixed addresses. That leaves the usual endian swapping in place for
> > other general (ie external) devices (PCI devices, network chips, etc).
> 
> Is there a complete list of coldfire on-chip device drivers?
> 

I can list those i worked on

i2c-imx.c
spi-fsl-dspi.c
mcf-edma.c + fsl-edma.common.c
now working on a sdhci-esdhc-mcf.c

And about mcf5441x, some other drivers as usb or probably can have still 
to be enabled/mainlined.  

> Looking at some of the drivers:
> 
> - drivers/i2c/busses/i2c-imx.c uses only 8-bit accesses and works either way,
>   same for drivers/tty/serial/mcf.c
> - drivers/spi/spi-coldfire-qspi.c is apparently coldfire-only and could use
>   ioread32be for a portable to do big-endian register access.
> - edma-common has a wrapper to support both big-endian and little-endian
>   configurations in the same kernel image, but the mcf interrupt handler
>   is hardcoded to the (normally) little-endian ioread32 function.
> - drivers/net/ethernet/freescale/fec_main.c is shared between coldfire
>   and i.MX (but not mpc52xx), and is hardcoded to readl/writel, and
>   would need the same trick as edma to make it portable.
> 
>       Arnd

Regards,
Angelo
