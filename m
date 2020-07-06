Return-Path: <SRS0=tLCE=AR=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgGFAaM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Jul 2020 20:30:12 -0400
Date: Mon, 06 Jul 2020 10:30:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 5/6] powerpc/pseries: implement paravirt qspinlocks for
 SPLPAR
References: <20200703073516.1354108-1-npiggin@gmail.com>
        <20200703073516.1354108-6-npiggin@gmail.com>
        <81d9981b-8a20-729c-b861-c7229e40bb65@redhat.com>
In-Reply-To: <81d9981b-8a20-729c-b861-c7229e40bb65@redhat.com>
MIME-Version: 1.0
Message-ID: <1593994632.syt8hwimv9.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>
Message-ID: <20200706003005.1DhwBV3uxgoMdTqeYP11rcZm2Y6N8iWEXeVIoN72uw8@z>

Excerpts from Waiman Long's message of July 6, 2020 5:00 am:
> On 7/3/20 3:35 AM, Nicholas Piggin wrote:
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   arch/powerpc/include/asm/paravirt.h           | 28 ++++++++++
>>   arch/powerpc/include/asm/qspinlock.h          | 55 +++++++++++++++++++
>>   arch/powerpc/include/asm/qspinlock_paravirt.h |  5 ++
>>   arch/powerpc/platforms/pseries/Kconfig        |  5 ++
>>   arch/powerpc/platforms/pseries/setup.c        |  6 +-
>>   include/asm-generic/qspinlock.h               |  2 +
>>   6 files changed, 100 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
>>
>> diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/=
asm/paravirt.h
>> index 7a8546660a63..f2d51f929cf5 100644
>> --- a/arch/powerpc/include/asm/paravirt.h
>> +++ b/arch/powerpc/include/asm/paravirt.h
>> @@ -29,6 +29,16 @@ static inline void yield_to_preempted(int cpu, u32 yi=
eld_count)
>>   {
>>   	plpar_hcall_norets(H_CONFER, get_hard_smp_processor_id(cpu), yield_co=
unt);
>>   }
>> +
>> +static inline void prod_cpu(int cpu)
>> +{
>> +	plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
>> +}
>> +
>> +static inline void yield_to_any(void)
>> +{
>> +	plpar_hcall_norets(H_CONFER, -1, 0);
>> +}
>>   #else
>>   static inline bool is_shared_processor(void)
>>   {
>> @@ -45,6 +55,19 @@ static inline void yield_to_preempted(int cpu, u32 yi=
eld_count)
>>   {
>>   	___bad_yield_to_preempted(); /* This would be a bug */
>>   }
>> +
>> +extern void ___bad_yield_to_any(void);
>> +static inline void yield_to_any(void)
>> +{
>> +	___bad_yield_to_any(); /* This would be a bug */
>> +}
>> +
>> +extern void ___bad_prod_cpu(void);
>> +static inline void prod_cpu(int cpu)
>> +{
>> +	___bad_prod_cpu(); /* This would be a bug */
>> +}
>> +
>>   #endif
>>  =20
>>   #define vcpu_is_preempted vcpu_is_preempted
>> @@ -57,5 +80,10 @@ static inline bool vcpu_is_preempted(int cpu)
>>   	return false;
>>   }
>>  =20
>> +static inline bool pv_is_native_spin_unlock(void)
>> +{
>> +     return !is_shared_processor();
>> +}
>> +
>>   #endif /* __KERNEL__ */
>>   #endif /* __ASM_PARAVIRT_H */
>> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include=
/asm/qspinlock.h
>> index c49e33e24edd..0960a0de2467 100644
>> --- a/arch/powerpc/include/asm/qspinlock.h
>> +++ b/arch/powerpc/include/asm/qspinlock.h
>> @@ -3,9 +3,36 @@
>>   #define _ASM_POWERPC_QSPINLOCK_H
>>  =20
>>   #include <asm-generic/qspinlock_types.h>
>> +#include <asm/paravirt.h>
>>  =20
>>   #define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
>>  =20
>> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
>> +extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u3=
2 val);
>> +extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 =
val);
>> +
>> +static __always_inline void queued_spin_lock_slowpath(struct qspinlock =
*lock, u32 val)
>> +{
>> +	if (!is_shared_processor())
>> +		native_queued_spin_lock_slowpath(lock, val);
>> +	else
>> +		__pv_queued_spin_lock_slowpath(lock, val);
>> +}
>=20
> In a previous mail, I said that:

Hey, yeah I read that right after sending the series out. Thanks for the=20
thorough review.

> You may need to match the use of __pv_queued_spin_lock_slowpath() with=20
> the corresponding __pv_queued_spin_unlock(), e.g.
>=20
> #define queued_spin_unlock queued_spin_unlock
> static inline queued_spin_unlock(struct qspinlock *lock)
> {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!is_shared_processor())
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 smp_store_release(&lock->locked, 0);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 __pv_queued_spin_unlock(lock);
> }
>=20
> Otherwise, pv_kick() will never be called.
>=20
> Maybe PowerPC HMT is different that the shared cpus can still process=20
> instruction, though slower, that cpu kicking like what was done in kvm=20
> is not really necessary. If that is the case, I think we should document=20
> that.

It does stop dispatch, but it will wake up by itself after all other=20
vCPUs have had a chance to dispatch. I will re-test with the fix in
place and see if there's any significant performance differences.

Thanks,
Nick
