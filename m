From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 23 May 2012 10:32:50 -0700
Message-ID: <CA+55aFxWaB4eeYgdvhTJ2RegM53WxJZFC4HfV=shNn7ZDdG9CQ@mail.gmail.com>
References: <CAMuHMdUdxrGqn9sRgwrNgX4teV_ivHSeBn3hKnvgxZRxQE_krQ@mail.gmail.com>
 <1337766025.3013.3.camel@dabdike.int.hansenpartnership.com>
 <CA+55aFy675A7qH+5GUZ_C_aN+Um0o70Zq=SVXYZxbM93ft50mg@mail.gmail.com> <20120523.132109.1153947222019508621.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53850 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab2EWRdL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 13:33:11 -0400
Received: by wibhj8 with SMTP id hj8so4914489wib.1
        for <linux-arch@vger.kernel.org>; Wed, 23 May 2012 10:33:10 -0700 (PDT)
In-Reply-To: <20120523.132109.1153947222019508621.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

On Wed, May 23, 2012 at 10:21 AM, David Miller <davem@davemloft.net> wr=
ote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Wed, 23 May 2012 08:15:42 -0700
>
>> Btw, the x86 version these days actually zeroes the last bytes of th=
e
>> word-at-a-time copy.
>
> I noticed, and that was the bug in the version I posted.
>
> I decided in the end to not do what x86 does because there's no
> cheap way to do it on big-endian. =A0I simply moved the 'dst'
> store before the has_zero() test.

Yes, the original x86 code worked that way too, and it's how 3.4 does
thing there. It results in garbage at the end of the result string,
but since we consider that to be undefined data anyway (unlike the C
library standard strncpy() that zero-fills it), it's not a big deal.

The reason I changed it on x86 was that I was a *tiny* bit worried
that some kernel user would eventually possibly expose those garbage
bytes. *IF* we were to ever have code like

   memset(buffer, 0, sizeof(buffer));
   strncpy_from_user(buffer, ptr, sizeof(buffer-1));

this would matter, and could expose data that the user didn't *intent*
to expose.

We don't have anything like that right now as far as I can tell (and I
did check, although it was more like a "glance through all the
users"), so it's more of a "possible future issues" thing than
anything else.

                 Linus
