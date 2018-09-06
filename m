Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:36043 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725935AbeIFF6a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 01:58:30 -0400
Date: Wed, 5 Sep 2018 21:25:40 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
In-Reply-To: <20180903090153.GA4560@andrea>
Message-ID: <Pine.LNX.4.44L0.1809052115490.2261-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Will Deacon <will.deacon@arm.com>, Andrea Parri <parri.andrea@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180906012540.bUTtn6xP2YsdGJB7gk-REUF72UQfHTjPqXYMaG7sS-Y@z>

On Mon, 3 Sep 2018, Andrea Parri wrote:

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
> as proposed in the patch under RFC),

In fact, there have have been _two_ proposals along this line.  One as
you describe here (which is what the 1/7 patch under discussion does),
and another in which unlock-lock sequences and atomic acquire-release
sequences both have "RCtso" semantics while ordinary acquire/release
sequences have RCpc semantics.  You should consider the second
proposal.  It could be put into the LKMM quite easily by building upon
this 1/7 patch.

>  I ask that we audit and modify
> the generic code accordingly/as suggested in other posts _before_ we
> upstream the changes for the LKMM: we should identify those places
> where (the newly introduced) _gap_ between unlock-lock and the other
> release-acquire is not admissible and fix those places (notice that
> this entails, in part., agreeing on what/where the generic code is).

Have you noticed any part of the generic code that relies on ordinary 
acquire-release (rather than atomic RMW acquire-release) in order to 
implement locking constructs?

> Finally, if we don't agree with the above assumption at all (that is,
> no matter if we are considering unlock-lock or other release-acquire
> sequences), then we should go RCpc [4].
> 
> I described three different approaches (which are NOT "independent",
> clearly; let us find an agreement...); even though some of them look
> insane to me, I'm currently open to all of them: thoughts?

How about this fourth approach?

Alan

>   Andrea
> 
> [1] http://lkml.kernel.org/r/20180712134821.GT2494@hirez.programming.kicks-ass.net
>     http://lkml.kernel.org/r/CA+55aFwKpkU5C23OYt1HCiD3X5bJHVh1jz5G2dSnF1+kVrOCTA@mail.gmail.com
> [2] http://lkml.kernel.org/r/20180622183007.GD1802@arm.com
> [3] http://lkml.kernel.org/r/11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com
> [4] http://lkml.kernel.org/r/20180711123421.GA9673@andrea
>     http://lkml.kernel.org/r/Pine.LNX.4.44L0.1807132133330.26947-100000@netrider.rowland.org
