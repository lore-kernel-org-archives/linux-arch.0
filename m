Return-Path: <arnd@arndb.de>
Received: from natsmtp00.rzone.de ([81.169.145.165]:19404 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S264966AbUGANDM
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Jul 2004 09:03:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: compat_sys_adjtimex
Date: Thu, 1 Jul 2004 15:02:09 +0200
References: <40E30E8F.3000601@intel.com> <16611.20590.297525.314297@cargo.ozlabs.ibm.com> <40E362D6.7010908@intel.com>
In-Reply-To: <40E362D6.7010908@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_VtA5Ax5aRf04h1g";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407011502.14131.arnd@arndb.de>
To: Arun Sharma <arun.sharma@intel.com>
Cc: Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--Boundary-02=_VtA5Ax5aRf04h1g
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Donnerstag, 1. Juli 2004 03:03, Arun Sharma wrote:
>=20
> +struct compat_timex {
> +=A0=A0=A0=A0=A0=A0=A0u32 modes;
> +=A0=A0=A0=A0=A0=A0=A0s32 offset, freq, maxerror, esterror;
> +=A0=A0=A0=A0=A0=A0=A0s32 status, constant, precision, tolerance;
> +=A0=A0=A0=A0=A0=A0=A0struct compat_timeval time;
> +=A0=A0=A0=A0=A0=A0=A0s32 tick;
> +=A0=A0=A0=A0=A0=A0=A0s32 ppsfreq, jitter, shift, stabil;
> +=A0=A0=A0=A0=A0=A0=A0s32 jitcnt, calcnt, errcnt, stbcnt;
> +=A0=A0=A0=A0=A0=A0=A0s32 =A0:32; s32 =A0:32; s32 =A0:32; s32 =A0:32;
> +=A0=A0=A0=A0=A0=A0=A0s32 =A0:32; s32 =A0:32; s32 =A0:32; s32 =A0:32;
> +=A0=A0=A0=A0=A0=A0=A0s32 =A0:32; s32 =A0:32; s32 =A0:32; s32 =A0:32;
> +};
> +

I'd personally prefer to use type names like compat_ulong_t
in the place of u32 when the a member in the original struct
is unsigned long.

> +asmlinkage long compat_sys_adjtimex(struct compat_timex *utp)
> +
This is missing a semicolon.

I had done my own version of compat_sys_adjtimex and most of
the other sys32_* functions that are worth consolidating some time
ago. Unfortunately I never got around to bringing them into a
proper patch for for submission. Would you like to have my code
so you can finish it?
As an alternative approach I can prepare patches that simply
add the compat_sys_* functions and leave it to each arch maintainer
to remove their own versions.

	Arnd <><

--Boundary-02=_VtA5Ax5aRf04h1g
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA5AtV5t5GS2LDRf4RAmshAKCYktkOHWN73w2tO/pkH8GDYunuUgCdFna7
KFQ5u9ykt917zwjV6vw+6B0=
=ZS0S
-----END PGP SIGNATURE-----

--Boundary-02=_VtA5Ax5aRf04h1g--
