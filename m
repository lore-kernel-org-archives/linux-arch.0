Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59224 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbeICVZA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Sep 2018 17:25:00 -0400
Date: Mon, 3 Sep 2018 18:04:13 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180903170412.GL6954@arm.com>
References: <20180831091641.GA3634@andrea>
 <Pine.LNX.4.44L0.1808311042340.4901-100000@netrider.rowland.org>
 <20180831160640.GG30626@arm.com>
 <20180831182845.GA4673@andrea>
 <20180903090153.GA4560@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903090153.GA4560@andrea>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180903170413.sR7DD46MglAhObIzrkuLsadcRHb1JjAnWRFEBPWul7o@z>

Andrea,

On Mon, Sep 03, 2018 at 11:01:53AM +0200, Andrea Parri wrote:
> On Fri, Aug 31, 2018 at 08:28:46PM +0200, Andrea Parri wrote:
> > > > Yes, it's true that implementing locks with atomic_cmpxchg_acquire 
> > > > should be correct on all existing architectures.  And Paul has invited 
> > > > a patch to modify the LKMM accordingly.  If you feel that such a change 
> > > > would be a useful enhancement to the LKMM's applicability, please write 
> > > > it.
> > > 
> > > Yes, please! That would be the "RmW" discussion which Andrea partially
> > > quoted earlier on, so getting that going independently from this patch
> > > sounds like a great idea to me.
> > 
> > That was indeed one of the proposal we discussed.  As you recalled, that
> > proposal only covered RmWs load-acquire (and ordinary store-release); in
> > particular, I realized that comments such as:
> > 
> >   "The atomic_cond_read_acquire() call above has provided the
> >    necessary acquire semantics required for locking."
> > 
> >    [from kernel/locking/qspinlock.c]
> > 
> > (for example)  would still _not have "generic validity" _if we added the
> > above po-unlock-rf-lock-po term... (which, again, makes me somehow uncon-
> > fortable);  Would to have _all_ the acquire be admissible for you?
> 
> In Cat speak,
> 
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 59b5cbe6b6240..fd9c0831adf0a 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -38,7 +38,7 @@ let strong-fence = mb | gp
>  (* Release Acquire *)
>  let acq-po = [Acquire] ; po ; [M]
>  let po-rel = [M] ; po ; [Release]
> -let rfi-rel-acq = [Release] ; rfi ; [Acquire]
> +let po-rel-rf-acq-po = po ; [Release] ; rf ; [Acquire] ; po
>  
>  (**********************************)
>  (* Fundamental coherence ordering *)
> @@ -60,13 +60,13 @@ let dep = addr | data
>  let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int)
> -let to-r = addr | (dep ; rfi) | rfi-rel-acq
> +let to-r = addr | (dep ; rfi)
>  let fence = strong-fence | wmb | po-rel | rmb | acq-po
> -let ppo = to-r | to-w | fence
> +let ppo = to-r | to-w | fence | (po-rel-rf-acq-po & int)
>  
>  (* Propagation: Ordering from release operations and strong fences. *)
>  let A-cumul(r) = rfe? ; r
> -let cumul-fence = A-cumul(strong-fence | po-rel) | wmb
> +let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | po-rel-rf-acq-po
>  let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
>  
>  (*

Isn't the job of the memory model to formalise the guarantees provided by
the implementation? Your diff appears to do exactly the opposite.

> I take this opportunity to summarize my viewpoint on these matters:
> 
> Someone would have to write the commit message for the above diff ...
> that is, to describe -why- we should go RCtso (and update the documen-
> tation accordingly); by now, the only argument for this appears to be:
> "(most) people expect strong ordering" _and they will be "lazy enough"
> to not check their expectations by using the LKMM tool (paraphrasing
> from [1]); IAC, Linux "might work" better if we add this ordering to
> the LKMM.  Agreeing on such an approach would mean agreeing that this
> argument "wins" over:
> 
>   "We want new architectures to implement acquire/release efficiently,
>    and it's not unlikely that they will have acquire loads that are
>    similar in semantics to LDAPR." [2]
> 
>   "RISC-V probably would have been RCpc [...]  it takes extra fences
>    to go from RCpc to either "RCtso" or RCsc." [3]
> 
> (or similar instances) since, of course, there is no such thing as a
> "free strong ordering"; and I'm not only talking about "efficiency",
> I'm also thinking at the fact that someone will have to maintain that
> ordering across all the architectures and in the LKMM.
> 
> If, OTOH, we agree that the above "win"/assumption is valid only for
> locks or, in other/better words, if we agree that we should maintain
> _two_ distinct release-acquire orderings (a first one for unlock-lock
> sequences and a second one for ordinary/atomic release-acquire, say,
> as proposed in the patch under RFC), I ask that we audit and modify
> the generic code accordingly/as suggested in other posts _before_ we
> upstream the changes for the LKMM: we should identify those places
> where (the newly introduced) _gap_ between unlock-lock and the other
> release-acquire is not admissible and fix those places (notice that
> this entails, in part., agreeing on what/where the generic code is).

This is completely unrealistic. Have we already audited the kernel for the
current definition of the memory model? Should we revert it until we have?

Of course not.

Right now, LKMM offers stronger guarantees that can portably be relied upon
in the codebase. Alan's patch fixes that, and holding back a fix for a known
issue runs counter to kernel development best practices.

> Finally, if we don't agree with the above assumption at all (that is,
> no matter if we are considering unlock-lock or other release-acquire
> sequences), then we should go RCpc [4].
> 
> I described three different approaches (which are NOT "independent",
> clearly; let us find an agreement...); even though some of them look
> insane to me, I'm currently open to all of them: thoughts?

I'm very confused by your statements hypothesising about where our opinions
may lie. We've discussed this to death, and it's clear that everybody who's
commented apart from you is happy to weaken acquire/release but leave
locking alone. Alan's written a patch to that effect which, again, only you
seem to have a problem with.

The problem isn't about "if we agree foo" or "if we don't agree bar", the
problem is that you're the only person raising an objection, so please can
you provide a constructive argument against Alan's patch, rather than a
confusing monologue of "what-if"s and unreasonable demands of anonymous
contributors? We don't have to solve all of our problems before we can
make any progress.

Thanks,

Will
