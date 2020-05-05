From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 0/4] Introduce the for_each_set_clump macro
Date: Tue, 5 May 2020 16:51:56 +0300
Message-ID: <CAHp75Vf_vP1qM9x81dErPeaJ4-cK-GOMnmEkxkhPY2gCvtmVbA@mail.gmail.com>
References: <cover.1588460322.git.syednwaris@gmail.com> <20200504114109.GE185537@smile.fi.intel.com>
 <20200504143638.GA4635@shinobu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728993AbgEENwD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 May 2020 09:52:03 -0400
In-Reply-To: <20200504143638.GA4635@shinobu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Syed Nayyar Waris <syednwaris@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Simek <michal.simek@xilinx.com>, Arnd Bergmann <arnd@arndb.de>, rrichter@marvell.com, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, "Zhang, Rui" <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, Linux-Arch <linux-arch@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>

On Mon, May 4, 2020 at 5:41 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Mon, May 04, 2020 at 02:41:09PM +0300, Andy Shevchenko wrote:
> > On Sun, May 03, 2020 at 04:38:36AM +0530, Syed Nayyar Waris wrote:

...

> > Looking into the last patches where we have examples I still do not see a
> > benefit of variadic clump sizes. power of 2 sizes would make sense (and be
> > optimized accordingly (64-bit, 32-bit).
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
>
> There is of course benefit in defining for_each_set_clump with clump
> sizes of powers of 2 (we can optimize for 32 and 64 bit sizes and avoid
> boundary checks that we know will not occur), but at the very least the
> variable size bitmap_set_value and bitmap_get_value provide significant
> benefit for the readability of the gpio-xilinx code:
>
>         bitmap_set_value(old, state[0], 0, width[0]);
>         bitmap_set_value(old, state[1], width[0], width[1]);
>         ...
>         state[0] = bitmap_get_value(new, 0, width[0]);
>         state[1] = bitmap_get_value(new, width[0], width[1]);
>
> These lines are simple and clear to read: we know immediately what they
> do. But if we did not have bitmap_set_value/bitmap_get_value, we'd have
> to use several bitwise operations for each line; the obfuscation of the
> code would be an obvious hinderance here.

Do I understand correctly that width[0] and width[1] may not be power
of two and it's actually the case?

-- 
With Best Regards,
Andy Shevchenko
