From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Mostly portable strnlen_user()
Date: Fri, 25 May 2012 21:19:01 -0700
Message-ID: <CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
References: <CA+55aFxYO-fb9K-_g8X85tK8-sGxUHy1R8X3Hes3fb-+0bhXLw@mail.gmail.com>
 <20120525.224318.1418525735588086513.davem@davemloft.net> <CA+55aFxDyPCEFbOFaPbXF556NbtakuC0RcoUKhCa5k2EsqJ8CQ@mail.gmail.com>
 <20120526.001552.1171433126500742038.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53622 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab2EZETY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 May 2012 00:19:24 -0400
Received: by weyu7 with SMTP id u7so939642wey.19
        for <linux-arch@vger.kernel.org>; Fri, 25 May 2012 21:19:22 -0700 (PDT)
In-Reply-To: <20120526.001552.1171433126500742038.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org

On Fri, May 25, 2012 at 9:15 PM, David Miller <davem@davemloft.net> wrote:
>
> At first glance, it does.
>
> I play with this and try to get it working on sparc tonight, thanks.

Make sure to take the second patch, the first was scrogged for the
asm-generic case (and thus sparc). It would never have compiled.

The second one should actually hopefully come close to working. At
least I tested the compile by building the lib/ files with that,
instead of the x86 native version.

Obviously the asm-generic version cannot actually work with the dentry
hashing routines (it needs the whole bytemask generation at a minimum
for that), so it may be broken in the sense of "it doesn't actually
work", but it is *closer*. And the concept seems to be ok, since it
seems to work on x86 (I'm running it right now)

                Linus
