From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH v3 1/2] membarrier: Provide register expedited
 private command
Date: Fri, 22 Sep 2017 11:30:57 +0800
Message-ID: <20170922033057.GF10893@tardis>
References: <20170919221342.29915-1-mathieu.desnoyers@efficios.com>
 <20170922032206.GE10893@tardis>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38492 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbdIVDcS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2017 23:32:18 -0400
Content-Disposition: inline
In-Reply-To: <20170922032206.GE10893@tardis>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Andrew Hunter <ahh@google.com>, Maged Michael <maged.michael@gmail.com>, gromer@google.com, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 11:22:06AM +0800, Boqun Feng wrote:
> Hi Mathieu,
>=20
> On Tue, Sep 19, 2017 at 06:13:41PM -0400, Mathieu Desnoyers wrote:
> > Provide a new command allowing processes to register their intent to use
> > the private expedited command.
> >=20
> > This allows PowerPC to skip the full memory barrier in switch_mm(), and
> > only issue the barrier when scheduling into a task belonging to a
> > process that has registered to use expedited private.
> >=20
> > Processes are now required to register before using
> > MEMBARRIER_CMD_PRIVATE_EXPEDITED, otherwise that command returns EPERM.
> >=20
>=20
> Sorry I'm late for the party, but I couldn't stop thinking whether we
> could avoid the register thing at all, because the registering makes
> sys_membarrier() more complex(both for the interface and the
> implementation). So how about we trade-off a little bit by taking
> some(not all) the rq->locks?
>=20
> The idea is in membarrier_private_expedited(), we go through all ->curr
> on each CPU and=20
>=20
> 1)	If it's a userspace task and its ->mm is matched, we send an ipi
>=20
> 2)	If it's a kernel task, we skip
>=20
> 	(Because there will be a smp_mb() implied by mmdrop(), when it
> 	switchs to userspace task).
>=20
> 3)	If it's a userspace task and its ->mm is not matched, we take
> 	the corresponding rq->lock and check rq->curr again, if its ->mm
> 	matched, we send an ipi, otherwise we do nothing.
>=20
> 	(Because if we observe rq->curr is not matched with rq->lock
> 	held, when a task having matched ->mm schedules in, the rq->lock
> 	pairing along with the smp_mb__after_spinlock() will guarantee
> 	it observes all memory ops before sys_membarrir()).
>=20
> membarrier_private_expedited() will look like this if we choose this
> way:
>=20
> void membarrier_private_expedited()
> {
> 	int cpu;
> 	bool fallback =3D false;
> 	cpumask_var_t tmpmask;
> 	struct rq_flags rf;
>=20
>=20
> 	if (num_online_cpus() =3D=3D 1)
> 		return;
>=20
> 	smp_mb();
>=20
> 	if (!zalloc_cpumask_var(&tmpmask, GFP_NOWAIT)) {
> 		/* Fallback for OOM. */
> 		fallback =3D true;
> 	}
>=20
> 	cpus_read_lock();
> 	for_each_online_cpu(cpu) {
> 		struct task_struct *p;
>=20
> 		if (cpu =3D=3D raw_smp_processor_id())
> 			continue;
>=20
> 		rcu_read_lock();
> 		p =3D task_rcu_dereference(&cpu_rq(cpu)->curr);
>=20
> 		if (!p) {
> 			rcu_read_unlock();
> 			continue;
> 		}
>=20
> 		if (p->mm =3D=3D current->mm) {
> 			if (!fallback)
> 				__cpumask_set_cpu(cpu, tmpmask);
> 			else
> 				smp_call_function_single(cpu, ipi_mb, NULL, 1);
> 		}
>=20
> 		if (p->mm =3D=3D current->mm || !p->mm) {
> 			rcu_read_unlock();
> 			continue;
> 		}
>=20
> 		rcu_read_unlock();
> 	=09
> 		/*
> 		 * This should be a arch-specific code, as we don't
> 		 * need it at else place other than some archs without
> 		 * a smp_mb() in switch_mm() (i.e. powerpc)
> 		 */
> 		rq_lock_irq(cpu_rq(cpu), &rf);
> 		if (p->mm =3D=3D current->mm) {

Oops, this one should be

		if (cpu_curr(cpu)->mm =3D=3D current->mm)

> 			if (!fallback)
> 				__cpumask_set_cpu(cpu, tmpmask);
> 			else
> 				smp_call_function_single(cpu, ipi_mb, NULL, 1);

, and this better be moved out of the lock rq->lock critical section.

Regards,
Boqun

> 		}
> 		rq_unlock_irq(cpu_rq(cpu), &rf);
> 	}
> 	if (!fallback) {
> 		smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
> 		free_cpumask_var(tmpmask);
> 	}
> 	cpus_read_unlock();
>=20
> 	smp_mb();
> }
>=20
> Thoughts?
>=20
> Regards,
> Boqun
>=20
[...]

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlnEg+sACgkQSXnow7UH
+rgLPggAipHRnoiXrL1dcRCGBknpKrnYnpPykTctrjJBqDn90IPljCfbliibNK16
+HNRnMv1QrDM4eFV8W0ZhgFF1bMmSuMm3pTyVVX/AhKwdjV3JTN/S3vmRNOWsLlt
A4Lap5ZOqYBBIE53w6d3qStm3xWckVt/g+xqNCmb//JbRfTr6mTi8afHwRqAGvie
9HpUz+KVrFS/6igu2/N+ArO9a19vRZczkemj7zUH7lLEYMh8AzCYiF05P1THrl3s
1iBBa3MP+iKM4rVJJJDUCU8UX/lwKIQkgoKAJmzyoYvG+1b92sudWA5UmfcR1gkz
ekAiIOSD+oaFE4BJPf+xmhvypBUguQ==
=SJvs
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
