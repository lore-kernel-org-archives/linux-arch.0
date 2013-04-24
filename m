From: =?ISO-8859-1?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: Re: [PATCHv2] arm: Preserve TPIDRURW on context switch
Date: Wed, 24 Apr 2013 23:44:34 +0200
Message-ID: <51785242.6020500@dawncrow.de>
References: <517168BB.3070903@dawncrow.de> <20130422143616.GP14496@n2100.arm.linux.org.uk> <20130422151836.GA15665@mudshark.cambridge.arm.com> <5175A697.3080308@dawncrow.de> <20130423091536.GB17593@mudshark.cambridge.arm.com> <51770E4E.2040003@dawncrow.de> <20130424094251.GA21850@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61444 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758268Ab3DXVom (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Apr 2013 17:44:42 -0400
In-Reply-To: <20130424094251.GA21850@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Am 24.04.2013 11:42, schrieb Will Deacon:
> Hi Andrew,
>=20
> On Tue, Apr 23, 2013 at 11:42:22PM +0100, Andr=E9 Hentschel wrote:
>> Am 23.04.2013 11:15, schrieb Will Deacon:
>>> You could introduce `get' tls functions, which don't do anything fo=
r CPUs
>>> without the relevant registers.
>>
>> Before i have another round of testing and patch formatting/sending,
>> what about the untested patch below?
>=20
> Ok. Comments inline.

Thanks for them. My first kernel patch was adding an include, this seco=
nd patch is a rather hard one. So every comment is appreciated.

>>  #ifdef __ASSEMBLY__
>> +	.macro get_tls2_none, tp, tmp1
>> +	.endm
>=20
> Cosmetic, but these are really horrible macro names.

I guess that's only about removing '2'?

>> +	.macro get_tls2_v6, tp, tmp1
>> +	ldr	\tmp1, =3Delf_hwcap
>> +	ldr	\tmp1, [\tmp1, #0]
>> +	tst	\tmp1, #HWCAP_TLS		@ hardware TLS available?
>> +	mrcne	p15, 0, \tmp1, c13, c0, 2		@ get user r/w TLS register
>> +	strne	\tmp1, [\tp, #4]
>=20
> You could factor out some of this hwcap checking now that it's used b=
y both
> set and get.

Sure, but the code would still run twice (unlike my PATCHv2)

>> +	ldrdne	\tmp1, \tmp2, [\tp]
>=20
> Does this work for big-endian CPUs?

I'd say yes.

>> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
>> index 047d3e4..6138eb1 100644
>> --- a/arch/arm/kernel/process.c
>> +++ b/arch/arm/kernel/process.c
>> @@ -395,7 +395,8 @@ copy_thread(unsigned long clone_flags, unsigned =
long stack_start,
>>  	clear_ptrace_hw_breakpoint(p);
>> =20
>>  	if (clone_flags & CLONE_SETTLS)
>> -		thread->tp_value =3D childregs->ARM_r3;
>> +		thread->tp_value[0] =3D childregs->ARM_r3;
>> +	thread->tp_value[1] =3D current_thread_info()->tp_value[1];
>>
>=20
> This still isn't correct. Imagine the following sequence of events:
>=20
>   - Task foo writes its TPIDRURW register from userspace and then iss=
ues a
>     fork() system call. No context switch occurs between these two ev=
ents.
>=20
>   - We start creating the child task, bar, and end up in copy_thread =
with
>     the `thread' pointing at foo's struct thread_info, which contains=
 the
>     *old* TPIDRURW value.
>=20
>   - We copy out the stale value into bar, which is then scheduled wit=
h an
>     old TPIDRURW value.
>=20
> The solution is to reload the value sitting in the register in copy_t=
hread,
> rather than relying on the thread_info being up-to-date. That's why I
> previously suggested not using asm macros for the getters.

Thanks for the informations. Further questions:
	Where would i place this functions? In tls.h as inline functions?
	How should that function look like? Containing compile-time checks and=
 only using assembler for mrc instructions?
	Wouldn't that be much overhead in __switch_to?

>> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
>> index 03deeff..2bc1514 100644
>> --- a/arch/arm/kernel/ptrace.c
>> +++ b/arch/arm/kernel/ptrace.c
>> @@ -849,7 +849,7 @@ long arch_ptrace(struct task_struct *child, long=
 request,
>>  #endif
>> =20
>>  		case PTRACE_GET_THREAD_AREA:
>> -			ret =3D put_user(task_thread_info(child)->tp_value,
>> +			ret =3D put_user(task_thread_info(child)->tp_value[0],
>>  				       datap);
>>  			break;
>=20
> I'm guessing debuggers don't care about the new TLS value, or do we n=
eed a
> new ptrace request?

I'd say no. In case someone would jump in and say we need it, it'd be a=
 seperate patch anyway.

Best regards.
