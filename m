From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch 31/37] mn10300: Use generic irq Kconfig
Date: Sat, 5 Mar 2011 22:02:33 +0100
Message-ID: <AANLkTi=nLFx7Z7UfiXZrBQoGgC1Fh_dh9--5T=Di9qhc@mail.gmail.com>
References: <20110119205258.462759212@linutronix.de>
	<20110119210840.381111598@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57596 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab1CEVCf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Mar 2011 16:02:35 -0500
In-Reply-To: <20110119210840.381111598@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>

On Wed, Jan 19, 2011 at 22:49, Thomas Gleixner <tglx@linutronix.de> wro=
te:
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: David Howells <dhowells@redhat.com>
> ---
> =C2=A0arch/mn10300/Kconfig | =C2=A0 =C2=A05 +----
> =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
>
> Index: linux-2.6/arch/mn10300/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/mn10300/Kconfig
> +++ linux-2.6/arch/mn10300/Kconfig
> @@ -1,6 +1,7 @@
> =C2=A0config MN10300
> =C2=A0 =C2=A0 =C2=A0 =C2=A0def_bool y
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select HAVE_OPROFILE
> + =C2=A0 =C2=A0 =C2=A0 select GENERIC_HARDIRQS

Wasn't this supposed to be "select HAVE_GENERIC_HARDIRQS"?

/me studying generic hardirqs...

>
> =C2=A0config AM33_2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0def_bool n
> @@ -76,10 +77,6 @@ config QUICKLIST
> =C2=A0config ARCH_HAS_ILOG2_U32
> =C2=A0 =C2=A0 =C2=A0 =C2=A0def_bool y
>
> -# Use the generic interrupt handling code in kernel/irq/
> -config GENERIC_HARDIRQS
> - =C2=A0 =C2=A0 =C2=A0 def_bool y
> -
> =C2=A0config HOTPLUG_CPU
> =C2=A0 =C2=A0 =C2=A0 =C2=A0def_bool n

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
