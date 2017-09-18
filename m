From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Rough notes from sys_membarrier() lightning BoF
Date: Mon, 18 Sep 2017 12:29:35 -0700
Message-ID: <20170918192935.GW3521@linux.vnet.ibm.com>
References: <20170917223608.GA14577@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1709181458420.1806-100000@iolanthe.rowland.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1709181458420.1806-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: peterz@infradead.org, mathieu.desnoyers@efficios.com, will.deacon@arm.com, luto@kernel.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, davejwatson@fb.com, maged.michael@gmail.com
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 18, 2017 at 03:04:21PM -0400, Alan Stern wrote:
> On Sun, 17 Sep 2017, Paul E. McKenney wrote:
> 
> > Hello!
> > 
> > Rough notes from our discussion last Thursday.  Please reply to the
> > group with any needed elaborations or corrections.
> > 
> > Adding Andy and Michael on CC since this most closely affects their
> > architectures.  Also adding Dave Watson and Maged Michael because
> > the preferred approach requires that processes wanting to use the
> > lightweight sys_membarrier() do a registration step.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > Problem:
> > 
> > 1.	The current sys_membarrier() introduces an smp_mb() that
> > 	is not otherwise required on powerpc.
> > 
> > 2.	The envisioned JIT variant of sys_membarrier() assumes that
> > 	the return-to-user instruction sequence handling any change
> > 	to the usermode instruction stream, and Andy Lutomirski's
> > 	upcoming changes invalidate this assumption.  It is believed
> > 	that powerpc has a similar issue.
> 
> > E.	Require that threads register before using sys_membarrier() for
> > 	private or JIT usage.  (The historical implementation using
> > 	synchronize_sched() would continue to -not- require registration,
> > 	both for compatibility and because there is no need to do so.)
> > 
> > 	For x86 and powerpc, this registration would set a TIF flag
> > 	on all of the current process's threads.  This flag would be
> > 	inherited by any later thread creation within that process, and
> > 	would be cleared by fork() and exec().	When this TIF flag is set,
> 
> Why a TIF flag, and why clear it during fork()?  If a process registers
> to use private expedited sys_membarrier, shouldn't that apply to
> threads it will create in the future just as much as to threads it has
> already created?

The reason for a TIF flag is to keep this per-architecture, as only
powerpc and x86 need it.

The reason for clearing it during fork() is that fork() creates a new
process initially having but a single thread, which might or might
not use sys_membarrier().  Usually not, as most instances of fork()
are quickly followed by exec().  In addition, if we give an error for
unregistered use of private sys_membarrier(), clearing on fork() gets an
unambiguous error instead of a silent likely failure (due to libraries
being confused by the fork()).

That said, pthread_create() should preserve the flag, as the new thread
will be part of this same process.

> > 	the return-to-user path would execute additional code that would
> > 	ensure that ordering and newly JITed code was handled correctly.
> > 	We believe that checks for these TIF flags could be combined with
> > 	existing checks to avoid adding any overhead in the common case
> > 	where the process was not using these sys_membarrier() features.
> > 
> > 	For all other architecture, the registration step would be
> > 	a no-op.
> 
> Don't we want to fail private expedited sys_membarrier calls if the 
> process hasn't registered for them?  This requires the registration 
> call to set a flag for the process, even on architectures where no 
> additional memory barriers are actually needed.  It can't be a no-op.

Good point, and we did discuss that.  Color me forgetful!!!

							Thanx, Paul
