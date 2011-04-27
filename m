From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 2/7] arch: add #define for each of optimized find bitops
Date: Wed, 27 Apr 2011 16:00:28 +0200
Message-ID: <BANLkTi=t4jFh58TSkgCt0YsweoEoO8TXvA@mail.gmail.com>
References: <1303910411-15793-1-git-send-email-akinobu.mita@gmail.com>
	<1303910411-15793-3-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43399 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509Ab1D0OAb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2011 10:00:31 -0400
In-Reply-To: <1303910411-15793-3-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Wed, Apr 27, 2011 at 15:20, Akinobu Mita <akinobu.mita@gmail.com> wr=
ote:
> The style that we normally use in asm-generic is to test the macro it=
self
> for existence, so in asm-generic, do:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#ifndef find_next_zero_bit_le
> =C2=A0 =C2=A0 =C2=A0 =C2=A0extern unsigned long find_next_zero_bit_le=
(const void *addr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long =
size, unsigned long offset);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#endif
>
> and in the architectures, write
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static inline unsigned long find_next_zero=
_bit_le(const void *addr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long =
size, unsigned long offset)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#define find_next_zero_bit_le find_next_ze=
ro_bit_le
>
> This adds the #define for each of the optimized find bitops in the
> architectures.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Acked-by: Greg Ungerer <gerg@uclinux.org>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>

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
