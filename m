From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/2] bits: Add tests of GENMASK
Date: Mon, 8 Jun 2020 09:33:05 +0200
Message-ID: <CAMuHMdVm_ptUipb==jt1aL4RLcRU=OHawV1j4xfB1_z7S-FPxQ@mail.gmail.com>
References: <20200604233003.GA102768@rikard> <20200607203411.70913-1-rikard.falkeborn@gmail.com>
 <20200607203411.70913-2-rikard.falkeborn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40808 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbgFHHdS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2020 03:33:18 -0400
In-Reply-To: <20200607203411.70913-2-rikard.falkeborn@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, emil.l.velikov@gmail.com, Kees Cook <keescook@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <lkp@intel.com>, syednwaris@gmail.com, William Breathitt Gray <vilhelm.gray@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>

Hi Richard,

Thanks for your patch!

On Sun, Jun 7, 2020 at 10:35 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
> Add tests of GENMASK and GENMASK_ULL.
>
> A few test cases that should fail compilation are provided under ifdef.

It doesn't hurt to mention the name of the #ifdef here.

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

> --- /dev/null
> +++ b/lib/test_bits.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Test cases for functions and macrso in bits.h
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/bits.h>
> +
> +
> +void genmask_test(struct kunit *test)
> +{
> +       KUNIT_EXPECT_EQ(test, 1ul, GENMASK(0, 0));
> +       KUNIT_EXPECT_EQ(test, 3ul, GENMASK(1, 0));
> +       KUNIT_EXPECT_EQ(test, 6ul, GENMASK(2, 1));
> +       KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, GENMASK(31, 0));
> +
> +#ifdef TEST_BITS_COMPILE

"#ifdef TEST_GENMASK_FAILURES"?

> +       /* these should fail compilation */
> +       GENMASK(0, 1);
> +       GENMASK(0, 10);
> +       GENMASK(9, 10);
> +#endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
