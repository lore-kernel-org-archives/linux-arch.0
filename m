From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Arch maintainers Ahoy!
Date: Thu, 24 May 2012 08:53:20 -0700
Message-ID: <CA+55aFzwZ3mCeALQx7fXX_HO4GZF03q4gtZOFGmdWkJrvwjrJg@mail.gmail.com>
References: <CA+55aFy675A7qH+5GUZ_C_aN+Um0o70Zq=SVXYZxbM93ft50mg@mail.gmail.com>
 <20120523.132109.1153947222019508621.davem@davemloft.net> <CA+55aFxWaB4eeYgdvhTJ2RegM53WxJZFC4HfV=shNn7ZDdG9CQ@mail.gmail.com>
 <20120523.141647.2252460119413470634.davem@davemloft.net> <CA+55aFxcRc_zR9HtFAtrT1exGP2DspP0aA6T49Ph3kZEHHyQWw@mail.gmail.com>
 <32064.1337852416@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37401 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489Ab2EXPxm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 May 2012 11:53:42 -0400
Received: by wibhn6 with SMTP id hn6so6074350wib.1
        for <linux-arch@vger.kernel.org>; Thu, 24 May 2012 08:53:41 -0700 (PDT)
In-Reply-To: <32064.1337852416@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: David Miller <davem@davemloft.net>, James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

On Thu, May 24, 2012 at 2:40 AM, David Howells <dhowells@redhat.com> wr=
ote:
>
> Could you use cpu_to_be32/64() and then ffs()? =A0That ought to work =
for both
> variants of endianness. =A0The cpu_to_beXX() should be a noop on BE a=
nd is
> likely to be a single instruction on LE. =A0The meat of ffs() is usua=
lly a
> single instruction, though it may have to have zero-detect logic adde=
d.

=46irst off, the *last* thing you want to do is go to big-endian mode.
All the bit counting gets *much* more complicated, and your argument
that it's "free" on some architectures is pointless, since it is only
free on the architectures that have the *least* users.

Secondly, it's not "likely a single instruction" on LE, neither is
ffs. It can be, but it's often one of the slower instructions.

Many architectures will have - but only in their most recent uarch
versions - popcount or similar, and if you're little-endian, that
would be what you want. Except we already figured out faster versions
for little-endian based on multiplication or a few add/shift
operations.

                        Linus
