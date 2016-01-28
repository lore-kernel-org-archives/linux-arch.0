From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v3] barriers: introduce smp_mb__release_acquire and
 update documentation
Date: Thu, 28 Jan 2016 10:46:23 +0800
Message-ID: <20160128024623.GA14082@fixme-laptop.cn.ibm.com>
References: <1453918924-27606-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453918924-27606-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2016 at 06:22:04PM +0000, Will Deacon wrote:
> As much as we'd like to live in a world where RELEASE -> ACQUIRE is
> always cheaply ordered and can be used to construct UNLOCK -> LOCK
> definitions with similar guarantees, the grim reality is that this isn't
> even possible on x86 (thanks to Paul for bringing us crashing down to
> Earth).
>=20
> This patch handles the issue by introducing a new barrier macro,
> smp_mb__after_release_acquire, that can be placed after an ACQUIRE that
> either reads from a RELEASE or is in program-order after a RELEASE. The
> barrier upgrades the RELEASE-ACQUIRE pair to a full memory barrier,
> implying global transitivity. At the moment, it doesn't have any users,
> so its existence serves mainly as a documentation aid and a potential
> stepping stone to the reintroduction of smp_mb__after_unlock_lock() used
> by RCU.
>=20
> Documentation/memory-barriers.txt is updated to describe more clearly
> the ACQUIRE and RELEASE ordering in this area and to show some examples
> of the new barrier in action.
>=20

Maybe also add an entry in "CPU MEMORY BARRIERS" section of
memory-barriers.txt? Something like (copy and paste from you commit log
;-)):

 (*) smp_mb__after_release_acquire();

     Placed after an ACQUIRE that either reads from a RELEASE or is in
     program-order after a RELEASE. The barrier upgrades the
     RELEASE-ACQUIRE pair to a full memory barrier, implying global
     transitivity.

This could give the readers an overview of the usage of this barrier.

> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>=20
> Based on Paul's patch to describe local vs global transitivity:
>=20
>   http://lkml.kernel.org/r/20160115173912.GU3818@linux.vnet.ibm.com
>=20
>  Documentation/memory-barriers.txt   | 63 +++++++++++++++++++++++++++++++=
++----
>  arch/ia64/include/asm/barrier.h     |  2 ++
>  arch/powerpc/include/asm/barrier.h  |  3 +-
>  arch/s390/include/asm/barrier.h     |  1 +
>  arch/sparc/include/asm/barrier_64.h |  5 +--
>  arch/x86/include/asm/barrier.h      |  2 ++
>  include/asm-generic/barrier.h       | 13 ++++++++
>  7 files changed, 80 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-bar=
riers.txt
> index 2dc4ba7c8d4d..62ce096b88fa 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -454,16 +454,22 @@ And a couple of implicit varieties:
>       The use of ACQUIRE and RELEASE operations generally precludes the n=
eed
>       for other sorts of memory barrier (but note the exceptions mentione=
d in
>       the subsection "MMIO write barrier").  In addition, a RELEASE+ACQUI=
RE
> -     pair is -not- guaranteed to act as a full memory barrier.  However,=
 after
> +     pair is -not- guaranteed to act as a full memory barrier without an
> +     explicit smp_mb__after_release_acquire() barrier.  However, after
>       an ACQUIRE on a given variable, all memory accesses preceding any p=
rior
>       RELEASE on that same variable are guaranteed to be visible.  In oth=
er
> -     words, within a given variable's critical section, all accesses of =
all
> -     previous critical sections for that variable are guaranteed to have
> -     completed.
> +     words, for a CPU executing within a given variable's critical secti=
on,
> +     all accesses of all previous critical sections for that variable are
> +     guaranteed to be visible to that CPU.
> =20
>       This means that ACQUIRE acts as a minimal "acquire" operation and
>       RELEASE acts as a minimal "release" operation.
> =20
> +A subset of the atomic operations described in atomic_ops.txt have ACQUI=
RE
> +and RELEASE variants in addition to fully-ordered and relaxed (no barrier
> +semantics) definitions.  For compound atomics performing both a load and
> +a store, ACQUIRE semantics apply only to the load and RELEASE semantics
> +apply only to the store portion of the operation.
> =20
>  Memory barriers are only required where there's a possibility of interac=
tion
>  between two CPUs or between a CPU and a device.  If it can be guaranteed=
 that
> @@ -1357,7 +1363,7 @@ However, the transitivity of release-acquire is loc=
al to the participating
>  CPUs and does not apply to cpu3().  Therefore, the following outcome
>  is possible:
> =20
> -	r0 =3D=3D 0 && r1 =3D=3D 1 && r2 =3D=3D 1 && r3 =3D=3D 0 && r4 =3D=3D 0
> +	r0 =3D=3D 0 && r1 =3D=3D 1 && r2 =3D=3D 1 && r3 =3D=3D 0 && r4 =3D=3D 0=
 && r5 =3D=3D 1
> =20
>  Although cpu0(), cpu1(), and cpu2() will see their respective reads and
>  writes in order, CPUs not involved in the release-acquire chain might
> @@ -1369,10 +1375,27 @@ store to u as happening -after- cpu1()'s load fro=
m v, even though
>  both cpu0() and cpu1() agree that these two operations occurred in the
>  intended order.
> =20
> +This can be forbidden by upgrading the release-acquire relationship
> +between cpu0() and cpu1() to a full barrier using
> +smp_mb__after_release_acquire() to enforce global transitivity:
> +
> +	void cpu1(void)
> +	{
> +		r1 =3D smp_load_acquire(&y);
> +		smp_mb__after_release_acquire();
> +		r4 =3D READ_ONCE(v);
> +		r5 =3D READ_ONCE(u);
> +		smp_store_release(&z, 1);
> +	}
> +
> +With this addition, the previous result is forbidden and, as long as
> +r1 =3D=3D 1, all CPUs must agree that cpu0()'s store to u happened before
> +cpu1()'s read from v.
> +
>  However, please keep in mind that smp_load_acquire() is not magic.
>  In particular, it simply reads from its argument with ordering.  It does
>  -not- ensure that any particular value will be read.  Therefore, the
> -following outcome is possible:
> +following outcome is possible irrespective of any additional barriers:
> =20
>  	r0 =3D=3D 0 && r1 =3D=3D 0 && r2 =3D=3D 0 && r5 =3D=3D 0
> =20
> @@ -1971,6 +1994,34 @@ the RELEASE would simply complete, thereby avoidin=
g the deadlock.
>  	a sleep-unlock race, but the locking primitive needs to resolve
>  	such races properly in any case.
> =20
> +Where the RELEASE and ACQUIRE operations are performed by the same CPU
> +to different addresses, ordering can be enforced by an
> +smp_mb__after_release_acquire() barrier:
> +
> +	*A =3D a;
> +	RELEASE M
> +	ACQUIRE N
> +	smp_mb__after_release_acquire();
> +	*B =3D b;
> +
> +in which case, the only permitted orderings are:
> +
> +	STORE *A, RELEASE M, ACQUIRE N, STORE *B
> +	STORE *A, ACQUIRE N, RELEASE M, STORE *B
> +
> +Similarly, smp_mb__after_release_acquire() enforces full,
> +globally-transitive ordering in the case that an ACQUIRE operation on
> +one CPU reads from a RELEASE operation on another:
> +
> +	CPU 1			CPU 2				CPU 3
> +	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +		{ X =3D 0, Y =3D 0, M =3D 0 }
> +	STORE X=3D1		ACQUIRE M=3D=3D1			STORE Y=3D1
> +	RELEASE M=3D1		smp_mb__after_release_acquire() smp_mb();
> +				LOAD Y=3D=3D0			LOAD X=3D0
> +
> +This outcome is forbidden (i.e. CPU 3 must read X =3D=3D 1).
> +
>  Locks and semaphores may not provide any guarantee of ordering on UP com=
piled
>  systems, and so cannot be counted on in such a situation to actually ach=
ieve
>  anything at all - especially with respect to I/O accesses - unless combi=
ned
> diff --git a/arch/ia64/include/asm/barrier.h b/arch/ia64/include/asm/barr=
ier.h
> index 588f1614cafc..ed803c84bd19 100644
> --- a/arch/ia64/include/asm/barrier.h
> +++ b/arch/ia64/include/asm/barrier.h
> @@ -67,6 +67,8 @@ do {									\
>  	___p1;								\
>  })
> =20
> +#define __smp_mb__after_release_acquire()	__smp_mb()
> +
>  /*
>   * The group barrier in front of the rsm & ssm are necessary to ensure
>   * that none of the previous instructions in the same group are
> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/as=
m/barrier.h
> index c0deafc212b8..b12860b8c7e4 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -74,7 +74,8 @@ do {									\
>  	___p1;								\
>  })
> =20
> -#define smp_mb__before_spinlock()   smp_mb()
> +#define smp_mb__after_release_acquire()	__smp_mb()
> +#define smp_mb__before_spinlock()	smp_mb()
> =20
>  #include <asm-generic/barrier.h>
> =20
> diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barr=
ier.h
> index 5c8db3ce61c8..ee31da604b11 100644
> --- a/arch/s390/include/asm/barrier.h
> +++ b/arch/s390/include/asm/barrier.h
> @@ -45,6 +45,7 @@ do {									\
>  	___p1;								\
>  })
> =20
> +#define __smp_mb__release_acquire()	__smp_mb()

Should be __smp_mb__after_release_acquire(), so is the title of this
patch ;-)

Regards,
Boqun

>  #define __smp_mb__before_atomic()	barrier()
>  #define __smp_mb__after_atomic()	barrier()
> =20
> diff --git a/arch/sparc/include/asm/barrier_64.h b/arch/sparc/include/asm=
/barrier_64.h
> index c9f6ee64f41d..68c9e931a933 100644
> --- a/arch/sparc/include/asm/barrier_64.h
> +++ b/arch/sparc/include/asm/barrier_64.h
> @@ -52,8 +52,9 @@ do {									\
>  	___p1;								\
>  })
> =20
> -#define __smp_mb__before_atomic()	barrier()
> -#define __smp_mb__after_atomic()	barrier()
> +#define __smp_mb__after_release_acquire()	__smp_mb()
> +#define __smp_mb__before_atomic()		barrier()
> +#define __smp_mb__after_atomic()		barrier()
> =20
>  #include <asm-generic/barrier.h>
> =20
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrie=
r.h
> index a584e1c50918..b24dcb7e806a 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -77,6 +77,8 @@ do {									\
> =20
>  #endif
> =20
> +#define __smp_mb__after_release_acquire()	__smp_mb()
> +
>  /* Atomic operations are already serializing on x86 */
>  #define __smp_mb__before_atomic()	barrier()
>  #define __smp_mb__after_atomic()	barrier()
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 1cceca146905..895f5993d341 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -139,6 +139,10 @@ do {									\
>  })
>  #endif
> =20
> +#ifndef __smp_mb__after_release_acquire
> +#define __smp_mb__after_release_acquire()	do { } while (0)
> +#endif
> +
>  #ifdef CONFIG_SMP
> =20
>  #ifndef smp_store_mb
> @@ -161,6 +165,10 @@ do {									\
>  #define smp_load_acquire(p) __smp_load_acquire(p)
>  #endif
> =20
> +#ifndef smp_mb__after_release_acquire
> +#define smp_mb__after_release_acquire()	__smp_mb__after_release_acquire()
> +#endif
> +
>  #else	/* !CONFIG_SMP */
> =20
>  #ifndef smp_store_mb
> @@ -194,6 +202,10 @@ do {									\
>  })
>  #endif
> =20
> +#ifndef smp_mb__after_release_acquire
> +#define smp_mb__after_release_acquire()	do { } while (0)
> +#endif
> +
>  #endif
> =20
>  /* Barriers for virtual machine guests when talking to an SMP host */
> @@ -206,6 +218,7 @@ do {									\
>  #define virt_mb__after_atomic()	__smp_mb__after_atomic()
>  #define virt_store_release(p, v) __smp_store_release(p, v)
>  #define virt_load_acquire(p) __smp_load_acquire(p)
> +#define virt_mb__after_release_acquire() __smp_mb__after_release_acquire=
()
> =20
>  #endif /* !__ASSEMBLY__ */
>  #endif /* __ASM_GENERIC_BARRIER_H */
> --=20
> 2.1.4
>=20

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWqYD6AAoJEEl56MO1B/q4NzYH/3K3/04wyTFSst8M9lPjMA9v
5sSop1pYg3paw0w2acRfvUpCdrDN2oWhduhEg4e3+hk5sNceFEDpVQuBlrRvDdl7
6P3OV7nlYjtCkYSTTY6aab5/TsKOd0W0mbmbe61WkvGOsmmhgGgFqh/XVM8JS2Wl
Tj7W6fRsvOpcG5oF97kfy2YP3267sb11WEeQR0ZerGwwIRnW3lc6Oesq759Y5lkC
8WwBMq5IRel0hx4Eka9DKL0HYgOS3AyAwyY3H5Jbg6ddLW/TuMAoIQeIbDu5elrp
3LieDA0mwCHITfO6qMlbg0IKXOgm3mWuLde/+IQeuL62k2T/6ROCWg1uXEi1LyY=
=rMW6
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
