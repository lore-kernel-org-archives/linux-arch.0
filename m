From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/27] asm-generic: add generic io.h
Date: Mon, 4 May 2009 12:48:28 +0200
Message-ID: <200905041248.29400.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de> <19d8a91dbf3456f9eb0b0bb2f92b302b88a1c672.1241105648.git.arnd@arndb.de> <10f740e80905040007x38dfcdc5i4a7d351e59db71e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:63224 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbZEDKsp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2009 06:48:45 -0400
In-Reply-To: <10f740e80905040007x38dfcdc5i4a7d351e59db71e9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>

io.h is more or less a straight copy from the mn10300 code,
so maybe David Howells is interested in this as well.

On Monday 04 May 2009, Geert Uytterhoeven wrote:
> On Thu, Nov 6, 2008 at 15:38, Arnd Bergmann <arnd@arndb.de> wrote:
> > +static inline void outsw(unsigned long addr, const void *buffer, i=
nt count)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 if (count) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const u16 *buf =3D=
 buffer;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 outw(*buf++, addr);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } while (--count=
);
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +}
> > +
> > +static inline void outsl(unsigned long addr, const void *buffer, i=
nt count)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 if (count) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const u32 *buf =3D=
 buffer;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 outl(*buf++, addr);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } while (--count=
);
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +}
>=20
> Do we ever call these with count =3D=3D 0?

I don't think it can, but code is still more correct if it can handle i=
t.
It could of course be written as

	const u32 *buf;
	for (buf =3D buffer; count; count--)
		outl(*buf++, addr);


> > +/*
> > + * Change "struct page" to physical address.
> > + */
>=20
> Which `struct page'?

I can change the comment to what avr32 and m32r have:

arch/avr32/include/asm/io.h-/*
arch/avr32/include/asm/io.h: * ioremap  -   map bus memory into CPU spa=
ce
arch/avr32/include/asm/io.h- * @offset  bus address of the memory
arch/avr32/include/asm/io.h- * @size    size of the resource to map
arch/avr32/include/asm/io.h- *
arch/avr32/include/asm/io.h: * ioremap performs a platform specific seq=
uence of operations to make
arch/avr32/include/asm/io.h- * bus memory CPU accessible via the readb/=
=2E../writel functions and
arch/avr32/include/asm/io.h- * the other mmio helpers. The returned add=
ress is not guaranteed to
arch/avr32/include/asm/io.h- * be usable directly as a virtual address.
arch/avr32/include/asm/io.h- */


	Arnd <><
