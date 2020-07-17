From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Fri, 17 Jul 2020 09:39:25 -0400 (EDT)
Message-ID: <1770378591.18523.1594993165391.JavaMail.zimbra@efficios.com>
References: <20200710015646.2020871-1-npiggin@gmail.com> <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com> <1594868476.6k5kvx8684.astroid@bobo.none> <1594873644.viept6os6j.astroid@bobo.none> <1494299304.15894.1594914382695.JavaMail.zimbra@efficios.com> <1370747990.15974.1594915396143.JavaMail.zimbra@efficios.com> <595582123.17106.1594925921537.JavaMail.zimbra@efficios.com> <20200716212416.GA1126458@rowland.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.26.124]:49166 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQNj1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 09:39:27 -0400
In-Reply-To: <20200716212416.GA1126458@rowland.harvard.edu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nicholas Piggin <npiggin@gmail.com>, paulmck <paulmck@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>

----- On Jul 16, 2020, at 5:24 PM, Alan Stern stern@rowland.harvard.edu wrote:

> On Thu, Jul 16, 2020 at 02:58:41PM -0400, Mathieu Desnoyers wrote:
>> ----- On Jul 16, 2020, at 12:03 PM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>> 
>> > ----- On Jul 16, 2020, at 11:46 AM, Mathieu Desnoyers
>> > mathieu.desnoyers@efficios.com wrote:
>> > 
>> >> ----- On Jul 16, 2020, at 12:42 AM, Nicholas Piggin npiggin@gmail.com wrote:
>> >>> I should be more complete here, especially since I was complaining
>> >>> about unclear barrier comment :)
>> >>> 
>> >>> 
>> >>> CPU0                     CPU1
>> >>> a. user stuff            1. user stuff
>> >>> b. membarrier()          2. enter kernel
>> >>> c. smp_mb()              3. smp_mb__after_spinlock(); // in __schedule
>> >>> d. read rq->curr         4. rq->curr switched to kthread
>> >>> e. is kthread, skip IPI  5. switch_to kthread
>> >>> f. return to user        6. rq->curr switched to user thread
>> >>> g. user stuff            7. switch_to user thread
>> >>>                         8. exit kernel
>> >>>                         9. more user stuff
>> >>> 
>> >>> What you're really ordering is a, g vs 1, 9 right?
>> >>> 
>> >>> In other words, 9 must see a if it sees g, g must see 1 if it saw 9,
>> >>> etc.
>> >>> 
>> >>> Userspace does not care where the barriers are exactly or what kernel
>> >>> memory accesses might be being ordered by them, so long as there is a
>> >>> mb somewhere between a and g, and 1 and 9. Right?
>> >> 
>> >> This is correct.
>> > 
>> > Actually, sorry, the above is not quite right. It's been a while
>> > since I looked into the details of membarrier.
>> > 
>> > The smp_mb() at the beginning of membarrier() needs to be paired with a
>> > smp_mb() _after_ rq->curr is switched back to the user thread, so the
>> > memory barrier is between store to rq->curr and following user-space
>> > accesses.
>> > 
>> > The smp_mb() at the end of membarrier() needs to be paired with the
>> > smp_mb__after_spinlock() at the beginning of schedule, which is
>> > between accesses to userspace memory and switching rq->curr to kthread.
>> > 
>> > As to *why* this ordering is needed, I'd have to dig through additional
>> > scenarios from https://lwn.net/Articles/573436/. Or maybe Paul remembers ?
>> 
>> Thinking further about this, I'm beginning to consider that maybe we have been
>> overly cautious by requiring memory barriers before and after store to rq->curr.
>> 
>> If CPU0 observes a CPU1's rq->curr->mm which differs from its own process
>> (current)
>> while running the membarrier system call, it necessarily means that CPU1 had
>> to issue smp_mb__after_spinlock when entering the scheduler, between any
>> user-space
>> loads/stores and update of rq->curr.
>> 
>> Requiring a memory barrier between update of rq->curr (back to current process's
>> thread) and following user-space memory accesses does not seem to guarantee
>> anything more than what the initial barrier at the beginning of __schedule
>> already
>> provides, because the guarantees are only about accesses to user-space memory.
>> 
>> Therefore, with the memory barrier at the beginning of __schedule, just
>> observing that
>> CPU1's rq->curr differs from current should guarantee that a memory barrier was
>> issued
>> between any sequentially consistent instructions belonging to the current
>> process on
>> CPU1.
>> 
>> Or am I missing/misremembering an important point here ?
> 
> Is it correct to say that the switch_to operations in 5 and 7 include
> memory barriers?  If they do, then skipping the IPI should be okay.
> 
> The reason is as follows: The guarantee you need to enforce is that
> anything written by CPU0 before the membarrier() will be visible to CPU1
> after it returns to user mode.  Let's say that a writes to X and 9
> reads from X.
> 
> Then we have an instance of the Store Buffer pattern:
> 
>	CPU0			CPU1
>	a. Write X		6. Write rq->curr for user thread
>	c. smp_mb()		7. switch_to memory barrier
>	d. Read rq->curr	9. Read X
> 
> In this pattern, the memory barriers make it impossible for both reads
> to miss their corresponding writes.  Since d does fail to read 6 (it
> sees the earlier value stored by 4), 9 must read a.
> 
> The other guarantee you need is that g on CPU0 will observe anything
> written by CPU1 in 1.  This is easier to see, using the fact that 3 is a
> memory barrier and d reads from 4.

Right, and Nick's reply involving pairs of loads/stores on each side
clarifies the situation even further.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
