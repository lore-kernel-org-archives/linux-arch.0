Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37429 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfCHJT3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Mar 2019 04:19:29 -0500
MIME-Version: 1.0
References: <cover.1551598603.git.vilhelm.gray@gmail.com> <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
 <CACRpkdbvCGRjB1sZWqN3wm660cP8S4-j0ub1j1iYpitDK_eXcQ@mail.gmail.com> <20190308085733.GA3903@icarus>
In-Reply-To: <20190308085733.GA3903@icarus>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Mar 2019 11:19:16 +0200
Message-ID: <CAHp75VdaHYoXCqmnt=F_mnaTnCedLqs6CL1aC-oPFRdNJCAUCA@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190308091916.WRcOcVi7mDthsAC5dWQb3xH2zmW0rk4nMxiEDsXjL5I@z>

On Fri, Mar 8, 2019 at 10:56 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Fri, Mar 08, 2019 at 09:31:00AM +0100, Linus Walleij wrote:
> > On Sun, Mar 3, 2019 at 8:47 AM William Breathitt Gray
> > <vilhelm.gray@gmail.com> wrote:
> >
> > > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > > within a bitmap memory region. For each iteration, "start" is set to the
> > > bit offset of the found clump, while the respective clump value is
> > > stored to the location pointed by "clump". Additionally, the
> > > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > > respectively get and set an 8-bit value in a bitmap memory region.

> > Andrew: would you be OK with this being merged in v5.1?
> >
> > If we need to move the code to drivers/gpio that's OK (though
> > I think it's generally useful) but I need to know to proceed with
> > the William's nice optimization of these drivers.
> >
> > Yours,
> > Linus Walleij
>
> I was waiting on Andy to suggest some examples out of the GPIO realm,
> but he may be under a heavy workload right

Yeah, sorry for that. I will use your helpers in the future for sure
in the suitable parts of the code inside and outside of GPIO, just not
in a highest priority to me.

> so I decided to do a quick
> Consider this, if I am able to find a use for this macro outside of the
> GPIO subsystem within a matter minutes, then there must be some benefit
> in allowing the rest of the kernel to use the for_each_set_clump8 macro.
> So let's put it in bitops.h rather than restrict it to just the GPIO
> subsystem.

As I mentioned earlier I'm pretty sure I found as well opportunity to
use this new API
outside of GPIO realm. I just want to be sure (means of testing on real HW).

-- 
With Best Regards,
Andy Shevchenko
