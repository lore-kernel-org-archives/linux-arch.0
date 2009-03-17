From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Microblaze arch merging
Date: Tue, 17 Mar 2009 23:26:52 +1100
Message-ID: <20090317232652.8fe9dc30.sfr@canb.auug.org.au>
References: <49BF66EA.9030101@petalogix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__17_Mar_2009_23_26_52_+1100_40MP9NSbUau766cZ"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <49BF66EA.9030101@petalogix.com>
Sender: linux-next-owner@vger.kernel.org
To: michal.simek@petalogix.com
Cc: linux-next@vger.kernel.org, lkml <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

--Signature=_Tue__17_Mar_2009_23_26_52_+1100_40MP9NSbUau766cZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Tue, 17 Mar 2009 10:01:30 +0100 Michal Simek <michal.simek@petalogix.com=
> wrote:
>
> We have ready git server for pushing too.
> What is the best way for you? Code based on current linus-head on based
> on linux-next?

All trees included in linux-next should be based on Linus' tree (unless
there is a good reason for a dependency on another tree).

What I tell everyone: all patches/commits in the tree/series must
have been:

	posted to a relevant mailing list
	reviewed
	unit tested
	destined for the next merge window (or the current release)

*before* they are included.  The linux-next tree is for integration
testing and to lower the impact of conflicts between subsystems in the
next merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__17_Mar_2009_23_26_52_+1100_40MP9NSbUau766cZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkm/lwwACgkQjjKRsyhoI8xjvwCfevYdKr2ChJXCDrWZU/iesOnh
an0AoIJTAJ1MBrQRJp2i7pz8vGFIUe1k
=0mtc
-----END PGP SIGNATURE-----

--Signature=_Tue__17_Mar_2009_23_26_52_+1100_40MP9NSbUau766cZ--
