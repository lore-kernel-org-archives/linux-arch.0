From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
Date: Sun, 31 May 2020 14:00:45 +0300
Message-ID: <CAHp75Vdxa1_ANBLEOB6g25x3O0V5h3yjZve8qpz-xkisD3KTLg@mail.gmail.com>
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com> <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com> <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
 <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
 <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
 <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
 <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com>
 <CAHp75VfBe-LMiAi=E4Cy8OasmE8NdSqevp+dsZtTEOLwF-TgmA@mail.gmail.com> <CACG_h5p1UpLRoA+ubE4NTFQEvg-oT6TFmsLXXTAtBvzN9z3iPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgEaLBE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 31 May 2020 07:01:04 -0400
In-Reply-To: <CACG_h5p1UpLRoA+ubE4NTFQEvg-oT6TFmsLXXTAtBvzN9z3iPg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Syed Nayyar Waris <syednwaris@gmail.com>, Rikard Falkeborn <rikard.falkeborn@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, May 31, 2020 at 4:11 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> On Sat, May 30, 2020 at 2:50 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, May 30, 2020 at 11:45 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > On Sat, May 30, 2020 at 3:49 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:

...

> #if (l) == 0
> #define GENMASK_INPUT_CHECK(h, l)  0
> #elif
> #define GENMASK_INPUT_CHECK(h, l) \
>         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>                 __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> #endif
>
> I have verified that this works. Basically this just avoids the sanity
> check when the 'lower' bound 'l' is zero. Let me know if it looks
> fine.

Unfortunately, it's not enough. We need to take care about the following cases
1) h or l negative;
2) h == 0, if l == 0, I dunno what is this. it's basically either 0 or warning;
3) l == 0;
4) h and l > 0.

Now, on top of that (since it's a macro) we have to keep in mind that
h and l can be signed and / or unsigned types.
And macro shall work for all 4 cases (by type signedess).

> Regarding min, max macro that you suggested I am also looking further into it.

Since this has been introduced in v5.7 and not only your code is
affected by this I think we need to ping original author either to fix
or revert.

So, I Cc'ed to the author and reviewers, because they probably know
better why that had been done in the first place and breaking existing
code.

-- 
With Best Regards,
Andy Shevchenko
