From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Thu, 16 Jul 2020 16:06:10 +1000
Message-ID: <1594878414.pdm2jvp999.astroid@bobo.none>
References: <1594868476.6k5kvx8684.astroid@bobo.none>
        <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgGPGGQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 02:06:16 -0400
In-Reply-To: <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>

Excerpts from Andy Lutomirski's message of July 16, 2020 3:18 pm:
>=20
>=20
>> On Jul 15, 2020, at 9:15 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>=20
>> =EF=BB=BFExcerpts from Mathieu Desnoyers's message of July 14, 2020 12:1=
3 am:
>>> ----- On Jul 13, 2020, at 9:47 AM, Nicholas Piggin npiggin@gmail.com wr=
ote:
>>>=20
>>>> Excerpts from Nicholas Piggin's message of July 13, 2020 2:45 pm:
>>>>> Excerpts from Andy Lutomirski's message of July 11, 2020 3:04 am:
>>>>>> Also, as it stands, I can easily see in_irq() ceasing to promise to
>>>>>> serialize.  There are older kernels for which it does not promise to
>>>>>> serialize.  And I have plans to make it stop serializing in the
>>>>>> nearish future.
>>>>>=20
>>>>> You mean x86's return from interrupt? Sounds fun... you'll konw where=
 to
>>>>> update the membarrier sync code, at least :)
>>>>=20
>>>> Oh, I should actually say Mathieu recently clarified a return from
>>>> interrupt doesn't fundamentally need to serialize in order to support
>>>> membarrier sync core.
>>>=20
>>> Clarification to your statement:
>>>=20
>>> Return from interrupt to kernel code does not need to be context serial=
izing
>>> as long as kernel serializes before returning to user-space.
>>>=20
>>> However, return from interrupt to user-space needs to be context serial=
izing.
>>=20
>> Hmm, I'm not sure it's enough even with the sync in the exit_lazy_tlb
>> in the right places.
>>=20
>> A kernel thread does a use_mm, then it blocks and the user process with
>> the same mm runs on that CPU, and then it calls into the kernel, blocks,
>> the kernel thread runs again, another CPU issues a membarrier which does
>> not IPI this one because it's running a kthread, and then the kthread
>> switches back to the user process (still without having unused the mm),
>> and then the user process returns from syscall without having done a=20
>> core synchronising instruction.
>>=20
>> The cause of the problem is you want to avoid IPI'ing kthreads. Why?
>> I'm guessing it really only matters as an optimisation in case of idle
>> threads. Idle thread is easy (well, easier) because it won't use_mm, so=20
>> you could check for rq->curr =3D=3D rq->idle in your loop (in a suitable=
=20
>> sched accessor function).
>>=20
>> But... I'm not really liking this subtlety in the scheduler for all this=
=20
>> (the scheduler still needs the barriers when switching out of idle).
>>=20
>> Can it be improved somehow? Let me forget x86 core sync problem for now
>> (that _may_ be a bit harder), and step back and look at what we're doing=
.
>> The memory barrier case would actually suffer from the same problem as
>> core sync, because in the same situation it has no implicit mmdrop in
>> the scheduler switch code either.
>>=20
>> So what are we doing with membarrier? We want any activity caused by the=
=20
>> set of CPUs/threads specified that can be observed by this thread before=
=20
>> calling membarrier is appropriately fenced from activity that can be=20
>> observed to happen after the call returns.
>>=20
>> CPU0                     CPU1
>>                         1. user stuff
>> a. membarrier()          2. enter kernel
>> b. read rq->curr         3. rq->curr switched to kthread
>> c. is kthread, skip IPI  4. switch_to kthread
>> d. return to user        5. rq->curr switched to user thread
>>                 6. switch_to user thread
>>                 7. exit kernel
>>                         8. more user stuff
>>=20
>> As far as I can see, the problem is CPU1 might reorder step 5 and step
>> 8, so you have mmdrop of lazy mm be a mb after step 6.
>>=20
>> But why? The membarrier call only cares that there is a full barrier
>> between 1 and 8, right? Which it will get from the previous context
>> switch to the kthread.
>>=20
>> I must say the memory barrier comments in membarrier could be improved
>> a bit (unless I'm missing where the main comment is). It's fine to know
>> what barriers pair with one another, but we need to know which exact
>> memory accesses it is ordering
>>=20
>>       /*
>>         * Matches memory barriers around rq->curr modification in
>>         * scheduler.
>>         */
>>=20
>> Sure, but it doesn't say what else is being ordered. I think it's just
>> the user memory accesses, but would be nice to make that a bit more
>> explicit. If we had such comments then we might know this case is safe.
>>=20
>> I think the funny powerpc barrier is a similar case of this. If we
>> ever see remote_rq->curr->flags & PF_KTHREAD, then we _know_ that
>> CPU has or will have issued a memory barrier between running user
>> code.
>>=20
>> So AFAIKS all this membarrier stuff in kernel/sched/core.c could
>> just go away. Except x86 because thread switch doesn't imply core
>> sync, so CPU1 between 1 and 8 may never issue a core sync instruction
>> the same way a context switch must be a full mb.
>>=20
>> Before getting to x86 -- Am I right, or way off track here?
>=20
> I find it hard to believe that this is x86 only. Why would thread switch =
imply core sync on any architecture?  Is x86 unique in having a stupid expe=
nsive core sync that is heavier than smp_mb()?

It's not the thread switch but the return from kernel to user -- at=20
least of architectures that implement membarrier SYNC_CORE, x86 can do=20
that without serializing.

The thread switch is muddying the waters a bit, it's not the actual=20
thread switch we care about, that just happens to be used as a point
where we try to catch the membarrier IPIs that were skipped due to the
PF_KTHREAD optimisation.

I think that doing said check in the lazy tlb exit code is both
unnecessary for the memory ordering and insufficient for pipeline=20
serialization.

> But I=E2=80=99m wondering if all this deferred sync stuff is wrong. In th=
e brave new world of io_uring and such, perhaps kernel access matter too.  =
Heck, even:
>=20
> int a[2];
>=20
> Thread A:
> a[0] =3D 1;
> a[1] =3D 2:
>=20
> Thread B:
>=20
> write(fd, a, sizeof(a));
>=20
> Doesn=E2=80=99t do what thread A is expecting.  Admittedly this particula=
r example is nonsense, but maybe there are sensible cases that matter to so=
meone.

I think kernel accesses probably do matter (or at least they should by=20
principle of least surprise). And so I was doubly misleading by labeling
it as "user stuff". I should have distinguished between previous user or
kernel accesses, as opposed to the kernel accesses specifically for the
implementation of the membarrier call.

So I think the membarrier code gets *that* part right (modulo what we=20
have seen already) if the kernel access is being done from process
context.

But yes if the access is coming from io_uring that has done
kthread_use_mm or some other random code running in a kernel thread
working on get_user_pages memory or any similar shared vm_insert_pfn
memory, then it goes completely to hell.

So good catch, PF_KTHREAD check is problematic there even if no actual
users exist today. rq->curr =3D=3D rq->idle test might be better, but can
we have interrupts writing completions into user memory? For performance
I would hope so, so that makes even that test problematic.

Maybe membarrier should close that gap entirely, and work around performanc=
e
issue by adding _USER_ONLY flags which explicitly only order user mode
accesess vs other user accesses.

Thanks,
Nick
