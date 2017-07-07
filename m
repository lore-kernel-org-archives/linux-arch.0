From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 2/9] RISC-V: Atomic and Locking Code
Date: Fri, 7 Jul 2017 10:14:25 +0800
Message-ID: <20170707021425.sssqytbf3gmbklwe@tardis>
References: <20170705084321.hqy4qsm45mv772k4@hirez.programming.kicks-ass.net>
 <mhng-c4e3a5d8-59ae-4db5-b6df-2d44fa07e83c@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yjxopaj2akqdak22"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33560 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753234AbdGGCOf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2017 22:14:35 -0400
Content-Disposition: inline
In-Reply-To: <mhng-c4e3a5d8-59ae-4db5-b6df-2d44fa07e83c@palmer-si-x1c4>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org


--yjxopaj2akqdak22
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 06:04:13PM -0700, Palmer Dabbelt wrote:
[...]
> >> +#define __smp_load_acquire(p)						\
> >> +do {									\
> >> +	union { typeof(*p) __val; char __c[1]; } __u =3D			\
> >> +		{ .__val =3D (__force typeof(*p)) (v) };			\
> >> +	compiletime_assert_atomic_type(*p);				\
> >> +	switch (sizeof(*p)) {						\
> >> +	case 1:								\
> >> +	case 2:								\
> >> +		__u.__val =3D READ_ONCE(*p);				\
> >> +		smb_mb();						\
> >> +		break;							\
> >> +	case 4:								\
> >> +		__asm__ __volatile__ (					\
> >> +			"amoor.w.aq %1, zero, %0"			\
> >> +			: "+A" (*p)					\
> >> +			: "=3Dr" (__u.__val)				\
> >> +			: "memory");					\
> >> +		break;							\
> >> +	case 8:								\
> >> +		__asm__ __volatile__ (					\
> >> +			"amoor.d.aq %1, zero, %0"			\
> >> +			: "+A" (*p)					\
> >> +			: "=3Dr" (__u.__val)				\
> >> +			: "memory");					\
> >> +		break;							\
> >> +	}								\
> >> +	__u.__val;							\
> >> +} while (0)
> >
> > 'creative' use of amoswap and amoor :-)
> >
> > You should really look at a normal load with ordering instruction
> > though, that amoor.aq is a rmw and will promote the cacheline to
> > exclusive (and dirty it).
>=20
> The thought here was that implementations could elide the MW by pattern
> matching the "zero" (x0, the architectural zero register) forms of AMOs w=
here
> it's interesting.  I talked to one of our microarchitecture guys, and whi=
le he
> agrees that's easy he points out that eliding half the AMO may wreak havo=
c on
> the consistency model.  Since we're not sure what the memory model is act=
ually
> going to look like, we thought it'd be best to just write the simplest co=
de
> here
>=20
>   /*
>    * TODO_RISCV_MEMORY_MODEL: While we could emit AMOs for the W and D si=
zed
>    * accesses here, it's questionable if that actually helps or not: the =
lack of
>    * offsets in the AMOs means they're usually preceded by an addi, so th=
ey
>    * probably won't save code space.  For now we'll just emit the fence.
>    */
>   #define __smp_store_release(p, v)                                      =
 \
>   ({                                                                     =
 \
>           compiletime_assert_atomic_type(*p);                            =
 \
>           smp_mb();                                                      =
 \
>           WRITE_ONCE(*p, v);                                             =
 \
>   })
>=20
>   #define __smp_load_acquire(p)                                          =
 \
>   ({                                                                     =
 \
>           union{typeof(*p) __p; long __l;} __u;                          =
 \

AFAICT, there seems to be an endian issue if you do this. No?

Let us assume typeof(*p) is char and *p =3D=3D 1, and on a big endian 32bit
platform:

>           compiletime_assert_atomic_type(*p);                            =
 \
>           __u.__l =3D READ_ONCE(*p);                                     =
   \

	READ_ONCE(*p) is 1 so
	__u.__l is 0x00 00 00 01 now

>           smp_mb();                                                      =
 \
>           __u.__p;                                                       =
 \

	__u.__p is then 0x00.

Am I missing something here?

Even so why not use the simple definition as in include/asm-generic/barrier=
=2Eh?

Regards,
Boqun



>   })
>=20
[...]

--yjxopaj2akqdak22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlle7n0ACgkQSXnow7UH
+rhG5QgAlNYGKN3609sb0Lq6b+lBeZ3agL20lUs8PD3lIxwpVkqtw2TdLVSAwwl0
k8ffV/q1G4qHmiBtYEvCcOSDRpfsZIpeQnBHTAmMHb6svSwQ4kCNdgLqdEudmd4t
Xj3AIRyMmsbSpMMqhUcDCPkTWjxDndeYbEoLa7DU0x/oaMllYElIZmYbq9K7w13A
NT51zTTXIGp1/V3aOhR+L76J0HpUt1IeaNOKVfmWFOs9MDHILVdPJF2Z3bxMJzrr
+2IDTqN5wCwHtkzWAD4bJSUPELaDP9pezxNS5MSimERRNkunhEK6/qYq2j/Qwh62
0x4VvPlMUfxXYaDmrljHDqZqIca+cg==
=+c/U
-----END PGP SIGNATURE-----

--yjxopaj2akqdak22--
