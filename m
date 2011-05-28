From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 1/1] Add new syscall sys_sendmmsg to generic unistd
Date: Sat, 28 May 2011 23:55:46 +0200
Message-ID: <1306619746.3001.977.camel@localhost>
References: <1306613969-9426-1-git-send-email-jonas.bonn@gmail.com>
	 <201105282324.31818.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-18Ag8dEXj/tp/wquGaGm"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.southpole.se ([193.12.106.18]:47804 "EHLO
	mail.southpole.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755581Ab1E1WRO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 28 May 2011 18:17:14 -0400
In-Reply-To: <201105282324.31818.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org



--=-18Ag8dEXj/tp/wquGaGm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2011-05-28 at 23:24 +0200, Arnd Bergmann wrote:
> I just saw your git tree for the OpenRISC architecture port and it
> looks really really nice, mostly by virtue of being very small, but
> also by not copying all the things that new architecture ports normally
> get wrong at the time when they show up on my radar.

> Do you plan to submit it upstream any time soon?

Yes, it's pretty much ready for submission.  There are a couple of areas
that I'm aware of that still need some work and there are some cleanups
to do, but everything that faces userspace (ABI) has settled so it's
stuff that could be done even after merging upstream.

What would be the best approach to request review?  I saw that the
unicore32 architecture was posted in 'functional/subsystem' chunks... is
that the best way to do it?  Shall I do the same, or do you have a
suggestion for a better way to do it?

/Jonas

--=-18Ag8dEXj/tp/wquGaGm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk3hb1oACgkQ70gcjN2673Op0ACfeLfDDe1tafgUTSIMFrS4TdbF
Ka4An01CR91qS1HCEFrd3LBSC69ELKPa
=it/K
-----END PGP SIGNATURE-----

--=-18Ag8dEXj/tp/wquGaGm--
