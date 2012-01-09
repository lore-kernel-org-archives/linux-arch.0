From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH 1/2] topology: Check for missing CPU devices
Date: Mon, 9 Jan 2012 02:06:50 +0100
Message-ID: <CAFLxGvwJWrSRSNxHE620XZkc4w0ayzeqqxZOR1efkh1V+VBO1w@mail.gmail.com>
References: <1326055714.13595.309.camel@deadeye>
	<CA+55aFwwnJPpVY++Vgr6p3s47YjdYWV3sgLZzvCtiJp6DEu78Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:41395 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755078Ab2AIBGv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 8 Jan 2012 20:06:51 -0500
In-Reply-To: <CA+55aFwwnJPpVY++Vgr6p3s47YjdYWV3sgLZzvCtiJp6DEu78Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, Thorsten Glaser <tg@mirbsd.de>, Debian kernel team <debian-kernel@lists.debian.org>, linux-m68k@vger.kernel.org, debian-68k@lists.debian.org

On Mon, Jan 9, 2012 at 1:18 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Ok, both of the patches look sane to me, but it would really be nice
> to hear from somebody with the actual affected architectures, and get
> a tested-by.

UML is affected:
https://lkml.org/lkml/2012/1/8/186

I wasted an hour finding out why it is crashing.
Instead of testing kernels I really should read more LKML. ;-)

-- 
Thanks,
//richard
