From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] x86/atomic changes for v2.6.35
Date: Wed, 19 May 2010 13:46:01 +0200
Message-ID: <AANLkTinWbueCQZdQgZFDLQPJYieB13orxDGYJzzRpPni@mail.gmail.com>
References: <20100517224531.GA27400@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38635 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab0ESLqE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 May 2010 07:46:04 -0400
In-Reply-To: <20100517224531.GA27400@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <luca@luca-barbieri.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org

On Tue, May 18, 2010 at 00:45, Ingo Molnar <mingo@elte.hu> wrote:
> Please pull the latest x86-atomic-for-linus git tree from:
>
> =C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-ti=
p.git x86-atomic-for-linus
>
>
> out-of-topic modifications in x86-atomic-for-linus:
> ---------------------------------------------------
> lib/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 # 86a8938: lib: Add self-test for atomic64_t
> lib/atomic64.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 # 9757789: lib: Fix atomic64_add_unless retu
> lib/atomic64_test.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0# a5c9161: x86, atomic64: In selftest, disti
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # 25a304f: lib: Fix a=
tomic64_inc_not_zero te
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # 9efbcd5: lib: Fix a=
tomic64_add_unless test
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # d7f6de1: x86: Imple=
ment atomic[64]_dec_if_
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # 8f4f202: lib: Only =
test atomic64_dec_if_po
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # 86a8938: lib: Add s=
elf-test for atomic64_t

Is having atomic64_t mandatory now?

According to the allmodconfig build logs
(http://kisskb.ellerman.id.au/kisskb/matrix/),
several architectures (at least m68k and mips) don't have it.
=46urthermore, the test fails to compile on a few architectures that do=
 have it
(parisc, s390, sh, ...).

<boilerplate>
It's a pity this wasn't raised/resolved between its detection in linux-=
next and
before it entered mainline...
</boilerplate>

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
