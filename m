From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: build warning after merge of the vfs tree
Date: Mon, 14 May 2018 10:56:32 +1000
Message-ID: <20180514105632.391d0cd0@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/T9vX==h=pKIziTO00Q7NwWc"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Linux-Arch Mailing List <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

--Sig_/T9vX==h=pKIziTO00Q7NwWc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs tree, today's linux-next build (arm
multi_v7_defconfig and others) produced this warning:

<stdin>:1332:2: warning: #warning syscall io_pgetevents not implemented [-W=
cpp]

Introduced by commit

  7a074e96dee6 ("aio: implement io_pgetevents")

Just a heads up to all the other architectures.

--=20
Cheers,
Stephen Rothwell

--Sig_/T9vX==h=pKIziTO00Q7NwWc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr43sAACgkQAVBC80lX
0Gzv6wf/bmoWQVU3UNpEDBsJO9RwHJ2ARTojpLq1gPyuAoaCEvL8UygF5G+Iuc+t
8vf33Zu/rHSPiXjNY1Dx+t3YlJwfRMJ4lUz+0M9AvQDkQsH80bUhfmcQRx6DJboP
fxNIE3tZXIXhaiH47Ani/QZBFmiDeMiSpRrLEfPM9qEssHnrG5jzWY5qiTHZ94EX
s4gE1AvbJ2UXiUtvxqXNEe36/vkJjiOEcE+7Gh3NYwTlvaX6M5rTUCC7wsP19Xbm
8fmyBtSTM0ADcYdP5S/CW9VntoA3SqJrT4LS0IFKL/9zQ+XY7825N3QJuemlKnBH
WoRq+vpm1yqWH8W02W0q8H7DuOfPFA==
=y+25
-----END PGP SIGNATURE-----

--Sig_/T9vX==h=pKIziTO00Q7NwWc--
