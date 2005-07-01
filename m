Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 1 Jul 2005 18:24:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH, for review 1/3] compat_sys_{read,write}
Message-Id: <20050701182434.0eefa808.sfr@canb.auug.org.au>
In-Reply-To: <9482.1120204705@warthog.cambridge.redhat.com>
References: <20050701145642.6a3d6542.sfr@canb.auug.org.au>
	<20050628181453.387e0fac.sfr@canb.auug.org.au>
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
	<9482.1120204705@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__1_Jul_2005_18_24_34_+1000_tHGTxg2KqpeCwEVn"
To: David Howells <dhowells@redhat.com>
Cc: ak@suse.de, davem@davemloft.net, matthew@wil.cx, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Fri__1_Jul_2005_18_24_34_+1000_tHGTxg2KqpeCwEVn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 01 Jul 2005 08:58:25 +0100 David Howells <dhowells@redhat.com> wrot=
e:
>
> Should this also extend to the pread/pwrite syscalls?

maybe ... :-)

> I think my biggest objection to this is that it'll stick another "frame" =
on
> the stack. For something like this the compiler probably can't tail-call,=
 at
> least not on archs like i386 where the extra argument is passed on the st=
ack.
> For an arch that passes at least the first four arguments in registers, it
> probably can, but I don't know that it will. Have you waved this in front=
 of
> any compiler hackers?

On i386, it doesn't do a tail call as you said.  On PPC64, it takes two
instructions to produce the tail call ...  We could inline
do_sys_{read,write} if it was a real worry.  It should only add 32 bytes
(or less) to the stack on i386, shouldn't it?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__1_Jul_2005_18_24_34_+1000_tHGTxg2KqpeCwEVn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxP3HFdBgD/zoJvwRAleGAJ9SwTFeD+g6TzlFqyUoO5Ob3KWi1QCfZwja
PFN//smvqZUafVh3d5Si4DY=
=iYdm
-----END PGP SIGNATURE-----

--Signature=_Fri__1_Jul_2005_18_24_34_+1000_tHGTxg2KqpeCwEVn--
