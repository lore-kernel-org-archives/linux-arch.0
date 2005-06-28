Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 29 Jun 2005 02:09:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: RFC: is_compat_task (Was: Re: input compat stuff)
Message-Id: <20050629020944.1af20657.sfr@canb.auug.org.au>
In-Reply-To: <20050628091704.GP4171@wotan.suse.de>
References: <20050628072710.GA29916@lst.de>
	<20050628181453.387e0fac.sfr@canb.auug.org.au>
	<20050628091704.GP4171@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__29_Jun_2005_02_09_44_+1000_/7FjOzzZpI+uKGZm"
To: Andi Kleen <ak@suse.de>
Cc: hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Wed__29_Jun_2005_02_09_44_+1000_/7FjOzzZpI+uKGZm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jun 2005 11:17:04 +0200 Andi Kleen <ak@suse.de> wrote:
>
> On Tue, Jun 28, 2005 at 06:14:53PM +1000, Stephen Rothwell wrote:
> > On Tue, 28 Jun 2005 09:27:10 +0200 Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > besides this beeing butt ugly didn't we have a rule about never check=
ing
> > > task flags whether we're a compat process?  And if we're going to all=
ow
> > > it it should be done properly.
> >=20
> > So, I have been thinking about this patch for a while (wondering how ba=
dly
> > flamed I would get when I posted it :-)).  What do you all think?  Is t=
his
> > a reasonable thing to do?
>=20
> No, it's not because it makes it impossible to have 64bit processes
> that run with 32bit ABI (not implemented right now but we don't
> want to break that).

Why does this make it impossible?  All I am defining is *arch specific*
macros that tell us if the kernel was entered through a compat syscall. If
your arch needs something other than my *examples*, then you are free to
define it.

> Please don't do this. It is absolutely the wrong thing to do.

Then please tell us what the right thing to do is.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__29_Jun_2005_02_09_44_+1000_/7FjOzzZpI+uKGZm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCwXZOFdBgD/zoJvwRAvMXAJ4tUPIq2l4q+NgVMboAe22/4vzghgCfbU1W
rMTDy6UeZGFFxQ/lLNqNYjg=
=ht3Q
-----END PGP SIGNATURE-----

--Signature=_Wed__29_Jun_2005_02_09_44_+1000_/7FjOzzZpI+uKGZm--
