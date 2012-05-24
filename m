From: David Howells <dhowells@redhat.com>
Subject: Re: Arch maintainers Ahoy!
Date: Thu, 24 May 2012 10:40:16 +0100
Message-ID: <32064.1337852416@redhat.com>
References: <CA+55aFxcRc_zR9HtFAtrT1exGP2DspP0aA6T49Ph3kZEHHyQWw@mail.gmail.com> <CA+55aFy675A7qH+5GUZ_C_aN+Um0o70Zq=SVXYZxbM93ft50mg@mail.gmail.com> <20120523.132109.1153947222019508621.davem@davemloft.net> <CA+55aFxWaB4eeYgdvhTJ2RegM53WxJZFC4HfV=shNn7ZDdG9CQ@mail.gmail.com> <20120523.141647.2252460119413470634.davem@davemloft.net>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43677 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161Ab2EXJlA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 May 2012 05:41:00 -0400
In-Reply-To: <CA+55aFxcRc_zR9HtFAtrT1exGP2DspP0aA6T49Ph3kZEHHyQWw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, David Miller <davem@davemloft.net>, James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org


Linus Torvalds <torvalds@linux-foundation.org> wrote:

> It's not faster to just do something like
> 
>    int byte = 4;
> 
> #if CONFIG_64BIT
>    byte = 8;
>    if (has_zero_32bit(value >> 32)) {
>        value >>= 32;
>        byte = 4;
>    }
> #endif
>    if (has_zero_16(value >> 16)) {
>       value >>= 16;
>       byte -= 2;
>    }
>    if (!value & 0xff00)
>       byte--;
>    return byte;


Could you use cpu_to_be32/64() and then ffs()?  That ought to work for both
variants of endianness.  The cpu_to_beXX() should be a noop on BE and is
likely to be a single instruction on LE.  The meat of ffs() is usually a
single instruction, though it may have to have zero-detect logic added.

David
