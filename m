From: Adam Jackson <ajax@redhat.com>
Subject: Re: asm/vga.h (was: Re: drm: Add support for platform devices to
 register as DRM devices)
Date: Tue, 10 Aug 2010 17:51:06 -0400
Message-ID: <1281477066.17843.3015.camel@atropine>
References: <AANLkTik44qbia+7w9=83cboTMLbvQDcH-60dHuAnd9ax@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-p76OG5oZ2flwIKIzvJVj"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTik44qbia+7w9=83cboTMLbvQDcH-60dHuAnd9ax@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


--=-p76OG5oZ2flwIKIzvJVj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-08-10 at 22:35 +0200, Geert Uytterhoeven wrote:

> Now, do we really need <asm/vga.h>? It seems I can make it build and boot=
 using:
>=20
> --- a/include/linux/vgaarb.h
> +++ b/include/linux/vgaarb.h
> @@ -31,7 +31,9 @@
>  #ifndef LINUX_VGA_H
>  #define LINUX_VGA_H
>=20
> +#ifdef CONFIG_VGA_ARB
>  #include <asm/vga.h>
> +#endif
>=20
>  /* Legacy VGA regions */
>  #define VGA_RSRC_NONE         0x00

That seems fine.

- ajax

--=-p76OG5oZ2flwIKIzvJVj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkxhycoACgkQW4otUKDs0NNGiwCfQuFFgBM8FUI8rYgUt0Sz1EXR
MyQAniQSvWUVFR9MLN7qoecHD2A2wnqQ
=FHMk
-----END PGP SIGNATURE-----

--=-p76OG5oZ2flwIKIzvJVj--
