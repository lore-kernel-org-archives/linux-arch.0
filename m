From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 9/9] RISC-V: Build Infastructure
Date: Wed, 28 Jun 2017 23:54:42 +0100
Message-ID: <20170628225442.GP6973@jhogan-linux.le.imgtec.org>
References: <20170606230007.19101-1-palmer@dabbelt.com>
 <20170628185538.1804-1-palmer@dabbelt.com>
 <20170628185538.1804-10-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SNlyIF2RY6TSxS+s"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:55618 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751581AbdF1Wyp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2017 18:54:45 -0400
Content-Disposition: inline
In-Reply-To: <20170628185538.1804-10-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

--SNlyIF2RY6TSxS+s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Jun 28, 2017 at 11:55:38AM -0700, Palmer Dabbelt wrote:
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> new file mode 100644
> index 000000000000..7f58cd251ab8
> --- /dev/null
> +++ b/arch/riscv/kernel/Makefile
> @@ -0,0 +1,16 @@
> +#
> +# Makefile for the RISC-V Linux kernel
> +#
> +
> +extra-y := head.o vmlinux.lds
> +
> +obj-y	:= cpu.o entry.o irq.o process.o ptrace.o reset.o setup.o \
> +	   signal.o syscall_table.o sys_riscv.o time.o traps.o \
> +	   riscv_ksyms.o stacktrace.o vdso.o cacheinfo.o vdso/

I would suggest splitting these sort of things onto separate lines.
It'll make later changes much more readable (especially when you're
escaping newlines) as well as avoiding conflicts.

> +
> +CFLAGS_setup.o := -mcmodel=medany
> +
> +obj-$(CONFIG_SMP)		+= smpboot.o smp.o

same here

> +obj-$(CONFIG_MODULES)		+= module.o
> +
> +clean:

> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> new file mode 100644
> index 000000000000..120c38e77a46
> --- /dev/null
> +++ b/arch/riscv/lib/Makefile
> @@ -0,0 +1,5 @@
> +lib-y	:= delay.o memcpy.o memset.o uaccess.o

and here

> +
> +ifeq ($(CONFIG_64BIT),)
> +lib-y += udivdi3.o
> +endif

Would this work?

lib-$(CONFIG_32BIT) += udivdi3.o

> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> new file mode 100644
> index 000000000000..36ebe6feb5d6
> --- /dev/null
> +++ b/arch/riscv/mm/Makefile
> @@ -0,0 +1 @@
> +obj-y := init.o fault.o extable.o ioremap.o

and here

Cheers
James

--SNlyIF2RY6TSxS+s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllUM7EACgkQbAtpk944
dnqY8g//T43SRRevae1FAwK30wqya9pogFnNtuvS2l0dlFqrSl6eGqb0PN4hV8Lx
+tlQx4GGHuOOdPNHlAALCDMo+Jn7YYRG5rJotPO+LZknGsVqMdb1wU7ddB9bqBkl
AgZGUBwf90kkZ112LfosK9ftQLeWFUpPpCI+Tl5UiNvP8ytnECVPc9wO/wiQ1bZ0
Via4W3JzaMphj46KrXd8gSgUUI5BbGQtXMMqka4KvcTTcRWeBd601gTZECP738Uh
/cu49mP73PH/RyU9ianoVEvUzBbqBxMmeMe4DCUEf4IA+RUOlEl0owIRX2PKempK
rhfayOdNxXZOEgGrCkRC+hqhcxi0PSpviwQ1MHYUskH+6ayP6rRPHuSgwj562OT8
p5xhv18RY+fHTiM7VJeFnVemZJ9t4icNN0vCbScR3g0UQXqVD8LeYDFqnojyipNg
qcWMRK+pfw86Nuvkf0DvAG99IcVo0J5523PNQFtMe0uD8VB76wIPPJ6bwNJlv9mU
hORW9eC9vBhSW4dDnOsy1t9HNP6ZCG/srHKjfDcD+1uQ4Lu1L2Haeix91KFwC//P
3OyerLd6n1pT7SB95Tjjliv5Y4whUTjq35IoLcDJ4K2amp/R21T/LsKO/udHsyzR
hAHqPz/1aCpT8fapixK5Flb1fBspvF/p6bssSgxg2dAGaqX35qs=
=V32B
-----END PGP SIGNATURE-----

--SNlyIF2RY6TSxS+s--
