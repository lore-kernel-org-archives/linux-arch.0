From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH 17/27] add generic lib/checksum.c
Date: Fri, 1 May 2009 00:35:47 +0200
Message-ID: <20090430223547.GO12974@lug-owl.de>
References: <cover.1241105648.git.arnd@arndb.de> <cda5746ab12cf9d6bcb7803a3667c92250a29784.1241105648.git.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6iXXu7NwgEt9u5a7"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763507AbZD3Wf7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cda5746ab12cf9d6bcb7803a3667c92250a29784.1241105648.git.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


--6iXXu7NwgEt9u5a7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-03-31 15:30:31 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> Add a generic (unoptimized) implementation of checksum.c in pure C
> for use by all architectures.
>=20
> Based on microblaze code by Michal Simek <monstr@monstr.eu>
>=20
> Cc: Michal Simek <monstr@monstr.eu>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Remis Lima Baima <remis.developer@googlemail.com>
> ---
>  include/asm-generic/checksum.h |   79 +++++++++++++++++
>  lib/Makefile                   |    2 +
>  lib/checksum.c                 |  188 ++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 269 insertions(+), 0 deletions(-)
>  create mode 100644 include/asm-generic/checksum.h
>  create mode 100644 lib/checksum.c
>=20
> diff --git a/lib/checksum.c b/lib/checksum.c
                                ^^^^^^^^^^^^^^
> new file mode 100644
> index 0000000..4f80a4d
> --- /dev/null
> +++ b/lib/checksum.c
> @@ -0,0 +1,188 @@
> +/*
> + * arch/microblaze/lib/checksum.c
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> + *
> + * Copyright (C) 2008 Michal Simek <monstr@monstr.eu>

I haven't looked at the code in detail, but it would be nice to see it
show up soon. Just faced the IP checksumming code while resurrecting
the VAX port.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:         "really soon now":      an unspecified period of time=
, likly to
the second  :                                 be greater than any reasonabl=
e definition
                                              of "soon".

--6iXXu7NwgEt9u5a7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkn6J8MACgkQHb1edYOZ4buZlQCggtMS918rOtWzi8mC+00TL7ob
VD0AnjW16QiZ/8f/6yASMg128dfmMXzq
=OBwo
-----END PGP SIGNATURE-----

--6iXXu7NwgEt9u5a7--
