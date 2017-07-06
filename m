From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 2/9] RISC-V: Atomic and Locking Code
Date: Thu, 6 Jul 2017 18:33:57 +0800
Message-ID: <20170706103357.inu4hi52iogrwo77@tardis>
References: <20170704195102.3974-1-palmer@dabbelt.com>
 <20170704195102.3974-3-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cojvf22vkdy4eh5z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170704195102.3974-3-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org
List-Id: linux-arch.vger.kernel.org


--cojvf22vkdy4eh5z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 04, 2017 at 12:50:55PM -0700, Palmer Dabbelt wrote:
[...]
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> new file mode 100644
> index 000000000000..81025c056412
> --- /dev/null
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -0,0 +1,138 @@
> +/*
> + * Copyright (C) 2014 Regents of the University of California
> + *
> + *   This program is free software; you can redistribute it and/or
> + *   modify it under the terms of the GNU General Public License
> + *   as published by the Free Software Foundation, version 2.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + */
> +
> +#ifndef _ASM_RISCV_CMPXCHG_H
> +#define _ASM_RISCV_CMPXCHG_H
> +
> +#include <linux/bug.h>
> +
> +#ifdef CONFIG_ISA_A
> +
> +#include <asm/barrier.h>
> +
> +#define __xchg(new, ptr, size, asm_or)				\
> +({								\
> +	__typeof__(ptr) __ptr = (ptr);				\
> +	__typeof__(new) __new = (new);				\
> +	__typeof__(*(ptr)) __ret;				\
> +	switch (size) {						\
> +	case 4:							\
> +		__asm__ __volatile__ (				\
> +			"amoswap.w" #asm_or " %0, %2, %1"	\
> +			: "=r" (__ret), "+A" (*__ptr)		\
> +			: "r" (__new));				\

It seems that you miss the "memmory" clobber here, so as for cmpxchg(),
did you do this on purpose? AFAIK, without this clobber, compilers are
within their right to reorder operations preceding and following this
operation, which makes it unordered.

> +		break;						\
> +	case 8:							\
> +		__asm__ __volatile__ (				\
> +			"amoswap.d" #asm_or " %0, %2, %1"	\
> +			: "=r" (__ret), "+A" (*__ptr)		\
> +			: "r" (__new));				\
> +		break;						\
> +	default:						\
> +		BUILD_BUG();					\
> +	}							\
> +	__ret;							\
> +})
> +
> +#define xchg(ptr, x)    (__xchg((x), (ptr), sizeof(*(ptr)), .aqrl))
> +
> +#define xchg32(ptr, x)				\
> +({						\
> +	BUILD_BUG_ON(sizeof(*(ptr)) != 4);	\
> +	xchg((ptr), (x));			\
> +})
> +
> +#define xchg64(ptr, x)				\
> +({						\
> +	BUILD_BUG_ON(sizeof(*(ptr)) != 8);	\
> +	xchg((ptr), (x));			\
> +})
> +
> +/*
> + * Atomic compare and exchange.  Compare OLD with MEM, if identical,
> + * store NEW in MEM.  Return the initial value in MEM.  Success is
> + * indicated by comparing RETURN with OLD.
> + */
> +#define __cmpxchg(ptr, old, new, size, lrb, scb)			\
> +({									\
> +	__typeof__(ptr) __ptr = (ptr);					\
> +	__typeof__(old) __old = (old);					\
> +	__typeof__(new) __new = (new);					\

Better write those two lines as:

	__typeof__(*(ptr)) __old = (old);					\
	__typeof__(*(ptr)) __new = (new);					\

? I'm thinking the case where @old and @new are int and ptr is "long *",
could the asm below do the implicitly converting right, i.e. keep the
sign bit?

Regards,
Boqun

> +	__typeof__(*(ptr)) __ret;					\
> +	register unsigned int __rc;					\
> +	switch (size) {							\
> +	case 4:								\
> +		__asm__ __volatile__ (					\
> +		"0:"							\
> +			"lr.w" #scb " %0, %2\n"				\
> +			"bne         %0, %z3, 1f\n"			\
> +			"sc.w" #lrb " %1, %z4, %2\n"			\
> +			"bnez        %1, 0b\n"				\
> +		"1:"							\
> +			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
> +			: "rJ" (__old), "rJ" (__new));			\
> +		break;							\
> +	case 8:								\
> +		__asm__ __volatile__ (					\
> +		"0:"							\
> +			"lr.d" #scb " %0, %2\n"				\
> +			"bne         %0, %z3, 1f\n"			\
> +			"sc.d" #lrb " %1, %z4, %2\n"			\
> +			"bnez        %1, 0b\n"				\
> +		"1:"							\
> +			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
> +			: "rJ" (__old), "rJ" (__new));			\
> +		break;							\
> +	default:							\
> +		BUILD_BUG();						\
> +	}								\
> +	__ret;								\
> +})
> +
> +#define cmpxchg(ptr, o, n) \
> +	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr)), .aqrl, .aqrl))
> +
> +#define cmpxchg_local(ptr, o, n) \
> +	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr)), , ))
> +
> +#define cmpxchg32(ptr, o, n)			\
> +({						\
> +	BUILD_BUG_ON(sizeof(*(ptr)) != 4);	\
> +	cmpxchg((ptr), (o), (n));		\
> +})
> +
> +#define cmpxchg32_local(ptr, o, n)		\
> +({						\
> +	BUILD_BUG_ON(sizeof(*(ptr)) != 4);	\
> +	cmpxchg_local((ptr), (o), (n));		\
> +})
> +
> +#define cmpxchg64(ptr, o, n)			\
> +({						\
> +	BUILD_BUG_ON(sizeof(*(ptr)) != 8);	\
> +	cmpxchg((ptr), (o), (n));		\
> +})
> +
> +#define cmpxchg64_local(ptr, o, n)		\
> +({						\
> +	BUILD_BUG_ON(sizeof(*(ptr)) != 8);	\
> +	cmpxchg_local((ptr), (o), (n));		\
> +})
> +
> +#else /* !CONFIG_ISA_A */
> +
> +#include <asm-generic/cmpxchg.h>
> +
> +#endif /* CONFIG_ISA_A */
> +

[...]

--cojvf22vkdy4eh5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlleEhEACgkQSXnow7UH
+riGqAf/dFXvnZ2eglNfjUoEwjRN/M0OMYTlXeLzWDSVJBQ0ens9tOefXrSK7Bdf
ZfYi0KKXv3iZwJBUDURc7N7CDtua/KzHpB++onXKA3J2+fCaLfEcozkbZDyuRTED
NAL3smKtrgbjzhaR0TYNyaX8YTYEe42tvcntHIAmP109Eb8JhFj+zy+z8aXXegyb
6iGQDv/ZDU95CTQl4otPh/WZw49CV7MU58eujZIzGJ547PkyhgmIqcKpp5kE9woI
RtaDa5zgRprq+ldrqQ6eF3XrToh3STMjg1J4yQufW58cQ4Z9rWYWaMmFLautmPZy
MugOXVHXITEndA3X63Oqfpzjw54exw==
=UTpF
-----END PGP SIGNATURE-----

--cojvf22vkdy4eh5z--
