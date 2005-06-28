Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 29 Jun 2005 02:34:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: RFC: is_compat_task (Was: Re: input compat stuff)
Message-Id: <20050629023455.5e2ef856.sfr@canb.auug.org.au>
In-Reply-To: <20050628161414.GP8035@wotan.suse.de>
References: <20050628072710.GA29916@lst.de>
	<20050628181453.387e0fac.sfr@canb.auug.org.au>
	<20050628091704.GP4171@wotan.suse.de>
	<20050629020944.1af20657.sfr@canb.auug.org.au>
	<20050628161414.GP8035@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__29_Jun_2005_02_34_55_+1000_Acnld7N=CXCOZdJ1"
To: Andi Kleen <ak@suse.de>
Cc: hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Wed__29_Jun_2005_02_34_55_+1000_Acnld7N=CXCOZdJ1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jun 2005 18:14:14 +0200 Andi Kleen <ak@suse.de> wrote:
>
> No, you're defining an arch specific macro to tell you that
> the current process was loaded from a 32bit executable.
> It does not tell you anything how the kernel was entered.
>=20
> Subtle but important difference.

Thats why my patch was just an example implementation (that happens to
work for us currently).

> The right thing to do is what all the other non broken compat
> functions do - figure out from the original system call entry
> point if you're in compat context or not.
>=20
> This typically requires a special path.

At least up to the point that you can flag it for further processing (see
the socket control message processing code).

We still have the signal delivery problem - a 32 bit binary running on
ppc64 needs the correct signal stack etc set up for it.  I guess most of
the 64bit arches have the equivalent of

        if (test_thread_flag(TIF_32BIT))
                return do_signal32(oldset, regs);

in do_signal().

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__29_Jun_2005_02_34_55_+1000_Acnld7N=CXCOZdJ1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCwXwvFdBgD/zoJvwRApl4AJ4p6i8PdcP04BiG9u2ewk1ZIf0CTACgnpq2
tuEt1Y+uzeygVMreUpE08yk=
=StBa
-----END PGP SIGNATURE-----

--Signature=_Wed__29_Jun_2005_02_34_55_+1000_Acnld7N=CXCOZdJ1--
