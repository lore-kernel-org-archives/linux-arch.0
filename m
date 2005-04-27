Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 28 Apr 2005 00:36:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] consolidate sys_shmat
Message-Id: <20050428003658.53d0b2ac.sfr@canb.auug.org.au>
In-Reply-To: <20050427125015.GU30431@linux-mips.org>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au>
	<20050323174810.17df4440.sfr@canb.auug.org.au>
	<20050323145132.GJ21986@parcelfarce.linux.theplanet.co.uk>
	<20050405180132.15e386cd.sfr@canb.auug.org.au>
	<20050405130312.GC16157@parcelfarce.linux.theplanet.co.uk>
	<20050427162709.6851e14b.sfr@canb.auug.org.au>
	<20050427125015.GU30431@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__28_Apr_2005_00_36_58_+1000_QsW9L0xqLiph7DCV"
To: Ralf Baechle <ralf@linux-mips.org>
Cc: matthew@wil.cx, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Thu__28_Apr_2005_00_36_58_+1000_QsW9L0xqLiph7DCV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Apr 2005 13:50:15 +0100 Ralf Baechle <ralf@linux-mips.org> wrote:
>
> On Wed, Apr 27, 2005 at 04:27:09PM +1000, Stephen Rothwell wrote:
>=20
> > I have minimised this patch a bit.  It now just consolidates sys_shmat =
and
> > in doing so, "fixes" the ABIs for MIPS(64) and ARM.  ARM glibc does not
> > use the sys_shmnat syscall directly so far (as far as I can see) and on
> > MIPS64, the ABI that glibc seems to expect (I am pretty much guessing) =
is
> > the fixed one.
>=20
> Correct, so the patch is looking ok.

Good, thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__28_Apr_2005_00_36_58_+1000_QsW9L0xqLiph7DCV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCb6OQ4CJfqux9a+8RAup/AJ9YNPQuJizs8o4dCTdxQhMLkfhiPgCfT1rw
m6c3BvqDXZZn4LuCjcOFmq0=
=Zokf
-----END PGP SIGNATURE-----

--Signature=_Thu__28_Apr_2005_00_36_58_+1000_QsW9L0xqLiph7DCV--
