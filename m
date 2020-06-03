From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
Date: Thu, 4 Jun 2020 00:59:19 +0300
Message-ID: <CAHp75VdVqKfGC1+yLOTORLXLRcLxXXUPW2v3iY0uGAS7CDUifQ@mail.gmail.com>
References: <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
 <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
 <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com>
 <CAHp75VfBe-LMiAi=E4Cy8OasmE8NdSqevp+dsZtTEOLwF-TgmA@mail.gmail.com>
 <CACG_h5p1UpLRoA+ubE4NTFQEvg-oT6TFmsLXXTAtBvzN9z3iPg@mail.gmail.com>
 <CAHp75Vdxa1_ANBLEOB6g25x3O0V5h3yjZve8qpz-xkisD3KTLg@mail.gmail.com>
 <20200531223716.GA20752@rikard> <20200601083330.GB1634618@smile.fi.intel.com>
 <20200602190136.GA913@rikard> <CAHp75VdUf8=y+y4Q3OtWc7owxg0uX8LhZY4Nrgnezuv+aSyzUg@mail.gmail.com>
 <20200603215314.GA916134@rikard> <CAHp75VeQ+3rRAs+5Tmn=Tj_jkdKff=crwX9S3bPGLO6iVQ8Kqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCV7g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2020 17:59:36 -0400
In-Reply-To: <CAHp75VeQ+3rRAs+5Tmn=Tj_jkdKff=crwX9S3bPGLO6iVQ8Kqg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: Emil Velikov <emil.l.velikov@gmail.com>, Syed Nayyar Waris <syednwaris@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jun 4, 2020 at 12:58 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jun 4, 2020 at 12:53 AM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> > On Wed, Jun 03, 2020 at 11:49:37AM +0300, Andy Shevchenko wrote:
> > > On Tue, Jun 2, 2020 at 10:01 PM Rikard Falkeborn
> > > <rikard.falkeborn@gmail.com> wrote:
>
> ...
>
> > I'd be very surprised if compilers warned for explicit casts but  I'll
> > send a proper patch soon to let the build robot try it.
>
> I noticed that you should have received kbuild bot report about a
> driver where it appears.
>
> You patch broke all cases where (l) = 0 and (h) is type of unsigned
> (not a const from compiler point of view).

I will ask to revert for rc1 if there will be no fix.


-- 
With Best Regards,
Andy Shevchenko
