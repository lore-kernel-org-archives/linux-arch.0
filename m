Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from partizan.velesys.com ([213.184.230.195]:62512 "EHLO
	partizan.velesys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbYBGI76 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Feb 2008 03:59:58 -0500
Date: Thu, 7 Feb 2008 10:51:33 +0200
From: "Kirill A. Shutemov" <k.shutemov@gmail.com>
Subject: Re: -
	cleanup-asm-elfpageuserh-ifdef-__kernel__-is-no-longer-needed-fix.pa
	tch removed from -mm tree
Message-ID: <20080207085133.GA4206@localhost.localdomain>
References: <200802070338.m173c8MA014249@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <200802070338.m173c8MA014249@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: dwmw2@infradead.org, linux-arch@vger.kernel.org, mm-commits@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On [Wed, 06.02.2008 19:38], akpm@linux-foundation.org wrote:
>=20
> The patch titled
>      Cleanup asm/{elf,page,user}.h: #ifdef __KERNEL__ is no longer needed=
 (fix)
> has been removed from the -mm tree.  Its filename was
>      cleanup-asm-elfpageuserh-ifdef-__kernel__-is-no-longer-needed-fix.pa=
tch

Why? asm/elf.h on PowerPC has still exported, so this patch is needed.

--=20
Regards,  Kirill A. Shutemov
 + Belarus, Minsk
 + Velesys Ltd, http://www.velesys.com/
 + ALT Linux Team, http://www.altlinux.com/

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkeqxpUACgkQbWYnhzC5v6rDwgCfSMrCNwztB5LpqNZ/9OE89Ym+
W9gAn0Aisg4yCqtLcQpOt1sb4klnSoLB
=0Xju
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
