From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 1/1] Add new syscall sys_sendmmsg to generic unistd
Date: Sun, 29 May 2011 23:30:24 +0200
Message-ID: <1306704624.3001.1206.camel@localhost>
References: <1306613969-9426-1-git-send-email-jonas.bonn@gmail.com>
	 <201105282324.31818.arnd@arndb.de> <1306619746.3001.977.camel@localhost>
	 <201105292027.10350.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-YJzZNHynJKMSlwvEkefl"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.southpole.se ([193.12.106.18]:46063 "EHLO
	mail.southpole.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859Ab1E2Vam (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 29 May 2011 17:30:42 -0400
In-Reply-To: <201105292027.10350.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org



--=-YJzZNHynJKMSlwvEkefl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2011-05-29 at 20:27 +0200, Arnd Bergmann wrote:
> Yes, that is the best way. At first, leave out any device driver changes,
> and submit only the code you need to have something that boots. Split
> that up into around 15 patches, e.g.
>=20
>  <snip>

Thanks for the thorough instructions... much appreciated.
I'll see if I can get this sorted out during this week.

>=20
> * remove all __ARCH_WANT_* from asm/unistd.h and use the generic glibc
>   implementation.

I tried this earlier but ran into issues with uClibc, which is the only
libc port that we currently have.  Is uClibc known to be compatible with
the reduced set of syscalls?

A good compromise here may be to submit the patch upstream with the
reduced set of syscalls but to maintain a separate tree locally that
reenables these for use with our current uClibc port until we can get it
straightened out.  It would be good to know, however, what's known to be
working for others in this area...

>=20
> * Figure out what the dma-mapping implementation should look like.
>   It seems to me that you just copied from microblaze but didn't
>   completely understand what you need. We can definitely help you here
>   if you can explain how DMA works on openrisc. In doubt, don't
>   set CONFIG_HAS_DMA and use asm-generic/dma-mapping-broken.h.
>=20

Yes, exactly... this was on the TODO list of cleanups.  I'll admit that
I was confused by this code so I may be asking for some help in this
area.

/Jonas

--=-YJzZNHynJKMSlwvEkefl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk3iuusACgkQ70gcjN2673ORSwCfao695R2Qf7smWlaSdizb3bjF
YVEAoKmnJ148BYJhL012oxizMlxt4FQ+
=w+CR
-----END PGP SIGNATURE-----

--=-YJzZNHynJKMSlwvEkefl--
