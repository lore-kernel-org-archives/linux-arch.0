Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 7 Apr 2005 15:14:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] consolidate shmat usage
Message-Id: <20050407151442.3f845205.sfr@canb.auug.org.au>
In-Reply-To: <20050407010501.1631e14f.sfr@canb.auug.org.au>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au>
	<20050323174810.17df4440.sfr@canb.auug.org.au>
	<20050323145132.GJ21986@parcelfarce.linux.theplanet.co.uk>
	<20050405180132.15e386cd.sfr@canb.auug.org.au>
	<20050405130312.GC16157@parcelfarce.linux.theplanet.co.uk>
	<20050407010501.1631e14f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__7_Apr_2005_15_14_42_+1000__LEO.6m7AOIFJNsf"
To: linux-arch@vger.kernel.org
Cc: matthew@wil.cx, rmk@arm.linux.org.uk, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Thu__7_Apr_2005_15_14_42_+1000__LEO.6m7AOIFJNsf
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Apr 2005 01:05:01 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Tue, 5 Apr 2005 14:03:12 +0100 Matthew Wilcox <matthew@wil.cx> wrote:
> >
> > Umm.  I think you've just discovered a bug in ARM and MIPS.  I don't see
> > any code in glibc for handling the 4-argument version of sys_shmat.
> > Russell, Ralf, could you comment?
>=20
> OK, assuming that using the 4 argument version of sys_shmat as a system
> call, here is another version of the patch (not tested) for comment.

I have now built that patch on ppc64, i386 and x86_64 with and without
CONFIG_SYSVIPC and booted it on ppc64.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__7_Apr_2005_15_14_42_+1000__LEO.6m7AOIFJNsf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCVMHH4CJfqux9a+8RAijmAJ4zMf29x9lqGclPl9ZRnYiTm0HXrACcDwmw
+KEcKoKHzFyma2i7dthcrq0=
=J9Zz
-----END PGP SIGNATURE-----

--Signature=_Thu__7_Apr_2005_15_14_42_+1000__LEO.6m7AOIFJNsf--
