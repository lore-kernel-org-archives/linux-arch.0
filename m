From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Tue, 21 Jul 2020 20:04:27 +1000
Message-ID: <1595324577.x3bf55tpgu.astroid@bobo.none>
References: <1594868476.6k5kvx8684.astroid@bobo.none>
        <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net>
        <20200716085032.GO10769@hirez.programming.kicks-ass.net>
        <1594892300.mxnq3b9a77.astroid@bobo.none>
        <20200716110038.GA119549@hirez.programming.kicks-ass.net>
        <1594906688.ikv6r4gznx.astroid@bobo.none>
        <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com>
        <1595213677.kxru89dqy2.astroid@bobo.none>
        <2055788870.20749.1595263590675.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgGUKEh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 06:04:37 -0400
In-Reply-To: <2055788870.20749.1595263590675.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>

Excerpts from Mathieu Desnoyers's message of July 21, 2020 2:46 am:
> ----- On Jul 19, 2020, at 11:03 PM, Nicholas Piggin npiggin@gmail.com wro=
te:
>=20
>> Excerpts from Mathieu Desnoyers's message of July 17, 2020 11:42 pm:
>>> ----- On Jul 16, 2020, at 7:26 PM, Nicholas Piggin npiggin@gmail.com wr=
ote:
>>> [...]
>>>>=20
>>>> membarrier does replace barrier instructions on remote CPUs, which do
>>>> order accesses performed by the kernel on the user address space. So
>>>> membarrier should too I guess.
>>>>=20
>>>> Normal process context accesses like read(2) will do so because they
>>>> don't get filtered out from IPIs, but kernel threads using the mm may
>>>> not.
>>>=20
>>> But it should not be an issue, because membarrier's ordering is only wi=
th
>>> respect
>>> to submit and completion of io_uring requests, which are performed thro=
ugh
>>> system calls from the context of user-space threads, which are called f=
rom the
>>> right mm.
>>=20
>> Is that true? Can io completions be written into an address space via a
>> kernel thread? I don't know the io_uring code well but it looks like
>> that's asynchonously using the user mm context.
>=20
> Indeed, the io completion appears to be signaled asynchronously between k=
ernel
> and user-space.

Yep, many other places do similar with use_mm.

[snip]

> So as far as membarrier memory ordering dependencies are concerned, it re=
lies
> on the store-release/load-acquire dependency chain in the completion queu=
e to
> order against anything that was done prior to the completed requests.
>=20
> What is in-flight while the requests are being serviced provides no memor=
y
> ordering guarantee whatsoever.

Yeah you're probably right in this case I think. Quite likely most kernel=20
tasks that asynchronously write to user memory would at least have some=20
kind of producer-consumer barriers.

But is that restriction of all async modifications documented and enforced
anywhere?

>> How about other memory accesses via kthread_use_mm? Presumably there is
>> still ordering requirement there for membarrier,
>=20
> Please provide an example case with memory accesses via kthread_use_mm wh=
ere
> ordering matters to support your concern.

I think the concern Andy raised with io_uring was less a specific=20
problem he saw and more a general concern that we have these memory=20
accesses which are not synchronized with membarrier.

>> so I really think
>> it's a fragile interface with no real way for the user to know how
>> kernel threads may use its mm for any particular reason, so membarrier
>> should synchronize all possible kernel users as well.
>=20
> I strongly doubt so, but perhaps something should be clarified in the doc=
umentation
> if you have that feeling.

I'd rather go the other way and say if you have reasoning or numbers for=20
why PF_KTHREAD is an important optimisation above rq->curr =3D=3D rq->idle
then we could think about keeping this subtlety with appropriate=20
documentation added, otherwise we can just kill it and remove all doubt.

That being said, the x86 sync core gap that I imagined could be fixed=20
by changing to rq->curr =3D=3D rq->idle test does not actually exist becaus=
e
the global membarrier does not have a sync core option. So fixing the
exit_lazy_tlb points that this series does *should* fix that. So
PF_KTHREAD may be less problematic than I thought from implementation
point of view, only semantics.

Thanks,
Nick
