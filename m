From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH v2 2/2] bits: Add tests of GENMASK
Date: Mon, 8 Jun 2020 20:42:22 +0200
Message-ID: <20200608184222.GA899@rikard>
References: <20200604233003.GA102768@rikard>
 <20200607203411.70913-1-rikard.falkeborn@gmail.com>
 <20200607203411.70913-2-rikard.falkeborn@gmail.com>
 <CAMuHMdVm_ptUipb==jt1aL4RLcRU=OHawV1j4xfB1_z7S-FPxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgFHSm2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2020 14:42:28 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdVm_ptUipb==jt1aL4RLcRU=OHawV1j4xfB1_z7S-FPxQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, emil.l.velikov@gmail.com, Kees Cook <keescook@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <lkp@intel.com>, syednwaris@gmail.com, William Breathitt Gray <vilhelm.gray@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>

On Mon, Jun 08, 2020 at 09:33:05AM +0200, Geert Uytterhoeven wrote:
> Hi Richard,
> 
> Thanks for your patch!
> 
> On Sun, Jun 7, 2020 at 10:35 PM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> > Add tests of GENMASK and GENMASK_ULL.
> >
> > A few test cases that should fail compilation are provided under ifdef.
> 
> It doesn't hurt to mention the name of the #ifdef here.
> 
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> 
> > --- /dev/null
> > +++ b/lib/test_bits.c
> > @@ -0,0 +1,73 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Test cases for functions and macrso in bits.h
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <linux/bits.h>
> > +
> > +
> > +void genmask_test(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_EQ(test, 1ul, GENMASK(0, 0));
> > +       KUNIT_EXPECT_EQ(test, 3ul, GENMASK(1, 0));
> > +       KUNIT_EXPECT_EQ(test, 6ul, GENMASK(2, 1));
> > +       KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, GENMASK(31, 0));
> > +
> > +#ifdef TEST_BITS_COMPILE
> 
> "#ifdef TEST_GENMASK_FAILURES"?

Much better! I'll update that (and add the ifdef to the commit message)
for v3.

Thanks

Rikard
> 
> > +       /* these should fail compilation */
> > +       GENMASK(0, 1);
> > +       GENMASK(0, 10);
> > +       GENMASK(9, 10);
> > +#endif
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
