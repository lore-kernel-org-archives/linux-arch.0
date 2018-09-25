From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Subject: [x86] BUG()/BUG_ON() macros cannot be disabled
Date: Tue, 25 Sep 2018 13:35:29 +0200
Message-ID: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="beyh2CM9IKZjJUog9ZIi56j5rFrMc4SBz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--beyh2CM9IKZjJUog9ZIi56j5rFrMc4SBz
Content-Type: multipart/mixed; boundary="ykzM58qJSbQVMj6jyweAtzezWrFi9csp4";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
Subject: [x86] BUG()/BUG_ON() macros cannot be disabled

--ykzM58qJSbQVMj6jyweAtzezWrFi9csp4
Content-Type: multipart/mixed;
 boundary="------------5E0CA33CC47A8D6B0687C66A"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5E0CA33CC47A8D6B0687C66A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

I recently tried to disable the BUG macros on x86-32. I disabled the
config item in 'General Setup -> Configure standard kernel features
(expert users) -> BUG() support'.
However, BUG/BUG_ON is still defined. In the !CONFIG_BUG branch in
include/asm-generic/bug.h (line 181) the code checks for the existence
of architecture-specific variants of those macros.
Since x86 defines its own version of BUG(), line 182 is *not* used.
In the following, the x86 variant of BUG() is then used to define the
BUG_ON() macro.

I propose a patch that really disables both macros if the developer
wants it.
It undefines the respective x86 variants, and defines both macros as
'empty' macros.

Regards,
Alex

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al

--------------5E0CA33CC47A8D6B0687C66A
Content-Type: text/x-patch;
 name="disable-bug-macro.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="disable-bug-macro.patch"

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 20561a60db9c..1e7977582277 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -178,14 +178,17 @@ void __warn(const char *file, int line, void *calle=
r, unsigned taint,
 })
=20
 #else /* !CONFIG_BUG */
-#ifndef HAVE_ARCH_BUG
-#define BUG() do {} while (1)
+#ifdef HAVE_ARCH_BUG
+#undef BUG
 #endif
=20
-#ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (condition) BUG(); } while (0)
+#ifdef HAVE_ARCH_BUG_ON
+#undef BUG_ON
 #endif
=20
+#define BUG_ON(condition) do { if (condition) BUG(); } while (0)
+#define BUG() do {} while (1)
+
 #ifndef HAVE_ARCH_WARN_ON
 #define WARN_ON(condition) ({						\
 	int __ret_warn_on =3D !!(condition);				\

--------------5E0CA33CC47A8D6B0687C66A--

--ykzM58qJSbQVMj6jyweAtzezWrFi9csp4--

--beyh2CM9IKZjJUog9ZIi56j5rFrMc4SBz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAluqHYEACgkQWT7tBbw+
9v0zChAAliYhce/UyYMlH6hVIcK8eoehFisYKEz8wK5Rd8VGWxsXMTvVVeWaj/j2
q+Gu+ixJvdZHqlgOYDvce6arXBDKQXS4Yzf975gXAlk170+UVREBrREpihaKOsFk
1bvAZ9cUTLI1Btc/VyNS98Pd83XOBzyas7PNDsppKlPG/Z4fJAWRWHr9C8nJm+Vt
lSBL6I7E2ytbBHNQLLMSeo/W5z3VMfvAHEMdaGp9PG0A90UQEAu1OyR8OgwzjJYd
XRxuYSXUk/C5oT8syuIEOoUdpW7HPoTNeRQBzwcThgsj39N+f1hgPrw2SB3iqdr+
iy9vMAJfsQvImk1OQ7vYk7+HO0sDhjccF71M/G8tSN6m0kzWm7bsya+xk5dA659C
Mldev/vYT84tLR1GMjaMbNb1YubNIDPXHhUgVfojT589e0FswuEvBpdt+mUCrJ1i
68dnpEm2NStc94oq/jya8pw3MNQofJc9MkDoiDMZZW1jcKx1R4XPZDrj/IKTsTiw
Z+lXNkrk/w97beu7h8vBB9VcGSxZQaNaWoDMvg92m5R9Ad/GeVBGnwHTQ5YoDQUQ
l3SpJUFXsJ1Ii6nhAxRW1OCoHNEXzuh9fBJZ2vd0vBOGAD/3Cs3kQDOf7SctF28/
VdcjlS9v6vs0i5PpF1DAtAdqX2YRRrLGvI4tF2vT8u7RxcF0U9A=
=2Kut
-----END PGP SIGNATURE-----

--beyh2CM9IKZjJUog9ZIi56j5rFrMc4SBz--
