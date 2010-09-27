From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch 08/19] genirq; Provide compat handling for chip->mask_ack()
Date: Mon, 27 Sep 2010 17:10:58 +0200
Message-ID: <AANLkTimpavoLaAeY7dXPh7-596+xK0ZFxYMb8AHT6fv1@mail.gmail.com>
References: <20100927121651.904100669@linutronix.de>
	<20100927121842.240806983@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51858 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756562Ab0I0PK7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Sep 2010 11:10:59 -0400
In-Reply-To: <20100927121842.240806983@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>

On Mon, Sep 27, 2010 at 14:44, Thomas Gleixner <tglx@linutronix.de> wro=
te:
> Wrap the old chip function mask_ack() until the migration is complete
> and the old chip functions are removed.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> =C2=A0kernel/irq/chip.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 20 +++++++++++++=
+++++--
> =C2=A0kernel/irq/internals.h | =C2=A0 17 +++++++++++------
> =C2=A0kernel/irq/manage.c =C2=A0 =C2=A0| =C2=A0 22 +++++++++++-------=
----
> =C2=A03 files changed, 40 insertions(+), 19 deletions(-)

3 files

> Index: linux-2.6-tip/kernel/irq/chip.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-tip.orig/kernel/irq/chip.c
> +++ linux-2.6-tip/kernel/irq/chip.c

Only 1 file?

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
