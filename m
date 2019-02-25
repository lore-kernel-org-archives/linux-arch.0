Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:43911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbfBYPvW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Feb 2019 10:51:22 -0500
Date: Mon, 25 Feb 2019 16:51:19 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] div64.h: Fix description of do_div parameter
Message-ID: <20190225155119.GA7654@latitude>
References: <20190225140355.4335-1-j.neuschaefer@gmx.net>
 <CAMuHMdXEY+ri8QO2AVGzD5vNuYujDNK-k62zz2Qd-ceMgT59tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXEY+ri8QO2AVGzD5vNuYujDNK-k62zz2Qd-ceMgT59tw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20190225155119.fBk3YHmGBe8nQkXIDHFw8Z3lT96RdN4XG-KPaV9pI60@z>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 04:19:02PM +0100, Geert Uytterhoeven wrote:
> Hi Jonathan,
>=20
> On Mon, Feb 25, 2019 at 3:05 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> > Contrary to the description, the first parameter (n) should not be
> > passed as a pointer, but directly as an lvalue. This is possible because
> > do_div is a macro.
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>=20
> Thanks for your patch!
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Shouldn't the "semantics" at the top of include/asm-generic/div64.h be
> updated, too?

Arguably, it's semantically close enough. I'm not sure.

> As this can't be expressed in a C function, perhaps that should be done
> using C++ syntax, like
>=20
>     uint32_t do_div(uint64_t &n, uint32_t base)
>     {
>         ...
>     }

That might confuse some people who aren't expecting C++ syntax.
I'll leave this as is, because I can't decide wether this is an
improvement.


Thanks,
Jonathan Neusch=C3=A4fer

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlx0Du8ACgkQCDBEmo7z
X9ulPw//Z1CKR5K1NBXBN8FGwlzGRQAXIAcsnNzeCiqbcwjLENyGq5AgGsVhQPH3
wo8xrTbdzwq/ogn9zerH8uNhz02/ewDb8o6gMI6WjcK15tJrkspy7zCcUqn7RnY+
GH6kV70Sx3xIjWdklrsKnWGKfOtmCn1Gm5aoN3lAzMSRRSN+B0vf30ir5Y4csGgy
f3+uriehAIrWw6DQrVN/xvZhNpDdDUiDCM13Yabg+dXXPdic9LPC4c6ijHzysuC7
NXPlQZu87/sRr2Bu+qVp2noW0nnEQxdofcJBXyEE0s8N+7aVGjaVwt4K2UJ5vp6A
UesKCGw3wEJhrjXa+QR35jObA08vzh3vqIjiWk+XTQ/JA/bEiYBV/E5IUhzDOezb
WuyB6jo2flZzYezwYoketY6HIns/DlxXuHtn1awmfg5rTmxBmkkhFLsI2IRPadRT
qSlhFeP4DMHy2fHqDqZBllKSkeRMWXDGc1fqwurzrnGfvvMrMRsyQ6++/hcNNeQO
hV5LLM+G3sBiEkGUj1k4Xl2tytmCqsOlilvFivX9pqFeBeMocKTc8wtyFWohseqp
nG99luWuDzR67w5X8ETQj+GT2qskr7VfiGwDTar4/WW/Ll2AydJcnzBvy2GxcapZ
wDpGia8jZLEn/DUyf6AppqDb7JIkc515RHsGL8FTXIs3svFQpkg=
=uSc2
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
