From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re:
Date: Mon, 27 Apr 2009 16:50:50 +0200
Message-ID: <10f740e80904270750n6f9bb593r8c2b6a257b034cea@mail.gmail.com>
References: <20090427143737.584097988@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:45455 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758835AbZD0Ouw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2009 10:50:52 -0400
Received: by ewy24 with SMTP id 24so2194901ewy.37
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2009 07:50:50 -0700 (PDT)
In-Reply-To: <20090427143737.584097988@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org

[bummer, reply-to-all broken]

On Mon, Apr 27, 2009 at 16:41,  <arnd@arndb.de> wrote:
> Subject: [RFC 06/17] asm-generic: add a complete signal.h

> There used to be an asm-generic/signal.h, but not one that
> could be used out of the box. This renames the existing file
> to asm-generic/signal-defs.h and adds a new asm-generic/signal.h

The rename was done in another patch, but you forgot to update this
patch description?

> with common definitions for sigaction and sigaltstack, but
> not for the old-style signal handlers.
>
> New architectures should only implement rt-signals and use this
> generic header.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Remis Lima Baima <remis.developer@googlemail.com>
> ---
> ---
> =C2=A0include/asm-generic/Kbuild =C2=A0 | =C2=A0 =C2=A01 =C2=A0 =C2=A0=
1 + =C2=A0 =C2=A0 0 - =C2=A0 =C2=A0 0 !
> =C2=A0include/asm-generic/signal.h | =C2=A0131 =C2=A0 =C2=A0131 + =C2=
=A0 0 - =C2=A0 =C2=A0 0 !

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
