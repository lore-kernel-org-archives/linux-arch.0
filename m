Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 25 Feb 2005 15:29:50 +0200
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] set_pte() part 1 (was Re: [PATCH] ppc32: Wrong vaddr in flush_hash_one_pte())
Message-ID: <20050225132950.GA28014@linux-sh.org>
References: <1109145729.5412.213.camel@gaston> <20050223161138.00d8205f.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20050223161138.00d8205f.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 23, 2005 at 04:11:38PM -0800, David S. Miller wrote:
> I've been over this a few times this afternoon and the patch looks
> correct.  Please test the build and boot of your platform, any build
> failures should be trivial typos and nothing major.
>=20
This works fine for sh and sh64 too.

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCHyhO1K+teJFxZ9wRApOmAJ9rSmoi882rh4OQhuRXpep9KnsBkQCeP9vX
ikVcE6Alwk98x5JVgavfD7w=
=RpZO
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
