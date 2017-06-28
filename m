From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 5/9] RISC-V: Task implementation
Date: Thu, 29 Jun 2017 00:32:55 +0100
Message-ID: <20170628233254.GR6973@jhogan-linux.le.imgtec.org>
References: <20170606230007.19101-1-palmer@dabbelt.com>
 <20170628185538.1804-1-palmer@dabbelt.com>
 <20170628185538.1804-6-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pwryyPyu+zbGuqhB"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:56865 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751855AbdF1Xc5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2017 19:32:57 -0400
Content-Disposition: inline
In-Reply-To: <20170628185538.1804-6-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

--pwryyPyu+zbGuqhB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Jun 28, 2017 at 11:55:34AM -0700, Palmer Dabbelt wrote:
> diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
> new file mode 100644
> index 000000000000..1190de7a0f74
> --- /dev/null
> +++ b/arch/riscv/include/asm/kprobes.h
> @@ -0,0 +1,22 @@
...
> +#ifdef CONFIG_KPROBES
> +#error "RISC-V doesn't skpport CONFIG_KPROBES"
> +#endif

I'm wondering where your fallback definition of e.g. NOKPROBE_SYMBOL
comes from then.

Could you just use the asm-generic one?

> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> new file mode 100644
> index 000000000000..b13d3ea3bf79
> --- /dev/null
> +++ b/arch/riscv/kernel/process.c
> @@ -0,0 +1,131 @@
...
> +void show_regs(struct pt_regs *regs)
> +{
> +	show_regs_print_info(KERN_DEFAULT);
> +
> +	printk(KERN_CONT "sepc: " REG_FMT " ra : " REG_FMT " sp : " REG_FMT "\n",
> +		regs->sepc, regs->ra, regs->sp);

I've noticed inconsistent use of pr_* and printk(KERN_* in this
patchset. Maybe now would be the best time to switch everything to pr_*.

> +	/* Reset FPU context
> +	 *	frm: round to nearest, ties to even (IEEE default)
> +	 *	fflags: accrued exceptions cleared
> +	 */

Similarly lots of multiline comments which don't follow the standard
style in Documentation/process/coding-style.rst. Maybe now is the best
time to convert if you're going to.

Cheers
James

--pwryyPyu+zbGuqhB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllUPKUACgkQbAtpk944
dno2DA//e5F9pwnHRB+EDJ5fjsGvmESzgbMze/klYnCEB29Vjxzoz8qXvupNaJ/T
IxUmW4nxdHd3chMT7ivMypZciTjYReBlNIX0CuLebdXaureKo3VxLMmnW5kmdA6m
BhuxnFgyQn6mcxBrqHs8wtJTNY2VG/BYBR8ks2YsMzpS0e4ryM8pw0gQ/1iyE4bm
UoSp5jnnaQOH46h4FakyXIHAM0ze8/fYQ6Lt5aAjE5rYIxDEX8JVLc+T+Iz8hnCM
FQ0Cf3acVSsEK+FXHc3vsRFxErn6g4y+MiDEUp2/94BkgPiicGleW6TvvYi2iuea
WqE0NeQ/IikSbRBr9QUaKeoIiQciUYws6N6MKFQVaLNjw08qcLdIypkrJuFAJksp
xGKkxIoarMLbSHvKxU55Jaa///4VXU3RxPLT6+dptyp1oV7ysc8A3Oxhq0LH/3Hs
mpsCdKKo+npPXMqFBk32BDSpncsD9zZWkYdwMB9phmOoXHmwtX/oZt6Z95gT+gvZ
5fWu3udBzPq2N7KW57V0iDSzswwWIHJksIEPG+NEBK9prc8RRZvyVBwSAVrXNZpf
SFQK3oZtq20Fm5/q/lTIN9PD/MM7uxeFPhbPzE7iULWgi4L72pap0vFWYFb9NLWt
wauF0aJ5laUzvOhx/HsyJgV7L26JTL2LlYhh2WlkkLKH+0LLKc4=
=6cyv
-----END PGP SIGNATURE-----

--pwryyPyu+zbGuqhB--
