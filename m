Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262847AbUKRSOF@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45734 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261856AbUKRSMV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Nov 2004 13:12:21 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.10/8.12.9) with ESMTP id iAIICHMW731916
	for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2004 13:12:17 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id iAIICDCP250396
	for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2004 13:12:17 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id iAIICDDO019237
	for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2004 13:12:13 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch] sys_stime needs a compat function.
Date: Thu, 18 Nov 2004 19:06:47 +0100
References: <20041118173416.GA8360@mschwid3.boeblingen.de.ibm.com>
In-Reply-To: <20041118173416.GA8360@mschwid3.boeblingen.de.ibm.com>
MIME-Version: 1.0
Message-Id: <200411181906.47591.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_3SOnB+ri95OolIW";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--Boundary-02=_3SOnB+ri95OolIW
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dunnersdag 18 November 2004 18:34, Martin Schwidefsky wrote:
>  ia64 doesn't support sys_stime

I'd call that a bug, too.

> and ppc64 has its own sys_stime functions.

This one is identical to the generic sys_stime function (despite the
comment above it), so it should be merged as well.

> +
> +#ifdef __ARCH_WANT_SYS_TIME
> +
> +/*
> + * sys_stime() can be implemented in user-level using
> + * sys_settimeofday().  Is this for backwards compatibility?  If so,
> + * why not move it into the appropriate arch directory (for those
> + * architectures that need it).
> + */
> +=20
> +asmlinkage long compat_sys_stime(compat_time_t __user *tptr)

I'd prefer having an extra __ARCH_WANT_COMPAT_SYS_TIME flag. Mips, x86_64,
ia64 and s390 only need compat_sys_stime, but not sys_stime for 64 bit
kernels.
Also, the comment you copied from sys_stime is apparently superceded by
introduction of __ARCH_WANT_XYZ.

	Arnd <><

--Boundary-02=_3SOnB+ri95OolIW
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBnOS35t5GS2LDRf4RAvMDAJ0ZfXEuPQLhCzbEliNOl5Q1cLP78wCgmWvy
TJUTRTtLeaTtn3+REon5GJ4=
=Kkgq
-----END PGP SIGNATURE-----

--Boundary-02=_3SOnB+ri95OolIW--
