From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Arch maintainers Ahoy!
Date: Thu, 24 May 2012 09:56:34 -0700
Message-ID: <CA+55aFwziHq8XZsD_N6sNHNfOoCjhE7AyuakXU0yeWVnk0v1LQ@mail.gmail.com>
References: <CA+55aFy675A7qH+5GUZ_C_aN+Um0o70Zq=SVXYZxbM93ft50mg@mail.gmail.com>
 <20120523.132109.1153947222019508621.davem@davemloft.net> <CA+55aFxWaB4eeYgdvhTJ2RegM53WxJZFC4HfV=shNn7ZDdG9CQ@mail.gmail.com>
 <20120523.141647.2252460119413470634.davem@davemloft.net> <CA+55aFxcRc_zR9HtFAtrT1exGP2DspP0aA6T49Ph3kZEHHyQWw@mail.gmail.com>
 <32064.1337852416@redhat.com> <CA+55aFzwZ3mCeALQx7fXX_HO4GZF03q4gtZOFGmdWkJrvwjrJg@mail.gmail.com>
 <14266.1337877929@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34116 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755926Ab2EXQ44 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 May 2012 12:56:56 -0400
Received: by wibhj8 with SMTP id hj8so6025144wib.1
        for <linux-arch@vger.kernel.org>; Thu, 24 May 2012 09:56:55 -0700 (PDT)
In-Reply-To: <14266.1337877929@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: David Miller <davem@davemloft.net>, James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

On Thu, May 24, 2012 at 9:45 AM, David Howells <dhowells@redhat.com> wr=
ote:
>
> I didn't suggest it was free, but it might be cheaper. =A0Besides x86=
/x86_64 has
> BSF/BSR instructions - though having played with Dave's algorithm som=
e, I
> don't think they're usable for this.

David, I don't think you've followed this saga very well.

That word-at-a-time algorithm *comes* from x86. Literally. The code is
90% pure copies from arch/x86/lib/usercopy.c.

We *know* how the code should be written on little-endian, AND IT IS
BOTH BETTER AND FASTER there.

Seriously. Little-endian is *superior* for string handling. No
questions. In fact, anybody who thinks that big-endian is better for
*anything* is seriously deluded these days.

Also, BSF is too damn slow. It's slow as hell on most older x86 chips,
and it's pointless. You can do clever tricks (again - only on
little-endian) that do it portably without it. Grep for
count_masked_bytes in the current tree, which does need a fast
multiplier on 64-bit, but fast multipliers are way more common than
the fast bit scan instructions.

I'd love to use a population count instruction, but efficient popc
instructions are simply not widely enough available. And the bsf
instruction is very slow on old x86 microarchitectures.

                  Linus
