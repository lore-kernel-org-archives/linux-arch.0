From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Tue, 21 Jul 2020 09:11:58 -0400 (EDT)
Message-ID: <470490605.22057.1595337118562.JavaMail.zimbra@efficios.com>
References: <1594868476.6k5kvx8684.astroid@bobo.none> <1594892300.mxnq3b9a77.astroid@bobo.none> <20200716110038.GA119549@hirez.programming.kicks-ass.net> <1594906688.ikv6r4gznx.astroid@bobo.none> <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com> <1595213677.kxru89dqy2.astroid@bobo.none> <2055788870.20749.1595263590675.JavaMail.zimbra@efficios.com> <1595324577.x3bf55tpgu.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1595324577.x3bf55tpgu.astroid@bobo.none>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

----- On Jul 21, 2020, at 6:04 AM, Nicholas Piggin npiggin@gmail.com wrote:

> Excerpts from Mathieu Desnoyers's message of July 21, 2020 2:46 am:
[...]
> 
> Yeah you're probably right in this case I think. Quite likely most kernel
> tasks that asynchronously write to user memory would at least have some
> kind of producer-consumer barriers.
> 
> But is that restriction of all async modifications documented and enforced
> anywhere?
> 
>>> How about other memory accesses via kthread_use_mm? Presumably there is
>>> still ordering requirement there for membarrier,
>> 
>> Please provide an example case with memory accesses via kthread_use_mm where
>> ordering matters to support your concern.
> 
> I think the concern Andy raised with io_uring was less a specific
> problem he saw and more a general concern that we have these memory
> accesses which are not synchronized with membarrier.
> 
>>> so I really think
>>> it's a fragile interface with no real way for the user to know how
>>> kernel threads may use its mm for any particular reason, so membarrier
>>> should synchronize all possible kernel users as well.
>> 
>> I strongly doubt so, but perhaps something should be clarified in the
>> documentation
>> if you have that feeling.
> 
> I'd rather go the other way and say if you have reasoning or numbers for
> why PF_KTHREAD is an important optimisation above rq->curr == rq->idle
> then we could think about keeping this subtlety with appropriate
> documentation added, otherwise we can just kill it and remove all doubt.
> 
> That being said, the x86 sync core gap that I imagined could be fixed
> by changing to rq->curr == rq->idle test does not actually exist because
> the global membarrier does not have a sync core option. So fixing the
> exit_lazy_tlb points that this series does *should* fix that. So
> PF_KTHREAD may be less problematic than I thought from implementation
> point of view, only semantics.

Today, the membarrier global expedited command explicitly skips kernel threads,
but it happens that membarrier private expedited considers those with the
same mm as target for the IPI.

So we already implement a semantic which differs between private and global
expedited membarriers. This can be explained in part by the fact that
kthread_use_mm was introduced after 4.16, where the most recent membarrier
commands where introduced. It seems that the effect on membarrier was not
considered when kthread_use_mm was introduced.

Looking at membarrier(2) documentation, it states that IPIs are only sent to
threads belonging to the same process as the calling thread. If my understanding
of the notion of process is correct, this should rule out sending the IPI to
kernel threads, given they are not "part" of the same process, only borrowing
the mm. But I agree that the distinction is moot, and should be clarified.

Without a clear use-case to justify adding a constraint on membarrier, I am
tempted to simply clarify documentation of current membarrier commands,
stating clearly that they are not guaranteed to affect kernel threads. Then,
if we have a compelling use-case to implement a different behavior which covers
kthreads, this could be added consistently across membarrier commands with a
flag (or by adding new commands).

Does this approach make sense ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
