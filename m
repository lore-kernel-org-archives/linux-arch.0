Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk1-f195.google.com ([209.85.221.195]:43264 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfD1IqQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Apr 2019 04:46:16 -0400
MIME-Version: 1.0
References: <20190427153222.GA9613@jerusalem> <20190427202150.GB9613@jerusalem>
In-Reply-To: <20190427202150.GB9613@jerusalem>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 28 Apr 2019 10:46:03 +0200
Message-ID: <CAMuHMdXNCxHP=BWPOy70LjNJoMH+zy7yYOHj29gYt79_5=4ffg@mail.gmail.com>
Subject: Re: endianness swapped
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Angelo Dureghello <angelo@sysam.it>
Cc: Logan Gunthorpe <logang@deltatee.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Greg KH <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190428084603.1gRUjBGd7b6BRiAYkupEo4B3foYnwRR_ZX_59Lnb9BQ@z>

Hi Angelo,

CC commit relations

On Sat, Apr 27, 2019 at 10:22 PM Angelo Dureghello <angelo@sysam.it> wrote:
> On Sat, Apr 27, 2019 at 05:32:22PM +0200, Angelo Dureghello wrote:
> > as you may know, i am working on mcf5441x.
> > Sorry for not following carefully all the threads, but from a certain
> > kernel version (likely 4.19 or near there), seems ioread32be
> > reads the bytes swapped in endianness (mcf-edma dma driver not working
> > anymore).
> >
> > Has there been a change about this in the architecture I/O access ?
> > How should i proceed now ? Fixing the DMA driver read/write, or what ?

> looks like the reason of my ioread32be now swapped is:
>
> https://patchwork.kernel.org/patch/10766673/
>
> Trying to figure out what to do now.

This is commit aecc787c06f4300f ("iomap: Use non-raw io functions for
io{read|write}XXbe"):

--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -65,8 +65,8 @@ static void bad_io_access(unsigned long port, const
char *access)
 #endif

 #ifndef mmio_read16be
-#define mmio_read16be(addr) be16_to_cpu(__raw_readw(addr))
-#define mmio_read32be(addr) be32_to_cpu(__raw_readl(addr))
+#define mmio_read16be(addr) swab16(readw(addr))
+#define mmio_read32be(addr) swab32(readl(addr))
 #endif

 unsigned int ioread8(void __iomem *addr)
@@ -106,8 +106,8 @@ EXPORT_SYMBOL(ioread32be);
 #endif

 #ifndef mmio_write16be
-#define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
-#define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
+#define mmio_write16be(val,port) writew(swab16(val),port)
+#define mmio_write32be(val,port) writel(swab32(val),port)

On big endian, the raw accessors are assumed to be non-swapping,
while non-raw accessors are assumed to be swapping.
The latter is not true for Coldfire internal registers, cfr.
arch/m68k/include/asm/io_no.h:

static inline u16 readw(const volatile void __iomem *addr)
{
        if (cf_internalio(addr))
                return __raw_readw(addr);
        return __le16_to_cpu(__raw_readw(addr));
}

Orthogonal to how Coldfire's read[wl]() should be fixed, I find it a bit
questionable to swap data twice on big endian architectures.

Fortunately we can avoid that by defining our own
mmio_{read,write}{16,32}be()...

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
