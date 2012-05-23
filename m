From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 23 May 2012 11:27:00 -0700
Message-ID: <CA+55aFxcRc_zR9HtFAtrT1exGP2DspP0aA6T49Ph3kZEHHyQWw@mail.gmail.com>
References: <CA+55aFy675A7qH+5GUZ_C_aN+Um0o70Zq=SVXYZxbM93ft50mg@mail.gmail.com>
 <20120523.132109.1153947222019508621.davem@davemloft.net> <CA+55aFxWaB4eeYgdvhTJ2RegM53WxJZFC4HfV=shNn7ZDdG9CQ@mail.gmail.com>
 <20120523.141647.2252460119413470634.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41119 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab2EWS1V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 14:27:21 -0400
Received: by wibhj8 with SMTP id hj8so4958398wib.1
        for <linux-arch@vger.kernel.org>; Wed, 23 May 2012 11:27:20 -0700 (PDT)
In-Reply-To: <20120523.141647.2252460119413470634.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

On Wed, May 23, 2012 at 11:16 AM, David Miller <davem@davemloft.net> wr=
ote:
>
> And believe it or not the "mask test each byte" thing is the fastest
> portable code I could come up with. =A0Big endian just blows for maki=
ng
> this calculation.

It's not faster to just do something like

   int byte =3D 4;

#if CONFIG_64BIT
   byte =3D 8;
   if (has_zero_32bit(value >> 32)) {
       value >>=3D 32;
       byte =3D 4;
   }
#endif
   if (has_zero_16(value >> 16)) {
      value >>=3D 16;
      byte -=3D 2;
   }
   if (!value & 0xff00)
      byte--;
   return byte;

which looks like it might generate ok code?

> But hey Linus I'm willing to be proven wrong, why don't you ask your
> google+ programming challenge entourage for some help? :-)

Hey, I refuse to start from something that looks stupid.

Btw, when benchmarking, make sure that your branches do not predict
well. Because in real life they won't predict well. So you can't
benchmark the mask->byte function with some  well-behaved input that
commonly returns the same value.

> For reference here is the final version of the sparc commit, it works
> and I've been running tests on it since last night. =A0I'm extrmely
> confident the C code will work on any big-endian machine.

Umm. Except your "top of address space" thing is entirely sparc-specifi=
c.

So no. The *bulk* of the code will work. But not all of it.

              Linus
