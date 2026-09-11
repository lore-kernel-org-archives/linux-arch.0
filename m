Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618ED2E92BA;
	Fri, 11 Sep 2026 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127019; cv=none; b=tsEQSuyPrPcG9n7sDpckJIKrm7J2zdf/SjHj1Xk+Mm+C6nuESRrcayXvGbmcioGYNRyMtM8LnmrsfIOPtpexyQe62GGFeLqkqUEcmrcBo0tudAXTlE0xu4DbvyxusSOBmgkf9LlHohBqG5tg1+pYY184NJImKv3+eMNp8DSY5TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127019; c=relaxed/simple;
	bh=e3YOIiwGt3cgjmHRWB+RtXrSlL305mlQvYlfAb1lp5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC+Bnr8NMc1zR41ybzGeD0x7GLBXPGLRlwN44V5/hLFmyUHGWZA7tfx642U9YNrTw5yqSeoPKEZ8RYAs+kNA+LOgHpOUb2QqvXJIAOoQTMXCXMHDRi25Xl1YPTuQiKZQOwFPeBcFZJER7pCp3eu6W8IoyhSctxUNug+HZx/GJTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGLQK1oI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGLQK1oI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1E91F000FF;
	Fri, 11 Sep 2026 11:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789127018;
	bh=+/EgM/tA+vXq24JmJMyx4qJZTVGVARPGFHT4/5zGdU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nGLQK1oIDgahtv16mUKFB6LsqT+q3DRPQTjQ1qvEebGKz4pt/xnKQsXn69ApZoV5w
	 ZzM44ewbyqCCgB3qBLIOz/EcdjuU9C9FgkegyAPU5DZf2nS8oAluI3v1Dy6b73bNUJ
	 d8vIvAnzEmsqe6ZDmbhEViL4JPnkk2AI8GdPWWa9bymOnfCjqejZCM+9YNdMY5CEDt
	 ZNKcrHsOCmpWtOOMeAR4wXD0OW5KpcSdszJngPoIR6MUFFVQjQ4j9pLY2a+izuMaWS
	 BLZLDewedS9Wnt4rJ8ptgUKCEyLqAdCLsx632Q7TP2cslLNHUwoKlWqIDje+3kRhs6
	 NH6AGDt7mUP6Q==
Date: Fri, 11 Sep 2026 13:43:35 +0200
From: Alejandro Colomar <alx@kernel.org>
To: astian <astian@memeware.net>
Cc: linux-man <linux-man@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arch@vger.kernel.org
Subject: Re: outb(2): terminology correction
Message-ID: <aqPpPQlEtyrIm42d@devuan>
References: <DL30FONT5B6G.1ETPJ04T023RU@memeware.net>
 <aqPmNKbqjBILjoqw@devuan>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b7jix4lwmaqlkmqt"
Content-Disposition: inline
In-Reply-To: <aqPmNKbqjBILjoqw@devuan>


--b7jix4lwmaqlkmqt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: astian <astian@memeware.net>
Cc: linux-man <linux-man@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arch@vger.kernel.org
Subject: Re: outb(2): terminology correction
Message-ID: <aqPpPQlEtyrIm42d@devuan>
References: <DL30FONT5B6G.1ETPJ04T023RU@memeware.net>
 <aqPmNKbqjBILjoqw@devuan>
MIME-Version: 1.0
In-Reply-To: <aqPmNKbqjBILjoqw@devuan>

> Date: 2026-09-11 13:36:29+0200
> From: Alejandro Colomar <alx@kernel.org>
>
> [CC +=3D GENERIC INCLUDE/ASM HEADER FILES maintainers]
>=20
> Hi astian, Arnd,
>=20
> > Date: 2026-08-31 09:09:46+0000
> > From: astian <astian@memeware.net>
> >
> > outb(2) says:
> >=20
> >   You must compile with -O or -O2 or similar.  The functions are defined
> >   as inline macros, and will not be substituted in without optimization
> >   enabled, causing unresolved references at link time.
> >=20
> > "inline macros [...] not substituted in without optimization" doesn't
> > make any sense.  C pre-processor macros cannot be inline or not inline.
> > Indeed these are inline *functions* (at least in this system) with
> > embedded assembly apparently referencing parameters (which, I surmise,
> > is why the functions need to be inlined by the compiler or the assembly
> > will not work).
> >=20
> > From /usr/include/x86_64-linux-gnu/sys/io.h (glibc 2.43):
> >=20
> >   [...]
> >   #if defined __GNUC__ && __GNUC__ >=3D 2
> >=20
> >   static __inline unsigned char
> >   inb (unsigned short int __port)
> >   {
> >     unsigned char _v;
> >=20
> >     __asm__ __volatile__ ("inb %w1,%0":"=3Da" (_v):"Nd" (__port));
> >     return _v;
> >   }
> >=20
> >   [...]
> >=20
> >   static __inline void
> >   outb (unsigned char __value, unsigned short int __port)
> >   {
> >     __asm__ __volatile__ ("outb %b0,%w1": :"a" (__value), "Nd" (__port)=
);
> >   }
> >=20
> >   [...]
> >=20
> > So I would say just s/inline macros/inline functions/g.
>=20
> Yes, 'inline functions' seems more appropriate than 'inline macros' (all
> macros are inlined, due to how the preprocessor works, so they'd be just
> macros, and as you showed, these are not even macros --except maybe in
> some architectures--).
>=20
> However, I doubt the entire paragraph.  I don't know why inline
> functions would produce unresolved references at link time _even if they
> were not substituted_.  The point of inline functions is that they are
> sometimes inlined, and sometimes not, and the compiler does the right
> thing in both cases.
>=20
> This seems like paranoia from decades ago, when inline functions were
> less known (and maybe compilers were more buggy than they are now).
>=20
> Arnd, should we remove the paragraph entirely?  Or is there any obscure
> reason why optimizations are required?

Or maybe those assembly instructions are what causes the linker issues?
If so, we should probably say something about that.


Cheers,
Alex

>=20
>=20
> Have a lovely day!
> Alex=20
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--b7jix4lwmaqlkmqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmqj6WYACgkQ64mZXMKQ
wqnD+hAArTjG5sTsS7pehGF4CDxQk0NbtPzQ3O6dG3h3Qe5z0dKjLeSv/5DwE1Be
y4UUD40IXErimRqkWOHYEWL5QSuk0BvsICM6Ibb59o082npIAOMLq26AwPQnrfuw
wn6+Zw7V9bdj/wYDScjd71weIOj6cK5AyGn91ZhS1f+hIwH3h8P33ssb/VxE75dC
x9FgnhgRrgkaEMq33DFkkQb2rBqSfEWNEWiZIFT44qis6slhIyK6qlBuvWnKU1oh
55uts6zes0St+VW4PKz3o9QBYMELTxtaTWDlbsBYiJ2dTIaw3PZukPdXwmQG5qxx
oXY12FTX54z5cAhsPhZTFT/VOvqAwyK5xXKJo9gaPJpKqL+V4Flv9RZhJKF0nmtI
4FwN8wQNV2xMvjLfFBX0JryvKy4ZJgm2h2mklVaD+IOsEJFFZQhvhlqlwC+LDbuH
ZR3pgXEA34OdTHAzHCpUyHKtnE+W+eauLHFb16v/sw6iE0ezPqUHGsIaKEnwaIBb
BKj4Oc87ExUcYuTlDPD5DnHh0nKU5zvop9juNtcKXhVB2DG1taZxNFq/uMPAZKOk
9E0Z4AO3Z5UETLGD6Zx6KdoyitNHIVCK33ubbs6IivywkmyaIKaN/I6w8EZnfvPb
zZfmtEkPE9tpjjErznebJUDBBo++Qn00EKsVkPbcsS2TIj0L9z4=
=zEs9
-----END PGP SIGNATURE-----

--b7jix4lwmaqlkmqt--
