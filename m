From: Jonas Bonn <jonas@southpole.se>
Subject: Re: Mostly portable strnlen_user()
Date: Sat, 26 May 2012 10:32:51 +0200
Message-ID: <CACM3HyFDY96F5kfsVCRQbx+8J+BUDCWXPqQVuLwOXRefS0Gcvg@mail.gmail.com>
References: <CA+55aFxYO-fb9K-_g8X85tK8-sGxUHy1R8X3Hes3fb-+0bhXLw@mail.gmail.com>
	<20120525.224318.1418525735588086513.davem@davemloft.net>
	<CA+55aFxDyPCEFbOFaPbXF556NbtakuC0RcoUKhCa5k2EsqJ8CQ@mail.gmail.com>
	<20120526.001552.1171433126500742038.davem@davemloft.net>
	<CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.southpole.se ([193.12.106.18]:57524 "EHLO
	mail.southpole.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab2EZIc4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 May 2012 04:32:56 -0400
Received: from mail-bk0-f46.google.com (assp.southpole.se [193.12.106.25])
	by mail.southpole.se (Postfix) with ESMTPA id 433613B4C11
	for <linux-arch@vger.kernel.org>; Sat, 26 May 2012 10:32:52 +0200 (CEST)
Received: by bkcji2 with SMTP id ji2so1259724bkc.19
        for <linux-arch@vger.kernel.org>; Sat, 26 May 2012 01:32:51 -0700 (PDT)
In-Reply-To: <CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org


On 26 May 2012 06:19, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Make sure to take the second patch, the first was scrogged for the
> asm-generic case (and thus sparc). It would never have compiled.
>
> The second one should actually hopefully come close to working. At
> least I tested the compile by building the lib/ files with that,
> instead of the x86 native version.
>
> Obviously the asm-generic version cannot actually work with the dentry
> hashing routines (it needs the whole bytemask generation at a minimum
> for that), so it may be broken in the sense of "it doesn't actually
> work", but it is *closer*. And the concept seems to be ok, since it
> seems to work on x86 (I'm running it right now)

I gave this a try on OpenRISC... works fine here, too.

/Jonas
