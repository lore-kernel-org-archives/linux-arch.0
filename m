Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52419 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeBVFYf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 00:24:35 -0500
Date: Thu, 22 Feb 2018 13:27:46 +0800
From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Message-ID: <20180222052746.vofmqbpnmfahck3z@tardis>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
 <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180222032349.klcuiq23f52sfop6@tardis>
 <20180222041357.GB2855@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mtzlcjcxkatg5c6c"
Content-Disposition: inline
In-Reply-To: <20180222041357.GB2855@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>


--mtzlcjcxkatg5c6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 08:13:57PM -0800, Paul E. McKenney wrote:
> On Thu, Feb 22, 2018 at 11:23:49AM +0800, Boqun Feng wrote:
> > On Tue, Feb 20, 2018 at 03:25:10PM -0800, Paul E. McKenney wrote:
> > > From: Alan Stern <stern@rowland.harvard.edu>
> > >=20
> > > This commit adds a litmus test in which P0() and P1() form a lock-bas=
ed S
> > > litmus test, with the addition of P2(), which observes P0()'s and P1(=
)'s
> > > accesses with a full memory barrier but without the lock.  This litmus
> > > test asks whether writes carried out by two different processes under=
 the
> > > same lock will be seen in order by a third process not holding that l=
ock.
> > > The answer to this question is "yes" for all architectures supporting
> >=20
> > Hmm.. it this true? Our spin_lock() is RCpc because of PowerPC, so
> > spin_lock()+spin_unlock() pairs don't provide transitivity, and that's
> > why we have smp_mb__after_unlock_lock(). Is there something I'm missing?
> > Or there is an upcomming commit to switch PowerPC's lock implementation?
>=20
> The PowerPC lock implementation's unlock-lock pair does not order writes
> from the previous critical section against reads from the later critical
> section, but it does order other combinations of reads and writes.

Ah.. right! Thanks for the explanation ;-)

> Some have apparently said that RISC-V 's unlock-lock pair also does not
> order writes from the previous critical section against writes from the
> later critical section.  And no, I don't claim to have yet gotten my
> head around RISC-V memory ordering.  ;-)
>=20

Me neither. Now I remember this: we have a off-list(accidentally)
discussion about this, and IIRC at that moment riscv people confirmed
that riscv's unlock-lock pair doesn't order write->write, but that was
before their memory model draft posted for discussions, so things may
change now...=20

Besides, I think the smp_mb() on P2 can be relaxed to smp_rmb(), no?

Regards,
Boqun

> 							Thanx, Paul
>=20
> > [Cc ppc maintainers]
> >=20
> > Regards,
> > Boqun
> >=20
> > > the Linux kernel, but is "no" according to the current version of LKM=
M.
> > >=20
> > > A patch to LKMM is under development.
> > >=20
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > ---
> > >  .../ISA2+pooncelock+pooncelock+pombonce.litmus     | 41 ++++++++++++=
++++++++++
> > >  1 file changed, 41 insertions(+)
> > >  create mode 100644 tools/memory-model/litmus-tests/ISA2+pooncelock+p=
ooncelock+pombonce.litmus
> > >=20
> > > diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelo=
ck+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+poonce=
lock+pombonce.litmus
> > > new file mode 100644
> > > index 000000000000..7a39a0aaa976
> > > --- /dev/null
> > > +++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pomb=
once.litmus
> > > @@ -0,0 +1,41 @@
> > > +C ISA2+pooncelock+pooncelock+pombonce.litmus
> > > +
> > > +(*
> > > + * Result: Sometimes
> > > + *
> > > + * This test shows that the ordering provided by a lock-protected S
> > > + * litmus test (P0() and P1()) are not visible to external process P=
2().
> > > + * This is likely to change soon.
> > > + *)
> > > +
> > > +{}
> > > +
> > > +P0(int *x, int *y, spinlock_t *mylock)
> > > +{
> > > +	spin_lock(mylock);
> > > +	WRITE_ONCE(*x, 1);
> > > +	WRITE_ONCE(*y, 1);
> > > +	spin_unlock(mylock);
> > > +}
> > > +
> > > +P1(int *y, int *z, spinlock_t *mylock)
> > > +{
> > > +	int r0;
> > > +
> > > +	spin_lock(mylock);
> > > +	r0 =3D READ_ONCE(*y);
> > > +	WRITE_ONCE(*z, 1);
> > > +	spin_unlock(mylock);
> > > +}
> > > +
> > > +P2(int *x, int *z)
> > > +{
> > > +	int r1;
> > > +	int r2;
> > > +
> > > +	r2 =3D READ_ONCE(*z);
> > > +	smp_mb();
> > > +	r1 =3D READ_ONCE(*x);
> > > +}
> > > +
> > > +exists (1:r0=3D1 /\ 2:r2=3D1 /\ 2:r1=3D0)
> > > --=20
> > > 2.5.2
> > >=20
>=20
>=20

--mtzlcjcxkatg5c6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqOVM8ACgkQSXnow7UH
+riMhwf+Okl3Jyf184VnXOuDWBLDyJSDhKDU59yU2c8TNQTsbfDGwasPmuzjAeeZ
/O+tdW3Uv4XtjaEs8tsf/RGTznSE9dYe2SNW9yUsafFIoiE7KwjYnqNnkctEk7Ge
+0SFZVgjaHyxZDrPmKGI/fUv7Cwr8JoqTohrp/ayx32bN7kWAm6JgbPOZchxemZn
dXCWUsU5aRZaf8NVLdXNwFpzSQfTiBtC+w6re8sB6JBsYy5+z7hE2XBiGM3ZIcgU
BSd3mGH2LLNghBXnTN+YuWvoaiDzRpD9nav48qL4hqJofqvWdMaRfx1JLNLrHAvY
g3mH/PlcW+8ai+HoXFI046U+yJcPEA==
=bZBc
-----END PGP SIGNATURE-----

--mtzlcjcxkatg5c6c--
