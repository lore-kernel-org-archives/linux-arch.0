From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCHv3] arm: Preserve the user r/w register TPIDRURW on
 context switch and fork
Date: Wed, 8 May 2013 09:57:53 +0100
Message-ID: <20130508085753.GA15568@mudshark.cambridge.arm.com>
References: <51896934.5080803@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51896934.5080803@dawncrow.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Andr=E9?= Hentschel <nerv@dawncrow.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Jonathan Austin <Jonathan.Austin@arm.com>
List-Id: linux-arch.vger.kernel.org

Hi Andre,

On Tue, May 07, 2013 at 09:51:00PM +0100, Andr=E9 Hentschel wrote:
> From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Hentschel?=3D <nerv@dawncrow.de>

Might just be my mailer, but you should check that your name is intact =
here
otherwise the git log will be mangled.

> Since commit 6a1c53124aa1 the user writeable TLS register was zeroed =
to
> prevent it from being used as a covert channel between two tasks.
>=20
> There are more and more applications coming to WinRT, Wine could supp=
ort them,
> but mostly they expect to have the thread environment block (TEB) in =
TPIDRURW.
>=20
> This patch preserves that register per thread instead of clearing it.
> Unlike the TPIDRURO, which is already switched, the TPIDRURW
> can be updated from userspace so needs careful treatment in the case =
that we
> modify TPIDRURW and call fork(). To avoid this we must always read
> TPIDRURW in copy_thread.
>=20
> Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>=20

[...]

> diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
> index 73409e6..22756ab 100644
> --- a/arch/arm/include/asm/tls.h
> +++ b/arch/arm/include/asm/tls.h
> @@ -2,27 +2,30 @@
>  #define __ASMARM_TLS_H
> =20
>  #ifdef __ASSEMBLY__
> -	.macro set_tls_none, tp, tmp1, tmp2
> +#include <asm/asm-offsets.h>
> +	.macro switch_tls_none, base, tp, tpuser, tmp1, tmp2
>  	.endm
> =20
> -	.macro set_tls_v6k, tp, tmp1, tmp2
> +	.macro switch_tls_v6k, base, tp, tpuser, tmp1, tmp2
> +	mrc	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
>  	mcr	p15, 0, \tp, c13, c0, 3		@ set TLS register
> -	mov	\tmp1, #0
> -	mcr	p15, 0, \tmp1, c13, c0, 2	@ clear user r/w TLS register
> +	mcr	p15, 0, \tpuser, c13, c0, 2	@ and the user r/w register
> +	strne	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it

Why is this conditional?

>  	.endm
> =20
> -	.macro set_tls_v6, tp, tmp1, tmp2
> +	.macro switch_tls_v6, base, tp, tpuser, tmp1, tmp2
>  	ldr	\tmp1, =3Delf_hwcap
>  	ldr	\tmp1, [\tmp1, #0]
>  	mov	\tmp2, #0xffff0fff
>  	tst	\tmp1, #HWCAP_TLS		@ hardware TLS available?
> -	mcrne	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
> -	movne	\tmp1, #0
> -	mcrne	p15, 0, \tmp1, c13, c0, 2	@ clear user r/w TLS register
>  	streq	\tp, [\tmp2, #-15]		@ set TLS value at 0xffff0ff0
> +	mrcne	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
> +	mcrne	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
> +	mcrne	p15, 0, \tpuser, c13, c0, 2	@ set user r/w register
> +	strne	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it
>  	.endm
> =20
> -	.macro set_tls_software, tp, tmp1, tmp2
> +	.macro switch_tls_software, base, tp, tpuser, tmp1, tmp2
>  	mov	\tmp1, #0xffff0fff
>  	str	\tp, [\tmp1, #-15]		@ set TLS value at 0xffff0ff0
>  	.endm
> @@ -31,19 +34,31 @@
>  #ifdef CONFIG_TLS_REG_EMUL
>  #define tls_emu		1
>  #define has_tls_reg		1
> -#define set_tls		set_tls_none
> +#define switch_tls	switch_tls_none
>  #elif defined(CONFIG_CPU_V6)
>  #define tls_emu		0
>  #define has_tls_reg		(elf_hwcap & HWCAP_TLS)
> -#define set_tls		set_tls_v6
> +#define switch_tls	switch_tls_v6
>  #elif defined(CONFIG_CPU_32v6K)
>  #define tls_emu		0
>  #define has_tls_reg		1
> -#define set_tls		set_tls_v6k
> +#define switch_tls	switch_tls_v6k
>  #else
>  #define tls_emu		0
>  #define has_tls_reg		0
> -#define set_tls		set_tls_software
> +#define switch_tls	switch_tls_software
>  #endif
> =20
> +#ifndef __ASSEMBLY__
> +static inline unsigned long get_tlsuser(void)
> +{
> +	if (has_tls_reg && !tls_emu)
> +	{
> +		unsigned long t;
> +		__asm__("mrc p15, 0, %0, c13, c0, 2" : "=3Dr" (t));
> +		return t;
> +	}
> +	return 0;

This isn't standard kernel coding style. Please do something like:

	static inline unsigned long get_tlsuser(void)
	{
		unsigned long reg =3D 0;

		if (has_tls_reg && !tls_emu)
			asm("mrc p15, 0, %0, c13, c0, 2" : "=3Dr" (reg));

		return reg;
	}

Will
