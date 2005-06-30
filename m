Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 1 Jul 2005 01:28:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: RFC: is_compat_task
Message-Id: <20050701012857.6b6de8f9.sfr@canb.auug.org.au>
In-Reply-To: <20050701003806.1de72653.sfr@canb.auug.org.au>
References: <20050628181453.387e0fac.sfr@canb.auug.org.au>
	<20050628091704.GP4171@wotan.suse.de>
	<20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk>
	<20050628.134736.45885284.davem@davemloft.net>
	<20050629164127.58e97376.sfr@canb.auug.org.au>
	<20050629121228.GH21575@bragg.suse.de>
	<20050630175741.0fba8049.sfr@canb.auug.org.au>
	<20050630084255.GC13890@bragg.suse.de>
	<20050701003806.1de72653.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__1_Jul_2005_01_28_57_+1000_5HQzDnjoSziZ/L9X"
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ak@suse.de, davem@davemloft.net, matthew@wil.cx, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Fri__1_Jul_2005_01_28_57_+1000_5HQzDnjoSziZ/L9X
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Jul 2005 00:38:06 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Like below?  I am not sure that this is better as we duplicate the code
> that selects the write_func ...

This is seeming like a lot of infrastructure change (I did the read
version as well) for a single (badly done) API.  How about we go with
is_compat_syscall() for 2.6.13 and revisit the VFS changes after that?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__1_Jul_2005_01_28_57_+1000_5HQzDnjoSziZ/L9X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxA+/FdBgD/zoJvwRAuG/AJ9TX1pxeHgWrtzvO6ztjJ5ACtLsEwCfaJ+a
kQnds8+uTRD/9zS1TCcdvfs=
=83r+
-----END PGP SIGNATURE-----

--Signature=_Fri__1_Jul_2005_01_28_57_+1000_5HQzDnjoSziZ/L9X--
