From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: f68f031d ("Documentation: atomic_t.txt: Explain ordering provided
 by smp_mb__{before,after}_atomic()")
Date: Fri, 3 May 2019 12:52:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1905031252060.1437-100000@iolanthe.rowland.org>
References: <20190503163411.GH2606@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190503163411.GH2606@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, 3 May 2019, Peter Zijlstra wrote:

> On Fri, May 03, 2019 at 12:19:21PM -0400, Alan Stern wrote:
> > On Fri, 3 May 2019, Peter Zijlstra wrote:
> > 
> > > On Fri, May 03, 2019 at 07:53:26AM -0700, Paul E. McKenney wrote:
> > > > Hello, Alan,
> > > > 
> > > > Just following up on the -rcu commit below.  I believe that it needs
> > > > some adjustment given Peter Zijlstra's addition of "memory" to the x86
> > > > non-value-returning atomics, but thought I should double-check.
> > > 
> > > Right; I should get back to that thread...
> > 
> > The real question, still outstanding, is whether smp_mb__before_atomic 
> > orders anything following the RMW instruction (and similarly, whether 
> > smp_mb__after_atomic orders anything preceding the RMW instruction).
> 
> Yes -- that was very much the intent, and only (some) x86 ops and (some)
> MIPS config have issues with that.

Okay, then I better update the patch.

Alan
