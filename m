Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 21 Jul 2005 17:05:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH, for review 1/3] compat_sys_{read,write}
Message-Id: <20050721170552.6ef403fb.sfr@canb.auug.org.au>
In-Reply-To: <20050701145642.6a3d6542.sfr@canb.auug.org.au>
References: <20050628181453.387e0fac.sfr@canb.auug.org.au>
	<20050628091704.GP4171@wotan.suse.de>
	<20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk>
	<20050628.134736.45885284.davem@davemloft.net>
	<20050629164127.58e97376.sfr@canb.auug.org.au>
	<20050629121228.GH21575@bragg.suse.de>
	<20050630175741.0fba8049.sfr@canb.auug.org.au>
	<20050630084255.GC13890@bragg.suse.de>
	<20050701003806.1de72653.sfr@canb.auug.org.au>
	<20050701012857.6b6de8f9.sfr@canb.auug.org.au>
	<20050630154904.GQ13890@bragg.suse.de>
	<20050701145642.6a3d6542.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__21_Jul_2005_17_05_52_+1000_HuMXG/Mo/xMoYbvh"
To: linux-arch@vger.kernel.org
Cc: ak@suse.de, davem@davemloft.net, matthew@wil.cx, hch@lst.de, akpm@osdl.org, paulus@samba.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Thu__21_Jul_2005_17_05_52_+1000_HuMXG/Mo/xMoYbvh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Jul 2005 14:56:42 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> This patch introduces compatibility syscalls for read and write and the
> equivalent hooks in struct file_operations.  These are neede to support
> the badly designed (i.e. broken) input layer evdev read and write
> interfaces.

Have you all come to some consensus on this issue?  Do I submit the
patches for compat_sys_read/write to Linus/Andrew?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__21_Jul_2005_17_05_52_+1000_HuMXG/Mo/xMoYbvh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC30lQFdBgD/zoJvwRAt3aAJ0UWq+tEofK/8Gi6vyK/XO7GR3p6gCeL9ZH
fQmXarZKCYr5d2ySsWYG7MY=
=mp/A
-----END PGP SIGNATURE-----

--Signature=_Thu__21_Jul_2005_17_05_52_+1000_HuMXG/Mo/xMoYbvh--
