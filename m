Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728679AbeLLWT3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Dec 2018 17:19:29 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBCM9Umg126213
        for <linux-arch@vger.kernel.org>; Wed, 12 Dec 2018 17:19:28 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pbasqgpg7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 12 Dec 2018 17:19:28 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 12 Dec 2018 22:19:26 -0000
Date: Wed, 12 Dec 2018 14:19:20 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] Linux: Implement membarrier function
Reply-To: paulmck@linux.ibm.com
References: <20181212194225.GB4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812121604430.1543-100000@iolanthe.rowland.org>
 <20181212215245.GC4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212215245.GC4170@linux.ibm.com>
Message-ID: <20181212221920.GA23239@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Goldblatt <davidtgoldblatt@gmail.com>, mathieu.desnoyers@efficios.com, Florian Weimer <fweimer@redhat.com>, triegel@redhat.com, libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181212221920.9vjZnCSE1hpIzwh9vNQxoNqks5qPFJlGFy9S4sI9da8@z>

On Wed, Dec 12, 2018 at 01:52:45PM -0800, Paul E. McKenney wrote:
> On Wed, Dec 12, 2018 at 04:32:50PM -0500, Alan Stern wrote:
> > On Wed, 12 Dec 2018, Paul E. McKenney wrote:
> > 
> > > OK.  How about this one?
> > > 
> > >          P0      P1                 P2      P3
> > >          Wa=2    rcu_read_lock()    Wc=2    Wd=2
> > >          memb    Wb=2               Rd=0    synchronize_rcu();
> > >          Rb=0    Rc=0                       Ra=0
> > > 	         rcu_read_unlock()
> > > 
> > > The model should say that it is allowed.  Taking a look...
> > > 
> > >          P0      P1                 P2      P3
> > > 				    Rd=0
> > > 					    Wd=2
> > > 					    synchronize_rcu();
> > > 	                                    Ra=0
> > > 	 Wa=2
> > > 	 membs
> > > 	         rcu_read_lock()
> > > 		 [m01]
> > > 		 Rc=0
> > > 		 		    Wc=2
> > > 				    [m02]   [m03]
> > > 	 membe
> > > 	 Rb=0
> > > 	         Wb=2
> > > 		 rcu_read_unlock()
> > > 
> > > Looks allowed to me.  If the synchronization of P1 and P2 were
> > > interchanged, it should be forbidden:
> > > 
> > >          P0      P1      P2                 P3
> > >          Wa=2    Wb=2    rcu_read_lock()    Wd=2
> > >          memb    Rc=0    Wc=2               synchronize_rcu();
> > >          Rb=0            Rd=0               Ra=0
> > >                          rcu_read_unlock()
> > > 
> > > Taking a look...
> > > 
> > >          P0      P1      P2                 P3
> > >                          rcu_read_lock()
> > >                          Rd=0
> > >          Wa=2    Wb=2                       Wd=2
> > >          membs                              synchronize_rcu();
> > >                  [m01]
> > >                  Rc=0
> > >                          Wc=2
> > >                          rcu_read_unlock()
> > > 			 [m02]              Ra=0 [Forbidden?]
> > > 	 membe
> > >          Rb=0
> 
> For one thing, Wb=2 needs to be down here, apologies!  Which then ...
> 
> > Have you tried writing these as real litmus tests and running them 
> > through herd?
> 
> That comes later, but yes, I will do that.
> 
> > > I believe that this ordering forbids the cycle:
> > > 
> > > 	Wa=1 > membs -> [m01] -> Rc=0 -> Wc=2 -> rcu_read_unlock() ->
> > > 		return from synchronize_rcu() -> Ra
> > > 
> > > Does this make sense, or am I missing something?
> > 
> > It's hard to tell.  What you have written here isn't justified by the
> > litmus test source code, since the position of m01 in P1's program
> > order is undetermined.  How do you justify m01 -> Rc, for example?
> 
> ... justifies Rc=0 following [m01].
> 
> > Write it this way instead, using the relations defined in the 
> > sys_membarrier patch for linux-kernel.cat:
> > 
> > 	memb ->memb-gp memb ->rcu-link Rc ->memb-rscsi Rc ->rcu-link
> > 		
> > 		rcu_read_unlock ->rcu-rscsi rcu_read_lock ->rcu-link 
> > 
> > 		synchronize_rcu ->rcu-gp synchronize_rcu ->rcu-link memb
> > 
> > Recall that:
> > 
> > 	memb-gp is the identity relation on sys_membarrier events,
> > 
> > 	rcu-link includes (po? ; fre ; po),
> > 
> > 	memb-rscsi is the identity relation on all events,
> > 
> > 	rcu-rscsi links unlocks to their corresponding locks, and
> > 
> > 	rcu-gp is the identity relation on synchronize_rcu events.
> > 
> > These facts justify the cycle above.
> > 
> > Leaving off the final rcu-link step, the sequence matches the
> > definition of rcu-fence (the relations are memb-gp, memb-rscsi, 
> > rcu-rscsi, rcu-gp with rcu-links in between).  Therefore the cycle is 
> > forbidden.
> 
> Understood, but that would be using the model to check the model.  ;-)

And here are the litmus tests in the same order as above.  They do give
the results we both called out above, which is encouraging.

							Thanx, Paul

------------------------------------------------------------------------

C C-memb-RCU-1
(*
 * Result: Sometimes
 *)

{
}


P0(int *x0, int *x1)
{
	WRITE_ONCE(*x0, 1);
	smp_memb();
	r1 = READ_ONCE(*x1);
}

P1(int *x1, int *x2)
{
	rcu_read_lock();
	WRITE_ONCE(*x1, 1);
	r1 = READ_ONCE(*x2);
	rcu_read_unlock();
}

P2(int *x2, int *x3)
{
	WRITE_ONCE(*x2, 1);
	r1 = READ_ONCE(*x3);
}

P3(int *x3, int *x0)
{
	WRITE_ONCE(*x3, 1);
	synchronize_rcu();
	r1 = READ_ONCE(*x0);
}

exists (0:r1=0 /\ 1:r1=0 /\ 2:r1=0 /\ 3:r1=0)

------------------------------------------------------------------------

C C-memb-RCU-1
(*
 * Result: Never
 *)

{
}


P0(int *x0, int *x1)
{
	WRITE_ONCE(*x0, 1);
	smp_memb();
	r1 = READ_ONCE(*x1);
}

P1(int *x1, int *x2)
{
	WRITE_ONCE(*x1, 1);
	r1 = READ_ONCE(*x2);
}

P2(int *x2, int *x3)
{
	rcu_read_lock();
	WRITE_ONCE(*x2, 1);
	r1 = READ_ONCE(*x3);
	rcu_read_unlock();
}

P3(int *x3, int *x0)
{
	WRITE_ONCE(*x3, 1);
	synchronize_rcu();
	r1 = READ_ONCE(*x0);
}

exists (0:r1=0 /\ 1:r1=0 /\ 2:r1=0 /\ 3:r1=0)
