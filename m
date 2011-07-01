From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: Build regressions/improvements in v3.0-rc5
Date: Fri, 1 Jul 2011 19:15:16 -0400
Message-ID: <CAMjpGUcrZpqDwi8r+BmyDV29-FcU9miJLv-dHGjUYY_GLYLU8A@mail.gmail.com>
References: <alpine.DEB.2.00.1106291011400.10665@ayla.of.borg> <201107020005.02075.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201107020005.02075.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 1, 2011 at 18:05, Arnd Bergmann wrote:
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -21,7 +21,7 @@
> =C2=A0#include <linux/pfn.h>
> =C2=A0#include <asm/io.h>
>
> -
> +#ifdef IO_SPACE_LIMIT
> =C2=A0struct resource ioport_resource =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =3D "PCI IO",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.start =C2=A0=3D 0,
> @@ -29,6 +29,7 @@ struct resource ioport_resource =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =C2=A0=3D IORESOURCE_IO,
> =C2=A0};
> =C2=A0EXPORT_SYMBOL(ioport_resource);
> +#endif

hmm, asm-generic/io.h unconditionally sets this to 0xffff.  should
that depend on CONFIG_HAS_IOPORT ?
-mike
