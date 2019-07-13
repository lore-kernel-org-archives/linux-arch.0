Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45503 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfGMA1M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jul 2019 20:27:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so7763044qkj.12
        for <linux-arch@vger.kernel.org>; Fri, 12 Jul 2019 17:27:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
From: Qian Cai <cai@lca.pw>
In-Reply-To: <20190712.154606.493382088615011132.davem@davemloft.net>
Date: Fri, 12 Jul 2019 20:27:09 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <EFD25845-097A-46B1-9C1A-02458883E4DA@lca.pw>
References: <1562959401-19815-1-git-send-email-cai@lca.pw>
 <20190712.154606.493382088615011132.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: sathya.perla@broadcom.com, ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com, arnd@arndb.de, dhowells@redhat.com, hpa@zytor.com, netdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190713002709.A379GzlI7EAloZkXNMoJN2Z2bxyZyTf6ByuBRXrks2s@z>



> On Jul 12, 2019, at 6:46 PM, David Miller <davem@davemloft.net> wrote:
>=20
> From: Qian Cai <cai@lca.pw>
> Date: Fri, 12 Jul 2019 15:23:21 -0400
>=20
>> The commit d66acc39c7ce ("bitops: Optimise get_order()") introduced a
>> problem for the be2net driver as "rx_frag_size" could be a module
>> parameter that can be changed while loading the module.
>=20
> Why is this a problem?

Well, for example, if rx_frag_size was set to 8096 when loading the =
module, the kernel has already used the default value 2048 during =
compilation time.

>=20
>> That commit checks __builtin_constant_p() first in get_order() which
>> cause "adapter->big_page_size" to be assigned a value based on the
>> the default "rx_frag_size" value at the compilation time. It also
>> generate a compilation warning,
>=20
> rx_frag_size is not a constant, therefore the __builtin_constant_p()
> test should not pass.
>=20
> This explanation doesn't seem valid.

Actually, GCC would consider it a const with -O2 optimized level because =
it found that it was never modified and it does not understand it is a =
module parameter. Considering the following code.

# cat const.c=20
#include <stdio.h>

static int a =3D 1;

int main(void)
{
	if (__builtin_constant_p(a))
		printf("a is a const.\n");

	return 0;
}

# gcc -O2 const.c -o const

# ./const=20
a is a const.=
