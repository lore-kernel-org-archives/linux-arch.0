From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Linux: Implement membarrier function
Date: Mon, 17 Dec 2018 11:02:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1812171054090.1630-100000@iolanthe.rowland.org>
References: <20181216185130.GB4170@linux.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181216185130.GB4170@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: David Goldblatt <davidtgoldblatt@gmail.com>, mathieu.desnoyers@efficios.com, Florian Weimer <fweimer@redhat.com>, triegel@redhat.com, libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, 16 Dec 2018, Paul E. McKenney wrote:

> OK, so "simultaneous" IPIs could be emulated in a real implementation by
> having sys_membarrier() send each IPI (but not wait for a response), then
> execute a full memory barrier and set a shared variable.  Each IPI handler
> would spin waiting for the shared variable to be set, then execute a full
> memory barrier and atomically increment yet another shared variable and
> return from interrupt.  When that other shared variable's value reached
> the number of IPIs sent, the sys_membarrier() would execute its final
> (already existing) full memory barrier and return.  Horribly expensive
> and definitely not recommended, but eminently doable.

I don't think that's right.  What would make the IPIs "simultaneous"  
would be if none of the handlers return until all of them have started
executing.  For example, you could have each handler increment a shared
variable and then spin, waiting for the variable to reach the number of
CPUs, before returning.

What you wrote was to have each handler wait until all the IPIs had 
been sent, which is not the same thing at all.

> The difference between current sys_membarrier() and the "simultaneous"
> variant described above is similar to the difference between
> non-multicopy-atomic and multicopy-atomic memory ordering.  So, after
> thinking it through, my guess is that pretty much any litmus test that
> can discern between multicopy-atomic and  non-multicopy-atomic should
> be transformable into something that can distinguish between the current
> and the "simultaneous" sys_membarrier() implementation.
> 
> Seem reasonable?

Yes.

> Or alternatively, may I please apply your Signed-off-by to your earlier
> sys_membarrier() patch so that I can queue it?  I will probably also
> change smp_memb() to membarrier() or some such.  Again, within the
> Linux kernel, membarrier() can be emulated with smp_call_function()
> invoking a handler that does smp_mb().

Do you really want to put sys_membarrier into the LKMM?  I'm not so 
sure it's appropriate.

Alan
