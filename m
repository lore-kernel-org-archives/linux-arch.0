From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/2] bits: Add tests of GENMASK
Date: Mon, 8 Jun 2020 11:08:30 +0300
Message-ID: <CAHp75Vf7ToQFS8dGNJ8FaXa8qpJa-82iHJ2s3VZdzWrBCf5=1A@mail.gmail.com>
References: <20200604233003.GA102768@rikard> <20200607203411.70913-1-rikard.falkeborn@gmail.com>
 <20200607203411.70913-2-rikard.falkeborn@gmail.com> <CAHp75Vd94PKFSYNQ6h+ju40TwtPvLpi5gt0kCec=SJJOcM3GYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgFHIIn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2020 04:08:43 -0400
In-Reply-To: <CAHp75Vd94PKFSYNQ6h+ju40TwtPvLpi5gt0kCec=SJJOcM3GYQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Emil Velikov <emil.l.velikov@gmail.com>, Kees Cook <keescook@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <lkp@intel.com>, Syed Nayyar Waris <syednwaris@gmail.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>

On Mon, Jun 8, 2020 at 11:08 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
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

test_bitops.c, of course.

-- 
With Best Regards,
Andy Shevchenko
