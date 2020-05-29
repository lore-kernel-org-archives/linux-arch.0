From: Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
Date: Sat, 30 May 2020 01:32:44 +0530
Message-ID: <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com> <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2UC5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 16:02:57 -0400
In-Reply-To: <20200529183824.GW1634618@smile.fi.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, May 30, 2020 at 12:08 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, May 29, 2020 at 11:38:18PM +0530, Syed Nayyar Waris wrote:
> > On Sun, May 24, 2020 at 8:15 PM kbuild test robot <lkp@intel.com> wrote:
>
> ...
>
> > >    579  static inline unsigned long bitmap_get_value(const unsigned long *map,
> > >    580                                                unsigned long start,
> > >    581                                                unsigned long nbits)
> > >    582  {
> > >    583          const size_t index = BIT_WORD(start);
> > >    584          const unsigned long offset = start % BITS_PER_LONG;
> > >    585          const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> > >    586          const unsigned long space = ceiling - start;
> > >    587          unsigned long value_low, value_high;
> > >    588
> > >    589          if (space >= nbits)
> > >  > 590                  return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> > >    591          else {
> > >    592                  value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> > >    593                  value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> > >    594                  return (value_low >> offset) | (value_high << space);
> > >    595          }
> > >    596  }
>
> > Regarding the above compilation warnings. All the warnings are because
> > of GENMASK usage in my patch.
> > The warnings are coming because of sanity checks present for 'GENMASK'
> > macro in include/linux/bits.h.
> >
> > Taking the example statement (in my patch) where compilation warning
> > is getting reported:
> > return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> >
> > 'nbits' is of type 'unsigned long'.
> > In above, the sanity check is comparing '0' with unsigned value. And
> > unsigned value can't be less than '0' ever, hence the warning.
> > But this warning will occur whenever there will be '0' as one of the
> > 'argument' and an unsigned variable as another 'argument' for GENMASK.
> >
> > This warning is getting cleared if I cast the 'nbits' to 'long'.
> >
> > Let me know if I should submit a next patch with the casts applied.
> > What do you guys think?
>
> Proper fix is to fix GENMASK(), but allowed workaround is to use
>         (BIT(nbits) - 1)
> instead.
>
> --
> With Best Regards,
> Andy Shevchenko
>

Hi Andy. Thank You for your comment.

When I used BIT macro (earlier), I had faced a problem. I want to tell
you about that.

Inside functions 'bitmap_set_value' and 'bitmap_get_value' when nbits (or
clump size) is BITS_PER_LONG, unexpected calculation happens.

Explanation:
Actually when nbits (clump size) is 64 (BITS_PER_LONG is 64 on my computer),
(BIT(nbits) - 1)
gives a value of zero and when this zero is ANDed with any value, it
makes it full zero. This is unexpected and incorrect calculation happening.

What actually happens is in the macro expansion of BIT(64), that is 1
<< 64, the '1' overflows from leftmost bit position (most significant
bit) and re-enters at the rightmost bit position (least significant
bit), therefore 1 << 64 becomes '0x1', and when another '1' is
subtracted from this, the final result becomes 0.

Since this macro is being used in both bitmap_get_value and
bitmap_set_value functions, it will give unexpected results when nbits or clump
size is BITS_PER_LONG (32 or 64 depending on arch).

William also knows about this issue:

"This is undefined behavior in the C standard (section 6.5.7 in the N1124)"

Andy, William,
Let me know what do you think ?

Regards
Syed Nayyar Waris
