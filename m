From: David Miller <davem@davemloft.net>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 23 May 2012 14:35:43 -0400 (EDT)
Message-ID: <20120523.143543.366370918467441501.davem@davemloft.net>
References: <CA+55aFxWaB4eeYgdvhTJ2RegM53WxJZFC4HfV=shNn7ZDdG9CQ@mail.gmail.com>
	<20120523.141647.2252460119413470634.davem@davemloft.net>
	<CA+55aFxcRc_zR9HtFAtrT1exGP2DspP0aA6T49Ph3kZEHHyQWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:60891 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760763Ab2EWSgu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 14:36:50 -0400
In-Reply-To: <CA+55aFxcRc_zR9HtFAtrT1exGP2DspP0aA6T49Ph3kZEHHyQWw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

=46rom: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 May 2012 11:27:00 -0700

> It's not faster to just do something like
>=20
>    int byte =3D 4;
>=20
> #if CONFIG_64BIT
>    byte =3D 8;
>    if (has_zero_32bit(value >> 32)) {
>        value >>=3D 32;
>        byte =3D 4;
>    }
> #endif
>    if (has_zero_16(value >> 16)) {
>       value >>=3D 16;
>       byte -=3D 2;
>    }
>    if (!value & 0xff00)
>       byte--;
>    return byte;
>=20
> which looks like it might generate ok code?

It might be, I'll play around with it.

=46WIW, when I code this end case in assembler on sparc64 I just go for
a bunch of conditional moves, so I'll try to come up with something
similar to the above that gcc will emit reasonably.

> Btw, when benchmarking, make sure that your branches do not predict
> well. Because in real life they won't predict well. So you can't
> benchmark the mask->byte function with some  well-behaved input that
> commonly returns the same value.

Indeed, and that's why I'd prefer it if gcc were to emit conditional
moves :-)

>> For reference here is the final version of the sparc commit, it work=
s
>> and I've been running tests on it since last night. =A0I'm extrmely
>> confident the C code will work on any big-endian machine.
>=20
> Umm. Except your "top of address space" thing is entirely sparc-speci=
fic.

Although a bit more expensive than what you can do on the x86 side
with these tests, I think my code should work.

Comparing get_fs() with USER_DS should be portable enough, as should
STACK_TOP, right?  Or does STACK_TOP have some weird semantics on some
architectures that I'm not aware of?

The only other thing is how we are using ~0UL as the limit for the
kernel, and for all practical purposes that ought to be fine too.
