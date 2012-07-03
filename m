Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from haggis.pcug.org.au ([203.10.76.10]:53645 "EHLO
	members.tip.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab2GCNQF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jul 2012 09:16:05 -0400
Date: Tue, 3 Jul 2012 23:15:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Message-ID: <20120703231555.b675da0eb648cbb2c7fecf41@canb.auug.org.au>
In-Reply-To: <20120703123322.GK29030@opensource.wolfsonmicro.com>
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20120703120059.f153bd696269528be2baa1bc@canb.auug.org.au>
	<20120703101209.GH29030@opensource.wolfsonmicro.com>
	<201207031116.05876.arnd@arndb.de>
	<20120703114844.GJ29030@opensource.wolfsonmicro.com>
	<20120703220512.e03805948e31cfa90778d6c2@canb.auug.org.au>
	<20120703123322.GK29030@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__3_Jul_2012_23_15_55_+1000_3EQJHF_IRzMjNmQ1"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, mturquette@ti.com, Russell King <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>
Message-ID: <20120703131555._IgSgeWK3WYqjyc2Gks5a2BbK1g5QV_rbYaYcahPwz0@z>

--Signature=_Tue__3_Jul_2012_23_15_55_+1000_3EQJHF_IRzMjNmQ1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, 3 Jul 2012 13:33:22 +0100 Mark Brown <broonie@opensource.wolfsonmic=
ro.com> wrote:
>
> On Tue, Jul 03, 2012 at 10:05:12PM +1000, Stephen Rothwell wrote:
> > On Tue, 3 Jul 2012 12:48:44 +0100 Mark Brown <broonie@opensource.wolfso=
nmicro.com> wrote:
>=20
> > > The reason I'm doing this is that the lack of a widely available clock
> > > API is a considerable pain point for a lot of the stuff I work on and
> > > this is the major blocker to just enabling the default implementation=
 on
> > > architectures that don't support it already which would be a big step
> > > forwards.
>=20
> > Agreed.  Please submit this patch and we can concentrate on this other
> > stuff later.
>=20
> Perhaps if you give me a couple of hours...

Sorry, I wasn't meaning to rush you, just agreeing that the two things
are separate.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__3_Jul_2012_23_15_55_+1000_3EQJHF_IRzMjNmQ1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJP8vCLAAoJEECxmPOUX5FEyFIP+QFb9J0lZ9Is6pg0fvwB2HK6
Xi3afBV/rhX5qCwQff48tLHHOG6N5cPxx26JDyhmGxfEDP6qHva24WHBZpPxKM6M
GdS10RY/K0AP+6QCi+0/skeu6pkoQWIPEXOKOrnQV/d+GrnETHOUplWx45jtmwD1
RQcGMK7BtvAW3A/FpXxDHn39Bca8nyv6kEWOyYBPIPVw02gYF+SVW0cyJ/FzDYTB
j46t4MuD+B98GjzrxXycy9cv54StFCMWx57jTvGAoyhfqZ+ymD10UrmDRGaK4bhR
3AAAb1ZQ/ORmYNfokhpP+1HW5hKJg+b4KgFrNL4towHa1zC/zW3GDOLwZe2mHxwp
jUlK3ZBRynEtNh2pnT9lnb6FYEwXguRQZpKVTG1K70/95TblEW6rmSLhmXHPYO+A
5Yw5+qIi7MGY1k4L05sHtJmTdKFP5ROG8mRveGl606eyqonUTkG1oVQnWNAqx1I/
oN3XIyawAKrO330F5LLOOHR7uViOZfyrJbEl1I2gIRFZNxyKvzfCShL7xxkGxhT7
62CvdvTqg4CMPAhSRqr1N1gPUeos12584rXLlvZ2KCE6lLzgto5jiNayXAaGlos2
tibngbcFWlzw9Zk35tBtOh259IO3mxjDs/FqeQdSOgeKKGRLtGl30ENNLiYW5iiT
/cfDyRenFZnVg0+1lw0r
=iVRk
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Jul_2012_23_15_55_+1000_3EQJHF_IRzMjNmQ1--
