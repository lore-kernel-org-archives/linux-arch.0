From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC LKMM 3/7] EXP tools/memory-model: Add more LKMM
 limitations
Date: Fri, 31 Aug 2018 11:43:42 +0200
Message-ID: <20180831094341.GA4634@andrea>
References: <20180829211018.GA19646@linux.vnet.ibm.com>
 <20180829211053.20531-3-paulmck@linux.vnet.ibm.com>
 <20180830091713.GA4617@andrea>
 <20180830221814.GQ4225@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180830221814.GQ4225@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

> > > +	b.	The "unless" RMW operations are not currently modeled:
> > > +		atomic_long_add_unless(), atomic_add_unless(),
> > > +		atomic_inc_unless_negative(), and
> > > +		atomic_dec_unless_positive().  These can be emulated
> > > +		in litmus tests, for example, by using atomic_cmpxchg().
> > 
> > There is a prototype atomic_add_unless(): with current herd7,
> > 
> > $ cat atomic_add_unless.litmus
> > C atomic_add_unless
> > 
> > {}
> > 
> > P0(atomic_t *u, atomic_t *v)
> > {
> > 	int r0;
> > 	int r1;
> > 
> > 	r0 = atomic_add_unless(u, 1, 2);
> > 	r1 = atomic_read(v);
> > }
> > 
> > P1(atomic_t *u, atomic_t *v)
> > {
> > 	int r0;
> > 	int r1;
> > 
> > 	r0 = atomic_add_unless(v, 1, 2);
> > 	r1 = atomic_read(u);
> > }
> > 
> > exists (0:r1=0 /\ 1:r1=0)
> > 
> > $ herd7 -conf linux-kernel.cfg atomic_add_unless.litmus
> > Test atomic_add_unless Allowed
> > States 3
> > 0:r1=0; 1:r1=1;
> > 0:r1=1; 1:r1=0;
> > 0:r1=1; 1:r1=1;
> > No
> > Witnesses
> > Positive: 0 Negative: 3
> > Condition exists (0:r1=0 /\ 1:r1=0)
> > Observation atomic_add_unless Never 0 3
> > Time atomic_add_unless 0.00
> > Hash=fa37a2359831690299e4cc394e45d966
> > 
> > The last commit in the herdtools7 repo. related to this implementation
> > (AFAICT) is:
> > 
> >   9523c340917b6a ("herd/linux: make atomic_add_unless a primitive, so as to yield more precise dependencies for the returned boolean.")
> > 
> > but I can only vaguely remember those dependencies issues now :/  ...;
> > maybe we can now solve these issues?  or should we change herd7 to re-
> > turn a warning?  (Notice that this primitive is currently not exported
> > to the linux-kernel.def file.)
> 
> Cool!  It would be good to add this to the .def file once the underlying
> herd7 machinery is ready.  And then I would update the documentation
> accordingly.  Or happily accept a patch updating the documentation,
> as the case might be.  ;-)

Fair enough, ;-)  Please feel free to add:

Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>

  Andrea
