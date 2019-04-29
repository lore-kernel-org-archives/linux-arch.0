Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38514 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbfD2LNu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Apr 2019 07:13:50 -0400
MIME-Version: 1.0
References: <20190427153222.GA9613@jerusalem> <20190427202150.GB9613@jerusalem>
 <CAMuHMdXNCxHP=BWPOy70LjNJoMH+zy7yYOHj29gYt79_5=4ffg@mail.gmail.com>
 <CAK8P3a2F6KW3M7ZaK=WL8429j_z=y_wXrx6rthxni8vBmsMPyg@mail.gmail.com>
 <c75092d5-0bbf-cd8e-d0a2-ff1384ac5a48@linux-m68k.org> <CAMuHMdUC6zXH5SUEChDNHHJL2=Aq6XfRebFWK0JtH5zDWMSVgQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUC6zXH5SUEChDNHHJL2=Aq6XfRebFWK0JtH5zDWMSVgQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 29 Apr 2019 13:13:32 +0200
Message-ID: <CAK8P3a0gex0ffvX9zQDV=N7g6q7UAxxYRn2PeAbbAgrd1wTvQg@mail.gmail.com>
Subject: Re: endianness swapped
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>, Angelo Dureghello <angelo@sysam.it>, Logan Gunthorpe <logang@deltatee.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Greg KH <gregkh@linuxfoundation.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190429111332.aLHthkx90vBb7ExbrIlD-RfZjKvKBPHDA55i8fbTJ7c@z>

On Mon, Apr 29, 2019 at 10:44 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, Apr 28, 2019 at 3:59 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
> > On 28/4/19 7:21 pm, Arnd Bergmann wrote:
> > > On Sun, Apr 28, 2019 at 10:46 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > >>
> > >> Orthogonal to how Coldfire's read[wl]() should be fixed, I find it a bit
> > >> questionable to swap data twice on big endian architectures.
> > >
> > > I would expect that the compiler is capable of detecting a double
> > > swap and optimize it out. Even if it can't, there are not that many
> > > instances of io{read,write}{16,32}be in the kernel, so the increase
> > > in kernel image size from a double swap should be limited to a
> > > few extra instructions, and the runtime overhead should be
> > > negligible compared to the bus access.
>
> Probably the overhead is not negligible on old m68k...

Maybe the I/O devices are faster than I expected then. I was guessing
that there is still a factor of 100x or more between going to an on-chip
bus and single byterev register-to-register instruction.

I did notice that __arch_swab32() is an inline assembly, so the
compiler has no way of eliminating the double swap, but
setting CONFIG_ARCH_USE_BUILTIN_BSWAP makes it
do the right thing.

      Arnd
