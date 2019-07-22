Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44453 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732192AbfGVVNU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jul 2019 17:13:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id d79so29536619qke.11
        for <linux-arch@vger.kernel.org>; Mon, 22 Jul 2019 14:13:19 -0700 (PDT)
Message-ID: <1563829996.11067.4.camel@lca.pw>
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
From: Qian Cai <cai@lca.pw>
Date: Mon, 22 Jul 2019 17:13:16 -0400
In-Reply-To: <1563572871.11067.2.camel@lca.pw>
References: <CAKwvOdkCfqfpJYYX+iu2nLCUUkeDorDdVP3e7koB9NYsRwgCNw@mail.gmail.com>
         <CAGG=3QUvdwJs1wW1w+5Mord-qFLa=_WkjTsiZuwGfcjkoEJGNQ@mail.gmail.com>
         <75B428FC-734C-4B15-B1A7-A3FC5F9F2FE5@lca.pw>
         <20190718.162928.124906203979938369.davem@davemloft.net>
         <1563572871.11067.2.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: morbo@google.com, ndesaulniers@google.com, jyknight@google.com, sathya.perla@broadcom.com, ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com, arnd@arndb.de, dhowells@redhat.com, hpa@zytor.com, netdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, natechancellor@gmail.com, Jakub Jelinek <jakub@redhat.com>
Message-ID: <20190722211316.GgeG835lDtSlUpZ_N2j3sG_cFT1fGXX3_3VfqhmRvg8@z>

On Fri, 2019-07-19 at 17:47 -0400, Qian Cai wrote:
> On Thu, 2019-07-18 at 16:29 -0700, David Miller wrote:
> > From: Qian Cai <cai@lca.pw>
> > Date: Thu, 18 Jul 2019 19:26:47 -0400
> > 
> > >  
> > >  
> > > > On Jul 18, 2019, at 5:21 PM, Bill Wendling <morbo@google.com> wrote:
> > > >  
> > > > [My previous response was marked as spam...]
> > > >  
> > > > Top-of-tree clang says that it's const:
> > > >  
> > > > $ gcc a.c -O2 && ./a.out
> > > > a is a const.
> > > >  
> > > > $ clang a.c -O2 && ./a.out
> > > > a is a const.
> > > 
> > >  
> > >  
> > > I used clang-7.0.1. So, this is getting worse where both GCC and clang
> > > will
> > 
> > start to suffer the
> > > same problem.
> > 
> > Then rewrite the module parameter macros such that the non-constness
> > is evident to all compilers regardless of version.
> > 
> > That is the place to fix this, otherwise we will just be adding hacks
> > all over the place rather than in just one spot.
> 
> The problem is that when the compiler is compiling be_main.o, it has no
> knowledge about what is going to happen in load_module().  The compiler can
> only
> see that a "const struct kernel_param_ops" "__param_ops_rx_frag_size" at the
> time with
> 
> __param_ops_rx_frag_size.arg = &rx_frag_size
> 
> but only in load_module()->parse_args()->parse_one()->param_set_ushort(), it
> changes "__param_ops_rx_frag_size.arg" which in-turn changes the value
> of "rx_frag_size".

Even for an obvious case, the compilers still go ahead optimizing a variable as
a constant. Maybe it is best to revert the commit d66acc39c7ce ("bitops:
Optimise get_order()") unless some compiler experts could improve the situation.

#include <stdio.h>

int a = 1;

int main(void)
{
        int *p;

        p = &a;
        *p = 2;

        if (__builtin_constant_p(a))
                printf("a is a const.\n");

        printf("a = %d\n", a);

        return 0;
}

# gcc -O2 const.c -o const

# ./const
a is a const.
a = 2
