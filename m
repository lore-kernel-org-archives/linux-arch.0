From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] STAGING: Comedi: Build only on arches providing PAGE_KERNEL_NOCACHE
Date: Thu, 23 Jun 2011 18:01:47 +0200
Message-ID: <BANLkTimR98qo5fjMRf-kZahcA=hE-E3+Hg@mail.gmail.com>
References: <20110623114536.GA14011@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110623114536.GA14011@linux-mips.org>
Sender: linux-sh-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-am33-list@redhat.com, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 23, 2011 at 13:45, Ralf Baechle <ralf@linux-mips.org> wrote=
:
> On architectures that don't define PAGE_KERNEL_NOCACHE, the Comedi dr=
iver turns
> into tragedy:
>
> =C2=A0CC [M] =C2=A0drivers/staging/comedi/drivers.o
> drivers/staging/comedi/drivers.c: In function =E2=80=98comedi_buf_all=
oc=E2=80=99:
> drivers/staging/comedi/drivers.c:505:41: error: =E2=80=98PAGE_KERNEL_=
NOCACHE=E2=80=99 undeclared (first use in this function)
> drivers/staging/comedi/drivers.c:505:41: note: each undeclared identi=
fier is rep orted only once for each function it appears in
> make[3]: *** [drivers/staging/comedi/drivers.o] Error 1
>
> Restrict the driver to only those architectures that define PAGE_KERN=
EL_NOCACHE.
>
> PAGE_KERNEL_NOCACHE is a kludge - some system architectures such as S=
GI IP27
> are even uable to offer uncached operation - at least in the way an u=
nwitting
> driver might assume. =C2=A0I haven't looked in details how the driver=
 is using
> the area vmaped with PAGE_KERNEL_NOCACHE but maybe doing it XFS-style=
 using
> cached memory and the flush_kernel_vmap_range / invalidate_kernel_vma=
p_range
> APIs in conjunction with the DMA API is a practical alternative.
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

If only to get m68k/allmodconfig going again (hmm, there's another
staging driver
preventing a green light).

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
