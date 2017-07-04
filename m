From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [patches] [PATCH 1/9] RISC-V: Init and Halt Code
Date: Tue, 4 Jul 2017 23:54:01 +0200
Message-ID: <20170704215401.whmxuedbu3jd7uf5@latitude>
References: <20170704195102.3974-1-palmer@dabbelt.com>
 <20170704195102.3974-2-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5f6agwiozkxzrbl4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170704195102.3974-2-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: patches@groups.riscv.org
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>
List-Id: linux-arch.vger.kernel.org


--5f6agwiozkxzrbl4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, below are some small comments.

On Tue, Jul 04, 2017 at 12:50:54PM -0700, Palmer Dabbelt wrote:
> This contains the various __init C functions, the initial assembly
> kernel entry point, and the code to reset the system.  When a file was
> init-related, it contains

It contains what?

> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
[...]

> +#ifdef CONFIG_GENERIC_BUG
> +#define __BUG_INSN	_AC(0x00100073, UL) /* sbreak */

This should be ebreak, not sbreak, in Priv Spec 1.10, AFAICT.
I guess binutils still understands sbreak, but it's nicer to stick to
the spec, IMHO.

> +#define BUG()							\
> +do {								\
> +	__asm__ __volatile__ (					\
> +		"1:\n\t"					\
> +			"sbreak\n"				\

ebreak

> +			".pushsection __bug_table,\"a\"\n\t"	\
> +		"2:\n\t"					\
> +			__BUG_ENTRY "\n\t"			\
> +			".org 2b + %2\n\t"			\
> +			".popsection"				\
> +		:						\
> +		: "i" (__FILE__), "i" (__LINE__),		\
> +		  "i" (sizeof(struct bug_entry)));		\
> +	unreachable();						\
> +} while (0)
> +#endif /* !__ASSEMBLY__ */
> +#else /* CONFIG_GENERIC_BUG */
> +#ifndef __ASSEMBLY__
> +#define BUG()							\
> +do {								\
> +	__asm__ __volatile__ ("sbreak\n");			\

ebreak

> +	unreachable();						\
> +} while (0)
> +#endif /* !__ASSEMBLY__ */
> +#endif /* CONFIG_GENERIC_BUG */
[...]

> +#define DO_ERROR_INFO(name, signo, code, str)				\
> +asmlinkage void name(struct pt_regs *regs)				\
> +{									\
> +	do_trap_error(regs, signo, code, regs->sepc, "Oops - " str);	\
> +}
> +
> +DO_ERROR_INFO(do_trap_unknown,
> +	SIGILL, ILL_ILLTRP, "unknown exception");
> +DO_ERROR_INFO(do_trap_insn_misaligned,
> +	SIGBUS, BUS_ADRALN, "instruction address misaligned");
> +DO_ERROR_INFO(do_trap_insn_fault,
> +	SIGBUS, BUS_ADRALN, "instruction access fault");

For a general instruction access fault, BUS_ADRALN seems wrong. A
variant of SIGSEGV seems more appropriate, IMHO.


Jonathan Neusch=C3=A4fer

--5f6agwiozkxzrbl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJZXA5wAAoJEAgwRJqO81/bWI8QAKAMZsol9wgY7Gr3UlBVe7sM
y9wkWSnWE9byQjuDObmd4Bu31Te/6dvPYZbMUthygY/pIDrCq89Tb6urILKMMPzB
6TmtYCWwitgn37FhiOa0qkh3LPoiVJP6N/zE2hATFxoTXWPiNjEW7qIDLymks5E5
bfst0l+8dc320hzezSF1X0GQ6dUzTDBlN7oD1CYEiVX3PhjjIiYLlA+glf6yBbhn
nlo1tHigJ8FNRYun2QExyNX45/nzRrmPTPwr9O39Gv3HJrPtxmb9B/xRrPcE/j1m
pEhJtzDBjFPntNqTij4tGAxOaZ7I5j9fORmwlPMkioFPptI0UrddC/jHFWv+1yw6
7p77grekfRY7WeF1wA4aPRWvG9AREp6ggEDqohRuyI3wv7TQ31BgI7YT2T2OxMct
YeN1LWQnMM0QL3TDMNdhexOizNfzX33mNEZiCUjNlpvo1eDwk0tlVKPGHNGsZVt9
dVIqpy+VY3Zs+lOpi0fcydQwNz1kvbPuLNiQwcWLPUoambuMXZplmMMOcJxPBaRH
qh13E10z/pzNSg6W/TrS5TvB76sYegYMpOLMbbjeaj4KzD2vwJc6zPGy9Ig5FMJM
ITCh/AEQCAMerorLbGHfGFnmeY+wdDKDfYulGQQlTpOBbMIgwSObTbIILhmYokB7
g4anEWTYrloLQPHR57Mo
=pXaG
-----END PGP SIGNATURE-----

--5f6agwiozkxzrbl4--
