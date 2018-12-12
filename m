From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] Linux: Implement membarrier function
Date: Wed, 12 Dec 2018 11:42:25 -0800
Message-ID: <20181212194225.GB4170@linux.ibm.com>
References: <20181212170706.GA17397@linux.ibm.com>
 <Pine.LNX.4.44L0.1812121302270.1543-100000@iolanthe.rowland.org>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812121302270.1543-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Goldblatt <davidtgoldblatt@gmail.com>, mathieu.desnoyers@efficios.com, Florian Weimer <fweimer@redhat.com>, triegel@redhat.com, libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 12, 2018 at 01:04:44PM -0500, Alan Stern wrote:
> On Wed, 12 Dec 2018, Paul E. McKenney wrote:
> 
> > > > > Or am I still missing something here?
> > > > 
> > > > You tell me...
> > > 
> > > I think I am on board.  ;-)
> > 
> > And more to the point, here is a three-process variant showing a cycle
> > that is permitted:
> > 
> > 
> >          P0      P1      P2
> >          Wa=2    Wb=2    Wc=2
> >          mb0s
> >                  [mb01]  [mb02]
> >          mb0e
> >          Rb=0    Rc=0    Ra=0
> > 
> > As can be seen by reordering it as follows:
> > 
> >          P0      P1      P2
> >                          Ra=0
> >          Wa=2
> >          mb0s
> >                  [mb01]
> >                  Rc=0
> >                          Wc=2
> >                          [mb02]
> >          mb0e
> >          Rb=0
> >                  Wb=2
> > 
> > Make sense?
> 
> You got it!

OK.  How about this one?

         P0      P1                 P2      P3
         Wa=2    rcu_read_lock()    Wc=2    Wd=2
         memb    Wb=2               Rd=0    synchronize_rcu();
         Rb=0    Rc=0                       Ra=0
	         rcu_read_unlock()

The model should say that it is allowed.  Taking a look...

         P0      P1                 P2      P3
				    Rd=0
					    Wd=2
					    synchronize_rcu();
	                                    Ra=0
	 Wa=2
	 membs
	         rcu_read_lock()
		 [m01]
		 Rc=0
		 		    Wc=2
				    [m02]   [m03]
	 membe
	 Rb=0
	         Wb=2
		 rcu_read_unlock()

Looks allowed to me.  If the synchronization of P1 and P2 were
interchanged, it should be forbidden:

         P0      P1      P2                 P3
         Wa=2    Wb=2    rcu_read_lock()    Wd=2
         memb    Rc=0    Wc=2               synchronize_rcu();
         Rb=0            Rd=0               Ra=0
                         rcu_read_unlock()

Taking a look...

         P0      P1      P2                 P3
                         rcu_read_lock()
                         Rd=0
         Wa=2    Wb=2                       Wd=2
         membs                              synchronize_rcu();
                 [m01]
                 Rc=0
                         Wc=2
                         rcu_read_unlock()
			 [m02]              Ra=0 [Forbidden?]
	 membe
         Rb=0

I believe that this ordering forbids the cycle:

	Wa=1 > membs -> [m01] -> Rc=0 -> Wc=2 -> rcu_read_unlock() ->
		return from synchronize_rcu() -> Ra

Does this make sense, or am I missing something?

							Thanx, Paul
