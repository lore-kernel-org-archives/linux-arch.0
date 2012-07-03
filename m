From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Date: Tue, 3 Jul 2012 22:05:12 +1000
Message-ID: <20120703220512.e03805948e31cfa90778d6c2@canb.auug.org.au>
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20120703120059.f153bd696269528be2baa1bc@canb.auug.org.au>
	<20120703101209.GH29030@opensource.wolfsonmicro.com>
	<201207031116.05876.arnd@arndb.de>
	<20120703114844.GJ29030@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__3_Jul_2012_22_05_12_+1000_zoTtojHe.nL5y0CC"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from haggis.pcug.org.au ([203.10.76.10]:35107 "EHLO
	members.tip.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab2GCMFW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jul 2012 08:05:22 -0400
In-Reply-To: <20120703114844.GJ29030@opensource.wolfsonmicro.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, mturquette@ti.com, Russell King <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>

--Signature=_Tue__3_Jul_2012_22_05_12_+1000_zoTtojHe.nL5y0CC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, 3 Jul 2012 12:48:44 +0100 Mark Brown <broonie@opensource.wolfsonmic=
ro.com> wrote:
>
> > I would definitely prefer being able to just write=20
>=20
> > generic-y +=3D clkdev.h=20
>=20
> I agree but I don't see this as something that should block having the
> facility.  Or if it does I guess I'll need to try to either fix clkdev
> to use the arch include optionally or go round all the architectures
> either of which is going to be needlessly painful.

True.

> > Maybe Michal Marek or someone on the kbuild mailing list can help
> > out with a solution for that.
>=20
> We could do that incrementally...

Yes, indeed it should be a separate change.

> The reason I'm doing this is that the lack of a widely available clock
> API is a considerable pain point for a lot of the stuff I work on and
> this is the major blocker to just enabling the default implementation on
> architectures that don't support it already which would be a big step
> forwards.

Agreed.  Please submit this patch and we can concentrate on this other
stuff later.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__3_Jul_2012_22_05_12_+1000_zoTtojHe.nL5y0CC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJP8t/4AAoJEECxmPOUX5FEVggP/0LHFP9mSzqlAsTmHhxFT6uE
zOG9w9XhLKCTJi/CoJNgSK+Ta4HPD5KMsa16bOeYiIQgQ0dqT48zfmCJIdYYPCbP
k24qOUueNPuRdQSE7BqwR+Mx5sMK0Ix1/AyQN3RKWEr+a3HdXtIr1ifqU1Itz6ih
s1sxyf4LsHgoEvCDlWg3lzs3FW0PLve1WUKcmbrIrxi5zLskQXPdwhJreakbsKHq
lmZBonqOkWvAl0dILZN5/NdGO7McBNelvHBoLYXOPhZ6xcWVEhBSeWrnr8JmFmmV
tAvpq7lp91ZhBBZ6vcEboAJLNslLG+w+7bJ0LvbZMliQbw3wFyk0+4hUvkC36FpS
Tyang0XXhJ/oqHovd2Yb5rleHqiWrrmCYRCYhmYDe6EPViQZnVy+DLJ1SeH7bwrv
GXId6v2uXdW+xtFQiFhLjwvxFku1cSM0O3i/vtvorC1m/dtZmBa39AwQd+RvYvl4
sKK9o4OOY696x1Vn8ak7IM6WaAD4gwXiRMey2cyr1R6aNrurWbk8/48xzjXDL//w
9GWQ8ejF/8drEH0+iMsjq7sP7BmWSYRLf+nEh/XRRdKBXcOPobL0fAP7cIB7LCOe
wsVOUe5WkiVXm+akhzZI3J3BoG6adC6BXEn73s5g9DSZXmyiwZDzsBP/3ClWIUc0
R+kIZmnAYZ3zMmOoTe08
=ZHIN
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Jul_2012_22_05_12_+1000_zoTtojHe.nL5y0CC--
