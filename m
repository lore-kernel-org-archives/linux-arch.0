From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Fri, 17 Jul 2020 10:00:23 +1000
Message-ID: <1594942495.8qcz211iwc.astroid@bobo.none>
References: <20200710015646.2020871-1-npiggin@gmail.com>
        <1594613902.1wzayj0p15.astroid@bobo.none>
        <1594647408.wmrazhwjzb.astroid@bobo.none>
        <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
        <1594868476.6k5kvx8684.astroid@bobo.none>
        <1594873644.viept6os6j.astroid@bobo.none>
        <1494299304.15894.1594914382695.JavaMail.zimbra@efficios.com>
        <1370747990.15974.1594915396143.JavaMail.zimbra@efficios.com>
        <595582123.17106.1594925921537.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <595582123.17106.1594925921537.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, paulmck <paulmck@kernel.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

Excerpts from Mathieu Desnoyers's message of July 17, 2020 4:58 am:
> ----- On Jul 16, 2020, at 12:03 PM, Mathieu Desnoyers mathieu.desnoyers@e=
fficios.com wrote:
>=20
>> ----- On Jul 16, 2020, at 11:46 AM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>>=20
>>> ----- On Jul 16, 2020, at 12:42 AM, Nicholas Piggin npiggin@gmail.com w=
rote:
>>>> I should be more complete here, especially since I was complaining
>>>> about unclear barrier comment :)
>>>>=20
>>>>=20
>>>> CPU0                     CPU1
>>>> a. user stuff            1. user stuff
>>>> b. membarrier()          2. enter kernel
>>>> c. smp_mb()              3. smp_mb__after_spinlock(); // in __schedule
>>>> d. read rq->curr         4. rq->curr switched to kthread
>>>> e. is kthread, skip IPI  5. switch_to kthread
>>>> f. return to user        6. rq->curr switched to user thread
>>>> g. user stuff            7. switch_to user thread
>>>>                         8. exit kernel
>>>>                         9. more user stuff
>>>>=20
>>>> What you're really ordering is a, g vs 1, 9 right?
>>>>=20
>>>> In other words, 9 must see a if it sees g, g must see 1 if it saw 9,
>>>> etc.
>>>>=20
>>>> Userspace does not care where the barriers are exactly or what kernel
>>>> memory accesses might be being ordered by them, so long as there is a
>>>> mb somewhere between a and g, and 1 and 9. Right?
>>>=20
>>> This is correct.
>>=20
>> Actually, sorry, the above is not quite right. It's been a while
>> since I looked into the details of membarrier.
>>=20
>> The smp_mb() at the beginning of membarrier() needs to be paired with a
>> smp_mb() _after_ rq->curr is switched back to the user thread, so the
>> memory barrier is between store to rq->curr and following user-space
>> accesses.
>>=20
>> The smp_mb() at the end of membarrier() needs to be paired with the
>> smp_mb__after_spinlock() at the beginning of schedule, which is
>> between accesses to userspace memory and switching rq->curr to kthread.
>>=20
>> As to *why* this ordering is needed, I'd have to dig through additional
>> scenarios from https://lwn.net/Articles/573436/. Or maybe Paul remembers=
 ?
>=20
> Thinking further about this, I'm beginning to consider that maybe we have=
 been
> overly cautious by requiring memory barriers before and after store to rq=
->curr.
>=20
> If CPU0 observes a CPU1's rq->curr->mm which differs from its own process=
 (current)
> while running the membarrier system call, it necessarily means that CPU1 =
had
> to issue smp_mb__after_spinlock when entering the scheduler, between any =
user-space
> loads/stores and update of rq->curr.
>=20
> Requiring a memory barrier between update of rq->curr (back to current pr=
ocess's
> thread) and following user-space memory accesses does not seem to guarant=
ee
> anything more than what the initial barrier at the beginning of __schedul=
e already
> provides, because the guarantees are only about accesses to user-space me=
mory.
>=20
> Therefore, with the memory barrier at the beginning of __schedule, just o=
bserving that
> CPU1's rq->curr differs from current should guarantee that a memory barri=
er was issued
> between any sequentially consistent instructions belonging to the current=
 process on
> CPU1.
>=20
> Or am I missing/misremembering an important point here ?

I might have mislead you.

 CPU0            CPU1
 r1=3Dy            x=3D1
 membarrier()    y=3D1
 r2=3Dx

membarrier provides if r1=3D=3D1 then r2=3D=3D1 (right?)

 CPU0
 r1=3Dy
 membarrier()
   smp_mb();
   t =3D cpu_rq(1)->curr;
   if (t->mm =3D=3D mm)
     IPI(CPU1);
   smp_mb()
 r2=3Dx

 vs

 CPU1
   ...
   __schedule()
     smp_mb__after_spinlock()
     rq->curr =3D kthread
   ...
   __schedule()
     smp_mb__after_spinlock()
     rq->curr =3D user thread
 exit kernel
 x=3D1
 y=3D1

Now these last 3 stores are not ordered, so CPU0 might see y=3D=3D1 but
rq->curr =3D=3D kthread, right? Then it will skip the IPI and stores to x=20
and y will not be ordered.

So we do need a mb after rq->curr store when mm is switching.

I believe for the global membarrier PF_KTHREAD optimisation, we also=20
need a barrier when switching from a kernel thread to user, for the
same reason.

So I think I was wrong to say the barrier is not necessary.

I haven't quite worked out why two mb()s are required in membarrier(),
but at least that's less of a performance concern.

Thanks,
Nick
