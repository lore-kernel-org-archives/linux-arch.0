From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] topology: Check for missing CPU devices
Date: Mon, 9 Jan 2012 21:13:01 +0100
Message-ID: <CAMuHMdV614Hb9dFykFNbkwf-6hqx36qg_W=66tNqsexEHQ8d0A@mail.gmail.com>
References: <1326055714.13595.309.camel@deadeye>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1326055714.13595.309.camel@deadeye>
Sender: linux-m68k-owner@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, Thorsten Glaser <tg@mirbsd.de>, Debian kernel team <debian-kernel@lists.debian.org>, linux-m68k@vger.kernel.org, debian-68k@lists.debian.org
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 8, 2012 at 21:48, Ben Hutchings <ben@decadent.org.uk> wrote=
:
> Commit ccbc60d3e19a1b6ae66ca0d89b3da02dde62088b ('topology: Provide
> CPU topology in sysfs in !SMP configurations') causes a crash at boot
> on a several architectures. =C2=A0The topology sysfs code assumes tha=
t
> there is a CPU device for each online CPU whereas some architectures
> that do not support SMP or cpufreq do not register any CPU devices.
> Check for this before trying to use a device.
>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Thanks!
Works on its own or combined with "[PATCH 2/2] cpu: Register a generic
CPU device on architectures that currently do not".

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
