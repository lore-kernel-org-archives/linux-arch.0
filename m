Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327AB44780F;
	Fri, 11 Sep 2026 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126591; cv=none; b=MiQgDRQtRiZ9pLYBjwLWJN2CMZvkkSVlAdwBxCois+YOULna3yQ5sUJeTiL1me0e8UgyMtsPSGfKfMF1qmK2n8Dm5RH4TQMSeOhFt0YlEcuiX3mrSUOQ57ZS8iVGsDOXHWOY9dZq9Ju6Q/DQ5Z5jtACFqODzyPvVnbvnKzCEum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126591; c=relaxed/simple;
	bh=+qMKPziVfnt8c6WfBGKva66n05dt49W+4h7uHkDbGLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqlQDYDbZ1nAyAik+18PekwKkkTuqhJbSudw3NfYke8jDYDEdtMvSfzEvibbaLNta2keEb911FCCZewBcesQNtkVy7bJlOma81nMTUuicmdwGhdVTMx9QiumO4sdAd4Pd5YOLBnFoUmjcYiFUJ3TIbJ1o/nOFywQ+xXMAsZ981k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFJ9fDLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFJ9fDLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72FA1F000FF;
	Fri, 11 Sep 2026 11:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789126589;
	bh=AQU6MWJbRrhREm5QDygJms8/XqL/d2LFpfFIMzUS2Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WFJ9fDLFfExcrcsOi01Azg7y+L2qnUf73SY1fmYUk2LGghPJrjb76xE0D4TF6IXBV
	 G4PxXK0muB3d8E2Tdr1/YWdhUeFxFBknjL0M/X41D0xazM1XGCO4rSAVKsoy3iQbBt
	 FfUiZwyUowTnMh2nVnZGrGctmxsqUjqTqhBIvMEZx6zmRHnb3cQy9ttcqksUhMGAVs
	 h0R1CrsWwA7A9UzkEodI+ZDVwYI9WK/xWdOSt1KJo30G49cMorWJjcWVFi9qwuCRUF
	 qnKW7iOxpTTzMjRyidVN12I+QIK4VK45CAq/zRUsMF1XzqzwTBBivpiSYSXv9xwhBl
	 NWIphGwJ9/Atg==
Date: Fri, 11 Sep 2026 13:36:26 +0200
From: Alejandro Colomar <alx@kernel.org>
To: astian <astian@memeware.net>
Cc: linux-man <linux-man@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arch@vger.kernel.org
Subject: Re: outb(2): terminology correction
Message-ID: <aqPmNKbqjBILjoqw@devuan>
References: <DL30FONT5B6G.1ETPJ04T023RU@memeware.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eu7bcqr4hwqoophm"
Content-Disposition: inline
In-Reply-To: <DL30FONT5B6G.1ETPJ04T023RU@memeware.net>


--eu7bcqr4hwqoophm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: astian <astian@memeware.net>
Cc: linux-man <linux-man@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arch@vger.kernel.org
Subject: Re: outb(2): terminology correction
Message-ID: <aqPmNKbqjBILjoqw@devuan>
References: <DL30FONT5B6G.1ETPJ04T023RU@memeware.net>
MIME-Version: 1.0
In-Reply-To: <DL30FONT5B6G.1ETPJ04T023RU@memeware.net>

[CC +=3D GENERIC INCLUDE/ASM HEADER FILES maintainers]

Hi astian, Arnd,

> Date: 2026-08-31 09:09:46+0000
> From: astian <astian@memeware.net>
>
> outb(2) says:
>=20
>   You must compile with -O or -O2 or similar.  The functions are defined
>   as inline macros, and will not be substituted in without optimization
>   enabled, causing unresolved references at link time.
>=20
> "inline macros [...] not substituted in without optimization" doesn't
> make any sense.  C pre-processor macros cannot be inline or not inline.
> Indeed these are inline *functions* (at least in this system) with
> embedded assembly apparently referencing parameters (which, I surmise,
> is why the functions need to be inlined by the compiler or the assembly
> will not work).
>=20
> From /usr/include/x86_64-linux-gnu/sys/io.h (glibc 2.43):
>=20
>   [...]
>   #if defined __GNUC__ && __GNUC__ >=3D 2
>=20
>   static __inline unsigned char
>   inb (unsigned short int __port)
>   {
>     unsigned char _v;
>=20
>     __asm__ __volatile__ ("inb %w1,%0":"=3Da" (_v):"Nd" (__port));
>     return _v;
>   }
>=20
>   [...]
>=20
>   static __inline void
>   outb (unsigned char __value, unsigned short int __port)
>   {
>     __asm__ __volatile__ ("outb %b0,%w1": :"a" (__value), "Nd" (__port));
>   }
>=20
>   [...]
>=20
> So I would say just s/inline macros/inline functions/g.

Yes, 'inline functions' seems more appropriate than 'inline macros' (all
macros are inlined, due to how the preprocessor works, so they'd be just
macros, and as you showed, these are not even macros --except maybe in
some architectures--).

However, I doubt the entire paragraph.  I don't know why inline
functions would produce unresolved references at link time _even if they
were not substituted_.  The point of inline functions is that they are
sometimes inlined, and sometimes not, and the compiler does the right
thing in both cases.

This seems like paranoia from decades ago, when inline functions were
less known (and maybe compilers were more buggy than they are now).

Arnd, should we remove the paragraph entirely?  Or is there any obscure
reason why optimizations are required?


Have a lovely day!
Alex=20

--=20
<https://www.alejandro-colomar.es>

--eu7bcqr4hwqoophm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmqj57EACgkQ64mZXMKQ
wqnfuA/5ATYh1GqbR0ESbOWRXNIRo++ceelL3P+WLa9UUFoad4OCn1jZmptqp7V6
aUF4U+SVdfLFSuYC/xCa+i+Y5Hq7SOX3ybFRNqbKECTXSzrW9Wa6IuXuxHCyUdSh
M87zj/l0jnPeucdKn8XDetqiEQmVGIOiP4AmI+dPHh5/uWGnx06T5TEFatIR4is/
AsfsFinrLc6SgWpOIYNFywqY4ccXK9un1iIYKva8fxXW/GmiA+MjZdiXSsZyNP8f
hS939LzSnvm6rRqLF6+fnw9gbqTIKGcifuQuMwgxLJz/y+BZ5RqSaLlX9AMNnq4H
EphIKQyG1TGPtc+psDVikavx1kq9s7oMDbSBYLlpQDLvRKTM/tuKn7po/GdVGMqH
JA2meWJ7aD8GUkmzG1XdTAiFP2+lZ3KxbKjv1R8GEdhTVOL2GfGKyrz42BM7djLH
F/bX7D8ZgbuCcF90kUWsV5HKuKlstNQNof3FGxds0TtJ5VWK7vfFu5jXbomS9oU7
vX5OV5xf7A3HPOE9UOHMQkWW15Ajecz2EaTiVAxlYiMHcjSxgZK/78iEd9g0hotS
A3d/saj+pOpEVq546FaIk5bNHoAMdkotYHCBjUOUG0uR4WksZvPOnk8TJ1kSMw/J
dYrP2CU/wMoCVUrTUj528IvglPUEKPadXX+ruSK91sLOFUwPa7I=
=0FlB
-----END PGP SIGNATURE-----

--eu7bcqr4hwqoophm--
