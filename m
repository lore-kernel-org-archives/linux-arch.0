From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] barriers: introduce smp_mb__release_acquire and update
 documentation
Date: Thu, 17 Sep 2015 15:57:13 +0800
Message-ID: <20150917075713.GA1300@fixme-laptop.cn.ibm.com>
References: <1442333610-16228-1-git-send-email-will.deacon@arm.com>
 <20150915174724.GP4029@linux.vnet.ibm.com>
 <20150916091452.GC3816@twins.programming.kicks-ass.net>
 <20150916102908.GA28771@arm.com>
 <20150916104314.GA3604@twins.programming.kicks-ass.net>
 <20150916110706.GF28771@arm.com>
 <20150917025012.GB4000@fixme-laptop.cn.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150917025012.GB4000@fixme-laptop.cn.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2015 at 10:50:12AM +0800, Boqun Feng wrote:
> On Wed, Sep 16, 2015 at 12:07:06PM +0100, Will Deacon wrote:
> > On Wed, Sep 16, 2015 at 11:43:14AM +0100, Peter Zijlstra wrote:
> > > On Wed, Sep 16, 2015 at 11:29:08AM +0100, Will Deacon wrote:
> > > > > Indeed, that is a hole in the definition, that I think we should =
close.
> > >=20
> > > > I'm struggling to understand the hole, but here's my intuition. If =
an
> > > > ACQUIRE on CPUx reads from a RELEASE by CPUy, then I'd expect CPUx =
to
> > > > observe all memory accessed performed by CPUy prior to the RELEASE
> > > > before it observes the RELEASE itself, regardless of this new barri=
er.
> > > > I think this matches what we currently have in memory-barriers.txt =
(i.e.
> > > > acquire/release are neither transitive or multi-copy atomic).
> > >=20
> > > Ah agreed. I seem to have gotten my brain in a tangle.
> > >=20
> > > Basically where a program order release+acquire relies on an address
> > > dependency, a cross cpu release+acquire relies on causality. If we
> > > observe the release, we must also observe everything prior to it etc.
> >=20
> > Yes, and crucially, the "everything prior to it" only encompasses acces=
ses
> > made by the releasing CPU itself (in the absence of other barriers and
> > synchronisation).
> >=20
>=20
> Just want to make sure I understand you correctly, do you mean that in
> the following case:
>=20
> CPU 1			CPU 2				CPU 3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> { A =3D 0, B =3D 0 }
> WRITE_ONCE(A,1);	r1 =3D READ_ONCE(A);		r2 =3D smp_load_acquire(&B);
> 			smp_store_release(&B, 1);	r3 =3D READ_ONCE(A);
>=20
> r1 =3D=3D 1 && r2 =3D=3D 1 && r3 =3D=3D 0 is not prohibitted?
>=20
> However, according to the discussion of Paul and Peter:
>=20
> https://lkml.org/lkml/2015/9/15/707
>=20
> I think that's prohibitted on architectures except s390 for sure. And
> for s390, we are waiting for the maintainers to verify this. If s390
> also prohibits this, then a release-acquire pair(on different CPUs) to
> the same variable does guarantee transitivity.
>=20
> Did I misunderstand you or miss something here?
>=20
> > Given that we managed to get confused, it doesn't hurt to call this out
> > explicitly in the doc, so I can add the following extra text.
> >=20
> > Will
> >=20
> > --->8
> >=20
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-b=
arriers.txt
> > index 46a85abb77c6..794d102d06df 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -1902,8 +1902,8 @@ the RELEASE would simply complete, thereby avoidi=
ng the deadlock.
> >  	a sleep-unlock race, but the locking primitive needs to resolve
> >  	such races properly in any case.
> > =20
> > -If necessary, ordering can be enforced by use of an
> > -smp_mb__release_acquire() barrier:
> > +Where the RELEASE and ACQUIRE operations are performed by the same CPU,
> > +ordering can be enforced by use of an smp_mb__release_acquire() barrie=
r:
> > =20
> >  	*A =3D a;
> >  	RELEASE M
> > @@ -1916,6 +1916,10 @@ in which case, the only permitted sequences are:
> >  	STORE *A, RELEASE M, ACQUIRE N, STORE *B
> >  	STORE *A, ACQUIRE N, RELEASE M, STORE *B
> > =20
> > +Note that smp_mb__release_acquire() has no effect on ACQUIRE or RELEASE
> > +operations performed by other CPUs, even if they are to the same varia=
ble.
> > +In cases where transitivity is required, smp_mb() should be used expli=
citly.
> > +
>=20
> Then, IIRC, the memory order effect of RELEASE+ACQUIRE should be:
>=20
> If an ACQUIRE loads the value of stored by a RELEASE, then on the CPU
> executing the ACQUIRE operation, all the memory operations after the
> ACQUIRE operation will perceive all the memory operations before the
> RELEASE operation on the CPU executing the RELEASE operation.
>=20

Ah.. I think I lost my mind while writting this. Should be:

If an ACQUIRE loads the value of stored by a RELEASE, then after the
ACQUIRE operation, the CPU executing the ACQUIRE operation will perceive
all the memory operations that have been perceived by the CPU executing
the RELEASE operation before the RELEASE operation.=20

Which means a release+acquire pair to the same variable guarantees
transitivity.

Sorry for the misleading paragraph..

Regards,
Boqun

> This could cover both the "on the same CPU" and "on different CPUs"
> cases.
>=20
> Of course, this may has nothing to do with smp_mb__release_acquire(),
> but I think we can take this chance to document the memory order effect
> of RELEASE+ACQUIRE well.
>=20
>=20
> Regards,
> Boqun
>=20
> >  Locks and semaphores may not provide any guarantee of ordering on UP c=
ompiled
> >  systems, and so cannot be counted on in such a situation to actually a=
chieve
> >  anything at all - especially with respect to I/O accesses - unless com=
bined
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/



--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV+nJWAAoJEEl56MO1B/q4wlUH+wZtf9FTAHe4sKG3EpVeS2Sj
LGarhZ3YSzvP92S/rRs/Vwe0EDEz3yY+UIKmNzQbPDTPBd76HyTBmOpeMW8D6TR2
fKuWPXB/DBINAekimvw4wOnAzLBWIaR7UECtCU0IbTep8DkAHvVlkibTRt4aDX2C
PfeYDfF5T08MSmtdCZc3TMKwIYW5D9ClQswCVLuAgWmzspeF5JhdT1YcU8VfRA/c
2NoeDa6iDAhGlcFr7XlgBtaBKrSS8bcgyamxRiKJvUlOxCUUIiYZImqMO5stQ3FZ
mtZZ6sk5GS9Nv970oatjUI3ZEEzLzcxOODRD44JmTyPzFprKSu3O0kYKF+puxWA=
=GKGd
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
