Return-Path: <arnd@arndb.de>
Received: from natsmtp00.rzone.de ([81.169.145.165]:28862 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S264034AbUFKPLD
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Jun 2004 11:11:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: sys getdents64 needs compat wrapper ?
Date: Fri, 11 Jun 2004 17:09:34 +0200
References: <26879984$108508699040ad1d0eba5381.88033699@config20.schlund.de> <20040604172816.259f38e8.davem@redhat.com> <40C4DA5E.8090700@intel.com>
In-Reply-To: <40C4DA5E.8090700@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_vscyAdioANU083D";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406111709.35146.arnd@arndb.de>
To: Arun Sharma <arun.sharma@intel.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--Boundary-02=_vscyAdioANU083D
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On maanantai 07 kes=E4kuu 2004 23:13, Arun Sharma wrote:
> This updated patch takes care of the __user problems that Dave
> pointed out. Regarding __put_user vs __copy_to_user, __put_user
> is more optimal on ia64 like Andrew already noted. I realize it's
> not optimal on all platforms. So I suggest that we apply the=20
> patch for now and try to build something that's optimal for all
> platforms in the future.    =20

> +=A0=A0=A0=A0=A0=A0=A0if (dirent) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if ((__put_user(offset, (u3=
2 __user *)&dirent->d_off))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 || (__put_user(offset >> 3=
2, ((u32 __user *)&dirent->d_off) + 1)))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0got=
o efault;
> +=A0=A0=A0=A0=A0=A0=A0}

I just realized your code is broken on big-endian architectures, so
we should either get back to __copy_to_user or find the optimal solution
now.

How about a {__,}{get,put}_user_unaligned() that gets defined per
architecture in one of these two ways:

/* put_user doesn't care about alignment */
#define put_user_unaligned(x,ptr) put_user(x,ptr)

/* put_user only works on aligned data */
#define put_user_unaligned(x,ptr) ({ \
	__typeof__(*(ptr)) __x =3D (x); \
	copy_to_user(ptr, &__x, sizeof(*(ptr))) ? -EFAULT : 0; \
})

	Arnd <><

--Boundary-02=_vscyAdioANU083D
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAycsv5t5GS2LDRf4RAlJ0AJ0ZcELFu2F8jS+2HZEJLK5Y28DaBgCcDI2i
ujvd/Z0J1ZoTEVf3+kir3qo=
=pg+C
-----END PGP SIGNATURE-----

--Boundary-02=_vscyAdioANU083D--
