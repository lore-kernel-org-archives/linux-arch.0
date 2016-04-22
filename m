From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC][PATCH 18/31] locking,powerpc: Implement
 atomic{,64}_fetch_{add,sub,and,or,xor}{,_relaxed,_acquire,_release}()
Date: Sat, 23 Apr 2016 00:41:57 +0800
Message-ID: <20160422164157.GB3369@insomnia>
References: <20160422090413.393652501@infradead.org>
 <20160422093924.212277819@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:33718 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027AbcDVQis (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 12:38:48 -0400
Content-Disposition: inline
In-Reply-To: <20160422093924.212277819@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2016 at 11:04:31AM +0200, Peter Zijlstra wrote:
> Implement FETCH-OP atomic primitives, these are very similar to the
> existing OP-RETURN primitives we already have, except they return the
> value of the atomic variable _before_ modification.
>=20
> This is especially useful for irreversible operations -- such as
> bitops (because it becomes impossible to reconstruct the state prior
> to modification).
>=20
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/powerpc/include/asm/atomic.h |   83 +++++++++++++++++++++++++++++++=
++-----
>  1 file changed, 74 insertions(+), 9 deletions(-)
>=20
> --- a/arch/powerpc/include/asm/atomic.h
> +++ b/arch/powerpc/include/asm/atomic.h
> @@ -78,21 +78,53 @@ static inline int atomic_##op##_return_r
>  	return t;							\
>  }
> =20
> +#define ATOMIC_FETCH_OP_RELAXED(op, asm_op)				\
> +static inline int atomic_fetch_##op##_relaxed(int a, atomic_t *v)	\
> +{									\
> +	int res, t;							\
> +									\
> +	__asm__ __volatile__(						\
> +"1:	lwarx	%0,0,%4		# atomic_fetch_" #op "_relaxed\n"	\
> +	#asm_op " %1,%2,%0\n"						\

Should be

	#asm_op " %1,%3,%0\n"

right? Because %2 is v->counter and %3 is @a.

Regards,
Boqun

> +	PPC405_ERR77(0, %4)						\
> +"	stwcx.	%1,0,%4\n"						\
> +"	bne-	1b\n"							\
> +	: "=3D&r" (res), "=3D&r" (t), "+m" (v->counter)			\
> +	: "r" (a), "r" (&v->counter)					\
> +	: "cc");							\
> +									\
> +	return res;							\
> +}
> +
>  #define ATOMIC_OPS(op, asm_op)						\
>  	ATOMIC_OP(op, asm_op)						\
> -	ATOMIC_OP_RETURN_RELAXED(op, asm_op)
> +	ATOMIC_OP_RETURN_RELAXED(op, asm_op)				\
> +	ATOMIC_FETCH_OP_RELAXED(op, asm_op)
> =20
>  ATOMIC_OPS(add, add)
>  ATOMIC_OPS(sub, subf)
> =20
> -ATOMIC_OP(and, and)
> -ATOMIC_OP(or, or)
> -ATOMIC_OP(xor, xor)
> -
>  #define atomic_add_return_relaxed atomic_add_return_relaxed
>  #define atomic_sub_return_relaxed atomic_sub_return_relaxed
> =20
> +#define atomic_fetch_add_relaxed atomic_fetch_add_relaxed
> +#define atomic_fetch_sub_relaxed atomic_fetch_sub_relaxed
> +
> +#undef ATOMIC_OPS
> +#define ATOMIC_OPS(op, asm_op)						\
> +	ATOMIC_OP(op, asm_op)						\
> +	ATOMIC_FETCH_OP_RELAXED(op, asm_op)
> +
> +ATOMIC_OPS(and, and)
> +ATOMIC_OPS(or, or)
> +ATOMIC_OPS(xor, xor)
> +
> +#define atomic_fetch_and_relaxed atomic_fetch_and_relaxed
> +#define atomic_fetch_or_relaxed  atomic_fetch_or_relaxed
> +#define atomic_fetch_xor_relaxed atomic_fetch_xor_relaxed
> +
>  #undef ATOMIC_OPS
> +#undef ATOMIC_FETCH_OP_RELAXED
>  #undef ATOMIC_OP_RETURN_RELAXED
>  #undef ATOMIC_OP
> =20
> @@ -329,20 +361,53 @@ atomic64_##op##_return_relaxed(long a, a
>  	return t;							\
>  }
> =20
> +#define ATOMIC64_FETCH_OP_RELAXED(op, asm_op)				\
> +static inline long							\
> +atomic64_fetch_##op##_relaxed(long a, atomic64_t *v)			\
> +{									\
> +	long res, t;							\
> +									\
> +	__asm__ __volatile__(						\
> +"1:	ldarx	%0,0,%4		# atomic64_fetch_" #op "_relaxed\n"	\
> +	#asm_op " %1,%3,%0\n"						\
> +"	stdcx.	%1,0,%4\n"						\
> +"	bne-	1b\n"							\
> +	: "=3D&r" (res), "=3D&r" (t), "+m" (v->counter)			\
> +	: "r" (a), "r" (&v->counter)					\
> +	: "cc");							\
> +									\
> +	return t;							\
> +}
> +
>  #define ATOMIC64_OPS(op, asm_op)					\
>  	ATOMIC64_OP(op, asm_op)						\
> -	ATOMIC64_OP_RETURN_RELAXED(op, asm_op)
> +	ATOMIC64_OP_RETURN_RELAXED(op, asm_op)				\
> +	ATOMIC64_FETCH_OP_RELAXED(op, asm_op)
> =20
>  ATOMIC64_OPS(add, add)
>  ATOMIC64_OPS(sub, subf)
> -ATOMIC64_OP(and, and)
> -ATOMIC64_OP(or, or)
> -ATOMIC64_OP(xor, xor)
> =20
>  #define atomic64_add_return_relaxed atomic64_add_return_relaxed
>  #define atomic64_sub_return_relaxed atomic64_sub_return_relaxed
> =20
> +#define atomic64_fetch_add_relaxed atomic64_fetch_add_relaxed
> +#define atomic64_fetch_sub_relaxed atomic64_fetch_sub_relaxed
> +
> +#undef ATOMIC64_OPS
> +#define ATOMIC64_OPS(op, asm_op)					\
> +	ATOMIC64_OP(op, asm_op)						\
> +	ATOMIC64_FETCH_OP_RELAXED(op, asm_op)
> +
> +ATOMIC64_OPS(and, and)
> +ATOMIC64_OPS(or, or)
> +ATOMIC64_OPS(xor, xor)
> +
> +#define atomic64_fetch_and_relaxed atomic64_fetch_and_relaxed
> +#define atomic64_fetch_or_relaxed  atomic64_fetch_or_relaxed
> +#define atomic64_fetch_xor_relaxed atomic64_fetch_xor_relaxed
> +
>  #undef ATOPIC64_OPS
> +#undef ATOMIC64_FETCH_OP_RELAXED
>  #undef ATOMIC64_OP_RETURN_RELAXED
>  #undef ATOMIC64_OP
> =20
>=20
>=20

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXGlRRAAoJEEl56MO1B/q4hyoH/0qvpP+MVq1isOPXwNbJy6MZ
xBWCO3Jpw2x7FoPG0ONG1HioE2fUrze9I/4Hus7nFaySf+oegDYhsQG2DyD7k6L0
xVJi4b6OvRquoQQrvFJVmXsaJk+ihtUmMMcxyHuNa2WlePQ2wSZkMDxB5ikyIFPR
kKVbc7zAk5zLLi9nNUiZJN5InTKYFoU8AnJpy/9TV7VSOcr/hrcfeeaxgXTYR0Gf
iIuAiQigQ69TCiwDdVJAqy9jT1zLVtkyINZX8/wyDSahCJvv9pl/e7dTwgL3lVjp
lwVDmW4E+o13fRZJWTb9K/RhcCrkRPyUBN0UVWYVOVaysS9mBH2PXcpPshpAwdY=
=O5Bw
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
