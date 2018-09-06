From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Date: Thu, 6 Sep 2018 11:36:55 +0200
Message-ID: <20180906093655.GA9653@andrea>
References: <20180903090153.GA4560@andrea>
 <Pine.LNX.4.44L0.1809052115490.2261-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1809052115490.2261-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>, Andrea Parri <parri.andrea@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 05, 2018 at 09:25:40PM -0400, Alan Stern wrote:
> On Mon, 3 Sep 2018, Andrea Parri wrote:
> 
> > I take this opportunity to summarize my viewpoint on these matters:
> > 


[1st approach/fix]

> > Someone would have to write the commit message for the above diff ...
> > that is, to describe -why- we should go RCtso (and update the documen-
> > tation accordingly); by now, the only argument for this appears to be:
> > "(most) people expect strong ordering" _and they will be "lazy enough"
> > to not check their expectations by using the LKMM tool (paraphrasing
> > from [1]); IAC, Linux "might work" better if we add this ordering to
> > the LKMM.  Agreeing on such an approach would mean agreeing that this
> > argument "wins" over:
> > 
> >   "We want new architectures to implement acquire/release efficiently,
> >    and it's not unlikely that they will have acquire loads that are
> >    similar in semantics to LDAPR." [2]
> > 
> >   "RISC-V probably would have been RCpc [...]  it takes extra fences
> >    to go from RCpc to either "RCtso" or RCsc." [3]
> > 
> > (or similar instances) since, of course, there is no such thing as a
> > "free strong ordering"; and I'm not only talking about "efficiency",
> > I'm also thinking at the fact that someone will have to maintain that
> > ordering across all the architectures and in the LKMM.
> > 


[2nd approach/fix]

> > If, OTOH, we agree that the above "win"/assumption is valid only for
> > locks or, in other/better words, if we agree that we should maintain
> > _two_ distinct release-acquire orderings (a first one for unlock-lock
> > sequences and a second one for ordinary/atomic release-acquire, say,
> > as proposed in the patch under RFC),
> 
> In fact, there have have been _two_ proposals along this line.  One as
> you describe here (which is what the 1/7 patch under discussion does),
> and another in which unlock-lock sequences and atomic acquire-release
> sequences both have "RCtso" semantics while ordinary acquire/release
> sequences have RCpc semantics.  You should consider the second
> proposal.  It could be put into the LKMM quite easily by building upon
> this 1/7 patch.

I posted a prototype here (no replies from other LKMM maintainers):

  http://lkml.kernel.org/r/20180712212351.GA5480@andrea

I'm certainly willing to consider it, but I would agree with you in
saying that this proposal follows this second "approach" above  (in
part., it might be subject to the same/similar counterarguments).


> 
> >  I ask that we audit and modify
> > the generic code accordingly/as suggested in other posts _before_ we
> > upstream the changes for the LKMM: we should identify those places
> > where (the newly introduced) _gap_ between unlock-lock and the other
> > release-acquire is not admissible and fix those places (notice that
> > this entails, in part., agreeing on what/where the generic code is).
> 
> Have you noticed any part of the generic code that relies on ordinary 
> acquire-release (rather than atomic RMW acquire-release) in order to 
> implement locking constructs?

There are several places in code where the "lock-acquire" seems to be
provided by an atomic_cond_read_acquire/smp_cond_load_acquire: I have
mentioned one in qspinlock in this thread; qrwlock and mcs_spinlock
provide other examples (grep for the primitives...).

As long as we don't consider these primitive as RMW (which would seem
odd...) or as acquire for which "most people expect strong ordering"
(see above), these provides other examples for the _gap_ I mentioned.

Notice that the issue/counter-argument here is not only:

  "the proposal is taking us away from a tested-and-verified-over
   -years design kernel developers are _used to reason with [have
   one release-acquire] in favor of an "unrealistically" or harder,
   FWIW, verifiable one [as if one wasn't enough fun already... ;-)]"
   
The issue is also how to realize the proposed "abstract" design in
kernel code!, since that "gap" makes doing so _not straightforward
at _least (examples: arm64 using LDAPR for its acquire and having
to fix its *cond_read* implementation;  or riscv using .aq/.rl for
its atomics and having to audit generic code, which is "hard" ...).


> 

[3rd approach/fix]

> > Finally, if we don't agree with the above assumption at all (that is,
> > no matter if we are considering unlock-lock or other release-acquire
> > sequences), then we should go RCpc [4].
> > 
> > I described three different approaches (which are NOT "independent",
> > clearly; let us find an agreement...); even though some of them look
> > insane to me, I'm currently open to all of them: thoughts?
> 
> How about this fourth approach?

Are you referring to the variation on the 2nd approach remarked above?
if so, please see above; otherwise, I'd ask "which one?".

  Andrea


> 
> Alan
> 
> >   Andrea
> > 
> > [1] http://lkml.kernel.org/r/20180712134821.GT2494@hirez.programming.kicks-ass.net
> >     http://lkml.kernel.org/r/CA+55aFwKpkU5C23OYt1HCiD3X5bJHVh1jz5G2dSnF1+kVrOCTA@mail.gmail.com
> > [2] http://lkml.kernel.org/r/20180622183007.GD1802@arm.com
> > [3] http://lkml.kernel.org/r/11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com
> > [4] http://lkml.kernel.org/r/20180711123421.GA9673@andrea
> >     http://lkml.kernel.org/r/Pine.LNX.4.44L0.1807132133330.26947-100000@netrider.rowland.org
> 
