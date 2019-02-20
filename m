Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57920 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBTNlO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Feb 2019 08:41:14 -0500
Date: Wed, 20 Feb 2019 13:41:06 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190220134106.GA7523@fuggles.cambridge.arm.com>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220131456.GA3215@andrea>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190220134106.XClND3UTgtZ5XK3faIz6h-0PHM0z1m2nqtV7UoqsiNE@z>

On Wed, Feb 20, 2019 at 02:14:56PM +0100, Andrea Parri wrote:
> On Wed, Feb 20, 2019 at 10:26:04AM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 19, 2019 at 06:01:17PM -0800, Paul E. McKenney wrote:
> > > On Tue, Feb 19, 2019 at 11:57:37PM +0100, Andrea Parri wrote:
> > > > Remove this subtle (and, AFAICT, unused) ordering: we can add it back,
> > > > if necessary, but let us not encourage people to rely on this thing.
> > > > 
> > > > For example, the following "exists" clause can be satisfied with this
> > > > change:
> > > > 
> > > > C dep-rfi
> > > > 
> > > > { }
> > > > 
> > > > P0(int *x, int *y)
> > > > {
> > > > 	WRITE_ONCE(*x, 1);
> > > > 	smp_store_release(y, 1);
> > > > }
> > > > 
> > > > P1(int *x, int *y, int *z)
> > > > {
> > > > 	int r0;
> > > > 	int r1;
> > > > 	int r2;
> > > > 
> > > > 	r0 = READ_ONCE(*y);
> > > > 	WRITE_ONCE(*z, r0);
> > > > 	r1 = smp_load_acquire(z);
> > > > 	r2 = READ_ONCE(*x);
> > > > }
> > > > 
> > > > exists (1:r0=1 /\ 1:r2=0)
> > > 
> > > Any objections?  If I don't hear any in a couple days, I will apply this.
> > 
> > IIUC you cannot build hardware that allows the above, so why would we
> > allow it?
> 
> The change/simplification was mainly intended as precautionary measure
> (hence the "we can add it back, ..."): I do agree that it shouldn't be
> possible to realize the above state; OTOH, you really don't need to be
> too "creative" to imagine possible mis-uses/mis-interpretations of the
> (dep ; rfi) term ("forget" ONCEs, trick herd7 with "false dependencies"
> or simply wrongly assume that control dependencies are part this "dep",
> what else? ...).  So, no, I'm not that fond to this term; why should I
> be?  or you are simply suggesting to expand the changelog?

Simplification can mean different things to different people.

Whilst I completely agree that relying on the ordering provided by "dep ;
rfi" is subtle and error prone, having it forbid the outcome above appeals
to a hardware-based mindset of how memory ordering works. In the kernel
community, I would posit that the majority of developers are writing code
with the underlying hardware in mind and so allowing behaviours in the
memory model which are counter to how a real machine operates is likely to
make things more confusing, rather than simplifying them!

IIRC, herd has a feature where you can "flag" the result of a litmus test
to highlight certain internal constraint violations (e.g. warning that a
data race is present in a concurrent C11 program). How about we preserve
the existing semantics, but flag any use of "dep; rfi" to indicate that
the ordering guarantees being relied upon are subtle and error-prone, and
therefore should only be considered for fast-path code?

Will
