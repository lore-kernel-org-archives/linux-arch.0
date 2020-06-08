From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH v2 2/2] bits: Add tests of GENMASK
Date: Mon, 8 Jun 2020 20:44:26 +0200
Message-ID: <20200608184426.GB899@rikard>
References: <20200604233003.GA102768@rikard>
 <20200607203411.70913-1-rikard.falkeborn@gmail.com>
 <20200607203411.70913-2-rikard.falkeborn@gmail.com>
 <CAHp75Vd94PKFSYNQ6h+ju40TwtPvLpi5gt0kCec=SJJOcM3GYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFHSoc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2020 14:44:32 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75Vd94PKFSYNQ6h+ju40TwtPvLpi5gt0kCec=SJJOcM3GYQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Emil Velikov <emil.l.velikov@gmail.com>, Kees Cook <keescook@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <lkp@intel.com>, Syed Nayyar Waris <syednwaris@gmail.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>

On Mon, Jun 08, 2020 at 11:08:04AM +0300, Andy Shevchenko wrote:
> On Sun, Jun 7, 2020 at 11:34 PM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> >
> > Add tests of GENMASK and GENMASK_ULL.
> >
> > A few test cases that should fail compilation are provided under ifdef.
> >
> 
> Thank you very much!
> 
> > * New patch. First time I wrote a KUnittest so may be room for
> >   improvements...
> 
> Have you considered to unify them with existing test_bitops.h?

test_bitops.c seems to be tests for macros/functions in bitops.h, so I
figured it would make more sense to add tests of bits.h in test_bits.c.
But I don't have a strong opinion about it. If you prefer, I'll move
them to test_bitops.c.

Rikard
> 
> -- 
> With Best Regards,
> Andy Shevchenko
