Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 5 Apr 2005 18:01:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] consolidate shmat usage
Message-Id: <20050405180132.15e386cd.sfr@canb.auug.org.au>
In-Reply-To: <20050323145132.GJ21986@parcelfarce.linux.theplanet.co.uk>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au>
	<20050323174810.17df4440.sfr@canb.auug.org.au>
	<20050323145132.GJ21986@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__5_Apr_2005_18_01_32_+1000_RA4pNoUf+k+SSsM6"
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Tue__5_Apr_2005_18_01_32_+1000_RA4pNoUf+k+SSsM6
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Mar 2005 14:51:32 +0000 Matthew Wilcox <matthew@wil.cx> wrote:
>
> > I am eventually aiming at consolidating (as much as possible of)
> > sys_ipc and doing compat_sys_ipc.
>=20
> Great, but please remember not all architectures have a sys_ipc (looks
> like alpha, ia64, parisc and x86_64 according to a fairly recent version
> of glibc).

Yes, I understand that.

> I don't see the need for a wrapper function in sys_parisc.c -- would
> make sense to just call the sys_shmatcall() directly.  I suspect the
> same goes for Alpha's osf_shmat() function.

I agree, I was just doing minimal changes first.

> I dislike the naming here.  The manpage for shmat is the three-argument
> version.  The only reason we have the four-argument version is because
> of the silly sys_ipc multiplexer.  So I think sys_shmat() should be
> the three-argument form and we should rename the existing sys_shmat()
> to something like ipc_shmat().  Does it need to be asmlinkage?

OK, I have changed sys_shmat to sys_shmat4 and sys_shmatcall to sys_shmat.
There are some architectures that use each of these directly as system
calls.

New version in following email.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__5_Apr_2005_18_01_32_+1000_RA4pNoUf+k+SSsM6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCUkXc4CJfqux9a+8RAjJLAJ4hw50jtByPfpET1n+q8KdN/bYt4wCeJt5T
qW6hIwBCfdHh/91DB4Ot/ug=
=/dSC
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Apr_2005_18_01_32_+1000_RA4pNoUf+k+SSsM6--
