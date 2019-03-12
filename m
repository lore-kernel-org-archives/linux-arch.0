Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46758 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfCLJJT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Mar 2019 05:09:19 -0400
MIME-Version: 1.0
References: <cover.1551598603.git.vilhelm.gray@gmail.com> <0840d55707dacd1121659723246fa9f55737f426.1551598603.git.vilhelm.gray@gmail.com>
 <CAK7LNARRqYb_ovO_ccQ8xTLTzNYyTEK8whT2r0cq_AqpWqeNXg@mail.gmail.com>
 <CAHp75Vcbi+VeD8xzaB0hSNVhMuiVcwjD8Q9Tt6-H8L9CD32N8Q@mail.gmail.com> <CAK7LNATQN5TJkmOq0r1BzxQCk1T4AmsUmhR1zU+gq8e_f5-FQw@mail.gmail.com>
In-Reply-To: <CAK7LNATQN5TJkmOq0r1BzxQCk1T4AmsUmhR1zU+gq8e_f5-FQw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 Mar 2019 11:09:06 +0200
Message-ID: <CAHp75VfMvReunZgtBbA42Xw6GtzTO8Xfr2V9nZyV8xYjPnBm4w@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] gpio: uniphier: Utilize for_each_set_clump8 macro
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <20190312090906.6BP7gmvkScm0ntEYu0ylbUQD86hUERI-HXwLEbnIZ4I@z>

On Tue, Mar 12, 2019 at 10:58 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Tue, Mar 12, 2019 at 4:19 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Mar 12, 2019 at 6:40 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > > On Sun, Mar 3, 2019 at 4:51 PM William Breathitt Gray
> > > <vilhelm.gray@gmail.com> wrote:
> > > >
> > > > Replace verbose implementation in set_multiple callback with
> > > > for_each_set_clump8 macro to simplify code and improve clarity. An
> > > > improvement in this case is that banks that are not masked will now be
> > > > skipped.
> >
> > > Please do not do this.
> > >
> > > Nothing in this driver says the GPIO width is 8-bit.
> >
> > Huh?
> >
> > https://elixir.bootlin.com/linux/latest/source/include/dt-bindings/gpio/uniphier-gpio.h#L9
> >
> > Isn't a hardcoding?
>
>
> Semi-hardcoding.
>
> I needed to factor out some magic numbers
> shared between DT and drivers.

Effectively means you introduced an ABI, which we are not supposed to
change, where the number is carved in stone for all hardware covered
by this driver + DT pair.
If you would ever need another one it would require extending existing
bindings without dropping them away.

> Then, dt-bindings is out of realm of operating system.

Exactly!

> If I am doing wrong, I take back my comments, though.

-- 
With Best Regards,
Andy Shevchenko
