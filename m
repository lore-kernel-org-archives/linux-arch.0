From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Wed, 22 Jul 2020 00:30:01 +1000
Message-ID: <1595341248.r2i8fnhz28.astroid@bobo.none>
References: <1594868476.6k5kvx8684.astroid@bobo.none>
        <1594892300.mxnq3b9a77.astroid@bobo.none>
        <20200716110038.GA119549@hirez.programming.kicks-ass.net>
        <1594906688.ikv6r4gznx.astroid@bobo.none>
        <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com>
        <1595213677.kxru89dqy2.astroid@bobo.none>
        <2055788870.20749.1595263590675.JavaMail.zimbra@efficios.com>
        <1595324577.x3bf55tpgu.astroid@bobo.none>
        <470490605.22057.1595337118562.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgGUOaK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 10:30:10 -0400
In-Reply-To: <470490605.22057.1595337118562.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>

Excerpts from Mathieu Desnoyers's message of July 21, 2020 11:11 pm:
> ----- On Jul 21, 2020, at 6:04 AM, Nicholas Piggin npiggin@gmail.com wrot=
e:
>=20
>> Excerpts from Mathieu Desnoyers's message of July 21, 2020 2:46 am:
> [...]
>>=20
>> Yeah you're probably right in this case I think. Quite likely most kerne=
l
>> tasks that asynchronously write to user memory would at least have some
>> kind of producer-consumer barriers.
>>=20
>> But is that restriction of all async modifications documented and enforc=
ed
>> anywhere?
>>=20
>>>> How about other memory accesses via kthread_use_mm? Presumably there i=
s
>>>> still ordering requirement there for membarrier,
>>>=20
>>> Please provide an example case with memory accesses via kthread_use_mm =
where
>>> ordering matters to support your concern.
>>=20
>> I think the concern Andy raised with io_uring was less a specific
>> problem he saw and more a general concern that we have these memory
>> accesses which are not synchronized with membarrier.
>>=20
>>>> so I really think
>>>> it's a fragile interface with no real way for the user to know how
>>>> kernel threads may use its mm for any particular reason, so membarrier
>>>> should synchronize all possible kernel users as well.
>>>=20
>>> I strongly doubt so, but perhaps something should be clarified in the
>>> documentation
>>> if you have that feeling.
>>=20
>> I'd rather go the other way and say if you have reasoning or numbers for
>> why PF_KTHREAD is an important optimisation above rq->curr =3D=3D rq->id=
le
>> then we could think about keeping this subtlety with appropriate
>> documentation added, otherwise we can just kill it and remove all doubt.
>>=20
>> That being said, the x86 sync core gap that I imagined could be fixed
>> by changing to rq->curr =3D=3D rq->idle test does not actually exist bec=
ause
>> the global membarrier does not have a sync core option. So fixing the
>> exit_lazy_tlb points that this series does *should* fix that. So
>> PF_KTHREAD may be less problematic than I thought from implementation
>> point of view, only semantics.
>=20
> Today, the membarrier global expedited command explicitly skips kernel th=
reads,
> but it happens that membarrier private expedited considers those with the
> same mm as target for the IPI.
>=20
> So we already implement a semantic which differs between private and glob=
al
> expedited membarriers.

Which is not a good thing.

> This can be explained in part by the fact that
> kthread_use_mm was introduced after 4.16, where the most recent membarrie=
r
> commands where introduced. It seems that the effect on membarrier was not
> considered when kthread_use_mm was introduced.

No it was just renamed, it used to be called use_mm and has been in the=20
kernel for ~ever.

That you hadn't considered this is actually weight for my point, which=20
is that there's so much subtle behaviour that's easy to miss we're=20
better off with simpler and fewer special cases until it's proven=20
they're needed. Not the other way around.

>=20
> Looking at membarrier(2) documentation, it states that IPIs are only sent=
 to
> threads belonging to the same process as the calling thread. If my unders=
tanding
> of the notion of process is correct, this should rule out sending the IPI=
 to
> kernel threads, given they are not "part" of the same process, only borro=
wing
> the mm. But I agree that the distinction is moot, and should be clarified=
.

It does if you read it in a user-hostile legalistic way. The reality is=20
userspace shouldn't and can't know about how the kernel might implement=20
functionality.

> Without a clear use-case to justify adding a constraint on membarrier, I =
am
> tempted to simply clarify documentation of current membarrier commands,
> stating clearly that they are not guaranteed to affect kernel threads. Th=
en,
> if we have a compelling use-case to implement a different behavior which =
covers
> kthreads, this could be added consistently across membarrier commands wit=
h a
> flag (or by adding new commands).
>=20
> Does this approach make sense ?

The other position is without a clear use case for PF_KTHREAD, seeing as=20
async kernel accesses had not been considered before now, we limit the=20
optimision to only skipping the idle thread. I think that makes more=20
sense (unless you have a reason for PF_KTHREAD but it doesn't seem like=20
there is much of one).

Thanks,
Nick
