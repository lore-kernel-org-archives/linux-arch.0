From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] modules: make arch's use default loader hooks
Date: Fri, 1 Jul 2011 09:00:13 +0200
Message-ID: <BANLkTi=j+3eovYhcjoniFrCL_vAC0BQCdw@mail.gmail.com>
References: <201106281245.19457.arnd@arndb.de>
	<1309461732-2875-1-git-send-email-jonas@southpole.se>
	<1309461732-2875-2-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39276 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080Ab1GAHAO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2011 03:00:14 -0400
In-Reply-To: <1309461732-2875-2-git-send-email-jonas@southpole.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: rusty@rustcorp.com.au, arnd@ardnb.de, mingo@elte.hu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, monstr@monstr.eu, cmetcalf@tilera.com, torvalds@linux-foundation.org, akpm@linux-foundation.org

On Thu, Jun 30, 2011 at 21:22, Jonas Bonn <jonas@southpole.se> wrote:
> This patch removes all the module loader hook implementations in the
> architecture specific code where the functionality is the same as tha=
t
> now provided by the recently added default hooks.
>
> Signed-off-by: Jonas Bonn <jonas@southpole.se>

> =C2=A0arch/m68k/kernel/module_mm.c =C2=A0 =C2=A0| =C2=A0 27 ---------=
--------
> =C2=A0arch/m68k/kernel/module_no.c =C2=A0 =C2=A0| =C2=A0 34 ---------=
------------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
