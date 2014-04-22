From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 18/18] asm-generic: io: define relaxed accessor macros
 unconditionally
Date: Tue, 22 Apr 2014 16:09:46 +0200
Message-ID: <5356782A.9050809@monstr.eu>
References: <1397742261-15621-1-git-send-email-will.deacon@arm.com> <1397742261-15621-19-git-send-email-will.deacon@arm.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tiDH4Mqrch3wXrvoNuUH4amjGcTWUvO9I"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44696 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744AbaDVOJ6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 10:09:58 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so4610586eei.5
        for <linux-arch@vger.kernel.org>; Tue, 22 Apr 2014 07:09:57 -0700 (PDT)
In-Reply-To: <1397742261-15621-19-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, dhowells@redhat.com, broonie@linaro.org, benh@kernel.crashing.org, peterz@infradead.org, paulmck@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tiDH4Mqrch3wXrvoNuUH4amjGcTWUvO9I
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/17/2014 03:44 PM, Will Deacon wrote:
> Now that no architectures using asm-generic/io.h define their own relax=
ed
> accessors, the dummy definitions can be used unconditionally.
>=20
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  include/asm-generic/io.h | 18 ------------------
>  1 file changed, 18 deletions(-)

Do we need this? I think there could be a need to overwrite them.
Currently we are just lucky that architecture which uses asm-generic/io.h=

don't need to overwrite it.
But I expect that all archs should use asm-generic/io.h to clean
architecture io.h exactly I have done it for Microblaze.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--tiDH4Mqrch3wXrvoNuUH4amjGcTWUvO9I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNWeCoACgkQykllyylKDCHL7QCfZHY0AEPJpupieO3TTKRh9VXj
VN4AnRtRl3pIh5H8pVJrJxaX+V08i19U
=7Mr8
-----END PGP SIGNATURE-----

--tiDH4Mqrch3wXrvoNuUH4amjGcTWUvO9I--
