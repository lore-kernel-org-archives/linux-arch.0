From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC][PATCH 2/3] math128: Introduce {mult,add,cmp}_u128
Date: Wed, 25 Apr 2012 16:35:47 +0200
Message-ID: <CAMuHMdVSjX1ZRc_Q0cuL+U_f+zzuD+1cjW-OBdn1c3mC8Ya_Rg@mail.gmail.com>
References: <20120424161039.293018424@chello.nl>
	<20120424162224.526249106@chello.nl>
	<20120425102342.45cf5c5e81e8aeb3bec67d0b@canb.auug.org.au>
	<1335341466.28150.248.camel@twins>
	<CAMuHMdUqgR8Z8wtBjm=-g9ff6CVmEd=FpbC2tk-CMU7B3XVVDg@mail.gmail.com>
	<1335355106.28150.254.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62186 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab2DYOft convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Apr 2012 10:35:49 -0400
In-Reply-To: <1335355106.28150.254.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Apr 25, 2012 at 13:58, Peter Zijlstra <a.p.zijlstra@chello.nl> =
wrote:
>> Still using quilt? I didn't regret ditching it in favor of git (yumm=
y,
>> git rebase ;-).
>
> Yeah, I can't seem to deal with git, I edit my patches by hand way to=
o
> often, also quilt is a _LOT_ faster pushing/popping patches than git =
is
> (and yes I use an SSD).
>
> Not using git also means I don't have to deal with the trainwreck tha=
t
> is git-merge,.. /me runs like hell.

But you have to deal with the quilt-oh-no-the-patch-no-longer-applies
trainwreck...

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
