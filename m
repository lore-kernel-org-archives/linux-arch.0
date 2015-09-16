From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] barriers: introduce smp_mb__release_acquire and update
 documentation
Date: Wed, 16 Sep 2015 19:49:18 +0800
Message-ID: <20150916114918.GA12664@fixme-laptop.cn.ibm.com>
References: <1442333610-16228-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35788 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbbIPLtr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Sep 2015 07:49:47 -0400
Content-Disposition: inline
In-Reply-To: <1442333610-16228-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Tue, Sep 15, 2015 at 05:13:30PM +0100, Will Deacon wrote:
> As much as we'd like to live in a world where RELEASE -> ACQUIRE is
> always cheaply ordered and can be used to construct UNLOCK -> LOCK
> definitions with similar guarantees, the grim reality is that this isn't
> even possible on x86 (thanks to Paul for bringing us crashing down to
> Earth).
>=20
> This patch handles the issue by introducing a new barrier macro,
> smp_mb__release_acquire, that can be placed between a RELEASE and a
> subsequent ACQUIRE operation in order to upgrade them to a full memory
> barrier. At the moment, it doesn't have any users, so its existence
> serves mainly as a documentation aid.
>=20
> Documentation/memory-barriers.txt is updated to describe more clearly
> the ACQUIRE and RELEASE ordering in this area and to show an example of
> the new barrier in action.
>=20
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>=20
> Following our discussion at [1], I thought I'd try to write something
> down...
>=20
> [1] http://lkml.kernel.org/r/20150828104854.GB16853@twins.programming.kic=
ks-ass.net
>=20
>  Documentation/memory-barriers.txt  | 23 ++++++++++++++++++++++-
>  arch/powerpc/include/asm/barrier.h |  1 +
>  arch/x86/include/asm/barrier.h     |  2 ++
>  include/asm-generic/barrier.h      |  4 ++++
>  4 files changed, 29 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-bar=
riers.txt
> index 2ba8461b0631..46a85abb77c6 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -459,11 +459,18 @@ And a couple of implicit varieties:
>       RELEASE on that same variable are guaranteed to be visible.  In oth=
er
>       words, within a given variable's critical section, all accesses of =
all
>       previous critical sections for that variable are guaranteed to have
> -     completed.
> +     completed.  If the RELEASE and ACQUIRE operations act on independent
> +     variables, an smp_mb__release_acquire() barrier can be placed betwe=
en
> +     them to upgrade the sequence to a full barrier.
> =20
>       This means that ACQUIRE acts as a minimal "acquire" operation and
>       RELEASE acts as a minimal "release" operation.
> =20
> +A subset of the atomic operations described in atomic_ops.txt have ACQUI=
RE
> +and RELEASE variants in addition to fully-ordered and relaxed definition=
s.
> +For compound atomics performing both a load and a store, ACQUIRE semanti=
cs
> +apply only to the load and RELEASE semantics only to the store portion of
> +the operation.
> =20
>  Memory barriers are only required where there's a possibility of interac=
tion
>  between two CPUs or between a CPU and a device.  If it can be guaranteed=
 that
> @@ -1895,6 +1902,20 @@ the RELEASE would simply complete, thereby avoidin=
g the deadlock.
>  	a sleep-unlock race, but the locking primitive needs to resolve
>  	such races properly in any case.
> =20
> +If necessary, ordering can be enforced by use of an
> +smp_mb__release_acquire() barrier:
> +
> +	*A =3D a;
> +	RELEASE M
> +	smp_mb__release_acquire();

Should this barrier be placed after the ACQUIRE? Because we do actually
want(?) and allow RELEASE and ACQUIRE operations to reorder in this
case, like your following example, right?

Regards,
Boqun

> +	ACQUIRE N
> +	*B =3D b;
> +
> +in which case, the only permitted sequences are:
> +
> +	STORE *A, RELEASE M, ACQUIRE N, STORE *B
> +	STORE *A, ACQUIRE N, RELEASE M, STORE *B
> +

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV+Vc3AAoJEEl56MO1B/q4n+gH/2ELpa0R1GIqixl6oF1iv1Sd
3xPfOmo75QMSz2sDtkwWsfdjCKVqSixhnavx3H16gu9zQmZmIaPmHp0ow2+PEdge
VPJj9592Vo6FaQSgSIQv/TuWRDaqKEEXlRzKjiJK1Ji5QisRExfDSgpxOfDse/Ci
MhYyTt/LVu2sFXt8Xjte7gIJBUUGQeeLY2xoxiPcwWF8DRMEtKj2aWVZXU87c9GC
YRXScVcWnfTaleC/Fe+gs9oF6+5evdfXHu71IbrGbvBEx1dGYfERKBZ1yLesNOVt
RQmsUrRn5EUxk3c7Xf5tj9HICs3+CwEdSW1aAH85UegfHiryClGRjo8EKTOfvU0=
=ZGky
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
