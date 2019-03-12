Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-02.nifty.com ([210.131.2.81]:51001 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfCLI6E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Mar 2019 04:58:04 -0400
MIME-Version: 1.0
References: <cover.1551598603.git.vilhelm.gray@gmail.com> <0840d55707dacd1121659723246fa9f55737f426.1551598603.git.vilhelm.gray@gmail.com>
 <CAK7LNARRqYb_ovO_ccQ8xTLTzNYyTEK8whT2r0cq_AqpWqeNXg@mail.gmail.com> <CAHp75Vcbi+VeD8xzaB0hSNVhMuiVcwjD8Q9Tt6-H8L9CD32N8Q@mail.gmail.com>
In-Reply-To: <CAHp75Vcbi+VeD8xzaB0hSNVhMuiVcwjD8Q9Tt6-H8L9CD32N8Q@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 12 Mar 2019 17:57:22 +0900
Message-ID: <CAK7LNATQN5TJkmOq0r1BzxQCk1T4AmsUmhR1zU+gq8e_f5-FQw@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] gpio: uniphier: Utilize for_each_set_clump8 macro
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <20190312085722.evt8C-O47kvWOcBrF9AE0FcBR4qD116q1xyw7zo-Ppc@z>

On Tue, Mar 12, 2019 at 4:19 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Mar 12, 2019 at 6:40 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > On Sun, Mar 3, 2019 at 4:51 PM William Breathitt Gray
> > <vilhelm.gray@gmail.com> wrote:
> > >
> > > Replace verbose implementation in set_multiple callback with
> > > for_each_set_clump8 macro to simplify code and improve clarity. An
> > > improvement in this case is that banks that are not masked will now be
> > > skipped.
>
> > Please do not do this.
> >
> > Nothing in this driver says the GPIO width is 8-bit.
>
> Huh?
>
> https://elixir.bootlin.com/linux/latest/source/include/dt-bindings/gpio/uniphier-gpio.h#L9
>
> Isn't a hardcoding?


Semi-hardcoding.

I needed to factor out some magic numbers
shared between DT and drivers.

Then, dt-bindings is out of realm of operating system.

If I am doing wrong, I take back my comments, though.



-- 
Best Regards
Masahiro Yamada
