From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix unsigned less than zero warnings
Date: Fri, 5 Jun 2020 01:30:03 +0200
Message-ID: <20200604233003.GA102768@rikard>
References: <20200603215314.GA916134@rikard>
 <20200603220226.916269-1-rikard.falkeborn@gmail.com>
 <CAHp75VcNVOF6jHZ7gtpqskg9rDgwt3MmtGZJJOXE-GwvXRPOhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFDXaN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jun 2020 19:30:13 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VcNVOF6jHZ7gtpqskg9rDgwt3MmtGZJJOXE-GwvXRPOhw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, emil.l.velikov@gmail.com, Kees Cook <keescook@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Syed Nayyar Waris <syednwaris@gmail.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, kbuild test robot <lkp@intel.com>

On Thu, Jun 04, 2020 at 09:41:29AM +0300, Andy Shevchenko wrote:
> On Thu, Jun 4, 2020 at 1:03 AM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> >
> > When calling the GENMASK and GENMASK_ULL macros with zero lower bit and
> > an unsigned unknown high bit, some gcc versions warn due to the
> > comparisons of the high and low bit in GENMASK_INPUT_CHECK.
> >
> > To silence the warnings, cast the inputs to int before doing the
> > comparisons. The only valid inputs to GENMASK() and GENMASK_ULL() are
> > are 0 to 31 or 63. Anything outside this is undefined due to the shifts
> > in GENMASK()/GENMASK_ULL(). Therefore, casting the inputs to int do not
> > change the values for valid known inputs. For unknown values, the check
> > does not change anything since it's a compile-time check only.
> >
> > As an example of the warning, kindly reported by the kbuild test robot:
> >
> > from drivers/mfd/atmel-smc.c:11:
> > drivers/mfd/atmel-smc.c: In function 'atmel_smc_cs_encode_ncycles':
> > include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> > 26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > |                            ^
> > include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> > 16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> > |                                                              ^
> > include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> > 39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > |   ^~~~~~~~~~~~~~~~~~~
> > >> drivers/mfd/atmel-smc.c:49:25: note: in expansion of macro 'GENMASK'
> > 49 |  unsigned int lsbmask = GENMASK(msbpos - 1, 0);
> > |                         ^~~~~~~
> >
> 
> Thank you for the patch!
> 
> I think there is still a possibility to improve (as I mentioned there
> are test cases that are absent right now).
> What if we will have unsigned long value 0x100000001? Would it be 1
> after casting?
> 
> Maybe cast to (long) or (long long) more appropriate?

It you're entering 0x10000001 you're going to get a compiler warning
since it's going to be shifted out of range, when I wrote the check I
figured that should be enough, but perhaps I was wrong?

How about requiring both l and h bit to be constant? (that's
arguably the way I should have written in the first place). That's going
to remove the warnings for GENMASK(x, 0). It will not work as expected
when mixing negative and unsigned input, like GENMASK(-1, 0u) is not
going to fail the build while GENMASK(1u, -1) will. For GENMASK(-1, 0u),
you will get a compiler warning due to the shifts in GENMASK.

If we need to handle the negative inputs as well. I think I'd prefer to add
explicit checks for negative values over the casting. A macro for that
can probably be reused in other places as well.

> 
> Please, add test cases.

Will do.

Rikard
> 
> > Fixes: 295bcca84916 ("linux/bits.h: add compile time sanity check of GENMASK inputs")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Emil Velikov <emil.l.velikov@gmail.com>
> > Reported-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > ---
> >  include/linux/bits.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > index 4671fbf28842..293d1ee71a48 100644
> > --- a/include/linux/bits.h
> > +++ b/include/linux/bits.h
> > @@ -21,9 +21,10 @@
> >  #if !defined(__ASSEMBLY__) && \
> >         (!defined(CONFIG_CC_IS_GCC) || CONFIG_GCC_VERSION >= 49000)
> >  #include <linux/build_bug.h>
> > +/* Avoid Wtype-limits warnings by casting the inputs to int */
> >  #define GENMASK_INPUT_CHECK(h, l) \
> >         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > +               __builtin_constant_p((int)(l) > (int)(h)), (int)(l) > (int)(h), 0)))
> >  #else
> >  /*
> >   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> > --
> > 2.27.0
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
