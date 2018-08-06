Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34111 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHFLBU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Aug 2018 07:01:20 -0400
MIME-Version: 1.0
References: <20180731051519.101249-1-ysato@users.sourceforge.jp>
 <CAMuHMdUQReuzR=x54gnC1XdP77RrT1TaWoFFXUhUQ02A+giPqQ@mail.gmail.com>
 <87600us5k9.wl-ysato@users.sourceforge.jp> <20180804103550.GA3183@bombadil.infradead.org>
 <CAMuHMdXsz-+zsxouaLP5tTKA46G34iAACSce+RXrD8AiiQc2+A@mail.gmail.com>
 <20180804105149.GB3183@bombadil.infradead.org> <4e9e1599-9dbf-75dc-561e-77d5cb063714@landley.net>
 <20180805163234.GR1392@brightrain.aerifal.cx> <61a157f1-7d43-6554-5d26-84d47ce6cabe@landley.net>
 <20180805233349.GS1392@brightrain.aerifal.cx> <CAMuHMdUgy8B4d4rAAvixB66cxaN9OiWxnXJKL17J1c47MfU76Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUgy8B4d4rAAvixB66cxaN9OiWxnXJKL17J1c47MfU76Q@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 6 Aug 2018 10:53:00 +0200
Message-ID: <CAK8P3a0JWqW-Z8EJ2BWL-Ez0=ombxrynmptxv7HT_WjSCFbV6w@mail.gmail.com>
Subject: Re: [PATCH] sh: remove unneeded constructor.
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Rob Landley <rob@landley.net>, Matthew Wilcox <willy@infradead.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Mon, Aug 6, 2018 at 8:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Aug 6, 2018 at 1:34 AM Rich Felker <dalias@libc.org> wrote:
> > On Sun, Aug 05, 2018 at 05:48:52PM -0500, Rob Landley wrote:
> > > On 08/05/2018 11:32 AM, Rich Felker wrote:
> >
> > Yes, if there's a lot of arch-specific infrastructure for boot time
> > setup, platform devices, behavior of mmu and cache, etc. that's the
> > same for 32- and 64-bit "variants" of an arch, and especially if the
> > 32-bit variant is mostly a legacy userspace that actually runs on
> > 64-bit hardware that's capable of doing both, then there's a good
> > argument for having them use a shared tree. That last part makes sense
> > for SH -- I think we'd certainly want 32-bit userspace to be able to
> > run on a 64-bit kernel. But it seems like it's possible to split that
> > across archs since ARM did.
> >
> > Really it's sort of a historical accident/misfactoring that
> > "user-to-kernel interface for ISA X" and "kernel internals for the
> > machine arch using ISA X" are conflated as the same thing. If this had
> > been done in a more clean manner the "compat syscall" stuff wouldn't
> > be such a mess.
>
> Obviously you know more about eventual 64-bit j-core support than me,
> but if you intend to run 32-bit userspace on 64-bit j-core, having it
> shared makes sense, especially if you'll maintain both.
>
> On the platform side, there will be a big difference between mostly legacy
> SH and new DT-based j-core on the 32-bit bit side, and mostly new DT-based
> j-core on the 64-bit side.
>
> Arnd probably has a better view on this.

I suspect arch/sh is in a similar state to what arch/arm was in when we added
arch/arm64, where 90% of the code is there to deal with concepts that no longer
apply to the new code base, in particular board support for pre-DT machines.

Starting a new arch/j64 would then make it look more like a clean arch/riscv/ or
arch/nds32, which are the most recently added ones. However, if you do
that, you should really start from scratch instead of copying the existing
arch code, which was the mistake that arch/arm64 did.

       Arnd
