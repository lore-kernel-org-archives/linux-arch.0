Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:60147 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbXIJBRl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 9 Sep 2007 21:17:41 -0400
Date: Mon, 10 Sep 2007 11:17:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: kbuild: enable possibility to specify xFLAGS on commandline
Message-Id: <20070910111720.dbd4f68f.sfr@canb.auug.org.au>
In-Reply-To: <214e7ea7cfce67dca284414d82062854@kernel.crashing.org>
References: <20070909180254.GA20086@uranus.ravnborg.org>
	<214e7ea7cfce67dca284414d82062854@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__10_Sep_2007_11_17_20_+1000_UH1kmdb+M7El9AMh"
Sender: linux-arch-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andi Kleen <ak@suse.de>, linux arch <linux-arch@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, kbuild devel <kbuild-devel@lists.sourceforge.net>
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Mon__10_Sep_2007_11_17_20_+1000_UH1kmdb+M7El9AMh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Sep 2007 20:26:16 +0200 Segher Boessenkool <segher@kernel.crashin=
g.org> wrote:
>
> powerpc uses
>=20
> 	KBUILD_DEFCONFIG :=3D $(shell uname -m)_defconfig
>=20
> to automagically pick the defconfig you want, but that obviously
> doesn't work for cross-builds.
>=20
> pmac32_defconfig and pseries_defconfig are probably used the most,
> you might want to test with one of those next time.

As someone else said, ppc64_defconfig would be better as that builds all
the 64 bit platforms.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__10_Sep_2007_11_17_20_+1000_UH1kmdb+M7El9AMh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFG5JsrTgG2atn1QN8RAuQKAJ0RDmm1o1p5jxQg6G0WIt3j0By7SQCVFgQw
nLnqH1ErtJBy9MZVCPj3CA==
=HzcL
-----END PGP SIGNATURE-----

--Signature=_Mon__10_Sep_2007_11_17_20_+1000_UH1kmdb+M7El9AMh--
