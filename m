Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40686 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934310AbeEIIkP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2018 04:40:15 -0400
Date: Wed, 9 May 2018 17:39:51 +0900
From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/5] regulator: add dummy function
 of_find_regulator_by_node
Message-ID: <20180509083951.GV13402@sirena.org.uk>
References: <1525566016-30172-1-git-send-email-changbin.du@intel.com>
 <1525566016-30172-3-git-send-email-changbin.du@intel.com>
 <20180509082114.GQ13402@sirena.org.uk>
 <20180509081341.ahx7xuqs366gmqaf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udzYTtuEmHLUHegf"
Content-Disposition: inline
In-Reply-To: <20180509081341.ahx7xuqs366gmqaf@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org, rostedt@goodmis.org, rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180509083951.DcJIqDHfkZUCVHLYpacelf0avKVUAs1sT1UDD_TqXJY@z>


--udzYTtuEmHLUHegf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2018 at 04:13:42PM +0800, Du, Changbin wrote:
> On Wed, May 09, 2018 at 05:21:14PM +0900, Mark Brown wrote:

> > Please do not submit new versions of already applied patches, please
> > submit incremental updates to the existing code.  Modifying existing
> > commits creates problems for other users building on top of those
> > commits so it's best practice to only change pubished git commits if
> > absolutely essential.

> Hmm, I saw your merging notification too late. Let me refresh the series. Sorry
> for confusing.

No problem, just wanted to make sure I wasn't missing any updates from
this new version.

--udzYTtuEmHLUHegf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrys9YACgkQJNaLcl1U
h9DCCAf/VP6rHeYQnotzPDF2V8drlbz4lnUv8HqZlc3BYUzCICzPWc5VAfEmVymP
AzhWSBahraHfBfN4rfb/CGrmLNscjKn8zqrGZnoBARM1oloAKZiohRnHQVrrYJZ2
g4cmTgQaXCv2+FdyEc4zr97eeM33gPQoWoIeOC+pO2Fmk+zSAfudKEvtwxCbLE+U
Lx4xNH9F8CatF2VxaZuPwUfKCOh6e7uZJmHFac97NQeEYsOb95M7HKah1A77wolW
VNvqqomOOWiztnqgd3pqGCABA/i+DwTQY+p6K+y+S43KT8zux/79x2aZgqSs/njQ
9A4q/dG1CRplf7issZr/s1plZW0Tfg==
=hROQ
-----END PGP SIGNATURE-----

--udzYTtuEmHLUHegf--
