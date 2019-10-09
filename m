Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34027 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbfJISyS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 14:54:18 -0400
MIME-Version: 1.0
References: <cover.1570633189.git.vilhelm.gray@gmail.com> <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570633189.git.vilhelm.gray@gmail.com>
 <CAK7LNATgW7bXUmqV=3QAaJ0Qu73Kox-TgDCQJb=s0=mwewSCUg@mail.gmail.com> <20191009170917.GG32742@smile.fi.intel.com>
In-Reply-To: <20191009170917.GG32742@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Oct 2019 20:54:04 +0200
Message-ID: <CAMuHMdXyyrL4ibKvjMV6r8TuxpmK73=JxsWNEfcRk1NjwsnOjA@mail.gmail.com>
Subject: Re: [PATCH v17 01/14] bitops: Introduce the for_each_set_clump8 macro
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andrew Morton <akpm@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, Phil Reid <preid@electromag.com.au>, Lukas Wunner <lukas@wunner.de>, sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191009185404.kW-hz7ikKUUN9jl_or2ksGlf_Isahk7IW9wZS7GiK0A@z>

Hi Andy,

On Wed, Oct 9, 2019 at 7:09 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Oct 10, 2019 at 01:28:08AM +0900, Masahiro Yamada wrote:
> > On Thu, Oct 10, 2019 at 12:27 AM William Breathitt Gray
> > <vilhelm.gray@gmail.com> wrote:
> > >
> > > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > > within a bitmap memory region. For each iteration, "start" is set to the
> > > bit offset of the found clump, while the respective clump value is
> > > stored to the location pointed by "clump". Additionally, the
> > > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > > respectively get and set an 8-bit value in a bitmap memory region.
>
> > Why is the return type "unsigned long" where you know
> > it return the 8-bit value ?
>
> Because bitmap API operates on unsigned long type. This is not only
> consistency, but for sake of flexibility in case we would like to introduce
> more calls like clump16 or so.

TBH, that doesn't convince me: those functions explicitly take/return an
8-bit value, and have "8" in their name.  The 8-bit value is never
really related to, retrieved from, or stored in a full "unsigned long"
element of a bitmap, only to/from/in a part (byte) of it.

Following your rationale, all of iowrite{8,16,32,64}*() should take an
"unsigned long" value, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
