Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59818 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbeEAUlL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 May 2018 16:41:11 -0400
Date: Wed, 2 May 2018 05:40:36 +0900
From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] regulator: add dummy of_find_regulator_by_node
Message-ID: <20180501204033.GB2714@sirena.org.uk>
References: <1525179614-14571-1-git-send-email-changbin.du@intel.com>
 <1525179614-14571-3-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <1525179614-14571-3-git-send-email-changbin.du@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: changbin.du@intel.com
Cc: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org, x86@kernel.org, lgirdwood@gmail.com, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180501204036.qHAXXRv0TcgltFRISGrubad6MsllOASipt-gFdV4vp0@z>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 01, 2018 at 09:00:11PM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
>=20
> If device tree is not enabled, of_find_regulator_by_node() should have
> a dummy function since the function call is still there.
>=20
> Signed-off-by: Changbin Du <changbin.du@intel.com>

This appears to have no obvious connection with the cover letter for the
series...  The first question here is if this is something best fixed
with a stub or by fixing the users - is the lack of a stub pointing out
some bugs in them?  I'm a bit worried about how we've been managing to
avoid any build test issues here though, surely the various builders
would have spotted a problem?

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlro0L0ACgkQJNaLcl1U
h9CscQf/fCFHs4Y+wOz7y7A8Oi1kYWKHd3GMzcQmKVje+1f40XdgSBRI5bJvdiO1
NbLfwcMa0x6JlpGNOqrvGSnxBDSg/VD7i2CIBM4zTcmMRebaOu8pjSAuMQTtOY30
sL2Y+sWxdV+jhrptwIwESPrsc212Mf/rHKKrdgHOSjtwZyCVKBipShRpjcSfWy2p
6vwUb7searqTv8clBseUgAyZl7SIL/RouXyZIg6cE9/FGa5euhrkMZLkpSzYEj7+
iM+T12lhL357JISouoqQWJ6irOQTQ/0ZfUIhk3/NcFzCbP1lqsiHMQpwBl09Ttbd
ztKHAW9dCLbZGJAQHLdL8iXZRVsgEw==
=k9wt
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
