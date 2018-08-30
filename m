From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Date: Thu, 30 Aug 2018 17:31:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1808301712230.31183-100000@netrider.rowland.org>
References: <20180830125045.GA6936@andrea>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830125045.GA6936@andrea>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <parri.andrea@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Thu, 30 Aug 2018, Andrea Parri wrote:

> > All the architectures supported by the Linux kernel (including RISC-V)
> > do provide this ordering for locks, albeit for varying reasons.
> > Therefore this patch changes the model in accordance with the
> > developers' wishes.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Reviewed-by: Will Deacon <will.deacon@arm.com>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Round 2 ;-), I guess...  Let me start from the uncontroversial points:
> 
>   1) being able to use the LKMM to reason about generic locking code
>      is useful and desirable (paraphrasing Peter in [1]);
> 
>   2) strengthening the ordering requirements of such code isn't going
>      to boost performance (that's "real maths").
> 
> This patch is taking (1) away from us and it is formalizing (2), with
> almost _no_ reason (no reason at all, if we stick to the commit msg.).

That's not quite fair.  Generic code isn't always universally
applicable; some of it is opt-in -- meant only for the architectures
that can support it.  In general, the LKMM allows us to reason about
higher abstractions (such as locking) at a higher level, without
necessarily being able to verify the architecture-specific details of
the implementations.

> In [2], Will wrote:
> 
>   "[...] having them [the RMWs] closer to RCsc[/to the semantics of
>    locks] would make it easier to implement and reason about generic
>    locking implementations (i.e. reduce the number of special ordering
>    cases and/or magic barrier macros)"
> 
> "magic barrier macros" as in "mmh, if we accept this patch, we _should_
> be auditing the various implementations/code to decide where to place a
> 
>   smp_barrier_promote_ordinary_release_acquire_to_unlock_lock()" ;-)
> 
> or the like, and "special ordering cases" as in "arrgh, (otherwise) we
> are forced to reason on a per-arch basis while looking at generic code".

Currently the LKMM does not permit architecture-specific reasoning.  It 
would have to be extended (in a different way for each architecture) 
first.

For example, one could use herd's POWER model combined with the POWER 
compilation scheme and the POWER-specific implementation of spinlocks 
for such reasoning.  The LKMM alone is not sufficient.

Sure, programming and reasoning about the kernel would be easier if all
architectures were the same.  Unfortunately, we (and the kernel) have
to live in the real world.

> (Remark: ordinary release/acquire are building blocks for code such as
>  qspinlock, (q)rwlock, mutex, rwsem, ... and what else??).

But are these building blocks used the same way for all architectures?

> To avoid further repetition, I conclude by confirming all the concerns
> and my assessment of this patch as pointed out in [3]; the subsequent
> discussion, although not conclusive, presented several suggestions for
> improvement (IMO).

Alan
