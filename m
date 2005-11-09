Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Nov 2005 16:40:04 +0200
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: irq-type-flags.patch
Message-ID: <20051109144004.GA25926@linux-sh.org>
References: <20051108191057.09f57114.akpm@osdl.org> <20051109133023.GD17992@linux-sh.org> <20051109134932.GB27540@parisc-linux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20051109134932.GB27540@parisc-linux.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 09, 2005 at 06:49:32AM -0700, Matthew Wilcox wrote:
> On Wed, Nov 09, 2005 at 03:30:23PM +0200, Paul Mundt wrote:
> > > +#define SA_TRIGGER_LOW		0x00000004
> > > +#define SA_TRIGGER_RISING	0x00000002
> > > +#define SA_TRIGGER_FALLING	0x00000001
> > It probably makes sense to move SA_TRIGGER here as well, as it's going =
to
> > be a pretty common mask. Otherwise everyone that plans to make use of
> > this will likely end up duplicating it.
>=20
> Are there any other architectures that plan to make use of this?

SH will at least to some extent. There's some older SH-3's that could
benefit from this (we currently have some ugly hacks in place to handle
the edge cases for some of these legacy devices on these systems, but
it's pretty broken at the moment). The newer cores don't have a lot of
use for this though.

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDcgpE1K+teJFxZ9wRAjkfAJ44ItTwfTixtMOSdnN5/G2f2i1vJACfYwQ3
WPAE+Sqx2a9KsLq1YPhwhM8=
=S6EA
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
