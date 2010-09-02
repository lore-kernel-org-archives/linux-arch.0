From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] M68K: Use CONFIG_MMU not __uClinux__ to select
 m68knommu contributions
Date: Thu, 2 Sep 2010 21:53:53 +0200
Message-ID: <AANLkTikwax-Jb60jT5_TOL=Zkwbgh8FwMk78ncm1dN-P@mail.gmail.com>
References: <19747.1283422807@redhat.com>
	<20100902102158.19806.14133.stgit@warthog.procyon.org.uk>
	<m38w3kns4r.fsf@hase.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54861 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756365Ab0IBTxy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Sep 2010 15:53:54 -0400
In-Reply-To: <m38w3kns4r.fsf@hase.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@redhat.com>
Cc: David Howells <dhowells@redhat.com>, gerg@snapgear.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 2, 2010 at 16:21, Andreas Schwab <schwab@redhat.com> wrote:
> David Howells <dhowells@redhat.com> writes:
>
>> Use CONFIG_MMU not __uClinux__ to select m68knommu contributions as =
nothing in
>> the arch defines __uClinux__ for the build.
>
> You are using the wrong compiler.

it would be nice if you could use the same compiler for m68k and m68kno=
mmu, at
least for compiling kernels.

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
