From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Mostly portable strnlen_user()
Date: Fri, 25 May 2012 18:09:33 -0700
Message-ID: <CA+55aFwQV9kaVV9rvrVvqMa_dAetG-X1HzsiHHb4TNVa=W6Pgg@mail.gmail.com>
References: <20120525.191407.1171512018515372695.davem@davemloft.net>
 <CA+55aFxyno-mCNsJZzpW+5HAc0KA477ZeHGZ6=ONLcnHWiHaEA@mail.gmail.com>
 <20120525.194125.1593753424815090718.davem@davemloft.net> <20120525.204135.1619066165157180427.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42588 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab2EZBJy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2012 21:09:54 -0400
Received: by wibhj8 with SMTP id hj8so43716wib.1
        for <linux-arch@vger.kernel.org>; Fri, 25 May 2012 18:09:53 -0700 (PDT)
In-Reply-To: <20120525.204135.1619066165157180427.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org

On Fri, May 25, 2012 at 5:41 PM, David Miller <davem@davemloft.net> wro=
te:
>
> Ok, something like the following, just to give you an idea. =A0Just t=
he
> sparc word-at-a-time.h header addition and the lib/strnlen_user.c
> changes.

Looks good to me.

> Probably I should add little-endian code to the header and put it
> under asm-generic instead since there isn't really anything sparc
> specific about it and this will make it easier for other ports to use
> this stuff.

Actually, I think it's better if we just do two separate ones: a
"generic little-endian" and a "generic big-endian" one. Rather than
mixing both into one file that is then included from some arch-file
that statically knows its endianness instead.

> This is untested and of course we'd need to tweak the x86
> word-at-a-time header and adjust the other call sites in
> the DCACHE and elsewhere.

I can do that. Give me a few minutes. Or more. Let's see how it ends up=
=2E.

                 Linus
