Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83]:50746 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeJSVF2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Oct 2018 17:05:28 -0400
MIME-Version: 1.0
References: <20181019120952.32763-1-hch@lst.de> <20181019120952.32763-7-hch@lst.de>
 <20181019122228.GJ30658@n2100.armlinux.org.uk>
In-Reply-To: <20181019122228.GJ30658@n2100.armlinux.org.uk>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 19 Oct 2018 21:58:46 +0900
Message-ID: <CAK7LNATZ8LagrTrTae_QCQbSuTW7_y6sDrdTHfTyONPrsYDs4A@mail.gmail.com>
Subject: Re: [PATCH 6/9] PCI: consolidate PCI config entry in drivers/pci
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Alex Bounine <alex.bou9@gmail.com>, mporter@kernel.crashing.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <20181019125846.jbIYS06VUCljnt_2d1VsRT4fgsDMWmni8zTd4f-_yps@z>

On Fri, Oct 19, 2018 at 9:23 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> > index a68b34183107..b185794549be 100644
> > --- a/arch/arm/mach-pxa/Kconfig
> > +++ b/arch/arm/mach-pxa/Kconfig
> > @@ -125,7 +125,7 @@ config MACH_ARMCORE
> >       bool "CompuLab CM-X255/CM-X270 modules"
> >       select ARCH_HAS_DMA_SET_COHERENT_MASK if PCI
> >       select IWMMXT
> > -     select MIGHT_HAVE_PCI
> > +     select HAVE_PCI
> >       select NEED_MACH_IO_H if PCI
> >       select PXA25x
> >       select PXA27x
>
> This is wrong.  "MIGHT_HAVE_PCI" is _not_ the same as "HAVE_PCI" - we
> have a bunch of platforms that mandatorily have PCI and these select
> PCI directly.  "MIGHT_HAVE_PCI" controls the _visibility_ of the PCI
> menu option, but does not prevent it being selected.  Your patch will
> cause Kconfig to complain for those which mandatorily have PCI but
> do not set HAVE_PCI.


Good catch!
But, adding a bunch of 'select HAVE_PCI' along with 'select PCI' is ugly.

Do you have any suggestion?

How about letting CONFIG_ARM to select HAVE_PCI ?

-- 
Best Regards
Masahiro Yamada
