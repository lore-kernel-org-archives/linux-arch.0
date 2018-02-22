Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f176.google.com ([74.125.82.176]:46190 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbeBVKmI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 05:42:08 -0500
Date: Thu, 22 Feb 2018 18:45:32 +0800
From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Message-ID: <20180222104532.6znly3zespgfga4i@tardis>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
 <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180222032349.klcuiq23f52sfop6@tardis>
 <20180222041357.GB2855@linux.vnet.ibm.com>
 <20180222052746.vofmqbpnmfahck3z@tardis>
 <fad8e18b-ef5a-5bc0-5d87-6fad2e9f7c95@nvidia.com>
 <20180222065847.zqiquiyehvzgiiht@tardis>
 <20180222101504.GQ25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ci7ab5w6tv3ramfs"
Content-Disposition: inline
In-Reply-To: <20180222101504.GQ25201@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Daniel Lustig <dlustig@nvidia.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>


--ci7ab5w6tv3ramfs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 11:15:04AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 02:58:47PM +0800, Boqun Feng wrote:
> > > And yes, if we go with a purely RCpc interpretation of acquire and
> > > release, then I don't believe the writes in the previous critical
> > > section would be ordered with the writes in the subsequent critical
> > > section.  That's really all the argument boils down to.  We'd like
> >=20
> > I think atomics in Linux kernel(and in LKMM) are purely RCpc, right?
> > Alan and Andrea?=20
> >=20
> > And we are not going to change it, are we?
> >=20
> > If atomics in Linux kernel are purely RCpc, then it cerntainly makes
> > sense for riscv to provide purely RCpc atomics.
>=20
> So there's 3 things:
>=20
>   smp_load_acquire(), smp_store_release()
>=20
>   atomic*_{acquire,release}()
>=20
>   *_{lock,unlock}();
>=20
> Which are all quite distinct.
>=20
> smp_load_acquire() and smp_store_release() are RCpc, and there is no
> discussion of ever wanting to change that.
>=20
> The atomics also follow this and are RCpc, in fact the RELEASE only
> applies to the STORE and the ACQUIRE only applies to the LOAD of the
> atomics.
>=20
> The locking primitives OTOH we would really rather like to be RCsc, and
> everybody except PPC has them as such, PPC being the only one having
> RCpc locks.
>=20
> I read the part you quoted from Daniel as being purely about spinlocks,
> the 'critical section' wording being a dead give away, so I'm then
> somewhat confused why you talk about atomics.

Maybe it's me who misunderstand Daniel's words. But my understanding is
that riscv people are on a debate about whether their "RCpc" atomic
instructions need to be more strict: release+acquire pair orders two
writes. And I thought that atomics(including RmW atomics) in kernel only
have purely RCpc semantics, which I needed to check with you guy. And if
I'm right, it's cerntainly fine for riscv "RCpc" instruction to be
purely RCpc.

Note that even on PPC, the release+acquire pair of atomics orders writes
before and after, and on x86, writes are ordered since it's TSO. So
strictly speaking, I think our current implementation of atomics are a
little more strict than purely RCpc. If we think this is an requirement
for implementation of atomic primitives, than the current version of
riscv's "RCpc" atomics don't suffice.

Regards,
Boqun

--ci7ab5w6tv3ramfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqOn0gACgkQSXnow7UH
+rgiBQgAqeS8IrnlHw0UjeeKk0dteFu5Z/677/DyBE8hO7Jo280fXe64EoU2d0XH
BD3g7plUWVB2NxzWYZkePnYuZD34Rqtknt6Do+liuaeB/ifEeRMCZ+51nHaNA5Id
jF0sr36/QcjAe7IVPloimH7q72+HEJ1NGt2FvDNPCoHrcCEUoQPxuIPRaUX6ePey
vD63CQSy/fSNoCGzMYOsgmMNWtzYkTm3HGJNSn1KJ8mTy7KU1m0FBAc/ZBXyUBb2
HkweoPDZmpP+S2FwIVs8HAIVeASIEKQKnruZ357DCGq94MwjUBhkmBAVveDj0A/L
Upy6iXq352/mRmj0FzOy3ltkSBxqMg==
=G/un
-----END PGP SIGNATURE-----

--ci7ab5w6tv3ramfs--
