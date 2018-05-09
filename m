Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37878 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933805AbeEIIVs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2018 04:21:48 -0400
Date: Wed, 9 May 2018 17:21:14 +0900
From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/5] regulator: add dummy function
 of_find_regulator_by_node
Message-ID: <20180509082114.GQ13402@sirena.org.uk>
References: <1525566016-30172-1-git-send-email-changbin.du@intel.com>
 <1525566016-30172-3-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EkxpYdHiqGHPYbUt"
Content-Disposition: inline
In-Reply-To: <1525566016-30172-3-git-send-email-changbin.du@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: changbin.du@intel.com
Cc: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org, rostedt@goodmis.org, rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180509082114.Kn2BPSx42eRx-oOhIfCHobq5dfLQ1HBPjKwJkT_ZS1E@z>


--EkxpYdHiqGHPYbUt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 08:20:13AM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
>=20
> If device tree is not enabled, of_find_regulator_by_node() should have
> a dummy function since the function call is still there.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--EkxpYdHiqGHPYbUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlryr3kACgkQJNaLcl1U
h9Cf1Qf/VZXV2l+LOlO9wC/dYLfOubi56ydHPoYZE4BS7u5oWeD5QkXCJHO2HBYd
hdPcuUgmVFyhllxpd6b44kSgYP70DoyxZ0ijsXZ4bEgg76pGKz9Fl8vhJ2EGmoeW
3LCZ6ESiYwFPoDs3dtIpiOpzVxghMHSqUvQeFEwzLvP08r5fzTmDTUUhXUrY/9f+
5bG/l+YkEXqo05FKp85vs+EA4ck1GPqZWT+eNQUHqNuARGUNvvG1OHQIYk9BewC0
vXPe8+U98hjHjRpQWWIZJr0rrh17am9+y4H+HHxjUHlh/KxVjeDuz2g6w6k3Chrw
r0j4nYeUdcc/WoCxu+jv5Jerhn2TBQ==
=MKwt
-----END PGP SIGNATURE-----

--EkxpYdHiqGHPYbUt--
