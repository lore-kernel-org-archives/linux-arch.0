From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
Date: Sat, 30 May 2020 01:07:51 +0300
Message-ID: <CAHp75VfGCLSOwPtygG7Vq8RLhvA3_3EcB-WRCXZzR=jzOP6DsA@mail.gmail.com>
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com> <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com> <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
 <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgE2WII (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 18:08:08 -0400
In-Reply-To: <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, May 30, 2020 at 12:42 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, May 29, 2020 at 11:07 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > On Sat, May 30, 2020 at 12:08 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

...

> > Explanation:
> > Actually when nbits (clump size) is 64 (BITS_PER_LONG is 64 on my computer),
> > (BIT(nbits) - 1)
> > gives a value of zero and when this zero is ANDed with any value, it
> > makes it full zero. This is unexpected and incorrect calculation happening.
> >
> > What actually happens is in the macro expansion of BIT(64), that is 1
> > << 64, the '1' overflows from leftmost bit position (most significant
> > bit) and re-enters at the rightmost bit position (least significant
> > bit), therefore 1 << 64 becomes '0x1', and when another '1' is
> > subtracted from this, the final result becomes 0.
> >
> > Since this macro is being used in both bitmap_get_value and
> > bitmap_set_value functions, it will give unexpected results when nbits or clump
> > size is BITS_PER_LONG (32 or 64 depending on arch).
>
> I see, something like
> https://elixir.bootlin.com/linux/latest/source/include/linux/dma-mapping.h#L139
> should be done.
> But yes, let's try to fix GENMASK().
>
> So, if we modify the following
>
>   #define GENMASK_INPUT_CHECK(h, l) \
>     (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>     __builtin_constant_p((l) > (h)), (l) > (h), 0)))
>
> to be
>
>   #define GENMASK_INPUT_CHECK(h, l) \
>     (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>     __builtin_constant_p((l) > (h)), (l) ? (l) > (h) : 0, 0)))
>
> would it work?

Actually it needs an amendment for signed types...

(l) ? (l) > (h) : !((h) > 0)

...but today is Friday night, so, mistakes are warranted :-)

-- 
With Best Regards,
Andy Shevchenko
