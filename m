From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [GIT PULL] x86/atomic changes for v2.6.35
Date: Wed, 19 May 2010 07:24:00 -0700
Message-ID: <4BF3F480.3000902@zytor.com>
References: <20100517224531.GA27400@elte.hu> <AANLkTinWbueCQZdQgZFDLQPJYieB13orxDGYJzzRpPni@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:36611 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175Ab0ESOYd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 May 2010 10:24:33 -0400
In-Reply-To: <AANLkTinWbueCQZdQgZFDLQPJYieB13orxDGYJzzRpPni@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <luca@luca-barbieri.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org

On 05/19/2010 04:46 AM, Geert Uytterhoeven wrote:
> On Tue, May 18, 2010 at 00:45, Ingo Molnar <mingo@elte.hu> wrote:
>> Please pull the latest x86-atomic-for-linus git tree from:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.gi=
t x86-atomic-for-linus
>>
>>
>> out-of-topic modifications in x86-atomic-for-linus:
>> ---------------------------------------------------
>> lib/Makefile                       # 86a8938: lib: Add self-test for=
 atomic64_t
>> lib/atomic64.c                     # 9757789: lib: Fix atomic64_add_=
unless retu
>> lib/atomic64_test.c                # a5c9161: x86, atomic64: In self=
test, disti
>>                                   # 25a304f: lib: Fix atomic64_inc_n=
ot_zero te
>>                                   # 9efbcd5: lib: Fix atomic64_add_u=
nless test
>>                                   # d7f6de1: x86: Implement atomic[6=
4]_dec_if_
>>                                   # 8f4f202: lib: Only test atomic64=
_dec_if_po
>>                                   # 86a8938: lib: Add self-test for =
atomic64_t
>=20
> Is having atomic64_t mandatory now?
>=20
> According to the allmodconfig build logs
> (http://kisskb.ellerman.id.au/kisskb/matrix/),
> several architectures (at least m68k and mips) don't have it.
> Furthermore, the test fails to compile on a few architectures that do=
 have it
> (parisc, s390, sh, ...).
>=20
> <boilerplate>
> It's a pity this wasn't raised/resolved between its detection in linu=
x-next and
> before it entered mainline...
> </boilerplate>
>=20

Is having atomic64_t mandatory?  Not yet, I don't think, but it probabl=
y
will be soon -- which is why there is a generic implementation
available.  All those architectures just need to select
CONFIG_GENERIC_ATOMIC64 and voil=C3=A0, problem solved.

As far as your boilerplate is concerned, I think Linus made it clear at
the Kernel Summit that is it not the obligation of x86/ARM/PowerPC to
slow down to not break the smaller architectures; it's the
responsibility of those architecture maintainers to keep up.  Sorry.

	-hpa

--=20
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
