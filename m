From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] barriers: introduce smp_mb__release_acquire and update
 documentation
Date: Tue, 22 Sep 2015 07:42:19 +0800
Message-ID: <20150921234219.GA29992@fixme-laptop.cn.ibm.com>
References: <20150915174724.GP4029@linux.vnet.ibm.com>
 <20150916091452.GC3816@twins.programming.kicks-ass.net>
 <20150916102908.GA28771@arm.com>
 <20150916104314.GA3604@twins.programming.kicks-ass.net>
 <20150916110706.GF28771@arm.com>
 <20150917025012.GB4000@fixme-laptop.cn.ibm.com>
 <20150917180001.GR25634@arm.com>
 <20150921134515.GA970@fixme-laptop.cn.ibm.com>
 <20150921141038.GB970@fixme-laptop.cn.ibm.com>
 <20150921222301.GF7356@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33929 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbbIUXml (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Sep 2015 19:42:41 -0400
Content-Disposition: inline
In-Reply-To: <20150921222301.GF7356@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2015 at 11:23:01PM +0100, Will Deacon wrote:
> On Mon, Sep 21, 2015 at 03:10:38PM +0100, Boqun Feng wrote:
> > On Mon, Sep 21, 2015 at 09:45:15PM +0800, Boqun Feng wrote:
> > > On Thu, Sep 17, 2015 at 07:00:01PM +0100, Will Deacon wrote:
> > > > On Thu, Sep 17, 2015 at 03:50:12AM +0100, Boqun Feng wrote:
> > > > > If an ACQUIRE loads the value of stored by a RELEASE, then after =
the
> > > > > ACQUIRE operation, the CPU executing the ACQUIRE operation will p=
erceive
> > > > > all the memory operations that have been perceived by the CPU exe=
cuting
> > > > > the RELEASE operation before the RELEASE operation.=20
> > > > >=20
> > > > > Which means a release+acquire pair to the same variable guarantees
> > > > > transitivity.
> > > >=20
> > > > Almost, but on arm64 at least, "all the memory operations" above do=
esn't
> > > > include reads by other CPUs. I'm struggling to figure out whether t=
hat's
> > > > actually an issue.
> > > >=20
> > >=20
> > > Ah.. that's indeed an issue! for example:
> > >=20
> > > CPU 0			CPU 1				CPU 2
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > {a =3D 0, b =3D 0, c =3D 0}
> > > r1 =3D READ_ONCE(a);	WRITE_ONCE(b, 1);		r3 =3D smp_load_acquire(&c);
> > > smp_rmb();		smp_store_release(&c, 1);	WRITE_ONCE(a, 1);
> > > r2 =3D READ_ONCE(b)
> > >=20
> > > where r1 =3D=3D 1 && r2 =3D=3D 0 && r3 =3D=3D 1 is actually not prohi=
bitted, at
> > > least on POWER.
> > >=20
> >=20
> > Oops.. I use wrong litmus here.. so this is prohibitted on POWER. Sorry
> > for the misleading. How about the behavior of that on arm and arm64?
>=20
> That explicit test is forbidden on arm/arm64 because of the smp_rmb(),
> but if you rewrite it as (LDAR is acquire, STLR is release):
>=20
>=20
>   {
>   0:X1=3Dx; 0:X3=3Dy;
>   1:X1=3Dy; 1:X2=3Dz;
>   2:X1=3Dz; 2:X3=3Dx;
>   }
>    P0           | P1           | P2                ;
>    LDAR W0,[X1] | MOV W0,#1    | LDAR W0,[X1]      ;
>    LDR W2,[X3]  | STR W0,[X1]  | MOV W2,#1         ;
>                 | STLR W0,[X2] | STR W2,[X3]       ;
>=20
>   Observed
>       0:X0=3D1; 0:X2=3D0; 2:X0=3D1;
>=20

X0 is W0, etc. Right?

>=20
> then it is permitted on arm64. Note that herd currently claims that this
> is forbidden, but I'm talking to the authors about getting that fixed :)
>=20

Good to know ;-) I think this actually means two things:

1.	ACQUIRE doesn't provide transitivity itself

and=20

2.	We still need the term like "transitively before".

Regards,
Boqun

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWAJXYAAoJEEl56MO1B/q4IAcIAJjP+wW0G6gA2yaC9EFOWBIa
7cqugp2Zq61KgLDVEek5iypK2R3m4+/EjNNQ/8CDrXFB9vhHoEOdEOdwHhwp2RtL
NTgoK3uRd1Qb+WCNMKj+vtePxrCLnJG9r7f+4babNriRv2G8+3Y8KcZwiuYOff21
MBAqP1Ryzv/PXEiP8CUYEPy4LEmiI8KmdpWGk7p7NR7TW2bJMJEYJzSuq7WMmbJ6
WFI6VB/xAhBHtmHJtN2VQejWoduNnxVNLXVtI3hO6UPsanLVAaWdM+iWg2BZx2P1
lSeqXHBjf8ufZDVsPp3sX8FfhQneQQRkV8NezG1FlckCAar3gKMPMN8x5Z2s8HM=
=3S1h
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
