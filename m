From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [patches] [PATCH 1/9] RISC-V: Init and Halt Code
Date: Fri, 7 Jul 2017 14:58:55 +0200
Message-ID: <20170707125855.rgqp432a62kmskhr@latitude>
References: <20170704215401.whmxuedbu3jd7uf5@latitude>
 <mhng-c095ae8f-4e14-4984-b4d8-10f3b27a2135@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hghahaihv7gffyi3"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:57938 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbdGGNAm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Jul 2017 09:00:42 -0400
Content-Disposition: inline
In-Reply-To: <mhng-c095ae8f-4e14-4984-b4d8-10f3b27a2135@palmer-si-x1c4>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: j.neuschaefer@gmx.net, patches@groups.riscv.org, peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com


--hghahaihv7gffyi3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 03:34:39PM -0700, Palmer Dabbelt wrote:
> On Tue, 04 Jul 2017 14:54:01 PDT (-0700), j.neuschaefer@gmx.net wrote:
[...]
> >> +#define DO_ERROR_INFO(name, signo, code, str)				\
> >> +asmlinkage void name(struct pt_regs *regs)				\
> >> +{									\
> >> +	do_trap_error(regs, signo, code, regs->sepc, "Oops - " str);	\
> >> +}
> >> +
> >> +DO_ERROR_INFO(do_trap_unknown,
> >> +	SIGILL, ILL_ILLTRP, "unknown exception");
> >> +DO_ERROR_INFO(do_trap_insn_misaligned,
> >> +	SIGBUS, BUS_ADRALN, "instruction address misaligned");
> >> +DO_ERROR_INFO(do_trap_insn_fault,
> >> +	SIGBUS, BUS_ADRALN, "instruction access fault");
> >
> > For a general instruction access fault, BUS_ADRALN seems wrong. A
> > variant of SIGSEGV seems more appropriate, IMHO.
>=20
> How does this look?
>=20
>   diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>   index 4c693b5b9980..3ce9ac6e736e 100644
>   --- a/arch/riscv/kernel/traps.c
>   +++ b/arch/riscv/kernel/traps.c
>   @@ -112,7 +112,7 @@ DO_ERROR_INFO(do_trap_unknown,
>    DO_ERROR_INFO(do_trap_insn_misaligned,
>           SIGBUS, BUS_ADRALN, "instruction address misaligned");
>    DO_ERROR_INFO(do_trap_insn_fault,
>   -       SIGBUS, BUS_ADRALN, "instruction access fault");
>   +       SIGBUS, SEGV_ACCERR, "instruction access fault");
>    DO_ERROR_INFO(do_trap_insn_illegal,
>           SIGILL, ILL_ILLOPC, "illegal instruction");
>    DO_ERROR_INFO(do_trap_load_misaligned,

I'm not familiar with the trap handling infrastructure, but looking at
include/uapi/asm-generic/siginfo.h, SEGV_ACCERR would alias to
BUS_ADRERR (both are defined as (__SI_FAULT|2)). So if you use SEGV_*,
you need to use SIGSEGV, too.

With DO_ERROR_INFO(..., SIGSEGV, SEGV_ACCERR, ...); it looks good to me.


Jonathan Neusch=C3=A4fer

--hghahaihv7gffyi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJZX4WGAAoJEAgwRJqO81/btq0P/2quCmxHDgBfEuncGEMAJ1aj
0NZzf8F/gHS7079KuTywiRfRs517oq3bM1Sq4+PA/Qo2+OqUihWYXKhYSFuIMmNV
LbPzXCotdBK16QxvcMnIIGcW/T9aBi61l1y51ivZxLCRuCcf75oSkJQF+pfrlESG
/DJiMwb3EAqIOYwRILDOb4o6blXXoSfEt4zoQnILLmTHC4YxqWeCGie7gQ3huTst
tLSrT5YMK1HZAslFYgs9TA0227RjQ+oOdPJCOb+Yf1QFLqX8sebk6163LYApBYfZ
dx6dxrRUDC9Fzt4Q6/6AwTmd0FeavrvTWKAToM3A1g/jteGUwJN2ya45BzSgNdEY
mHoq+NuxLVfnf8yLCzwQtjJ0T7rFK8RrjZKrc1jXo46DqaCJz17RvLmnXJNnUi8W
BY0p4pDpPfxpJqZmf9aBlG0DejolK7r8rxGz8DVnJjkHhyyQEvgfxCUDZH42u8ok
FDM/ACYi81RGGLQ++ANil8FQCRK/0Lvg8J2fgD5DKxWws0s8AA7MeO7mEnXuAhZO
uxBtY7z+/5c1EYUKfDksO1CG7fwjO/hEi3tkYYEVb0yqBowLIVmGWUJivb2SL/gZ
2bfm5HNYNzDFJ7a3L/jkBfUcZ8W0h5R/EsCFqkBevB5eltrDjccKnV6+UcK26Qkb
OkTlGPE9iQLgpZ43aYyk
=C55K
-----END PGP SIGNATURE-----

--hghahaihv7gffyi3--
