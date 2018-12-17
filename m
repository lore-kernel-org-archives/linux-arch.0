From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] Linux: Implement membarrier function
Date: Mon, 17 Dec 2018 10:32:34 -0800
Message-ID: <20181217183234.GL4170@linux.ibm.com>
References: <20181216185130.GB4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812171054090.1630-100000@iolanthe.rowland.org>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812171054090.1630-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Goldblatt <davidtgoldblatt@gmail.com>, mathieu.desnoyers@efficios.com, Florian Weimer <fweimer@redhat.com>, triegel@redhat.com, libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 17, 2018 at 11:02:40AM -0500, Alan Stern wrote:
> On Sun, 16 Dec 2018, Paul E. McKenney wrote:
> 
> > OK, so "simultaneous" IPIs could be emulated in a real implementation by
> > having sys_membarrier() send each IPI (but not wait for a response), then
> > execute a full memory barrier and set a shared variable.  Each IPI handler
> > would spin waiting for the shared variable to be set, then execute a full
> > memory barrier and atomically increment yet another shared variable and
> > return from interrupt.  When that other shared variable's value reached
> > the number of IPIs sent, the sys_membarrier() would execute its final
> > (already existing) full memory barrier and return.  Horribly expensive
> > and definitely not recommended, but eminently doable.
> 
> I don't think that's right.  What would make the IPIs "simultaneous"  
> would be if none of the handlers return until all of them have started
> executing.  For example, you could have each handler increment a shared
> variable and then spin, waiting for the variable to reach the number of
> CPUs, before returning.
> 
> What you wrote was to have each handler wait until all the IPIs had 
> been sent, which is not the same thing at all.

You are right, the handlers need to do the atomic increment before
waiting for the shared variable to be set, and the sys_membarrier()
must wait for the incremented variable to reach its final value before
setting the shared variable.

> > The difference between current sys_membarrier() and the "simultaneous"
> > variant described above is similar to the difference between
> > non-multicopy-atomic and multicopy-atomic memory ordering.  So, after
> > thinking it through, my guess is that pretty much any litmus test that
> > can discern between multicopy-atomic and  non-multicopy-atomic should
> > be transformable into something that can distinguish between the current
> > and the "simultaneous" sys_membarrier() implementation.
> > 
> > Seem reasonable?
> 
> Yes.
> 
> > Or alternatively, may I please apply your Signed-off-by to your earlier
> > sys_membarrier() patch so that I can queue it?  I will probably also
> > change smp_memb() to membarrier() or some such.  Again, within the
> > Linux kernel, membarrier() can be emulated with smp_call_function()
> > invoking a handler that does smp_mb().
> 
> Do you really want to put sys_membarrier into the LKMM?  I'm not so 
> sure it's appropriate.

We do need it for the benefit of the C++ folks, but you are right that
it need not be accepted into the kernel to be useful to them.

So agreed, let's hold off for the time being.

							Thanx, Paul
