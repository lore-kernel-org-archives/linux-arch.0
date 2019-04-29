Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44071 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfD2Iof (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Apr 2019 04:44:35 -0400
MIME-Version: 1.0
References: <20190427153222.GA9613@jerusalem> <20190427202150.GB9613@jerusalem>
 <CAMuHMdXNCxHP=BWPOy70LjNJoMH+zy7yYOHj29gYt79_5=4ffg@mail.gmail.com>
 <CAK8P3a2F6KW3M7ZaK=WL8429j_z=y_wXrx6rthxni8vBmsMPyg@mail.gmail.com> <c75092d5-0bbf-cd8e-d0a2-ff1384ac5a48@linux-m68k.org>
In-Reply-To: <c75092d5-0bbf-cd8e-d0a2-ff1384ac5a48@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Apr 2019 10:44:22 +0200
Message-ID: <CAMuHMdUC6zXH5SUEChDNHHJL2=Aq6XfRebFWK0JtH5zDWMSVgQ@mail.gmail.com>
Subject: Re: endianness swapped
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Angelo Dureghello <angelo@sysam.it>, Logan Gunthorpe <logang@deltatee.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Greg KH <gregkh@linuxfoundation.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190429084422.B13MNwd949qgvqnLdPEewHLaquZ7u8Nnm4mu-2G3Ra0@z>

Hi Greg,

On Sun, Apr 28, 2019 at 3:59 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 28/4/19 7:21 pm, Arnd Bergmann wrote:
> > On Sun, Apr 28, 2019 at 10:46 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> >> On Sat, Apr 27, 2019 at 10:22 PM Angelo Dureghello <angelo@sysam.it> wrote:
> >>> On Sat, Apr 27, 2019 at 05:32:22PM +0200, Angelo Dureghello wrote:
> >>>> as you may know, i am working on mcf5441x.
> >>>> Sorry for not following carefully all the threads, but from a certain
> >>>> kernel version (likely 4.19 or near there), seems ioread32be
> >>>> reads the bytes swapped in endianness (mcf-edma dma driver not working
> >>>> anymore).
> >>>>
> >>>> Has there been a change about this in the architecture I/O access ?
> >>>> How should i proceed now ? Fixing the DMA driver read/write, or what ?
> >>
> >>> looks like the reason of my ioread32be now swapped is:
> >>>
> >>> https://patchwork.kernel.org/patch/10766673/
> >>>
> >>> Trying to figure out what to do now.
> >>
> >> This is commit aecc787c06f4300f ("iomap: Use non-raw io functions for
> >> io{read|write}XXbe"):
> >>
> >> --- a/lib/iomap.c
> >> +++ b/lib/iomap.c
> >> @@ -65,8 +65,8 @@ static void bad_io_access(unsigned long port, const
> >> char *access)
> >>   #endif
> >>
> >>   #ifndef mmio_read16be
> >> -#define mmio_read16be(addr) be16_to_cpu(__raw_readw(addr))
> >> -#define mmio_read32be(addr) be32_to_cpu(__raw_readl(addr))
> >> +#define mmio_read16be(addr) swab16(readw(addr))
> >> +#define mmio_read32be(addr) swab32(readl(addr))
> >>   #endif
> >>
> >>   unsigned int ioread8(void __iomem *addr)
> >> @@ -106,8 +106,8 @@ EXPORT_SYMBOL(ioread32be);
> >>   #endif
> >>
> >>   #ifndef mmio_write16be
> >> -#define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
> >> -#define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
> >> +#define mmio_write16be(val,port) writew(swab16(val),port)
> >> +#define mmio_write32be(val,port) writel(swab32(val),port)
> >>
> >> On big endian, the raw accessors are assumed to be non-swapping,
> >> while non-raw accessors are assumed to be swapping.
> >> The latter is not true for Coldfire internal registers, cfr.
> >> arch/m68k/include/asm/io_no.h:

> >> static inline u16 readw(const volatile void __iomem *addr)
> >> {
> >>          if (cf_internalio(addr))
> >>                  return __raw_readw(addr);
> >>          return __le16_to_cpu(__raw_readw(addr));
> >> }
> >>
> >> Orthogonal to how Coldfire's read[wl]() should be fixed, I find it a bit
> >> questionable to swap data twice on big endian architectures.
> >
> > I would expect that the compiler is capable of detecting a double
> > swap and optimize it out. Even if it can't, there are not that many
> > instances of io{read,write}{16,32}be in the kernel, so the increase
> > in kernel image size from a double swap should be limited to a
> > few extra instructions, and the runtime overhead should be
> > negligible compared to the bus access.

Probably the overhead is not negligible on old m68k...

> >> Fortunately we can avoid that by defining our own
> >> mmio_{read,write}{16,32}be()...
>
> Makes sense.

I've just sent a patch to do that, as a fix for v5.1 or v5.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
