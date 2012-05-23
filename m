From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 23 May 2012 14:01:26 -0700
Message-ID: <CA+55aFx1HNC5rd5dzuKpNiHKWvkhoc=-y6hsAW-L_X7sz5Taog@mail.gmail.com>
References: <CA+55aFxcRc_zR9HtFAtrT1exGP2DspP0aA6T49Ph3kZEHHyQWw@mail.gmail.com>
 <20120523.143543.366370918467441501.davem@davemloft.net> <CA+55aFy78h5z1fnW+TovTQ4wUBauUW4i7=Z583tbQVMhsWvTAQ@mail.gmail.com>
 <20120523.163644.875474822428763332.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:60298 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab2EWVBr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 17:01:47 -0400
Received: by wgbds11 with SMTP id ds11so5081952wgb.1
        for <linux-arch@vger.kernel.org>; Wed, 23 May 2012 14:01:46 -0700 (PDT)
In-Reply-To: <20120523.163644.875474822428763332.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

On Wed, May 23, 2012 at 1:36 PM, David Miller <davem@davemloft.net> wro=
te:
>
> I toyed around with some of the ideas we discussed but gcc really
> mishandled all the approaches I tried.

Have you tried coding them as ?: expressions, along with making all
the temporaries separate variables? Sometimes that seems to make gcc
more eager to use cmov's.

Although that seemed to work better before. These days gcc sometimes
seems so eager to show it knows better than the programmer that it is
hard to make it do the obvious thing from the obvious source code..

> 1) In the loop, use the test:
>
> =A0 =A0 =A0(x + 0xfefefeff) & ~(x | 0x7f7f7f7f)
>
> =A0 It's the same effective cost as the current test (on sparc
> =A0 it would be ADD, OR, ANDNCC).
>
> =A0 We make sure to calculate the "x | 0x7f7f7f7f" part into
> =A0 a variable which is not clobbered by the rest of the test.
>
> =A0 This is so we can reuse it in #2.
>
> 2) Once we find a word containing the zero byte, do a:
>
> =A0 =A0 =A0 =A0~(((x & 0x7f7f7f7f) + 0x7f7f7f7f) | x | 0x7f7f7f7f)
>
> =A0 and that "x | 0x7f7f7f7f" part is already calculated and thus
> =A0 can be cribbed the place we left it in #1 above.
>
> =A0 And now we'll have exactly a 0x80 where there is a zero byte,
> =A0 and no bleeding of 0x80 values into adjacent byte positions.
>
> Once we have that we can just test that mask directly for the
> zero byte location search code.

Sounds likely, and you only have two different constants to worry about=
=2E

Sadly, I don't see any way to get the "only high bits set" cheaply,
like the little-endian case does (ie going from "zero in second byte
and after": 0x00808080 to the byte mask you need: 0xff000000). If you
had that, and the appropriate unaligneds, you'd also have everything
for the dcache case, not just strncpy.

                  Linus
