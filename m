Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44270 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGRX0u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jul 2019 19:26:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id d79so21883115qke.11
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2019 16:26:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
From: Qian Cai <cai@lca.pw>
In-Reply-To: <CAGG=3QUvdwJs1wW1w+5Mord-qFLa=_WkjTsiZuwGfcjkoEJGNQ@mail.gmail.com>
Date: Thu, 18 Jul 2019 19:26:47 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <75B428FC-734C-4B15-B1A7-A3FC5F9F2FE5@lca.pw>
References: <1562959401-19815-1-git-send-email-cai@lca.pw>
 <20190712.154606.493382088615011132.davem@davemloft.net>
 <EFD25845-097A-46B1-9C1A-02458883E4DA@lca.pw>
 <20190712.175038.755685144649934618.davem@davemloft.net>
 <D7E57421-A6F4-4453-878A-8F173A856296@lca.pw>
 <CAKwvOdkCfqfpJYYX+iu2nLCUUkeDorDdVP3e7koB9NYsRwgCNw@mail.gmail.com>
 <CAGG=3QUvdwJs1wW1w+5Mord-qFLa=_WkjTsiZuwGfcjkoEJGNQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, James Y Knight <jyknight@google.com>, David Miller <davem@davemloft.net>, sathya.perla@broadcom.com, ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, netdev@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Nathan Chancellor <natechancellor@gmail.com>
Message-ID: <20190718232647.6nlmD4vPyTnVaOt047YxAtEno_p88lnCDfq0YEUHOGE@z>



> On Jul 18, 2019, at 5:21 PM, Bill Wendling <morbo@google.com> wrote:
>=20
> [My previous response was marked as spam...]
>=20
> Top-of-tree clang says that it's const:
>=20
> $ gcc a.c -O2 && ./a.out
> a is a const.
>=20
> $ clang a.c -O2 && ./a.out
> a is a const.


I used clang-7.0.1. So, this is getting worse where both GCC and clang =
will start to suffer the
same problem.

>=20
>=20
> On Thu, Jul 18, 2019 at 2:10 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>=20
>> On Thu, Jul 18, 2019 at 2:01 PM Qian Cai <cai@lca.pw> wrote:
>>>=20
>>>=20
>>>=20
>>>> On Jul 12, 2019, at 8:50 PM, David Miller <davem@davemloft.net> =
wrote:
>>>>=20
>>>> From: Qian Cai <cai@lca.pw>
>>>> Date: Fri, 12 Jul 2019 20:27:09 -0400
>>>>=20
>>>>> Actually, GCC would consider it a const with -O2 optimized level =
because it found that it was never modified and it does not understand =
it is a module parameter. Considering the following code.
>>>>>=20
>>>>> # cat const.c
>>>>> #include <stdio.h>
>>>>>=20
>>>>> static int a =3D 1;
>>>>>=20
>>>>> int main(void)
>>>>> {
>>>>>     if (__builtin_constant_p(a))
>>>>>             printf("a is a const.\n");
>>>>>=20
>>>>>     return 0;
>>>>> }
>>>>>=20
>>>>> # gcc -O2 const.c -o const
>>>>=20
>>>> That's not a complete test case, and with a proper test case that
>>>> shows the externalization of the address of &a done by the module
>>>> parameter macros, gcc should not make this optimization or we =
should
>>>> define the module parameter macros in a way that makes this =
properly
>>>> clear to the compiler.
>>>>=20
>>>> It makes no sense to hack around this locally in drivers and other
>>>> modules.
>>>=20
>>> If you see the warning in the original patch,
>>>=20
>>> =
https://lore.kernel.org/netdev/1562959401-19815-1-git-send-email-cai@lca.p=
w/
>>>=20
>>> GCC definitely optimize rx_frag_size  to be a constant while I just =
confirmed clang
>>> -O2 does not. The problem is that I have no clue about how to let =
GCC not to
>>> optimize a module parameter.
>>>=20
>>> Though, I have added a few people who might know more of compilers =
than myself.
>>=20
>> + Bill and James, who probably knows more than they'd like to about
>> __builtin_constant_p and more than other LLVM folks at this point.
>>=20
>> --
>> Thanks,
>> ~Nick Desaulniers
