From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Date: Wed, 20 Feb 2019 14:27:14 +0100
Message-ID: <20190220132714.GI32494@hirez.programming.kicks-ass.net>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220131456.GA3215@andrea>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
List-Id: linux-arch.vger.kernel.org

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
> 
> I should probably also remark that "such a simplification" wouldn't be
> a first time for the LKMM and, in fact, for the ppo term itself:
> 
>   https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/WeakModel.html#Preserved%20Program%20Order

I'm completely failing to understand any of that.

What I do object to is a model that's weaker than any possible sane
hardware.
