Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FFD372691;
	Sat, 12 Sep 2026 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789251005; cv=none; b=Z8OB9kmbDiqhrwVRmh2oNU5AwuD6VDijt2gs0Qfxx/7QzIzRMDtHLxFaPdXui41J+cVsDhLFqTJ6/+DOB1LczeTcQwRy2OT7LIjX3MFQQt4MSl01q+vMnYXGV0hsNLfH+2lgfJJ8CEK/Lt6Ma5lTx2ctOGmWEgcxIJ7O6cd9h2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789251005; c=relaxed/simple;
	bh=SX1hZjzmYPaZSWp9Fj08OOTlpfhY0F08YMWHEdU/Hjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/ieWXJHPUgO3l8bfPhk2Ch5lDDDOG1avuZedUauEyNLkeseuaR6FdmXMF35d4u58DPCjl852vi99EOAusvPMCPqzZ1+v6S5tIzSru++tRCTuGMyAW4RU5uQbSRM7b07y2LTeDHDmGY3Eq9r0d8nnLMDILfYF5lMWLOIgCuy7hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcmQ8WF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcmQ8WF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237EF1F000FF;
	Sat, 12 Sep 2026 22:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789251003;
	bh=UiQmtbNHXTX6DxeJ3CSlfjwZMgJtMc33BKSDGJvfKlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NcmQ8WF+NTXPv4xGimWA0+ROZqDMY2u9S10pQehZ7cMVxuU1VW7VteQm2b5H6zAet
	 kwz6Y6wWaGvNvq+BzISNYOouE0mxaK9924XCxJ4IXy0XTiUynJjAhXqbU8ePJ+zk/A
	 E+brzqFg4zLdCiboHir53DxLvXBWarTtLdjY90uCqNdEM3zxfacv+7xN+67FwhDlrz
	 lcOz01hsykUXQy7ezbTIfwqQgpz/yjl4PrczlVEy+qAW9SxJiYWhwEtMOpFYW00GIq
	 SBmzDjMpIylGK+SA3NElUM+VcZ8/foKuGxqPfwqy76ltNbomw/jowTJ3b3WTxIfxmK
	 vEZscnAE2Qgeg==
Date: Sun, 13 Sep 2026 00:09:59 +0200
From: Alejandro Colomar <alx@kernel.org>
To: astian <astian@memeware.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Andreas Jaeger <aj@suse.de>, 
	linux-man <linux-man@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: outb(2): terminology correction
Message-ID: <aqXNK3qkcOZNwWOZ@devuan>
References: <DL30FONT5B6G.1ETPJ04T023RU@memeware.net>
 <aqPmNKbqjBILjoqw@devuan>
 <b6258140-1ece-4113-bcb4-025302ef59cc@app.fastmail.com>
 <DLDOAQWX9IIH.E1ZNJ3O80VQ@memeware.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qkilby5ylueyqgll"
Content-Disposition: inline
In-Reply-To: <DLDOAQWX9IIH.E1ZNJ3O80VQ@memeware.net>


--qkilby5ylueyqgll
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: astian <astian@memeware.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Andreas Jaeger <aj@suse.de>, 
	linux-man <linux-man@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: outb(2): terminology correction
Message-ID: <aqXNK3qkcOZNwWOZ@devuan>
References: <DL30FONT5B6G.1ETPJ04T023RU@memeware.net>
 <aqPmNKbqjBILjoqw@devuan>
 <b6258140-1ece-4113-bcb4-025302ef59cc@app.fastmail.com>
 <DLDOAQWX9IIH.E1ZNJ3O80VQ@memeware.net>
MIME-Version: 1.0
In-Reply-To: <DLDOAQWX9IIH.E1ZNJ3O80VQ@memeware.net>

Hi astian,

> Date: 2026-09-12 21:58:26+0000
> From: astian <astian@memeware.net>
>
[...]
> >> Arnd, should we remove the paragraph entirely?  Or is there any obscure
> >> reason why optimizations are required?
> >
> > Or maybe those assembly instructions are what causes the linker issues?
> > If so, we should probably say something about that.
>=20
> I had a closer look and I now think that's not the case.  These
> instructions work fine even if the function is not inlined.  See more
> below.

Thanks!

> On 11 Sep 2026 14:20 +0200, Arnd Bergmann wrote:
[...]
> > Using 'extern __inline' without optimization in --std=3Dgnu89 would lea=
d to
> > the compiler using an 'extern' reference rather than emitting a static
> > version,
>=20
> This seems to be the original reason for the optimisation requirement.

Agree.

> The manual says [0]:
>=20
>   GCC does not inline any functions when not optimizing unless you
>   specify the =E2=80=98always_inline=E2=80=99 attribute for the function =
[...]
>=20
>   [...]
>=20
>   If you specify both inline and extern in the function definition, then
>   the definition is used only for inlining.  In no case is the function
>   compiled on its own, not even if you refer to its address explicitly.
>   Such an address becomes an external reference, as if you had only
>   declared the function, and had not defined it.
>=20
>   This combination of inline and extern has almost the effect of a
>   macro. [...]
>=20
>   0: https://gcc.gnu.org/onlinedocs/gcc/Inline.html
>=20
> Thus, using "extern inline" but not enabling optimisations (and not
> providing a separate definition in some other object) would have
> produced a linker error.

Indeed.

> > the 'static __inline' variant works as intended in both gnu
> > and standard c99.
>=20
> That "__inline" keyword (yes, it's a keyword, regardless of eponymous
> macros) is odd.  Apparently an old non-standard import from MSVC.
>=20
> Are standard/newer keywords (inline/__inline__) not used for reasons of
> backward compatibility (with old compiler or C language versions)?

Yes, glibc needs to be compatible with C89, which doesn't have 'inline'.
Since users of C89 could be defining 'inline' for anything, glibc has to
use something in the implementation namespace.


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--qkilby5ylueyqgll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmqlzbEACgkQ64mZXMKQ
wqm9+hAAkG+t+GYoNt2EegfuK+h2e5Gd7vg1ZfPlhKU+TywLdamDqlSwKOaf0v3B
jevC2HVGWF5DDhkdf3PPbG8cgeDO9qDGrJ6v8ak9J4mnjOAGGJPX0tWFyGYXQQDw
Kt7PV+mwMvP84PnvFKvYDpeWfVYoe9Hp09s+lPOwzUj6SjFnEgR/yqR03ZKYYZDf
9MYtM+gk+Y3d8xC6YeZ7tmjaBRf1wHE4vczuzfv6M91KpmKp0HMh4nZjvNnMqoDK
M8VeowJrIoTxYbnsDEWufq1w0eQGs7usqsYpgdlWnKZ/FD0f+MdAAZ99GN91zUYb
Vjv7N7MohxCl3FcWpoIetrNquMQLl30a3GPIwNDXIy/v0J0XaxoUR09ti2ivrMLi
49wGOicwlyYWyHt5wdRNYCRpD1ZFFKmunYyPZz9iByGOLqGYBAgYPGkOaKgjUnKQ
CJoYN08iJlw49OHFktd39NmRYIz563Rez9Zha5NLo8mKBtWKkzwr5DV4HV07qUlw
3cuk22avcmHYks0owLWqfDM2dlrd1sZQcxdk2wogwOmWJqwYep9CRL2Uk8AjijiN
WmXQpOPy0+mBsZirMBHqf2jwDTgAIgopPNC5UyOD1i71GKSk4BMaiSX2UurJj6V2
ptL87IP6yBHNg5kxArCYbF31lac/Yk4K/X6sEj3QBuWJRp2lQ9I=
=+csA
-----END PGP SIGNATURE-----

--qkilby5ylueyqgll--
