Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:54174 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfCLHVk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Mar 2019 03:21:40 -0400
Date: Tue, 12 Mar 2019 16:22:22 +0900
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190312072222.GA2898@icarus>
References: <cover.1551598603.git.vilhelm.gray@gmail.com>
 <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
 <CACRpkdbvCGRjB1sZWqN3wm660cP8S4-j0ub1j1iYpitDK_eXcQ@mail.gmail.com>
 <20190308085733.GA3903@icarus>
 <CAK7LNARvv3Z-eJooj7Htv7xWzD_Ow1whxcPrpqn84JHyqUnEJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNARvv3Z-eJooj7Htv7xWzD_Ow1whxcPrpqn84JHyqUnEJA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190312072222.XXYrjGp4btlI-wGDk9yP5XNhNuT7ci9TY_iMPnL36Yo@z>

On Tue, Mar 12, 2019 at 02:36:21PM +0900, Masahiro Yamada wrote:
> On Fri, Mar 8, 2019 at 5:57 PM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > On Fri, Mar 08, 2019 at 09:31:00AM +0100, Linus Walleij wrote:
> > > On Sun, Mar 3, 2019 at 8:47 AM William Breathitt Gray
> > > <vilhelm.gray@gmail.com> wrote:
> > >
> > > > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > > > within a bitmap memory region. For each iteration, "start" is set to the
> > > > bit offset of the found clump, while the respective clump value is
> > > > stored to the location pointed by "clump". Additionally, the
> > > > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > > > respectively get and set an 8-bit value in a bitmap memory region.
> > > >
> > > > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > >
> > > Andrew: would you be OK with this being merged in v5.1?
> > >
> > > If we need to move the code to drivers/gpio that's OK (though
> > > I think it's generally useful) but I need to know to proceed with
> > > the William's nice optimization of these drivers.
> > >
> > > Yours,
> > > Linus Walleij
> >
> > I was waiting on Andy to suggest some examples out of the GPIO realm,
> > but he may be under a heavy workload right so I decided to do a quick
> > search for one.
> >
> > In drivers/of/unittest.c, there is loop across a bitmap in the
> > of_unittest_destroy_tracked_overlays function:
> >
> >         for (id = MAX_UNITTEST_OVERLAYS - 1; id >= 0; id--) {
> >                 if (!(overlay_id_bits[BIT_WORD(id)] & BIT_MASK(id)))
> >                         continue;
> >
> > This section of code is checking each bit individually, and skipping if
> > that bit is not set. This looping can be optimized by using the
> > for_each_set_clump8 macro
> 
> 
> Probably no.
> 
> 
> I see this comment before the loop.
> /* remove in reverse order */

You're right, for_each_set_clump8 wouldn't work in this case since it
does not loop in reverse order. I shouldn't have rushed to find a case
and ignored the context of the code like that.

Since Andy appears to have hardware outside of the GPIO subsystem he's
testing, let's wait for that and see how it turns out.

William Breathitt Gray

> 
> 
> Also, the unittest code handles per-bit
> whereas your helper does per-byte.
> 
> 
> 
> 
> 
> > to skip clumps of nonset bits (not to mention
> > make the logic of the code much simpler and easier to follow by reducing
> > the code to a single line):
> >
> >         for_each_set_clump8(id, clump, overlay_id_bits, MAX_UNITTEST_OVERLAYS-1)
> >
> > The for_each_set_clump8 macro is not specific to the GPIO subsystem; I
> > just happen to use it in these GPIO drivers simply because I am most
> > familar with this section of the kernel (it's where most of my
> > contributions occur afterall).
> >
> > Consider this, if I am able to find a use for this macro outside of the
> > GPIO subsystem within a matter minutes, then there must be some benefit
> > in allowing the rest of the kernel to use the for_each_set_clump8 macro.
> > So let's put it in bitops.h rather than restrict it to just the GPIO
> > subsystem.
> 
> 
> If we do not find useful cases in other subsystem,
> this patch set looks over-engineering to me.
> 
> 
> 
> 
> 
> 
> > William Breathitt Gray
> 
> 
> --
> Best Regards
> Masahiro Yamada
