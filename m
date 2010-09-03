From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] M68K: Use CONFIG_MMU not __uClinux__ to select
 m68knommu contributions
Date: Fri, 3 Sep 2010 12:02:28 +0200
Message-ID: <AANLkTi=1vPD-9iU7EszKwx1PV=Qay_d4dt_pT75sKj2a@mail.gmail.com>
References: <m3vd6nmd68.fsf@hase.home>
	<19747.1283422807@redhat.com>
	<20100902102158.19806.14133.stgit@warthog.procyon.org.uk>
	<m38w3kns4r.fsf@hase.home>
	<AANLkTikwax-Jb60jT5_TOL=Zkwbgh8FwMk78ncm1dN-P@mail.gmail.com>
	<3048.1283505520@redhat.com>
	<4C80C068.1010302@snapgear.com>
	<AANLkTikBLCg_FUwGGiajw3+dgCe6y0s0a1yMs8=A2oCR@mail.gmail.com>
	<7877.1283507577@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36440 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab0ICKC3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Sep 2010 06:02:29 -0400
In-Reply-To: <7877.1283507577@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Greg Ungerer <gerg@snapgear.com>, Andreas Schwab <schwab@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Sep 3, 2010 at 11:52, David Howells <dhowells@redhat.com> wrote=
:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>> > Not sure about m68k but m68knommu targets already setup
>> > appropriate -mcpu flags for its various supported CPU types.
>>
>> Same for m68k.
>
> It doesn't seem to:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0warthog>grep -r mcpu arch/m68k
> =C2=A0 =C2=A0 =C2=A0 =C2=A0warthog1>grep -r mtune arch/m68k
> =C2=A0 =C2=A0 =C2=A0 =C2=A0warthog1>

Sorry, we're still using e.g. -m68040 instead of the -mcpu/-mtune varia=
nts.

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
