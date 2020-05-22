From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Some -serious- BPF-related litmus tests
Date: Fri, 22 May 2020 10:43:52 -0700
Message-ID: <20200522174352.GJ2869@paulmck-ThinkPad-P72>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200522143201.GB32434@rowland.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com, will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, andriin@fb.com
List-Id: linux-arch.vger.kernel.org

On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
> On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
> > On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > Just wanted to call your attention to some pretty cool and pretty serious
> > > litmus tests that Andrii did as part of his BPF ring-buffer work:
> > > 
> > > https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
> > > 
> > > Thoughts?
> > 
> > I find:
> > 
> > 	smp_wmb()
> > 	smp_store_release()
> > 
> > a _very_ weird construct. What is that supposed to even do?
> 
> Indeed, it looks like one or the other of those is redundant (depending 
> on the context).

Probably.  Peter instead asked what it was supposed to even do.  ;-)

> Also, what use is a spinlock that is accessed in only one thread?

Multiple writers synchronize via the spinlock in this case.  I am
guessing that his larger 16-hour test contended this spinlock.

> Finally, I doubt that these tests belong under tools/memory-model.  
> Shouldn't they go under the new Documentation/ directory for litmus 
> tests?  And shouldn't the patch update a README file?

Agreed, and I responded to that effect to his original patch:

https://lore.kernel.org/bpf/20200522003433.GG2869@paulmck-ThinkPad-P72/

							Thanx, Paul
