From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: LMB bits
Date: Fri, 9 Jul 2010 10:24:39 +0200
Message-ID: <AANLkTikAb5UeOLmcZaHWfKEUkwgrE4sNMinkGHxxMdTl@mail.gmail.com>
References: <1278031351-23223-1-git-send-email-yinghai@kernel.org>
	<1278659480.28659.149.camel@pasglop>
	<20100709072408.GD10743@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61101 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab0GIIYl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jul 2010 04:24:41 -0400
Received: by wwb24 with SMTP id 24so4592723wwb.1
        for <linux-arch@vger.kernel.org>; Fri, 09 Jul 2010 01:24:40 -0700 (PDT)
In-Reply-To: <20100709072408.GD10743@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Yinghai Lu <yinghai@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org

On Fri, Jul 9, 2010 at 09:24, Ingo Molnar <mingo@elte.hu> wrote:
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> So I've pushed the memblocks rename and the modified version of my p=
atches
>> that Yinghai produced in the "memblock" branch of the powerpc.git tr=
ee,
>> based on top of current Linus tree.

> to Linus straight away - to get the big rename out of the way:
>
> =C2=A074 files changed, 1039 insertions(+), 1039 deletions(-)

Seems I have missed that part of the discussion: why is lmb renamed?

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
