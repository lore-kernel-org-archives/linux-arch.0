From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: OF files
Date: Mon, 5 May 2008 10:14:06 +1000
Message-ID: <20080505101406.a0993afc.sfr@canb.auug.org.au>
References: <5257.8247-18740-1017760922-1209828638@seznam.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__5_May_2008_10_14_06_+1000_xq9zJ+vWz3cqsInr"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:56320 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752772AbYEEAOO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 4 May 2008 20:14:14 -0400
In-Reply-To: <5257.8247-18740-1017760922-1209828638@seznam.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <Monstr@seznam.cz>
Cc: Arnd Bergmann <arnd@arndb.de>, John Williams <john.williams@petalogix.com>, Matthew Wilcox <matthew@wil.cx>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, John Linn <John.Linn@xilinx.com>, Ulrich Drepper <drepper@redhat.com>, paulus@samba.org

--Signature=_Mon__5_May_2008_10_14_06_+1000_xq9zJ+vWz3cqsInr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Sat, 03 May 2008 17:30:41 +0200 (CEST) Michal Simek <Monstr@seznam.cz> w=
rote:
>
> Hi Paulus and others,
>=20
> I tested OF files changes. I sent you some patches about.
>=20
> I look at headers files too. Is it possible to move prom.h, of_device.h
> and of_platform.h to asm-generic or linux folder?=20

We already have include/linux/of_{device,platform}.h. prom.h is mostly
powerpc specific - you should either create your own prom.h, or suggest
stuff that needs to be moved into linux/of.h.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__5_May_2008_10_14_06_+1000_xq9zJ+vWz3cqsInr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIHlFTTgG2atn1QN8RAk/IAJ96tNQd+u3tf65EXT/PcIHc+27waACgk0+s
lADVemRtNNF8c+QtUJxEDkc=
=Py1/
-----END PGP SIGNATURE-----

--Signature=_Mon__5_May_2008_10_14_06_+1000_xq9zJ+vWz3cqsInr--
