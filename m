Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41875 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfGRVKT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jul 2019 17:10:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so13178320pff.8
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2019 14:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <1562959401-19815-1-git-send-email-cai@lca.pw> <20190712.154606.493382088615011132.davem@davemloft.net>
 <EFD25845-097A-46B1-9C1A-02458883E4DA@lca.pw> <20190712.175038.755685144649934618.davem@davemloft.net>
 <D7E57421-A6F4-4453-878A-8F173A856296@lca.pw>
In-Reply-To: <D7E57421-A6F4-4453-878A-8F173A856296@lca.pw>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 18 Jul 2019 14:10:06 -0700
Message-ID: <CAKwvOdkCfqfpJYYX+iu2nLCUUkeDorDdVP3e7koB9NYsRwgCNw@mail.gmail.com>
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Qian Cai <cai@lca.pw>, Bill Wendling <morbo@google.com>, James Y Knight <jyknight@google.com>
Cc: David Miller <davem@davemloft.net>, sathya.perla@broadcom.com, ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, netdev@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Nathan Chancellor <natechancellor@gmail.com>
Message-ID: <20190718211006.7-8H33QUGVynYg2z2_gesBPqOA1bA0z3iolRfl0FQhw@z>

On Thu, Jul 18, 2019 at 2:01 PM Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Jul 12, 2019, at 8:50 PM, David Miller <davem@davemloft.net> wrote:
> >
> > From: Qian Cai <cai@lca.pw>
> > Date: Fri, 12 Jul 2019 20:27:09 -0400
> >
> >> Actually, GCC would consider it a const with -O2 optimized level because it found that it was never modified and it does not understand it is a module parameter. Considering the following code.
> >>
> >> # cat const.c
> >> #include <stdio.h>
> >>
> >> static int a = 1;
> >>
> >> int main(void)
> >> {
> >>      if (__builtin_constant_p(a))
> >>              printf("a is a const.\n");
> >>
> >>      return 0;
> >> }
> >>
> >> # gcc -O2 const.c -o const
> >
> > That's not a complete test case, and with a proper test case that
> > shows the externalization of the address of &a done by the module
> > parameter macros, gcc should not make this optimization or we should
> > define the module parameter macros in a way that makes this properly
> > clear to the compiler.
> >
> > It makes no sense to hack around this locally in drivers and other
> > modules.
>
> If you see the warning in the original patch,
>
> https://lore.kernel.org/netdev/1562959401-19815-1-git-send-email-cai@lca.pw/
>
> GCC definitely optimize rx_frag_size  to be a constant while I just confirmed clang
> -O2 does not. The problem is that I have no clue about how to let GCC not to
> optimize a module parameter.
>
> Though, I have added a few people who might know more of compilers than myself.

+ Bill and James, who probably knows more than they'd like to about
__builtin_constant_p and more than other LLVM folks at this point.

-- 
Thanks,
~Nick Desaulniers
