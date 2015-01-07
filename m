Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:44380 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbbAGKV6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jan 2015 05:21:58 -0500
Received: by mail-wg0-f41.google.com with SMTP id l18so880389wgh.28
        for <linux-arch@vger.kernel.org>; Wed, 07 Jan 2015 02:21:56 -0800 (PST)
Message-ID: <54AD06EA.6030105@monstr.eu>
Date: Wed, 07 Jan 2015 11:14:02 +0100
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
Subject: Re: [PATCH v2 10/40] microblaze/uaccess: fix sparse errors
References: <1420558883-10131-1-git-send-email-mst@redhat.com> <1420558883-10131-11-git-send-email-mst@redhat.com>
In-Reply-To: <1420558883-10131-11-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XKncbsgA7xI3dS2mdHUeDkBEeboEli5jR"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Chen Gang <gang.chen.5i5j@gmail.com>
Message-ID: <20150107101402.EkNDZ7N3UosBMB6g1rM6RrPj-s58FnG--GQynmumfDg@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XKncbsgA7xI3dS2mdHUeDkBEeboEli5jR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/06/2015 04:44 PM, Michael S. Tsirkin wrote:
> virtio wants to read bitwise types from userspace using get_user.  At t=
he
> moment this triggers sparse errors, since the value is passed through a=
n
> integer.
>=20
> Fix that up using __force.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/microblaze/include/asm/uaccess.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/in=
clude/asm/uaccess.h
> index 59a89a6..e41bebf 100644
> --- a/arch/microblaze/include/asm/uaccess.h
> +++ b/arch/microblaze/include/asm/uaccess.h
> @@ -220,7 +220,7 @@ extern long __user_bad(void);
>  	} else {							\
>  		__gu_err =3D -EFAULT;					\
>  	}								\
> -	x =3D (typeof(*(ptr)))__gu_val;					\
> +	x =3D (__force typeof(*(ptr)))__gu_val;				\
>  	__gu_err;							\
>  })
> =20
> @@ -242,7 +242,7 @@ extern long __user_bad(void);
>  	default:							\
>  		/* __gu_val =3D 0; __gu_err =3D -EINVAL;*/ __gu_err =3D __user_bad()=
;\
>  	}								\
> -	x =3D (__typeof__(*(ptr))) __gu_val;				\
> +	x =3D (__force __typeof__(*(ptr))) __gu_val;			\
>  	__gu_err;							\
>  })
> =20
>=20

Applied.

Thanks,
Michal
--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--XKncbsgA7xI3dS2mdHUeDkBEeboEli5jR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlStBu4ACgkQykllyylKDCHjNQCdHZv2XJpcmTzpFxgf1PUaP6Om
/dIAoITgLXlEybEuWG0G7LT0C937QrAd
=7tKI
-----END PGP SIGNATURE-----

--XKncbsgA7xI3dS2mdHUeDkBEeboEli5jR--
