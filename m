Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36320 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbeBVGz1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 01:55:27 -0500
Date: Thu, 22 Feb 2018 14:58:47 +0800
From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Message-ID: <20180222065847.zqiquiyehvzgiiht@tardis>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
 <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180222032349.klcuiq23f52sfop6@tardis>
 <20180222041357.GB2855@linux.vnet.ibm.com>
 <20180222052746.vofmqbpnmfahck3z@tardis>
 <fad8e18b-ef5a-5bc0-5d87-6fad2e9f7c95@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ormwxexxgtj5uoi4"
Content-Disposition: inline
In-Reply-To: <fad8e18b-ef5a-5bc0-5d87-6fad2e9f7c95@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Lustig <dlustig@nvidia.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>


--ormwxexxgtj5uoi4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 09:42:08PM -0800, Daniel Lustig wrote:
> On 2/21/2018 9:27 PM, Boqun Feng wrote:
> > On Wed, Feb 21, 2018 at 08:13:57PM -0800, Paul E. McKenney wrote:
> >> On Thu, Feb 22, 2018 at 11:23:49AM +0800, Boqun Feng wrote:
> >>> On Tue, Feb 20, 2018 at 03:25:10PM -0800, Paul E. McKenney wrote:
> >>>> From: Alan Stern <stern@rowland.harvard.edu>
> >>>>
> >>>> This commit adds a litmus test in which P0() and P1() form a lock-ba=
sed S
> >>>> litmus test, with the addition of P2(), which observes P0()'s and P1=
()'s
> >>>> accesses with a full memory barrier but without the lock.  This litm=
us
> >>>> test asks whether writes carried out by two different processes unde=
r the
> >>>> same lock will be seen in order by a third process not holding that =
lock.
> >>>> The answer to this question is "yes" for all architectures supporting
> >>>
> >>> Hmm.. it this true? Our spin_lock() is RCpc because of PowerPC, so
> >>> spin_lock()+spin_unlock() pairs don't provide transitivity, and that's
> >>> why we have smp_mb__after_unlock_lock(). Is there something I'm missi=
ng?
> >>> Or there is an upcomming commit to switch PowerPC's lock implementati=
on?
> >>
> >> The PowerPC lock implementation's unlock-lock pair does not order writ=
es
> >> from the previous critical section against reads from the later critic=
al
> >> section, but it does order other combinations of reads and writes.
> >=20
> > Ah.. right! Thanks for the explanation ;-)
> >=20
> >> Some have apparently said that RISC-V 's unlock-lock pair also does not
> >> order writes from the previous critical section against writes from the
> >> later critical section.  And no, I don't claim to have yet gotten my
> >> head around RISC-V memory ordering.  ;-)
> >>
> >=20
> > Me neither. Now I remember this: we have a off-list(accidentally)
> > discussion about this, and IIRC at that moment riscv people confirmed
> > that riscv's unlock-lock pair doesn't order write->write, but that was
> > before their memory model draft posted for discussions, so things may
> > change now...=20
> >=20
> > Besides, I think the smp_mb() on P2 can be relaxed to smp_rmb(), no?
> >=20
> > Regards,
> > Boqun
> >=20
> >> 							Thanx, Paul
> >>
>=20
> As a matter of fact, the RISC-V memory model committee is debating this
> exact question at the moment.  Now that I see this thread I'll have to
> go back and catch up on what I've missed, but at least I can be on cc
> from this point on to answer any RISC-V questions that come up from
> here on.
>=20

Hi Daniel ;-)

> (Is there some place I should add my name as a RISC-V memory model
> contact, so I don't miss threads like this in the future?)
>=20

You can submit a patch to add yourself as a Maintainer or Reviewer for
LKMM, Patch #6 in this series is a good example:

	https://marc.info/?l=3Dlinux-kernel&m=3D151916916630299&w=3D2

, and "get_maintainer.pl" will help people find you for memory model
stuffs.=20

> And yes, if we go with a purely RCpc interpretation of acquire and
> release, then I don't believe the writes in the previous critical
> section would be ordered with the writes in the subsequent critical
> section.  That's really all the argument boils down to.  We'd like

I think atomics in Linux kernel(and in LKMM) are purely RCpc, right?
Alan and Andrea?=20

And we are not going to change it, are we?

If atomics in Linux kernel are purely RCpc, then it cerntainly makes
sense for riscv to provide purely RCpc atomics.

> to support RCpc if we can since that's all some software needs, but
> we also obviously want to make sure we can support RCsc and these
> kinds of LKMM subtleties efficiently too when needed.  So we have a

I think the problem here is that locks in Linux kernel are more strict
than RCpc but weaker than RCsc, and there is not a well-known concept
for the semantics of locks in Linux kernel AFAIK.

Regards,
Boqun

> few encoding details that we're still finalizing, because questions
> like this one are still popping up :)
>=20
> Let me know if you had other RISC-V-specific questions I can help
> answer.
>=20
> Dan

--ormwxexxgtj5uoi4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqOaiQACgkQSXnow7UH
+rjVoQf/R8bGFPon+fc+tjp0aODo15iaOVZTWWj92q7lXmwAnhKPnyQ6nK9VPHOF
B85UfBLV9kO20KsuHwW4kB/Nr22i0V1Y/rh2QyDQq8mcwQ6auVBjQp9Ii02LML12
op6m2WSJDvt536+ihxf938GW5fpdI//T3TdGS86fCJYO2coBvUUJKnHaBnp6dSOu
LB60x6VAushKRLZwHS9WApP0qaKG1kNFOg+hKU49gGCp3Ux3R/HBbSIjXqlZgLkT
PYGJ4di4cONuXMgAoyO3ZQ8J5BNZ/hHCNYnXdqHBGwIaPYxX0ulVt10HenDQeEHS
9FBL50w6Cjdfq2lGyUz2l9v2Rfq+Qw==
=ude3
-----END PGP SIGNATURE-----

--ormwxexxgtj5uoi4--
