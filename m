From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 23 May 2012 10:02:13 +0200
Message-ID: <CAMuHMdUdxrGqn9sRgwrNgX4teV_ivHSeBn3hKnvgxZRxQE_krQ@mail.gmail.com>
References: <CA+55aFzm5v2JXNOEp=VmJ22FOdo77L_TsDKbou6S=AtAJB-+Hg@mail.gmail.com>
	<20120523.014627.497058725671088241.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44536 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757149Ab2EWICO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 04:02:14 -0400
Received: by yenm10 with SMTP id m10so6193487yen.19
        for <linux-arch@vger.kernel.org>; Wed, 23 May 2012 01:02:14 -0700 (PDT)
In-Reply-To: <20120523.014627.497058725671088241.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, linux-arch@vger.kernel.org

On Wed, May 23, 2012 at 7:46 AM, David Miller <davem@davemloft.net> wro=
te:
> [PATCH] sparc: Add full proper error handling to strncpy_from_user().
>
> Linus removed the end-of-address-space hackery from
> fs/namei.c:do_getname() so we really have to validate these edge
> conditions and cannot cheat any more (as x86 used to as well).
>
> Move to a common C implementation like x86 did. =C2=A0And if both
> src and dst are sufficiently aligned we'll do word at a time
> copies and checks as well.

Now everybody is rewriting this in plain C, perhaps it make sense to
have it in lib/, so I don't have to write anything myself?

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Lazy Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
