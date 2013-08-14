From: =?UTF-8?B?QW5kcsOpIEhlbnRzY2hlbA==?= <nerv@dawncrow.de>
Subject: Re: arm: Only load TLS values when needed
Date: Wed, 14 Aug 2013 23:21:37 +0200
Message-ID: <520BF4E1.8040708@dawncrow.de>
References: <51E42E11.1010903@dawncrow.de> <51E5836B.1010904@arm.com> <51E59E8F.1060501@dawncrow.de> <51E67B98.9040101@arm.com> <51E6F532.1030004@dawncrow.de> <520B8F37.4040609@dawncrow.de> <520BAE58.3060600@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52051 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933191Ab3HNVVm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 Aug 2013 17:21:42 -0400
In-Reply-To: <520BAE58.3060600@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Austin <jonathan.austin@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Am 14.08.2013 18:20, schrieb Jonathan Austin:
> Hi Andr=C3=A9,
>=20
> On 14/08/13 15:07, Andr=C3=A9 Hentschel wrote:
>> Hi Jonathan,
>> Any updates on this?
>>
>=20
> I was holding out to see the version with ldrd at the top, as discuss=
ed below - I never saw a version with that change? I'd meant to ping yo=
u to see if that was coming, sorry.
>=20
>=20
> [...]
>>>> [...]
>>>>>> Now we've only got one instruction between the store and the loa=
d
>>>>>> and risk stalling the pipeline...
>>>>>>
>>>>>> Dave M cautiously says "The ancient advice was that one instruct=
ion
>>>>>> was enough" but this is very core dependent... I wonder if anyon=
e
>>>>>> has a good idea about whether this is an issue here...?
>>>>>
>>>>> We could use a ldrd at the top, that'd be nearly what we have rig=
ht
>>>>> now, don't we?
>>>>
>>>> Yea, that'd be good - as far as I can see from an 1136 TRM, the ld=
rd *may* be two cycles (depending on alignment of the words) but the ld=
r and ldrne will always be two cycles. Ahhh, the joys of modifying the =
fast path ;)
>=20
> Was expecting to see something that reflected this discussion,

Ah ok, i misunderstood that, sry.
Something like that?

=46rom: Andr=C3=A9 Hentschel <nerv@dawncrow.de>

This patch intents to reduce loading instructions when the resulting va=
lue is not used.
It's a follow up on a4780adeefd042482f624f5e0d577bf9cdcbb760

Signed-off-by: Andr=C3=A9 Hentschel <nerv@dawncrow.de>

---
This patch is against 28fbc8b6a29c849a3f03a6b05010d4b584055665

diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
index 83259b8..31743f7 100644
--- a/arch/arm/include/asm/tls.h
+++ b/arch/arm/include/asm/tls.h
@@ -3,29 +3,31 @@
=20
 #ifdef __ASSEMBLY__
 #include <asm/asm-offsets.h>
-	.macro switch_tls_none, base, tp, tpuser, tmp1, tmp2
+	.macro switch_tls_none, prev, next, tp, tpuser, tmp1, tmp2
 	.endm
=20
-	.macro switch_tls_v6k, base, tp, tpuser, tmp1, tmp2
+	.macro switch_tls_v6k, prev, next, tp, tpuser, tmp1, tmp2
+	ldrd	\tp, \tpuser, [\next, #TI_TP_VALUE]	@ get the next TLS and user =
r/w register
 	mrc	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
 	mcr	p15, 0, \tp, c13, c0, 3		@ set TLS register
 	mcr	p15, 0, \tpuser, c13, c0, 2	@ and the user r/w register
-	str	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it
+	str	\tmp2, [\prev, #TI_TP_VALUE + 4] @ save it
 	.endm
=20
-	.macro switch_tls_v6, base, tp, tpuser, tmp1, tmp2
+	.macro switch_tls_v6, prev, next, tp, tpuser, tmp1, tmp2
+	ldrd	\tp, \tpuser, [\next, #TI_TP_VALUE]
 	ldr	\tmp1, =3Delf_hwcap
 	ldr	\tmp1, [\tmp1, #0]
 	mov	\tmp2, #0xffff0fff
 	tst	\tmp1, #HWCAP_TLS		@ hardware TLS available?
 	streq	\tp, [\tmp2, #-15]		@ set TLS value at 0xffff0ff0
-	mrcne	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
+	mrcne	p15, 0, \tmp2, c13, c0, 2	@ get the previous user r/w register
 	mcrne	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
 	mcrne	p15, 0, \tpuser, c13, c0, 2	@ set user r/w register
-	strne	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it
+	strne	\tmp2, [\prev, #TI_TP_VALUE + 4] @ save it
 	.endm
=20
-	.macro switch_tls_software, base, tp, tpuser, tmp1, tmp2
+	.macro switch_tls_software, prev, next, tp, tpuser, tmp1, tmp2
 	mov	\tmp1, #0xffff0fff
 	str	\tp, [\tmp1, #-15]		@ set TLS value at 0xffff0ff0
 	.endm
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.=
S
index d40d0ef..11112de 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -689,12 +689,10 @@ ENTRY(__switch_to)
  THUMB(	stmia	ip!, {r4 - sl, fp}	   )	@ Store most regs on stack
  THUMB(	str	sp, [ip], #4		   )
  THUMB(	str	lr, [ip], #4		   )
-	ldr	r4, [r2, #TI_TP_VALUE]
-	ldr	r5, [r2, #TI_TP_VALUE + 4]
 #ifdef CONFIG_CPU_USE_DOMAINS
 	ldr	r6, [r2, #TI_CPU_DOMAIN]
 #endif
-	switch_tls r1, r4, r5, r3, r7
+	switch_tls r1, r2, r4, r5, r3, r7
 #if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
 	ldr	r7, [r2, #TI_TASK]
 	ldr	r8, =3D__stack_chk_guard
