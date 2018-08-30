From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC LKMM 3/7] EXP tools/memory-model: Add more LKMM
 limitations
Date: Thu, 30 Aug 2018 15:18:14 -0700
Message-ID: <20180830221814.GQ4225@linux.vnet.ibm.com>
References: <20180829211018.GA19646@linux.vnet.ibm.com>
 <20180829211053.20531-3-paulmck@linux.vnet.ibm.com>
 <20180830091713.GA4617@andrea>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180830091713.GA4617@andrea>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 30, 2018 at 11:17:13AM +0200, Andrea Parri wrote:
> On Wed, Aug 29, 2018 at 02:10:49PM -0700, Paul E. McKenney wrote:
> > This commit adds more detail about compiler optimizations and
> > not-yet-modeled Linux-kernel APIs.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  tools/memory-model/README | 39 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> > 
> > diff --git a/tools/memory-model/README b/tools/memory-model/README
> > index ee987ce20aae..acf9077cffaa 100644
> > --- a/tools/memory-model/README
> > +++ b/tools/memory-model/README
> > @@ -171,6 +171,12 @@ The Linux-kernel memory model has the following limitations:
> >  	particular, the "THE PROGRAM ORDER RELATION: po AND po-loc"
> >  	and "A WARNING" sections).
> >  
> > +	Note that this limitation in turn limits LKMM's ability to
> > +	accurately model address, control, and data dependencies.
> > +	For example, if the compiler can deduce the value of some variable
> > +	carrying a dependency, then the compiler can break that dependency
> > +	by substituting a constant of that value.
> > +
> >  2.	Multiple access sizes for a single variable are not supported,
> >  	and neither are misaligned or partially overlapping accesses.
> >  
> > @@ -190,6 +196,36 @@ The Linux-kernel memory model has the following limitations:
> >  	However, a substantial amount of support is provided for these
> >  	operations, as shown in the linux-kernel.def file.
> >  
> > +	a.	When rcu_assign_pointer() is passed NULL, the Linux
> > +		kernel provides no ordering, but LKMM models this
> > +		case as a store release.
> > +
> > +	b.	The "unless" RMW operations are not currently modeled:
> > +		atomic_long_add_unless(), atomic_add_unless(),
> > +		atomic_inc_unless_negative(), and
> > +		atomic_dec_unless_positive().  These can be emulated
> > +		in litmus tests, for example, by using atomic_cmpxchg().
> 
> There is a prototype atomic_add_unless(): with current herd7,
> 
> $ cat atomic_add_unless.litmus
> C atomic_add_unless
> 
> {}
> 
> P0(atomic_t *u, atomic_t *v)
> {
> 	int r0;
> 	int r1;
> 
> 	r0 = atomic_add_unless(u, 1, 2);
> 	r1 = atomic_read(v);
> }
> 
> P1(atomic_t *u, atomic_t *v)
> {
> 	int r0;
> 	int r1;
> 
> 	r0 = atomic_add_unless(v, 1, 2);
> 	r1 = atomic_read(u);
> }
> 
> exists (0:r1=0 /\ 1:r1=0)
> 
> $ herd7 -conf linux-kernel.cfg atomic_add_unless.litmus
> Test atomic_add_unless Allowed
> States 3
> 0:r1=0; 1:r1=1;
> 0:r1=1; 1:r1=0;
> 0:r1=1; 1:r1=1;
> No
> Witnesses
> Positive: 0 Negative: 3
> Condition exists (0:r1=0 /\ 1:r1=0)
> Observation atomic_add_unless Never 0 3
> Time atomic_add_unless 0.00
> Hash=fa37a2359831690299e4cc394e45d966
> 
> The last commit in the herdtools7 repo. related to this implementation
> (AFAICT) is:
> 
>   9523c340917b6a ("herd/linux: make atomic_add_unless a primitive, so as to yield more precise dependencies for the returned boolean.")
> 
> but I can only vaguely remember those dependencies issues now :/  ...;
> maybe we can now solve these issues?  or should we change herd7 to re-
> turn a warning?  (Notice that this primitive is currently not exported
> to the linux-kernel.def file.)

Cool!  It would be good to add this to the .def file once the underlying
herd7 machinery is ready.  And then I would update the documentation
accordingly.  Or happily accept a patch updating the documentation,
as the case might be.  ;-)

							Thanx, Paul

>   Andrea
> 
> 
> > +
> > +	c.	The call_rcu() function is not modeled.  It can be
> > +		emulated in litmus tests by adding another process that
> > +		invokes synchronize_rcu() and the body of the callback
> > +		function, with (for example) a release-acquire from
> > +		the site of the emulated call_rcu() to the beginning
> > +		of the additional process.
> > +
> > +	d.	The rcu_barrier() function is not modeled.  It can be
> > +		emulated in litmus tests emulating call_rcu() via
> > +		(for example) a release-acquire from the end of each
> > +		additional call_rcu() process to the site of the
> > +		emulated rcu-barrier().
> > +
> > +	e.	Sleepable RCU (SRCU) is not modeled.  It can be
> > +		emulated, but perhaps not simply.
> > +
> > +	f.	Reader-writer locking is not modeled.  It can be
> > +		emulated in litmus tests using atomic read-modify-write
> > +		operations.
> > +
> >  The "herd7" tool has some additional limitations of its own, apart from
> >  the memory model:
> >  
> > @@ -204,3 +240,6 @@ the memory model:
> >  Some of these limitations may be overcome in the future, but others are
> >  more likely to be addressed by incorporating the Linux-kernel memory model
> >  into other tools.
> > +
> > +Finally, please note that LKMM is subject to change as hardware, use cases,
> > +and compilers evolve.
> > -- 
> > 2.17.1
> > 
> 
