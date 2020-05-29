From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
Date: Thu, 28 May 2020 22:14:21 -0700
Message-ID: <CAEf4BzYf6jjrStc08R1bDASFyEdKj6vYg_MOaipUJ3vbdqNrSg@mail.gmail.com>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72> <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu> <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com> <20200525112521.GD317569@hirez.programming.kicks-ass.net>
 <20200525154730.GW2869@paulmck-ThinkPad-P72> <20200525170257.GA325280@hirez.programming.kicks-ass.net>
 <20200525172154.GZ2869@paulmck-ThinkPad-P72> <20200528220047.GB211369@google.com>
 <20200528221659.GS2483@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2FOd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 01:14:33 -0400
In-Reply-To: <20200528221659.GS2483@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, "Paul E. McKenney" <paulmck@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com, will@kernel.org, Boqun Feng <boqun.feng@gmail.com>, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, Akira Yokosawa <akiyks@gmail.com>, dlustig@nvidia.com, open list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Thu, May 28, 2020 at 3:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 28, 2020 at 06:00:47PM -0400, Joel Fernandes wrote:
>
> > Any idea why this choice of locking-based ring buffer implementation in BPF?
> > The ftrace ring buffer can support NMI interruptions as well for writes.
> >
> > Also, is it possible for BPF to reuse the ftrace ring buffer implementation
> > or does it not meet the requirements?
>
> Both perf and ftrace are per-cpu, which, according to the patch
> description is too much memory overhead for them. Neither have ever
> considered anything else, atomic ops are expensive.

Right, as mentioned in commit description to [0], desire to use shared
ring buffer across multiple CPUs to save memory and absorb bigger
spikes with overall lower memory use was one of main motivations.
Ordered events was another one. Both perf buffer and ftrace buffer use
strictly per-CPU buffers, which in practice makes a lot of developers
make hard and non-obvious choice between using too much memory or
losing too much events due to running out of space in a buffer.

  [0] https://patchwork.ozlabs.org/project/netdev/patch/20200526063255.1675186-2-andriin@fb.com/

>
> On top of that, they want multi-producer support. Yes, doing that gets
> interesting really fast, but using spinlocks gets you a trainwreck like
> this.
>
> This thing so readily wanting to drop data on the floor should worry

It's true that *in NMI context*, if spinlock is already taken,
reservation will fail, so under high contention there will be
potentially high number of drops. So for such cases perfbuf might be a
better approach and BPF applications will have to deal with higher
memory usage. In practice, though, most BPF programs are not running
in NMI context, so there won't be any drop due to spinlock usage.
Having both perfbuf and this new BPF ringbuf gives people choice and
more options to tailor to their needs.

There is another cluster of applications which are unnecessarily more
complicated just for the fact that there is no ordering between
correlated events that happen on different CPUs. Per-CPU buffers are
not well suited for such cases, unfortunately.

> people, but apparently they've not spend enough time debugging stuff
> with partial logs yet. Of course, bpf_prog_active already makes BPF
> lossy, so maybe they went with that.

Not sure which "partial logs" you mean, I'll assume dropped samples?
All production BPF applications are already designed to handle data
loss, because it could and does happen due to running out of buffer
space. Of course, amount of such drops is minimized however possible,
but applications still need to be able to handle that.

Now, though, there will be more options. Now it's not just a question
of whether to allocate a tiny 64KB per-CPU buffer on 80 core server
and use reasonable 5MB for perfbuf overall, but suffer high and
frequent data loss whenever a burst of incoming events happen. Or bump
it up to, say, 256KB (or higher) and use 20MB+ now, which most of the
time will be completely unused, but be able to absorb 4x more events.
Now it might be more than enough to just allocate a single shared 5MB
buffer and be able to absorb much higher spikes (of course, assuming
not all CPUs will be spiking at the same time, in which case nothing
can really help you much w.r.t. data loss).

So many BPF users are acutely aware of data loss and care a lot, but
there are other constraints that they have to take into account.

As for expensiveness of spinlock and atomics, a lot of applications we
are seeing do not require huge throughput that per-CPU data structures
provide, so such overhead is acceptable. Even under high contention,
BPF ringbuf performance is pretty reasonable and will satisfy a lot of
applications, see [1].

  [1] https://patchwork.ozlabs.org/project/netdev/patch/20200526063255.1675186-5-andriin@fb.com/

>
> All reasons why I never bother with BPF, aside from it being more
> difficult than hacking up a kernel in the first place.

It's not my goal to pitch BPF here, but for a lot of real-world use
cases, hacking kernel is not an option at all, for many reasons. One
of them is that kernel upgrades across huge fleet of servers take a
long time, which teams can't afford to wait. In such cases, BPF is a
perfect solution, which can't be beaten, as evidenced by a wide
variety of BPF applications solving real problems.
