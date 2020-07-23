From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks for
 SPLPAR
Date: Fri, 24 Jul 2020 00:09:48 +1000
Message-ID: <1595512823.5k2rrd4zk5.astroid@bobo.none>
References: <20200706043540.1563616-1-npiggin@gmail.com>
        <20200706043540.1563616-6-npiggin@gmail.com>
        <874kqhvu1v.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-ppc-owner@vger.kernel.org>
In-Reply-To: <874kqhvu1v.fsf@mpe.ellerman.id.au>
Sender: kvm-ppc-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

Excerpts from Michael Ellerman's message of July 9, 2020 8:53 pm:
> Nicholas Piggin <npiggin@gmail.com> writes:
>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/powerpc/include/asm/paravirt.h           | 28 ++++++++
>>  arch/powerpc/include/asm/qspinlock.h          | 66 +++++++++++++++++++
>>  arch/powerpc/include/asm/qspinlock_paravirt.h |  7 ++
>>  arch/powerpc/platforms/pseries/Kconfig        |  5 ++
>>  arch/powerpc/platforms/pseries/setup.c        |  6 +-
>>  include/asm-generic/qspinlock.h               |  2 +
>=20
> Another ack?
>=20
>> diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/=
asm/paravirt.h
>> index 7a8546660a63..f2d51f929cf5 100644
>> --- a/arch/powerpc/include/asm/paravirt.h
>> +++ b/arch/powerpc/include/asm/paravirt.h
>> @@ -45,6 +55,19 @@ static inline void yield_to_preempted(int cpu, u32 yi=
eld_count)
>>  {
>>  	___bad_yield_to_preempted(); /* This would be a bug */
>>  }
>> +
>> +extern void ___bad_yield_to_any(void);
>> +static inline void yield_to_any(void)
>> +{
>> +	___bad_yield_to_any(); /* This would be a bug */
>> +}
>=20
> Why do we do that rather than just not defining yield_to_any() at all
> and letting the build fail on that?
>=20
> There's a condition somewhere that we know will false at compile time
> and drop the call before linking?

Mainly so you could use it in if (IS_ENABLED()) blocks, but would still
catch the (presumably buggy) case where something calls it without the
option set.

I think I had it arranged a different way that was using IS_ENABLED=20
earlier and changed it but might as well keep it this way.

>=20
>> diff --git a/arch/powerpc/include/asm/qspinlock_paravirt.h b/arch/powerp=
c/include/asm/qspinlock_paravirt.h
>> new file mode 100644
>> index 000000000000..750d1b5e0202
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/qspinlock_paravirt.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#ifndef __ASM_QSPINLOCK_PARAVIRT_H
>> +#define __ASM_QSPINLOCK_PARAVIRT_H
>=20
> _ASM_POWERPC_QSPINLOCK_PARAVIRT_H please.
>=20
>> +
>> +EXPORT_SYMBOL(__pv_queued_spin_unlock);
>=20
> Why's that in a header? Should that (eventually) go with the generic impl=
ementation?

Yeah the qspinlock_paravirt.h header is a bit weird and only gets=20
included into kernel/locking/qspinlock.c

>> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platf=
orms/pseries/Kconfig
>> index 24c18362e5ea..756e727b383f 100644
>> --- a/arch/powerpc/platforms/pseries/Kconfig
>> +++ b/arch/powerpc/platforms/pseries/Kconfig
>> @@ -25,9 +25,14 @@ config PPC_PSERIES
>>  	select SWIOTLB
>>  	default y
>> =20
>> +config PARAVIRT_SPINLOCKS
>> +	bool
>> +	default n
>=20
> default n is the default.
>=20
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platf=
orms/pseries/setup.c
>> index 2db8469e475f..747a203d9453 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -771,8 +771,12 @@ static void __init pSeries_setup_arch(void)
>>  	if (firmware_has_feature(FW_FEATURE_LPAR)) {
>>  		vpa_init(boot_cpuid);
>> =20
>> -		if (lppaca_shared_proc(get_lppaca()))
>> +		if (lppaca_shared_proc(get_lppaca())) {
>>  			static_branch_enable(&shared_processor);
>> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
>> +			pv_spinlocks_init();
>> +#endif
>> +		}
>=20
> We could avoid the ifdef with this I think?

Yes I think so.

Thanks,
Nick
