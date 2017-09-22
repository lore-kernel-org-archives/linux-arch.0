From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH v3 1/2] membarrier: Provide register expedited
 private command
Date: Fri, 22 Sep 2017 16:56:17 +0800
Message-ID: <20170922085617.GB19090@tardis>
References: <20170919221342.29915-1-mathieu.desnoyers@efficios.com>
 <20170922032206.GE10893@tardis>
 <20170922082441.rxavx645ewoizuu2@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35067 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdIVI5m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2017 04:57:42 -0400
Content-Disposition: inline
In-Reply-To: <20170922082441.rxavx645ewoizuu2@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Andrew Hunter <ahh@google.com>, Maged Michael <maged.michael@gmail.com>, gromer@google.com, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 10:24:41AM +0200, Peter Zijlstra wrote:
> On Fri, Sep 22, 2017 at 11:22:06AM +0800, Boqun Feng wrote:
>=20
> > The idea is in membarrier_private_expedited(), we go through all ->curr
> > on each CPU and=20
> >=20
> > 1)	If it's a userspace task and its ->mm is matched, we send an ipi
> >=20
> > 2)	If it's a kernel task, we skip
> >=20
> > 	(Because there will be a smp_mb() implied by mmdrop(), when it
> > 	switchs to userspace task).
> >=20
> > 3)	If it's a userspace task and its ->mm is not matched, we take
> > 	the corresponding rq->lock and check rq->curr again, if its ->mm
> > 	matched, we send an ipi, otherwise we do nothing.
> >=20
> > 	(Because if we observe rq->curr is not matched with rq->lock
> > 	held, when a task having matched ->mm schedules in, the rq->lock
> > 	pairing along with the smp_mb__after_spinlock() will guarantee
> > 	it observes all memory ops before sys_membarrir()).
>=20
> 3) is an insta DoS.

OK, fair enough.

Regards,
Boqun

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlnE0C4ACgkQSXnow7UH
+riT2wf/dSA7iidnINAE6gPHHju6ELcM3uItlmi2JIniNPyBOIaSpHgGxk1Gc0yR
1TndkInNJCfgsEx8CAG1t0y865DhzpaIVAroWfYS4DtnHbMyIYLQ5VDQgIrERnKG
zACejLa1gHO3QEkEPQYK1eb3n+MDY4Qt6GEd0kFmSlFvXHLvnPwR/9GviYd4z3Hv
NYqXKwpnow0WhA+GuWwVtBYibSxawH6dzEKmAcRKhLAq6CLtcfxnRhtvEnghER4H
SD+VeYlu3fA0deThgXXecd56dLeULN6S3BS8tgKGc3KDJoVJoQfLWu+XZk9kNGXy
zt8XEv765S9Q+9q/qQ7XYrVPVE+yiQ==
=1I6v
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
