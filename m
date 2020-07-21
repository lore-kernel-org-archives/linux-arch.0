From: peterz@infradead.org
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Tue, 21 Jul 2020 17:06:56 +0200
Message-ID: <20200721150656.GN119549@hirez.programming.kicks-ass.net>
References: <1594868476.6k5kvx8684.astroid@bobo.none>
 <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net>
 <20200716085032.GO10769@hirez.programming.kicks-ass.net>
 <1594892300.mxnq3b9a77.astroid@bobo.none>
 <20200716110038.GA119549@hirez.programming.kicks-ass.net>
 <1594906688.ikv6r4gznx.astroid@bobo.none>
 <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com>
 <1595213677.kxru89dqy2.astroid@bobo.none>
 <2055788870.20749.1595263590675.JavaMail.zimbra@efficios.com>
 <1595324577.x3bf55tpgu.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbgGUPHN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 11:07:13 -0400
Content-Disposition: inline
In-Reply-To: <1595324577.x3bf55tpgu.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>

On Tue, Jul 21, 2020 at 08:04:27PM +1000, Nicholas Piggin wrote:

> That being said, the x86 sync core gap that I imagined could be fixed 
> by changing to rq->curr == rq->idle test does not actually exist because
> the global membarrier does not have a sync core option. So fixing the
> exit_lazy_tlb points that this series does *should* fix that. So
> PF_KTHREAD may be less problematic than I thought from implementation
> point of view, only semantics.

So I've been trying to figure out where that PF_KTHREAD comes from,
commit 227a4aadc75b ("sched/membarrier: Fix p->mm->membarrier_state racy
load") changed 'p->mm' to '!(p->flags & PF_KTHREAD)'.

So the first version:

  https://lkml.kernel.org/r/20190906031300.1647-5-mathieu.desnoyers@efficios.com

appears to unconditionally send the IPI and checks p->mm in the IPI
context, but then v2:

  https://lkml.kernel.org/r/20190908134909.12389-1-mathieu.desnoyers@efficios.com

has the current code. But I've been unable to find the reason the
'p->mm' test changed into '!(p->flags & PF_KTHREAD)'.

The comment doesn't really help either; sure we have the whole lazy mm
thing, but that's ->active_mm, not ->mm.

Possibly it is because {,un}use_mm() do not have sufficient barriers to
make the remote p->mm test work? Or were we over-eager with the !p->mm
doesn't imply kthread 'cleanups' at the time?

Also, I just realized, I still have a fix for use_mm() now
kthread_use_mm() that seems to have been lost.
