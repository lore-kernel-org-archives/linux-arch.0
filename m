From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Tue, 21 Jul 2020 11:15:13 -0400 (EDT)
Message-ID: <616209816.22376.1595344513051.JavaMail.zimbra@efficios.com>
References: <1594868476.6k5kvx8684.astroid@bobo.none> <20200716110038.GA119549@hirez.programming.kicks-ass.net> <1594906688.ikv6r4gznx.astroid@bobo.none> <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com> <1595213677.kxru89dqy2.astroid@bobo.none> <2055788870.20749.1595263590675.JavaMail.zimbra@efficios.com> <1595324577.x3bf55tpgu.astroid@bobo.none> <20200721150656.GN119549@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.26.124]:45222 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgGUPPP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 11:15:15 -0400
In-Reply-To: <20200721150656.GN119549@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>

----- On Jul 21, 2020, at 11:06 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Jul 21, 2020 at 08:04:27PM +1000, Nicholas Piggin wrote:
> 
>> That being said, the x86 sync core gap that I imagined could be fixed
>> by changing to rq->curr == rq->idle test does not actually exist because
>> the global membarrier does not have a sync core option. So fixing the
>> exit_lazy_tlb points that this series does *should* fix that. So
>> PF_KTHREAD may be less problematic than I thought from implementation
>> point of view, only semantics.
> 
> So I've been trying to figure out where that PF_KTHREAD comes from,
> commit 227a4aadc75b ("sched/membarrier: Fix p->mm->membarrier_state racy
> load") changed 'p->mm' to '!(p->flags & PF_KTHREAD)'.
> 
> So the first version:
> 
>  https://lkml.kernel.org/r/20190906031300.1647-5-mathieu.desnoyers@efficios.com
> 
> appears to unconditionally send the IPI and checks p->mm in the IPI
> context, but then v2:
> 
>  https://lkml.kernel.org/r/20190908134909.12389-1-mathieu.desnoyers@efficios.com
> 
> has the current code. But I've been unable to find the reason the
> 'p->mm' test changed into '!(p->flags & PF_KTHREAD)'.

Looking back at my inbox, it seems like you are the one who proposed to
skip all kthreads: 

https://lkml.kernel.org/r/20190904124333.GQ2332@hirez.programming.kicks-ass.net

> 
> The comment doesn't really help either; sure we have the whole lazy mm
> thing, but that's ->active_mm, not ->mm.
> 
> Possibly it is because {,un}use_mm() do not have sufficient barriers to
> make the remote p->mm test work? Or were we over-eager with the !p->mm
> doesn't imply kthread 'cleanups' at the time?

The nice thing about adding back kthreads to the threads considered for membarrier
IPI is that it has no observable effect on the user-space ABI. No pre-existing kthread
rely on this, and we just provide an additional guarantee for future kthread
implementations.

> Also, I just realized, I still have a fix for use_mm() now
> kthread_use_mm() that seems to have been lost.

I suspect we need to at least document the memory barriers in kthread_use_mm and
kthread_unuse_mm to state that they are required by membarrier if we want to
ipi kthreads as well.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
