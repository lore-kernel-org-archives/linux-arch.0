From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC][PATCH 14/31] locking,metag: Implement
 atomic_fetch_{add,sub,and,or,xor}()
Date: Sat, 30 Apr 2016 01:20:31 +0100
Message-ID: <20160430002031.GB15188@jhogan-linux.le.imgtec.org>
References: <20160422090413.393652501@infradead.org>
 <20160422093923.941873289@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:15500 "EHLO
	imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752363AbcD3AUe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2016 20:20:34 -0400
Content-Disposition: inline
In-Reply-To: <20160422093923.941873289@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Fri, Apr 22, 2016 at 11:04:27AM +0200, Peter Zijlstra wrote:
> Implement FETCH-OP atomic primitives, these are very similar to the
> existing OP-RETURN primitives we already have, except they return the
> value of the atomic variable _before_ modification.
>=20
> This is especially useful for irreversible operations -- such as
> bitops (because it becomes impossible to reconstruct the state prior
> to modification).
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/metag/include/asm/atomic.h        |    2 +
>  arch/metag/include/asm/atomic_lnkget.h |   36 ++++++++++++++++++++++++++=
+++----
>  arch/metag/include/asm/atomic_lock1.h  |   33 ++++++++++++++++++++++++++=
----
>  3 files changed, 63 insertions(+), 8 deletions(-)
>=20
> --- a/arch/metag/include/asm/atomic.h
> +++ b/arch/metag/include/asm/atomic.h
> @@ -17,6 +17,8 @@
>  #include <asm/atomic_lnkget.h>
>  #endif
> =20
> +#define atomic_fetch_or atomic_fetch_or
> +
>  #define atomic_add_negative(a, v)       (atomic_add_return((a), (v)) < 0)
> =20
>  #define atomic_dec_return(v) atomic_sub_return(1, (v))
> --- a/arch/metag/include/asm/atomic_lnkget.h
> +++ b/arch/metag/include/asm/atomic_lnkget.h
> @@ -69,16 +69,44 @@ static inline int atomic_##op##_return(i
>  	return result;							\
>  }
> =20
> -#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op)
> +#define ATOMIC_FETCH_OP(op)						\
> +static inline int atomic_fetch_##op(int i, atomic_t *v)			\
> +{									\
> +	int result, temp;						\
> +									\
> +	smp_mb();							\
> +									\
> +	asm volatile (							\
> +		"1:	LNKGETD %1, [%2]\n"				\
> +		"	" #op "	%0, %1, %3\n"				\

i was hoping never to have to think about meta asm constraints again :-P

and/or/xor are only available in the data units, as determined by %1 in
this case, so the constraint for result shouldn't have "a" in it.

diff --git a/arch/metag/include/asm/atomic_lnkget.h b/arch/metag/include/as=
m/atomic_lnkget.h
index 50ad05050947..def2c642f053 100644
--- a/arch/metag/include/asm/atomic_lnkget.h
+++ b/arch/metag/include/asm/atomic_lnkget.h
@@ -84,7 +84,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)		=
	\
 		"	ANDT	%0, %0, #HI(0x3f000000)\n"		\
 		"	CMPT	%0, #HI(0x02000000)\n"			\
 		"	BNZ 1b\n"					\
-		: "=3D&d" (temp), "=3D&da" (result)				\
+		: "=3D&d" (temp), "=3D&d" (result)				\
 		: "da" (&v->counter), "bd" (i)				\
 		: "cc");						\

That also ensures the "bd" constraint for %3 (meaning "an op2 register
where op1 [%1 in this case] is a data unit register and the instruction
supports O2R") is consistent.

So with that change this patch looks good to me:
Acked-by: James Hogan <james.hogan@imgtec.com>


Note that for the ATOMIC_OP_RETURN() case (add/sub only) either address
or data units can be used (hence the "da" for %1), but then the "bd"
constraint on %3 is wrong as op1 [%1] may not be in data unit (sorry I
didn't spot that at the time). I'll queue a fix, something like below
probably ("br" means "An Op2 register and the instruction supports O2R",
i.e. op1/%1 doesn't have to be a data unit register):

diff --git a/arch/metag/include/asm/atomic_lnkget.h b/arch/metag/include/as=
m/atomic_lnkget.h
index 50ad05050947..def2c642f053 100644
--- a/arch/metag/include/asm/atomic_lnkget.h
+++ b/arch/metag/include/asm/atomic_lnkget.h
@@ -61,7 +61,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v=
)		\
 		"	CMPT	%0, #HI(0x02000000)\n"			\
 		"	BNZ 1b\n"					\
 		: "=3D&d" (temp), "=3D&da" (result)				\
-		: "da" (&v->counter), "bd" (i)				\
+		: "da" (&v->counter), "br" (i)				\
 		: "cc");						\
 									\
 	smp_mb();							\
 									\							\

Thanks
James

> +		"	LNKSETD [%2], %0\n"				\
> +		"	DEFR	%0, TXSTAT\n"				\
> +		"	ANDT	%0, %0, #HI(0x3f000000)\n"		\
> +		"	CMPT	%0, #HI(0x02000000)\n"			\
> +		"	BNZ 1b\n"					\
> +		: "=3D&d" (temp), "=3D&da" (result)				\
> +		: "da" (&v->counter), "bd" (i)				\
> +		: "cc");						\
> +									\
> +	smp_mb();							\
> +									\
> +	return result;							\
> +}
> +
> +#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op) ATOMIC_FETCH_O=
P(op)
> =20
>  ATOMIC_OPS(add)
>  ATOMIC_OPS(sub)
> =20
> -ATOMIC_OP(and)
> -ATOMIC_OP(or)
> -ATOMIC_OP(xor)
> +#undef ATOMIC_OPS
> +#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
> +
> +ATOMIC_OPS(and)
> +ATOMIC_OPS(or)
> +ATOMIC_OPS(xor)
> =20
>  #undef ATOMIC_OPS
> +#undef ATOMIC_FETCH_OP
>  #undef ATOMIC_OP_RETURN
>  #undef ATOMIC_OP
> =20
> --- a/arch/metag/include/asm/atomic_lock1.h
> +++ b/arch/metag/include/asm/atomic_lock1.h
> @@ -64,15 +64,40 @@ static inline int atomic_##op##_return(i
>  	return result;							\
>  }
> =20
> -#define ATOMIC_OPS(op, c_op) ATOMIC_OP(op, c_op) ATOMIC_OP_RETURN(op, c_=
op)
> +#define ATOMIC_FETCH_OP(op, c_op)					\
> +static inline int atomic_fetch_##op(int i, atomic_t *v)			\
> +{									\
> +	unsigned long result;						\
> +	unsigned long flags;						\
> +									\
> +	__global_lock1(flags);						\
> +	result =3D v->counter;						\
> +	fence();							\
> +	v->counter c_op i;						\
> +	__global_unlock1(flags);					\
> +									\
> +	return result;							\
> +}
> +
> +#define ATOMIC_OPS(op, c_op)						\
> +	ATOMIC_OP(op, c_op)						\
> +	ATOMIC_OP_RETURN(op, c_op)					\
> +	ATOMIC_FETCH_OP(op, c_op)
> =20
>  ATOMIC_OPS(add, +=3D)
>  ATOMIC_OPS(sub, -=3D)
> -ATOMIC_OP(and, &=3D)
> -ATOMIC_OP(or, |=3D)
> -ATOMIC_OP(xor, ^=3D)
> =20
>  #undef ATOMIC_OPS
> +#define ATOMIC_OPS(op, c_op)						\
> +	ATOMIC_OP(op, c_op)						\
> +	ATOMIC_FETCH_OP(op, c_op)
> +
> +ATOMIC_OPS(and, &=3D)
> +ATOMIC_OPS(or, |=3D)
> +ATOMIC_OPS(xor, ^=3D)
> +
> +#undef ATOMIC_OPS
> +#undef ATOMIC_FETCH_OP
>  #undef ATOMIC_OP_RETURN
>  #undef ATOMIC_OP
> =20
>=20
>=20

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXI/pOAAoJEGwLaZPeOHZ6McoQAILWrlj7yPdWvEuEu1ppqntI
u1jRQBO9lTVzUH1opU2FKtZtT6/SkIAmiGOVjytodIfx+wkqy7I64ZDen3YjXdNA
5y6vrMr1CAQd++e4o56ia8RYlik8do95kj2VLlznu9F7JjSyXV0HAu3meL3EnpGy
TGEMeUf1aNAtfGJaXxSBAk8DjaXRxom/w3kZ+hYBHlK5LBB3ENFPqknnSXKQcS8c
e/ERouTx51jCO3mPS0jjtT1zGRMiZeGnorLgtgPlYVNcZDLJ7J5R1W/TnWJMA6pD
hXxJl3qAxeKTVtscRB2iASfByUR1C31D3bvf6H3DdTqOkaVloU6r7h9bJwjiB6r8
YdNQviP6dnUayR46g4lZtLsC0CRjFa6Bc6ufMohsKMmQdx9Lmh+XGc4mM36Zn5/F
SUlSp6bmWejnLCtuVFYvcPCbt9BZlTEQbnj4nkkl54XxAjK1NazLqtjS+uE+buyU
bP+hTpIN2YfXRmkLccUxDa/U8+WNu2rWOyf0QhLamGPLtVyt7nHgUdghl3hZq596
4HhG2ADmqxAUcnNaej5fnO3T84QbeJ8nPLVAN5218OO509UpWe/93CjdUTPAqyH5
XOqPP6UCmrrKdv50a4vmIxt/qIP7Z2/SGUl/foCtVy2PaYoWxIkMdCMhmV6YbkmZ
6MbRNYgHd3q7TA1japC+
=5VM6
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
