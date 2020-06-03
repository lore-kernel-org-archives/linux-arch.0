From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
Date: Wed, 3 Jun 2020 11:49:37 +0300
Message-ID: <CAHp75VdUf8=y+y4Q3OtWc7owxg0uX8LhZY4Nrgnezuv+aSyzUg@mail.gmail.com>
References: <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
 <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
 <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
 <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
 <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com>
 <CAHp75VfBe-LMiAi=E4Cy8OasmE8NdSqevp+dsZtTEOLwF-TgmA@mail.gmail.com>
 <CACG_h5p1UpLRoA+ubE4NTFQEvg-oT6TFmsLXXTAtBvzN9z3iPg@mail.gmail.com>
 <CAHp75Vdxa1_ANBLEOB6g25x3O0V5h3yjZve8qpz-xkisD3KTLg@mail.gmail.com>
 <20200531223716.GA20752@rikard> <20200601083330.GB1634618@smile.fi.intel.com> <20200602190136.GA913@rikard>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgFCIty (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2020 04:49:54 -0400
In-Reply-To: <20200602190136.GA913@rikard>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: Emil Velikov <emil.l.velikov@gmail.com>, Syed Nayyar Waris <syednwaris@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Jun 2, 2020 at 10:01 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
> On Mon, Jun 01, 2020 at 11:33:30AM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 01, 2020 at 12:37:16AM +0200, Rikard Falkeborn wrote:
> > > On Sun, May 31, 2020 at 02:00:45PM +0300, Andy Shevchenko wrote:

...

> > > If we cast to int, we don't need to worry about the signedness. If
> > > someone enters a value that can't be cast to int, there will still
> > > be a compiler warning about shift out of range.
> >
> > If the argument unsigned long long will it be the warning (it should not)?
>
> No, there should be no warning there.
>
> The inputs to GENMASK() needs to be between 0 and 31 (or 63 depending on the
> size of unsigned long). For any other values, there will be undefined behaviour,
> since the operands to the shifts in __GENMASK will be too large (or negative).

What I'm implying here that argument may be not constant, and compiler
can't know their values at hand.
So, in the following snippet

foo(unsigned long long x)
{
  u32 y;
  y = GENMASK(x, 0);
}

when you cast x to int wouldn't be a warning of possible value
reduction (even if we know that it won't be higher than 63/31)?

-- 
With Best Regards,
Andy Shevchenko
