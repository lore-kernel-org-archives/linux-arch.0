Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 24 Mar 2005 11:30:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] consolidate asm/ipc.h
Message-Id: <20050324113046.1d1a54a6.sfr@canb.auug.org.au>
In-Reply-To: <20050323080644.GA6760@wotan.suse.de>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au>
	<20050323080644.GA6760@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__24_Mar_2005_11_30_46_+1100_rr9HkFpB7zjiLZe9"
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Thu__24_Mar_2005_11_30_46_+1100_rr9HkFpB7zjiLZe9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Mar 2005 09:06:44 +0100 Andi Kleen <ak@suse.de> wrote:
>
> > diff -ruN linus/include/asm-x86_64/ipc.h linus-compat_sys_ipc.1/include=
/asm-x86_64/ipc.h
> > --- linus/include/asm-x86_64/ipc.h	2002-10-17 23:29:20.000000000 +1000
> > +++ linus-compat_sys_ipc.1/include/asm-x86_64/ipc.h	1970-01-01 10:00:00=
.000000000 +1000
> > @@ -1,6 +0,0 @@
> > -#ifndef __x8664_IPC_H__
> > -#define __x8664_IPC_H__
> > -
> > -/* dummy */
> > -
> > -#endif
>=20
> The dummy was originally put in because someone actually included it.
> That was in 2.4 days of course.

I removed the only places in x86_64 that included it.

> Can you do a allyesconfig build on x86-64 just to make sure it still buil=
ds?

As well as ever I suspect :-)

  BUILD   arch/x86_64/boot/bzImage
Root device is (8, 5)
Boot sector 512 bytes.
Setup is 5422 bytes.
System is 11506 kB
System is too big. Try using modules.
make[1]: *** [arch/x86_64/boot/bzImage] Error 1
make: *** [bzImage] Error 2

but the vmlinux has built ok (I am impressed - 214MB vmlinux :-)).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

P.S. I did notice this warning in particular:

arch/x86_64/lib/bitops.c:18: warning: `find_first_zero_bit' declared inline=
 after being called

--Signature=_Thu__24_Mar_2005_11_30_46_+1100_rr9HkFpB7zjiLZe9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCQgo24CJfqux9a+8RAn/mAJ9KbAttTLxVM2HFSnnCTI4JUvmJtACeLFay
lmT0t0iw3ajVqKKJ0lSy9L0=
=0wtI
-----END PGP SIGNATURE-----

--Signature=_Thu__24_Mar_2005_11_30_46_+1100_rr9HkFpB7zjiLZe9--
