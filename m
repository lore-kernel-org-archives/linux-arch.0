Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42253 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391327AbfGRVBa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jul 2019 17:01:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so21614523qkm.9
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2019 14:01:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
From: Qian Cai <cai@lca.pw>
In-Reply-To: <20190712.175038.755685144649934618.davem@davemloft.net>
Date: Thu, 18 Jul 2019 17:01:27 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <D7E57421-A6F4-4453-878A-8F173A856296@lca.pw>
References: <1562959401-19815-1-git-send-email-cai@lca.pw>
 <20190712.154606.493382088615011132.davem@davemloft.net>
 <EFD25845-097A-46B1-9C1A-02458883E4DA@lca.pw>
 <20190712.175038.755685144649934618.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: sathya.perla@broadcom.com, ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com, arnd@arndb.de, dhowells@redhat.com, hpa@zytor.com, netdev@vger.kernel.org, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, natechancellor@gmail.com
Message-ID: <20190718210127.vhsyDV7tlIoLd4K1P1WDoOufOF41VvCTWZ93abXECrw@z>



> On Jul 12, 2019, at 8:50 PM, David Miller <davem@davemloft.net> wrote:
>=20
> From: Qian Cai <cai@lca.pw>
> Date: Fri, 12 Jul 2019 20:27:09 -0400
>=20
>> Actually, GCC would consider it a const with -O2 optimized level =
because it found that it was never modified and it does not understand =
it is a module parameter. Considering the following code.
>>=20
>> # cat const.c=20
>> #include <stdio.h>
>>=20
>> static int a =3D 1;
>>=20
>> int main(void)
>> {
>> 	if (__builtin_constant_p(a))
>> 		printf("a is a const.\n");
>>=20
>> 	return 0;
>> }
>>=20
>> # gcc -O2 const.c -o const
>=20
> That's not a complete test case, and with a proper test case that
> shows the externalization of the address of &a done by the module
> parameter macros, gcc should not make this optimization or we should
> define the module parameter macros in a way that makes this properly
> clear to the compiler.
>=20
> It makes no sense to hack around this locally in drivers and other
> modules.

If you see the warning in the original patch,

=
https://lore.kernel.org/netdev/1562959401-19815-1-git-send-email-cai@lca.p=
w/

GCC definitely optimize rx_frag_size  to be a constant while I just =
confirmed clang
-O2 does not. The problem is that I have no clue about how to let GCC =
not to
optimize a module parameter.

Though, I have added a few people who might know more of compilers than =
myself.=
