From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC] remove linux/hardirq.h from asm-generic/local.h
Date: Wed, 17 Dec 2008 12:42:14 +1100
Message-ID: <20081217124214.3033bdf3.sfr@canb.auug.org.au>
References: <20081214133941.GA18035@flint.arm.linux.org.uk>
	<20081214095803.9d16e85f.akpm@linux-foundation.org>
	<20081214195116.GB11223@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__17_Dec_2008_12_42_14_+1100_OCr=2B99n1avZvRO"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:59308 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbYLQBm3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Dec 2008 20:42:29 -0500
In-Reply-To: <20081214195116.GB11223@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

--Signature=_Wed__17_Dec_2008_12_42_14_+1100_OCr=2B99n1avZvRO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Russell,

On Sun, 14 Dec 2008 19:51:16 +0000 Russell King <rmk+lkml@arm.linux.org.uk>=
 wrote:
>
> Thanks, I've committed to my git tree the addition of linux/hardirq.h to
> those two files I mentioned above.  I guess at some point you'll pick
> those up to prevent build errors on ARM?

Andrew will (presumably) get these through linux-next (which he bases the
mm trees on).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__17_Dec_2008_12_42_14_+1100_OCr=2B99n1avZvRO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklIWPYACgkQjjKRsyhoI8ybpwCfZJ18zseEcWO3ZBreAD7LPOZJ
CScAoIWXRk/sy0GH4aIBi7L6uqahbtrv
=djXG
-----END PGP SIGNATURE-----

--Signature=_Wed__17_Dec_2008_12_42_14_+1100_OCr=2B99n1avZvRO--
