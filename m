From: Jonathan Austin <jonathan.austin@arm.com>
Subject: Re: arm: Only load TLS values when needed
Date: Tue, 16 Jul 2013 18:31:23 +0100
Message-ID: <51E5836B.1010904@arm.com>
References: <51E42E11.1010903@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34778 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab3GPRbh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2013 13:31:37 -0400
In-Reply-To: <51E42E11.1010903@dawncrow.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?B?QW5kcsOpIEhlbnRzY2hlbA==?= <nerv@dawncrow.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>

Hi Andr=C3=A9,

On 15/07/13 18:14, Andr=C3=A9 Hentschel wrote:
> From: Andr=C3=A9 Hentschel <nerv@dawncrow.de>
>
> This patch intents to reduce loading instructions when the resulting =
value is not used.
> It's a follow up on a4780adeefd042482f624f5e0d577bf9cdcbb760
>

Have you done any benchmarking to see that this has any real impact? Or=
=20
tested on a !Vv6k system? It looks possible that the only case where=20
this will perform better is where we're using switch_tls_none or=20
switch_tls_software (both rare cases, I think) and there's some change=20
it will make things worse in other cases?

One of the reasons for Russell's suggestion of placing the ldrd (which=20
became the two ldr instructions you've removed from __switch_to, in=20
order to maintain building for older cores) where it is was in order to=
=20
reduce the chance of pipeline stalls.

As I've pointed out below, there is some risk that changing that has=20
implications for the v6 only case below (and the v6k case is now more=20
prone to stalls with !CONFIG_CPU_USE_DOMAINS, but newer cores should=20
have more advanced scheduling to avoid such issues anyway...)

> Signed-off-by: Andr=C3=A9 Hentschel <nerv@dawncrow.de>
>
> ---
> This patch is against Linux 3.11-rc1 (ad81f0545ef01ea651886dddac4bef6=
cec930092)
>
> Thanks to everyone who helped me with a4780adeefd042482f624f5e0d577bf=
9cdcbb760
>
> diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
> index 83259b8..3742722 100644
> --- a/arch/arm/include/asm/tls.h
> +++ b/arch/arm/include/asm/tls.h
> @@ -3,29 +3,32 @@
>
>   #ifdef __ASSEMBLY__
>   #include <asm/asm-offsets.h>
> -	.macro switch_tls_none, base, tp, tpuser, tmp1, tmp2
> +	.macro switch_tls_none, prev, next, tp, tpuser, tmp1, tmp2
>   	.endm
>
> -	.macro switch_tls_v6k, base, tp, tpuser, tmp1, tmp2
> +	.macro switch_tls_v6k, prev, next, tp, tpuser, tmp1, tmp2
> +	ldrd	\tp, \tpuser, [\next, #TI_TP_VALUE]	@ get the next TLS and use=
r r/w register
>   	mrc	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
>   	mcr	p15, 0, \tp, c13, c0, 3		@ set TLS register
>   	mcr	p15, 0, \tpuser, c13, c0, 2	@ and the user r/w register
> -	str	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it
> +	str	\tmp2, [\prev, #TI_TP_VALUE + 4] @ save it
>   	.endm
>
> -	.macro switch_tls_v6, base, tp, tpuser, tmp1, tmp2
> +	.macro switch_tls_v6, prev, next, tp, tpuser, tmp1, tmp2
>   	ldr	\tmp1, =3Delf_hwcap
>   	ldr	\tmp1, [\tmp1, #0]
>   	mov	\tmp2, #0xffff0fff
> +	ldr	\tp, [\next, #TI_TP_VALUE]	@ get the next TLS register
>   	tst	\tmp1, #HWCAP_TLS		@ hardware TLS available?
>   	streq	\tp, [\tmp2, #-15]		@ set TLS value at 0xffff0ff0
> -	mrcne	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
> +	mrcne	p15, 0, \tmp2, c13, c0, 2	@ get the previous user r/w registe=
r
> +	ldrne	\tpuser, [\next, #TI_TP_VALUE + 4]	@ get the next user r/w re=
gister
>   	mcrne	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
>   	mcrne	p15, 0, \tpuser, c13, c0, 2	@ set user r/w register

Now we've only got one instruction between the store and the load and=20
risk stalling the pipeline...

Dave M cautiously says "The ancient advice was that one instruction was=
=20
enough" but this is very core dependent... I wonder if anyone has a goo=
d=20
idea about whether this is an issue here...?

> -	strne	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it
> +	strne	\tmp2, [\prev, #TI_TP_VALUE + 4] @ save it
>   	.endm
>
> -	.macro switch_tls_software, base, tp, tpuser, tmp1, tmp2
> +	.macro switch_tls_software, prev, next, tp, tpuser, tmp1, tmp2
>   	mov	\tmp1, #0xffff0fff
>   	str	\tp, [\tmp1, #-15]		@ set TLS value at 0xffff0ff0
>   	.endm
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-arm=
v.S
> index a39cfc2a1..1484b59 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -689,12 +689,10 @@ ENTRY(__switch_to)
>    THUMB(	stmia	ip!, {r4 - sl, fp}	   )	@ Store most regs on stack
>    THUMB(	str	sp, [ip], #4		   )
>    THUMB(	str	lr, [ip], #4		   )
> -	ldr	r4, [r2, #TI_TP_VALUE]
> -	ldr	r5, [r2, #TI_TP_VALUE + 4]
>   #ifdef CONFIG_CPU_USE_DOMAINS
>   	ldr	r6, [r2, #TI_CPU_DOMAIN]
>   #endif
> -	switch_tls r1, r4, r5, r3, r7
> +	switch_tls r1, r2, r4, r5, r3, r7
>   #if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
>   	ldr	r7, [r2, #TI_TASK]
>   	ldr	r8, =3D__stack_chk_guard
>

Jonny
