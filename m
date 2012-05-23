From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 23 May 2012 08:15:42 -0700
Message-ID: <CA+55aFy675A7qH+5GUZ_C_aN+Um0o70Zq=SVXYZxbM93ft50mg@mail.gmail.com>
References: <CA+55aFzm5v2JXNOEp=VmJ22FOdo77L_TsDKbou6S=AtAJB-+Hg@mail.gmail.com>
 <20120523.014627.497058725671088241.davem@davemloft.net> <CAMuHMdUdxrGqn9sRgwrNgX4teV_ivHSeBn3hKnvgxZRxQE_krQ@mail.gmail.com>
 <1337766025.3013.3.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45770 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964839Ab2EWPQE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 11:16:04 -0400
Received: by wgbdr13 with SMTP id dr13so7315776wgb.1
        for <linux-arch@vger.kernel.org>; Wed, 23 May 2012 08:16:03 -0700 (PDT)
In-Reply-To: <1337766025.3013.3.camel@dabdike.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org

On Wed, May 23, 2012 at 2:40 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> I think the sparc version will work for everybody (it will certainly
> work on parisc). =A0The only thing that might be necessary is to add =
these
> guards:

The sparc version looks pretty generic (hey, it's almost all the x86
version verbatim), but no, there are more details there:

 - the alignment checks you noted (would make sense in
<asm/word-at-a-time.h>: maybe an architecture could do a cut-down
version that doesn't do everything needed for dcache word access, but
is still enough for just this)

 - the byte counting depends on byte order (more
<asm/word-at-a-time.h> details) and I suspect people wouldn't want to
do it for each byte anyway: even on big-endian I suspect you can find
smarter zero-finding than doing 8 byte tests by doing a "binary
search" with "has_zero()" and shifting.

 - the "where is end of address space" is architecture-dependent
(would need some helper inline in <asm/uaccess.h>). And at least FRV
has a *low* address check too, afaik, so the range check is not
*always* just "this is the max address".

but yes, the amount of architecture-specific code is fairly small.
There *might* be some additional detail I missed, but it's still going
to be a matter of small details rather than anything else.

Btw, the x86 version these days actually zeroes the last bytes of the
word-at-a-time copy. It was cheap, since we calculate the proper mask
anyway, and it means that you never copy unspecified bytes from user
space (even when you do overrun things), but it doesn't really
*matter* - we don't really care what crap goes into the rest of the
buffer. I thought it was cleaner that way, though, and if possible I'd
suggest people try to aim for that.

                        Linus
