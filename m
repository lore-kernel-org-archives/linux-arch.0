Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42014 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932781Ab2GCNrc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jul 2012 09:47:32 -0400
Date: Tue, 3 Jul 2012 14:47:30 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Message-ID: <20120703134729.GP29030@opensource.wolfsonmicro.com>
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120703114844.GJ29030@opensource.wolfsonmicro.com>
 <20120703220512.e03805948e31cfa90778d6c2@canb.auug.org.au>
 <201207031339.34369.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6iXXu7NwgEt9u5a7"
Content-Disposition: inline
In-Reply-To: <201207031339.34369.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, mturquette@ti.com, Russell King <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>
Message-ID: <20120703134730.rvzOCxvYoJG8phqYEBJZFAoCvwX11-_DXyRp7ipDZ94@z>


--6iXXu7NwgEt9u5a7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 03, 2012 at 01:39:34PM +0000, Arnd Bergmann wrote:

> Ok, let's do that then. What tree should we use for merging it?

> In theory I should take it to some asm-generic tree, but since
> I get very little traffic there, I'm usually happy to just provide
> an Ack and let anyone who needs the patch merge it through their
> trees.

I guess one of the clock trees which probably means Mike?

--6iXXu7NwgEt9u5a7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8vfFAAoJEBus8iNuMP3d6jYP/A2tuRA5AmjAepGUnjZA5DxD
Ggs+awXgHYcwHs0XWGT3e1POt9b713yBGKNZ/FGPQHOmS8d+HebsjoPoKHznau1u
LLlDt5mD2qg/ST/kNF7HtF4BtfPJy38h5CHRq5B8hbYu6zdpdayyZ3uE5vZp4Y4r
pokeLvs4wuskGnIHmxHOJAJTHcNgeZqDhoZRwIr699L6iuzos0I6GQZhuOzurOFZ
Unfgn3VAQ42ctKmuOj++RNbUweZPuJK7NbXd2Jm4EDSzeRAqbAB37Tc7nkVgo1eh
lmvfWLID6YZRGEPsOAeP+zDD7WqejAg+n6XtNLKcblvPhMOD4jLMspAha1UBk8Aq
5hqZ6kk3hCSV+/4+kncMTFjMAEz2yA88mvfaUA/ZwqR2N8npmB1QflWTHYpIIggL
yAqiHptfXQKa5OmE0E1mDa7GF0Xizf1Y/GbeTR7tMl/V5p4d0RwbWHy0SZRoDupW
42PPzucg5buH0B3rTQjQ8byW/rqxB0jKmFGOWGeQSB8XhlqOJ99XNVNMatPsyWb+
SYik8VjYK6PHQj4vCfyVrR4Uog+AAdzKmY7AQnKD6PPF6y2LHJMZQ3Cgeu01yUPy
x34743xPq1TEqzoqbLTS7xZMWzT3SSAGWKA3MADe//nsMNAmDD1JG9+lGQv6YRu3
Cy5j4vZaSynwu8aX8Trm
=LvgG
-----END PGP SIGNATURE-----

--6iXXu7NwgEt9u5a7--
