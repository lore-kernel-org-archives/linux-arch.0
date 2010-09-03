From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] M68K: Use CONFIG_MMU not __uClinux__ to select
 m68knommu contributions
Date: Fri, 3 Sep 2010 11:33:24 +0200
Message-ID: <AANLkTikBLCg_FUwGGiajw3+dgCe6y0s0a1yMs8=A2oCR@mail.gmail.com>
References: <m3vd6nmd68.fsf@hase.home>
	<19747.1283422807@redhat.com>
	<20100902102158.19806.14133.stgit@warthog.procyon.org.uk>
	<m38w3kns4r.fsf@hase.home>
	<AANLkTikwax-Jb60jT5_TOL=Zkwbgh8FwMk78ncm1dN-P@mail.gmail.com>
	<3048.1283505520@redhat.com>
	<4C80C068.1010302@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43518 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849Ab0ICJdZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Sep 2010 05:33:25 -0400
In-Reply-To: <4C80C068.1010302@snapgear.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: David Howells <dhowells@redhat.com>, Andreas Schwab <schwab@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Sep 3, 2010 at 11:31, Greg Ungerer <gerg@snapgear.com> wrote:
> On 03/09/10 19:18, David Howells wrote:
>> Andreas Schwab<schwab@redhat.com> =C2=A0wrote:
>>
>>> You are almost able to use the uclinux compiler for both, except th=
at
>>> currently __uClinux__ is hardcoded.
>>
>> The m68knommu arch Makefile in the kernel could specify it on the co=
mpiler
>> command line, then m68k compilers should be possible.
>>
>> The kernel should probably also set appropriate -mcpu=3D and -mtune=3D=
 flags,
>> depending on the type of kernel selected.
>
> Not sure about m68k but m68knommu targets already setup
> appropriate -mcpu flags for its various supported CPU types.

Same for m68k.

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
