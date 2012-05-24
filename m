From: David Howells <dhowells@redhat.com>
Subject: Re: Arch maintainers Ahoy!
Date: Thu, 24 May 2012 17:45:29 +0100
Message-ID: <14266.1337877929@redhat.com>
References: <CA+55aFzwZ3mCeALQx7fXX_HO4GZF03q4gtZOFGmdWkJrvwjrJg@mail.gmail.com> <CA+55aFy675A7qH+5GUZ_C_aN+Um0o70Zq=SVXYZxbM93ft50mg@mail.gmail.com> <20120523.132109.1153947222019508621.davem@davemloft.net> <CA+55aFxWaB4eeYgdvhTJ2RegM53WxJZFC4HfV=shNn7ZDdG9CQ@mail.gmail.com> <20120523.141647.2252460119413470634.davem@davemloft.net> <CA+55aFxcRc_zR9HtFAtrT1exGP2DspP0aA6T49Ph3kZEHHyQWw@mail.gmail.com> <32064.1337852416@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17018 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933508Ab2EXQpj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 May 2012 12:45:39 -0400
In-Reply-To: <CA+55aFzwZ3mCeALQx7fXX_HO4GZF03q4gtZOFGmdWkJrvwjrJg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, David Miller <davem@davemloft.net>, James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > Could you use cpu_to_be32/64() and then ffs()? =C2=A0That ought to =
work for both
> > variants of endianness. =C2=A0The cpu_to_beXX() should be a noop on=
 BE and is
> > likely to be a single instruction on LE. =C2=A0The meat of ffs() is=
 usually a
> > single instruction, though it may have to have zero-detect logic ad=
ded.
>=20
> First off, the *last* thing you want to do is go to big-endian mode.
> All the bit counting gets *much* more complicated, and your argument
> that it's "free" on some architectures is pointless, since it is only
> free on the architectures that have the *least* users.

I didn't suggest it was free, but it might be cheaper.  Besides x86/x86=
_64 has
BSF/BSR instructions - though having played with Dave's algorithm some,=
 I
don't think they're usable for this.

My suggestion assumes that there would be zeros beyond the terminal NUL=
, which
isn't something you can rely on.

David
