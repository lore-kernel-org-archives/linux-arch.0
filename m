From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Thu, 16 Jul 2020 14:42:38 +1000
Message-ID: <1594873644.viept6os6j.astroid@bobo.none>
References: <20200710015646.2020871-1-npiggin@gmail.com>
        <20200710015646.2020871-5-npiggin@gmail.com>
        <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com>
        <1594613902.1wzayj0p15.astroid@bobo.none>
        <1594647408.wmrazhwjzb.astroid@bobo.none>
        <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
        <1594868476.6k5kvx8684.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgGPEms (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 00:42:48 -0400
In-Reply-To: <1594868476.6k5kvx8684.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>

Excerpts from Nicholas Piggin's message of July 16, 2020 2:15 pm:
> Excerpts from Mathieu Desnoyers's message of July 14, 2020 12:13 am:
>> ----- On Jul 13, 2020, at 9:47 AM, Nicholas Piggin npiggin@gmail.com wro=
te:
>>=20
>>> Excerpts from Nicholas Piggin's message of July 13, 2020 2:45 pm:
>>>> Excerpts from Andy Lutomirski's message of July 11, 2020 3:04 am:
>>>>> Also, as it stands, I can easily see in_irq() ceasing to promise to
>>>>> serialize.  There are older kernels for which it does not promise to
>>>>> serialize.  And I have plans to make it stop serializing in the
>>>>> nearish future.
>>>>=20
>>>> You mean x86's return from interrupt? Sounds fun... you'll konw where =
to
>>>> update the membarrier sync code, at least :)
>>>=20
>>> Oh, I should actually say Mathieu recently clarified a return from
>>> interrupt doesn't fundamentally need to serialize in order to support
>>> membarrier sync core.
>>=20
>> Clarification to your statement:
>>=20
>> Return from interrupt to kernel code does not need to be context seriali=
zing
>> as long as kernel serializes before returning to user-space.
>>=20
>> However, return from interrupt to user-space needs to be context seriali=
zing.
>=20
> Hmm, I'm not sure it's enough even with the sync in the exit_lazy_tlb
> in the right places.
>=20
> A kernel thread does a use_mm, then it blocks and the user process with
> the same mm runs on that CPU, and then it calls into the kernel, blocks,
> the kernel thread runs again, another CPU issues a membarrier which does
> not IPI this one because it's running a kthread, and then the kthread
> switches back to the user process (still without having unused the mm),
> and then the user process returns from syscall without having done a=20
> core synchronising instruction.
>=20
> The cause of the problem is you want to avoid IPI'ing kthreads. Why?
> I'm guessing it really only matters as an optimisation in case of idle
> threads. Idle thread is easy (well, easier) because it won't use_mm, so=20
> you could check for rq->curr =3D=3D rq->idle in your loop (in a suitable=20
> sched accessor function).
>=20
> But... I'm not really liking this subtlety in the scheduler for all this=20
> (the scheduler still needs the barriers when switching out of idle).
>=20
> Can it be improved somehow? Let me forget x86 core sync problem for now
> (that _may_ be a bit harder), and step back and look at what we're doing.
> The memory barrier case would actually suffer from the same problem as
> core sync, because in the same situation it has no implicit mmdrop in
> the scheduler switch code either.
>=20
> So what are we doing with membarrier? We want any activity caused by the=20
> set of CPUs/threads specified that can be observed by this thread before=20
> calling membarrier is appropriately fenced from activity that can be=20
> observed to happen after the call returns.
>=20
> CPU0                     CPU1
>                          1. user stuff
> a. membarrier()          2. enter kernel
> b. read rq->curr         3. rq->curr switched to kthread
> c. is kthread, skip IPI  4. switch_to kthread
> d. return to user        5. rq->curr switched to user thread
> 		         6. switch_to user thread
> 		         7. exit kernel
>                          8. more user stuff
>=20
> As far as I can see, the problem is CPU1 might reorder step 5 and step
> 8, so you have mmdrop of lazy mm be a mb after step 6.
>=20
> But why? The membarrier call only cares that there is a full barrier
> between 1 and 8, right? Which it will get from the previous context
> switch to the kthread.

I should be more complete here, especially since I was complaining
about unclear barrier comment :)


CPU0                     CPU1
a. user stuff            1. user stuff
b. membarrier()          2. enter kernel
c. smp_mb()              3. smp_mb__after_spinlock(); // in __schedule
d. read rq->curr         4. rq->curr switched to kthread
e. is kthread, skip IPI  5. switch_to kthread
f. return to user        6. rq->curr switched to user thread
g. user stuff            7. switch_to user thread
                         8. exit kernel
                         9. more user stuff

What you're really ordering is a, g vs 1, 9 right?

In other words, 9 must see a if it sees g, g must see 1 if it saw 9,
etc.

Userspace does not care where the barriers are exactly or what kernel=20
memory accesses might be being ordered by them, so long as there is a
mb somewhere between a and g, and 1 and 9. Right?
