Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35853 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeHFJFd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Aug 2018 05:05:33 -0400
MIME-Version: 1.0
References: <20180731051519.101249-1-ysato@users.sourceforge.jp>
 <CAMuHMdUQReuzR=x54gnC1XdP77RrT1TaWoFFXUhUQ02A+giPqQ@mail.gmail.com>
 <87600us5k9.wl-ysato@users.sourceforge.jp> <20180804103550.GA3183@bombadil.infradead.org>
 <CAMuHMdXsz-+zsxouaLP5tTKA46G34iAACSce+RXrD8AiiQc2+A@mail.gmail.com>
 <20180804105149.GB3183@bombadil.infradead.org> <4e9e1599-9dbf-75dc-561e-77d5cb063714@landley.net>
 <20180805163234.GR1392@brightrain.aerifal.cx> <61a157f1-7d43-6554-5d26-84d47ce6cabe@landley.net>
 <20180805233349.GS1392@brightrain.aerifal.cx>
In-Reply-To: <20180805233349.GS1392@brightrain.aerifal.cx>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Aug 2018 08:57:41 +0200
Message-ID: <CAMuHMdUgy8B4d4rAAvixB66cxaN9OiWxnXJKL17J1c47MfU76Q@mail.gmail.com>
Subject: Re: [PATCH] sh: remove unneeded constructor.
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rich Felker <dalias@libc.org>
Cc: Rob Landley <rob@landley.net>, Matthew Wilcox <willy@infradead.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

Hi Rich,

CC Arnd

On Mon, Aug 6, 2018 at 1:34 AM Rich Felker <dalias@libc.org> wrote:
> On Sun, Aug 05, 2018 at 05:48:52PM -0500, Rob Landley wrote:
> > On 08/05/2018 11:32 AM, Rich Felker wrote:
> > > On Sun, Aug 05, 2018 at 10:54:56AM -0500, Rob Landley wrote:
> > >> On 08/04/2018 05:51 AM, Matthew Wilcox wrote:
> > >>> On Sat, Aug 04, 2018 at 12:47:08PM +0200, Geert Uytterhoeven wrote:
> > >>>> You do want to readd the __GFP_ZERO flag to the second user of PGALLOC_GFP,
> > >>>> don't you?
> > >>>
> > >>> I missed that!  Probably only relevant for SH-64.  But yes ... probably better
> > >>> to make this explicit then:
> > >>
> > >> As far as I know sh5/sh-64 never shipped, it was just some prototype hardware
> > >> that didn't go to production?
> > >
> > > I'm not sure about the details, but GCC has removed support and it's
> > > effectively dead. I would be happy to merge patches removing the
> > > existing SH-64 stuff in the kernel too. I'm not sure if generality to
> > > support LP64 should be left in the arch/sh tree for future or if the
> > > eventual 64-bit j-core should just be done as a separate arch tree; I
> > > suspect the latter might be cleaner.
> >
> > LP64 is mostly just "long fits in a pointer", which is true on 32 bit too. What
> > extra "lp64" support are you referring to?
>
> I'm using the normal definition of LP64 which is "long and pointer are
> both exactly 64-bits", not "long fits in pointer" or "long and pointer
> are same size".
>
> > It seems like the only architecture with 32 and 64 bit variants that _doesn't_
> > have them together is arm? (x86 does, powerpc does, mips does...)
>
> Yes, if there's a lot of arch-specific infrastructure for boot time
> setup, platform devices, behavior of mmu and cache, etc. that's the
> same for 32- and 64-bit "variants" of an arch, and especially if the
> 32-bit variant is mostly a legacy userspace that actually runs on
> 64-bit hardware that's capable of doing both, then there's a good
> argument for having them use a shared tree. That last part makes sense
> for SH -- I think we'd certainly want 32-bit userspace to be able to
> run on a 64-bit kernel. But it seems like it's possible to split that
> across archs since ARM did.
>
> Really it's sort of a historical accident/misfactoring that
> "user-to-kernel interface for ISA X" and "kernel internals for the
> machine arch using ISA X" are conflated as the same thing. If this had
> been done in a more clean manner the "compat syscall" stuff wouldn't
> be such a mess.

Obviously you know more about eventual 64-bit j-core support than me,
but if you intend to run 32-bit userspace on 64-bit j-core, having it
shared makes sense, especially if you'll maintain both.

On the platform side, there will be a big difference between mostly legacy
SH and new DT-based j-core on the 32-bit bit side, and mostly new DT-based
j-core on the 64-bit side.

Arnd probably has a better view on this.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
