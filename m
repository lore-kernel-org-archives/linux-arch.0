Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50539 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfBJM3H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Feb 2019 07:29:07 -0500
Date: Sun, 10 Feb 2019 13:29:03 +0100
From: Hugo Lefeuvre <hle@owl.eu.com>
Subject: void __iomem *addr should be const
Message-ID: <20190210122903.GA2400@behemoth.owl.eu.com.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190210122903.PYRVSdWpkdgtcy4alQCTCPHcQSQ0BuL2a4eWfXwmEh8@z>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

__iomem *addr seems to lack a const qualifier in the ioread* definitions
=66rom include/asm-generic/iomap.h (other definitions such as
asm-generic/io.h do have the const).

This issue was briefly discussed a while ago[0] but the outcome is not
quite clear to me. Should I submit a patch addressing this issue or is it
a definitive wontfix?

This issue triggers warnings in my current work but I would like to avoid
dropping the const if possible.

regards,
 Hugo

[0] https://patchwork.kernel.org/patch/5742881/

--=20
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUFZhdgIWqBhwqCvuZYVUZx9w0DQFAlxgGQkACgkQZYVUZx9w
0DR6cwgAq6NolHrnUG6fKSya+UIevGUn9SRgSjYwuJDSgiYxkZo4wpszsfOJG/Sh
kFrIW/BDZgUsRRGeKnIbc4hGQAckyq7fVHwahDS2O3H+DxawYflW3JABsTEntMkt
yFuZrtv7C9Epfl2sEDrndx9RhywggGbEy4oQagl6zIa4ZWGOTwScp8oDJ2enxXaf
FM8PDxi+MYHaT4JxdiEIo4F9sFD6WTaYRg5/hsHmTcAJvHkkjdCcx/6i7MavBvgm
OnwZi0jgB4zuW26vQxNU0CZ0fF11cmLr0506Oo3eBwNaAtIgR9S0ziCrCRVY+rLK
3y3dRFEUf6vxK/m6ms50tHeF21c/vw==
=3YFR
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
