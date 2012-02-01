From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: on memory barriers and cachelines
Date: Wed, 1 Feb 2012 09:17:20 -0800
Message-ID: <CA+55aFx2pZtabFS54xfiLRcWnXi2NJjCHxdn-NLzFOqg7HNtmg@mail.gmail.com>
References: <1328088838.2760.21.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56340 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab2BARRk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2012 12:17:40 -0500
Received: by yhoo21 with SMTP id o21so678028yho.19
        for <linux-arch@vger.kernel.org>; Wed, 01 Feb 2012 09:17:40 -0800 (PST)
In-Reply-To: <1328088838.2760.21.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, benh <benh@kernel.crashing.org>, davem <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, dhowells <dhowells@redhat.com>

On Wed, Feb 1, 2012 at 1:33 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> So I was talking to Paul yesterday and he mentioned how the SRCU sync
> primitive has to use extra synchronize_sched() calls in order to avoid
> smp_rmb() calls in the srcu_read_{un,}lock() calls.

So that's probably a bad optimization these days, simply because
smp_rmb() is totally free on x86.

And on other architectures, it is *usually* a fairly cheap pipeline
sync. But they mostly don't really matter, outside of ARM.

> Now memory barriers are usually explained as observable order between
> two (or more) unrelated variables, as Documentation/memory-barriers.txt
> does in great detail.
>
> What I couldn't find in there though, is what happens when both
> variables are on the same cacheline. The "The effects of the CPU cache"
> and "Cache coherency" sections are closest but leave me wanting on this
> point.
>
> Can we get some implicit behaviour from being on the same cacheline? Or
> can this memory access queue still totally wreck the game?

At least on alpha, the cacheline itself is subpartitioned into
sectors, and accesses to different parts of the same cacheline can go
to different sectors, and literally have ordering issues because a
write from another CPU will update the sectors individually. This is
where the insane "smp_read_barrier_depends()" comes from, iirc.

So no, you cannot assume that a single cacheline is somehow "atomic"
and inherently ordered.

Also, even if you were to find an atomic sub-chunk, if you need a
"smp_rmb()", what else would guarantee that the CPU core wouldn't
re-order things to do the second read first, then lose the cacheline,
re-read it, and then do the first read?

So the reason smp_rmb() is free on x86 is that won't do that kind of
re-ordering.  Either because the uarch won't re-order the cache
accesses of reads wrt each other in the first place or because the
uarch makes sure that cachelines stay around until instructions have
been retired in order. But other architectures that do need smp_rmb()
can well re-order loads wildly even if they share a cacheline.

But smp_rmb() and smp_wmb() are usually supposed *much* cheaper than a
full barrier. Of course, various architectures can get it totally
wrong, so..

                      Linus
