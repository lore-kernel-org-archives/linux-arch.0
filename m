From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Some -serious- BPF-related litmus tests
Date: Mon, 25 May 2020 08:47:30 -0700
Message-ID: <20200525154730.GW2869@paulmck-ThinkPad-P72>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <20200525112521.GD317569@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200525112521.GD317569@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andriin@fb.com>, Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com, will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Mon, May 25, 2020 at 01:25:21PM +0200, Peter Zijlstra wrote:
> On Fri, May 22, 2020 at 12:38:21PM -0700, Andrii Nakryiko wrote:
> > On 5/22/20 10:43 AM, Paul E. McKenney wrote:
> > > On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
> 
> > > > Also, what use is a spinlock that is accessed in only one thread?
> > > 
> > > Multiple writers synchronize via the spinlock in this case.  I am
> > > guessing that his larger 16-hour test contended this spinlock.
> > 
> > Yes, spinlock is for coordinating multiple producers. 2p1c cases (bounded
> > and unbounded) rely on this already. 1p1c cases are sort of subsets (but
> > very fast to verify) checking only consumer/producer interaction.
> 
> Does that spinlock imply that we can now never fix that atrocious
> bpf_prog_active trainwreck ?
> 
> How does that spinlock not trigger the USED <- IN-NMI lockdep check:
> 
>   f6f48e180404 ("lockdep: Teach lockdep about "USED" <- "IN-NMI" inversions")
> 
> ?
> 
> That is; how can you use a spinlock on the producer side at all?

So even trylock is now forbidden in NMI handlers?  If so, why?

							Thanx, Paul
