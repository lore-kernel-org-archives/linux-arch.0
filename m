From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Date: Thu, 23 Jul 2020 23:30:09 +1000
Message-ID: <1595510571.u39qfc8d1o.astroid@bobo.none>
References: <20200706043540.1563616-1-npiggin@gmail.com>
        <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
        <1594101082.hfq9x5yact.astroid@bobo.none>
        <20200708084106.GE597537@hirez.programming.kicks-ass.net>
        <1595327263.lk78cqolxm.astroid@bobo.none>
        <eaabf501-80fe-dd15-c03c-f75ce4f75877@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-ppc-owner@vger.kernel.org>
In-Reply-To: <eaabf501-80fe-dd15-c03c-f75ce4f75877@redhat.com>
Sender: kvm-ppc-owner@vger.kernel.org
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

Excerpts from Waiman Long's message of July 22, 2020 12:36 am:
> On 7/21/20 7:08 AM, Nicholas Piggin wrote:
>> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include=
/asm/qspinlock.h
>> index b752d34517b3..26d8766a1106 100644
>> --- a/arch/powerpc/include/asm/qspinlock.h
>> +++ b/arch/powerpc/include/asm/qspinlock.h
>> @@ -31,16 +31,57 @@ static inline void queued_spin_unlock(struct qspinlo=
ck *lock)
>>  =20
>>   #else
>>   extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)=
;
>> +extern void queued_spin_lock_slowpath_queue(struct qspinlock *lock);
>>   #endif
>>  =20
>>   static __always_inline void queued_spin_lock(struct qspinlock *lock)
>>   {
>> -	u32 val =3D 0;
>> -
>> -	if (likely(atomic_try_cmpxchg_lock(&lock->val, &val, _Q_LOCKED_VAL)))
>> +	atomic_t *a =3D &lock->val;
>> +	u32 val;
>> +
>> +again:
>> +	asm volatile(
>> +"1:\t"	PPC_LWARX(%0,0,%1,1) "	# queued_spin_lock			\n"
>> +	: "=3D&r" (val)
>> +	: "r" (&a->counter)
>> +	: "memory");
>> +
>> +	if (likely(val =3D=3D 0)) {
>> +		asm_volatile_goto(
>> +	"	stwcx.	%0,0,%1							\n"
>> +	"	bne-	%l[again]						\n"
>> +	"\t"	PPC_ACQUIRE_BARRIER "						\n"
>> +		:
>> +		: "r"(_Q_LOCKED_VAL), "r" (&a->counter)
>> +		: "cr0", "memory"
>> +		: again );
>>   		return;
>> -
>> -	queued_spin_lock_slowpath(lock, val);
>> +	}
>> +
>> +	if (likely(val =3D=3D _Q_LOCKED_VAL)) {
>> +		asm_volatile_goto(
>> +	"	stwcx.	%0,0,%1							\n"
>> +	"	bne-	%l[again]						\n"
>> +		:
>> +		: "r"(_Q_LOCKED_VAL | _Q_PENDING_VAL), "r" (&a->counter)
>> +		: "cr0", "memory"
>> +		: again );
>> +
>> +		atomic_cond_read_acquire(a, !(VAL & _Q_LOCKED_MASK));
>> +//		clear_pending_set_locked(lock);
>> +		WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
>> +//		lockevent_inc(lock_pending);
>> +		return;
>> +	}
>> +
>> +	if (val =3D=3D _Q_PENDING_VAL) {
>> +		int cnt =3D _Q_PENDING_LOOPS;
>> +		val =3D atomic_cond_read_relaxed(a,
>> +					       (VAL !=3D _Q_PENDING_VAL) || !cnt--);
>> +		if (!(val & ~_Q_LOCKED_MASK))
>> +			goto again;
>> +        }
>> +	queued_spin_lock_slowpath_queue(lock);
>>   }
>>   #define queued_spin_lock queued_spin_lock
>>  =20
>=20
> I am fine with the arch code override some part of the generic code.

Cool.

>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>> index b9515fcc9b29..ebcc6f5d99d5 100644
>> --- a/kernel/locking/qspinlock.c
>> +++ b/kernel/locking/qspinlock.c
>> @@ -287,10 +287,14 @@ static __always_inline u32  __pv_wait_head_or_lock=
(struct qspinlock *lock,
>>  =20
>>   #ifdef CONFIG_PARAVIRT_SPINLOCKS
>>   #define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
>> +#define queued_spin_lock_slowpath_queue	native_queued_spin_lock_slowpat=
h_queue
>>   #endif
>>  =20
>>   #endif /* _GEN_PV_LOCK_SLOWPATH */
>>  =20
>> +void queued_spin_lock_slowpath_queue(struct qspinlock *lock);
>> +static void __queued_spin_lock_slowpath_queue(struct qspinlock *lock);
>> +
>>   /**
>>    * queued_spin_lock_slowpath - acquire the queued spinlock
>>    * @lock: Pointer to queued spinlock structure
>> @@ -314,12 +318,6 @@ static __always_inline u32  __pv_wait_head_or_lock(=
struct qspinlock *lock,
>>    */
>>   void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>   {
>> -	struct mcs_spinlock *prev, *next, *node;
>> -	u32 old, tail;
>> -	int idx;
>> -
>> -	BUILD_BUG_ON(CONFIG_NR_CPUS >=3D (1U << _Q_TAIL_CPU_BITS));
>> -
>>   	if (pv_enabled())
>>   		goto pv_queue;
>>  =20
>> @@ -397,6 +395,26 @@ void queued_spin_lock_slowpath(struct qspinlock *lo=
ck, u32 val)
>>   queue:
>>   	lockevent_inc(lock_slowpath);
>>   pv_queue:
>> +	__queued_spin_lock_slowpath_queue(lock);
>> +}
>> +EXPORT_SYMBOL(queued_spin_lock_slowpath);
>> +
>> +void queued_spin_lock_slowpath_queue(struct qspinlock *lock)
>> +{
>> +	lockevent_inc(lock_slowpath);
>> +	__queued_spin_lock_slowpath_queue(lock);
>> +}
>> +EXPORT_SYMBOL(queued_spin_lock_slowpath_queue);
>> +
>> +static void __queued_spin_lock_slowpath_queue(struct qspinlock *lock)
>> +{
>> +	struct mcs_spinlock *prev, *next, *node;
>> +	u32 old, tail;
>> +	u32 val;
>> +	int idx;
>> +
>> +	BUILD_BUG_ON(CONFIG_NR_CPUS >=3D (1U << _Q_TAIL_CPU_BITS));
>> +
>>   	node =3D this_cpu_ptr(&qnodes[0].mcs);
>>   	idx =3D node->count++;
>>   	tail =3D encode_tail(smp_processor_id(), idx);
>> @@ -559,7 +577,6 @@ void queued_spin_lock_slowpath(struct qspinlock *loc=
k, u32 val)
>>   	 */
>>   	__this_cpu_dec(qnodes[0].mcs.count);
>>   }
>> -EXPORT_SYMBOL(queued_spin_lock_slowpath);
>>  =20
>>   /*
>>    * Generate the paravirt code for queued_spin_unlock_slowpath().
>>
> I would prefer to extract out the pending bit handling code out into a=20
> separate helper function which can be overridden by the arch code=20
> instead of breaking the slowpath into 2 pieces.

You mean have the arch provide a queued_spin_lock_slowpath_pending=20
function that the slow path calls?

I would actually prefer the pending handling can be made inline in
the queued_spin_lock function, especially with out-of-line locks it=20
makes sense to put it there.

We could ifdef out queued_spin_lock_slowpath_queue if it's not used,
then __queued_spin_lock_slowpath_queue would be inlined into the
caller so there would be no split?

Thanks,
Nick
