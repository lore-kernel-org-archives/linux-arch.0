From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
Date: Sat, 30 May 2020 01:19:13 +0300
Message-ID: <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com> <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com> <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
 <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com> <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgE2WT3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 18:19:29 -0400
In-Reply-To: <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, May 30, 2020 at 1:11 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> On Sat, May 30, 2020 at 3:13 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, May 29, 2020 at 11:07 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > On Sat, May 30, 2020 at 12:08 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, May 29, 2020 at 11:38:18PM +0530, Syed Nayyar Waris wrote:
> > > > > On Sun, May 24, 2020 at 8:15 PM kbuild test robot <lkp@intel.com> wrote:
> >
> > ...
> >
> > > > > Taking the example statement (in my patch) where compilation warning
> > > > > is getting reported:
> > > > > return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> > > > >
> > > > > 'nbits' is of type 'unsigned long'.
> > > > > In above, the sanity check is comparing '0' with unsigned value. And
> > > > > unsigned value can't be less than '0' ever, hence the warning.
> > > > > But this warning will occur whenever there will be '0' as one of the
> > > > > 'argument' and an unsigned variable as another 'argument' for GENMASK.
> >
> > > > Proper fix is to fix GENMASK(), but allowed workaround is to use
> > > >         (BIT(nbits) - 1)
> > > > instead.
> >
> > > When I used BIT macro (earlier), I had faced a problem. I want to tell
> > > you about that.
> > >
> > > Inside functions 'bitmap_set_value' and 'bitmap_get_value' when nbits (or
> > > clump size) is BITS_PER_LONG, unexpected calculation happens.
> > >
> > > Explanation:
> > > Actually when nbits (clump size) is 64 (BITS_PER_LONG is 64 on my computer),
> > > (BIT(nbits) - 1)
> > > gives a value of zero and when this zero is ANDed with any value, it
> > > makes it full zero. This is unexpected and incorrect calculation happening.
> > >
> > > What actually happens is in the macro expansion of BIT(64), that is 1
> > > << 64, the '1' overflows from leftmost bit position (most significant
> > > bit) and re-enters at the rightmost bit position (least significant
> > > bit), therefore 1 << 64 becomes '0x1', and when another '1' is
> > > subtracted from this, the final result becomes 0.
> > >
> > > Since this macro is being used in both bitmap_get_value and
> > > bitmap_set_value functions, it will give unexpected results when nbits or clump
> > > size is BITS_PER_LONG (32 or 64 depending on arch).
> >
> > I see, something like
> > https://elixir.bootlin.com/linux/latest/source/include/linux/dma-mapping.h#L139
> > should be done.
> > But yes, let's try to fix GENMASK().
> >
> > So, if we modify the following
> >
> >   #define GENMASK_INPUT_CHECK(h, l) \
> >     (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> >     __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> >
> > to be
> >
> >   #define GENMASK_INPUT_CHECK(h, l) \
> >     (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> >     __builtin_constant_p((l) > (h)), (l) ? (l) > (h) : 0, 0)))
> >
> > would it work?
>
> Sorry Andy it is not working. Actually the warning will be thrown,
> whenever there will be comparison between 'h' and 'l'. If one of them
> is '0' and the other is unsigned variable.
> In above, still there is comparison being done between 'h' and 'l', so
> the warning is getting thrown.

Ah, okay

what about (l) && ((l) > (h)) ?

> > > William also knows about this issue:
> > > "This is undefined behavior in the C standard (section 6.5.7 in the N1124)"
> >
> > I think it is about 6.5.7.3  here, 1U << 31 (or 63) is okay.
>
> Actually for:
> (BIT(nbits) - 1)
> When nbits will be BITS_PER_LONG it will be 1U << 32 (or 64). Isn't it ?
> The expression,
> BIT(64) - 1
> can become unexpectedly zero (incorrectly).

Yes, that's why I pointed out to the paragraph. It's about right
operand to be "great than or equal to" the size of type of left
operand.

-- 
With Best Regards,
Andy Shevchenko
