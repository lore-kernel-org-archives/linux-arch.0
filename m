Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268349AbUIKVHE@vger.kernel.org>
Received: from natnoddy.rzone.de ([81.169.145.166]:33693 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S268342AbUIKVHE
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 11 Sep 2004 17:07:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] cleanup: move call to update_process_times.
Date: Sat, 11 Sep 2004 23:06:17 +0200
References: <20040910151900.GA3645@mschwid3.boeblingen.de.ibm.com>
In-Reply-To: <20040910151900.GA3645@mschwid3.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_Nj2QBwif7fxK9V8";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409112306.21776.arnd@arndb.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--Boundary-02=_Nj2QBwif7fxK9V8
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Freitag, 10. September 2004 17:19, Martin Schwidefsky wrote:
> [PATCH] cleanup: remove unused definitions from timex.h.
>=20
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
>=20
> The CLOCK_TICK_FACTOR and FINETUNE defines from <asm/timex.h>
> are not used anywhere. Kill them.
>=20
The patch doesn't match the subject, it looks like you accidentally
sent the 'remove unused definitions from timex.h' patch twice
instead of 'move call to update_process_times'.

	Arnd <><

--Boundary-02=_Nj2QBwif7fxK9V8
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBQ2jN5t5GS2LDRf4RAiG+AJ9i5m1wFgZbMsrlPl3BAcJajkX1LwCfT1e/
vGnkAwLC4SkDawh6qhw4J+s=
=I3uo
-----END PGP SIGNATURE-----

--Boundary-02=_Nj2QBwif7fxK9V8--
