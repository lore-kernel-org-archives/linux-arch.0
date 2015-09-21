From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] barriers: introduce smp_mb__release_acquire and update
 documentation
Date: Mon, 21 Sep 2015 22:10:38 +0800
Message-ID: <20150921141038.GB970@fixme-laptop.cn.ibm.com>
References: <1442333610-16228-1-git-send-email-will.deacon@arm.com>
 <20150915174724.GP4029@linux.vnet.ibm.com>
 <20150916091452.GC3816@twins.programming.kicks-ass.net>
 <20150916102908.GA28771@arm.com>
 <20150916104314.GA3604@twins.programming.kicks-ass.net>
 <20150916110706.GF28771@arm.com>
 <20150917025012.GB4000@fixme-laptop.cn.ibm.com>
 <20150917180001.GR25634@arm.com>
 <20150921134515.GA970@fixme-laptop.cn.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150921134515.GA970@fixme-laptop.cn.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2015 at 09:45:15PM +0800, Boqun Feng wrote:
> On Thu, Sep 17, 2015 at 07:00:01PM +0100, Will Deacon wrote:
> > On Thu, Sep 17, 2015 at 03:50:12AM +0100, Boqun Feng wrote:
> > > On Wed, Sep 16, 2015 at 12:07:06PM +0100, Will Deacon wrote:
> > > > On Wed, Sep 16, 2015 at 11:43:14AM +0100, Peter Zijlstra wrote:
> > > > > On Wed, Sep 16, 2015 at 11:29:08AM +0100, Will Deacon wrote:
> > > > > > > Indeed, that is a hole in the definition, that I think we sho=
uld close.
> > > > >=20
> > > > > > I'm struggling to understand the hole, but here's my intuition.=
 If an
> > > > > > ACQUIRE on CPUx reads from a RELEASE by CPUy, then I'd expect C=
PUx to
> > > > > > observe all memory accessed performed by CPUy prior to the RELE=
ASE
> > > > > > before it observes the RELEASE itself, regardless of this new b=
arrier.
> > > > > > I think this matches what we currently have in memory-barriers.=
txt (i.e.
> > > > > > acquire/release are neither transitive or multi-copy atomic).
> > > > >=20
> > > > > Ah agreed. I seem to have gotten my brain in a tangle.
> > > > >=20
> > > > > Basically where a program order release+acquire relies on an addr=
ess
> > > > > dependency, a cross cpu release+acquire relies on causality. If we
> > > > > observe the release, we must also observe everything prior to it =
etc.
> > > >=20
> > > > Yes, and crucially, the "everything prior to it" only encompasses a=
ccesses
> > > > made by the releasing CPU itself (in the absence of other barriers =
and
> > > > synchronisation).
> > > >=20
> > >=20
> > > Just want to make sure I understand you correctly, do you mean that in
> > > the following case:
> > >=20
> > > CPU 1			CPU 2				CPU 3
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > { A =3D 0, B =3D 0 }
> > > WRITE_ONCE(A,1);	r1 =3D READ_ONCE(A);		r2 =3D smp_load_acquire(&B);
> > > 			smp_store_release(&B, 1);	r3 =3D READ_ONCE(A);
> > >=20
> > > r1 =3D=3D 1 && r2 =3D=3D 1 && r3 =3D=3D 0 is not prohibitted?
> > >=20
> > > However, according to the discussion of Paul and Peter:
> > >=20
> > > https://lkml.org/lkml/2015/9/15/707
> > >=20
> > > I think that's prohibitted on architectures except s390 for sure. And
> > > for s390, we are waiting for the maintainers to verify this. If s390
> > > also prohibits this, then a release-acquire pair(on different CPUs) to
> > > the same variable does guarantee transitivity.
> > >=20
> > > Did I misunderstand you or miss something here?
> >=20
> > That certainly works on arm and arm64, so if it works everywhere else t=
oo,
> > then we can strengthen this (but see below).
> >=20
> > > > diff --git a/Documentation/memory-barriers.txt b/Documentation/memo=
ry-barriers.txt
> > > > index 46a85abb77c6..794d102d06df 100644
> > > > --- a/Documentation/memory-barriers.txt
> > > > +++ b/Documentation/memory-barriers.txt
> > > > @@ -1902,8 +1902,8 @@ the RELEASE would simply complete, thereby av=
oiding the deadlock.
> > > >  	a sleep-unlock race, but the locking primitive needs to resolve
> > > >  	such races properly in any case.
> > > > =20
> > > > -If necessary, ordering can be enforced by use of an
> > > > -smp_mb__release_acquire() barrier:
> > > > +Where the RELEASE and ACQUIRE operations are performed by the same=
 CPU,
> > > > +ordering can be enforced by use of an smp_mb__release_acquire() ba=
rrier:
> > > > =20
> > > >  	*A =3D a;
> > > >  	RELEASE M
> > > > @@ -1916,6 +1916,10 @@ in which case, the only permitted sequences =
are:
> > > >  	STORE *A, RELEASE M, ACQUIRE N, STORE *B
> > > >  	STORE *A, ACQUIRE N, RELEASE M, STORE *B
> > > > =20
> > > > +Note that smp_mb__release_acquire() has no effect on ACQUIRE or RE=
LEASE
> > > > +operations performed by other CPUs, even if they are to the same v=
ariable.
> > > > +In cases where transitivity is required, smp_mb() should be used e=
xplicitly.
> > > > +
> > >=20
> > > Then, IIRC, the memory order effect of RELEASE+ACQUIRE should be:
> >=20
> > [updated from your reply]
> >=20
> > > If an ACQUIRE loads the value of stored by a RELEASE, then after the
> > > ACQUIRE operation, the CPU executing the ACQUIRE operation will perce=
ive
> > > all the memory operations that have been perceived by the CPU executi=
ng
> > > the RELEASE operation before the RELEASE operation.=20
> > >=20
> > > Which means a release+acquire pair to the same variable guarantees
> > > transitivity.
> >=20
> > Almost, but on arm64 at least, "all the memory operations" above doesn't
> > include reads by other CPUs. I'm struggling to figure out whether that's
> > actually an issue.
> >=20
>=20
> Ah.. that's indeed an issue! for example:
>=20
> CPU 0			CPU 1				CPU 2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> {a =3D 0, b =3D 0, c =3D 0}
> r1 =3D READ_ONCE(a);	WRITE_ONCE(b, 1);		r3 =3D smp_load_acquire(&c);
> smp_rmb();		smp_store_release(&c, 1);	WRITE_ONCE(a, 1);
> r2 =3D READ_ONCE(b)
>=20
> where r1 =3D=3D 1 && r2 =3D=3D 0 && r3 =3D=3D 1 is actually not prohibitt=
ed, at
> least on POWER.
>=20

Oops.. I use wrong litmus here.. so this is prohibitted on POWER. Sorry
for the misleading. How about the behavior of that on arm and arm64?

If prohibitted too, please ignore below.

Apologies again for that..

Regards,
Boqun

> However, I think that doens't mean a release+acquire pair to the same
> variable doesn't guarantee transitivity, because the transitivity is
> actually broken at the smp_rmb(). But yes, my document is incorrect.
> How about:
>=20
> If an ACQUIRE loads the value of stored by a RELEASE, then after the
> ACQUIRE operation, the CPU executing the ACQUIRE operation will perceive
> all the memory operations that have been perceived by the CPU executing
> the RELEASE operation *transitively* before the RELEASE operation.=20
> ("transitively before" means that a memory operation is either executed
> on the same CPU before the other, or guaranteed executed before the
> other by a transitive barrier).
>=20
> Which means a release+acquire pair to the same variable guarantees
> transitivity.
>=20
>=20
> Maybe we can avoid to use term "transitively before" here, but it's not
> bad to distinguish different kinds of "before"s.
>=20
> Regards,
> Boqun



--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWAA/aAAoJEEl56MO1B/q4b08IAJBj6KwyWSiv+rl4A24OmX3f
nIxBIUqbr/vmVDmCR5lgBR2GW1jmaIfnKJzsOGG2m0EMV47tgetNtJEib60zkoGe
ISlxhCa86h7yp0pLN2oSURQessat8lH6vnLn22IPcE1ZKeUocriMW9oquA4B7JRR
MyJ4Jb7h3OMhsqVQZYb2CyeL8DGpm12vCivbl8MktCK41M2as/yx+kTYQT4HbANp
RVP0zr9KZFXKctn+Piwzet4pijeAZcATAYO9IIG8Uj2tgkZjcjIgjr2B3BOToqwA
AXLA3zMd+N0dR/vfgxh9Qpy2WNSpD7wtPjAaUmKCO9dih7jd99GlbhLeivRGFKA=
=l/VP
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
