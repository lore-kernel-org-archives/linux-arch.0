Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269470AbUIRND6@vger.kernel.org>
Received: from natsmtp00.rzone.de ([81.169.145.165]:18887 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S269464AbUIRND6
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 18 Sep 2004 09:03:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: waitid fallout
Date: Sat, 18 Sep 2004 15:03:03 +0200
References: <200409150534.i8F5YeCF011453@magilla.sf.frob.com>
In-Reply-To: <200409150534.i8F5YeCF011453@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_KIDTBkwsopm7zMD";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409181503.07369.arnd@arndb.de>
To: Roland McGrath <roland@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Richard Henderson <rth@twiddle.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--Boundary-02=_KIDTBkwsopm7zMD
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mittwoch, 15. September 2004 07:34, Roland McGrath wrote:

> If we were to take it back out, then it
> would make more sense to have the system call be like SGI's waitsys that
> takes the waitid args plus a struct rusage *. =20

I just noticed it's changed in BK now. However, the respective
changes in the compat_sys_waitid() code and include/linux/syscalls.h
are still missing.

Also, why did you put the compat code in arch/* and not in
kernel/compat.c? Converting siginfo_t should probably remain
architecture specific, but the rest should be the same everywhere.

	Arnd <><

--Boundary-02=_KIDTBkwsopm7zMD
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBTDIK5t5GS2LDRf4RAgh6AJ0fOdiDUqLA6IY/oC+DNcGijYtcYACgmdoq
JtoL6A/FfMyO1GmyIrk1tME=
=kyda
-----END PGP SIGNATURE-----

--Boundary-02=_KIDTBkwsopm7zMD--
