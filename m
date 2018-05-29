Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965311AbeE2TB5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 May 2018 15:01:57 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4TJ0SMB004630
        for <linux-arch@vger.kernel.org>; Tue, 29 May 2018 15:01:56 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2j9c1b9gf3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 29 May 2018 15:01:56 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 29 May 2018 15:01:55 -0400
Date: Tue, 29 May 2018 12:03:32 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180528220811.GA5221@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1805291424440.1458-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1805291424440.1458-100000@iolanthe.rowland.org>
Message-ID: <20180529190332.GO3803@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, mingo@kernel.org, torvalds@linux-foundation.org, roman.penyaev@profitbricks.com
Message-ID: <20180529190332.B3-IqtnBO3pbjvQwpG3XK2tKmusgnMXFWB35k3k1UfU@z>

On Tue, May 29, 2018 at 02:35:34PM -0400, Alan Stern wrote:
> On Mon, 28 May 2018, Paul E. McKenney wrote:
> 
> > Hello!
> > 
> > The litmus test below is a first attempt to model Roman's rcu-rr
> > round-robin RCU-protected linked list.  His test code, which includes
> > the algorithm under test, may be found here:
> > 
> > https://github.com/rouming/rcu-rr/blob/master/rcu-rr.c
> > 
> > The P0() process below roughly corresponds to remove_conn_from_arr(),
> > with litmus-test variable "c" standing in for the per-CPU ppcpu_con.
> > Similarly, P1() roughly corresponds to get_next_conn_rr().  It claims
> > that the algorithm is safe, and also claims that it becomes unsafe if
> > either synchronize_rcu() is removed.
> 
> This algorithm (the one in the litmus test; I haven't looked at Roman's
> code) does seem valid.  In addition to removing either
> synchronize_rcu(), interchanging the order of the stores in P0 (c
> first, then w) would also invalidate it.
> 
> This is a little unusual in that c is written by more than one thread 
> with no protection.  It works because the writes are all stores of a 
> single pointer.
> 
> Why does the litmus test use smp_store_release() in three places?  
> There doesn't seem to be any need; WRITE_ONCE() would be sufficient.

Because the algorithm did.  A bit of a stretch for kfree, but... ;-)

Let's try removing them, please see below.

> Alan
> 
> > Does this in fact realistically model Roman's algorithm?  Either way,
> > is there a better approach?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > C C-RomanPenyaev-list-rcu-rr
> > 
> > {
> > 	int *z=1; (* List: v->w->x->y->z. Noncircular, but long enough. *)
> > 	int *y=z;
> > 	int *x=y;
> > 	int *w=x;
> > 	int *v=w; (* List head is v. *)
> > 	int *c=w; (* Cache, emulating ppcpu_con. *)
> > }
> > 
> > P0(int *c, int *v, int *w, int *x, int *y)
> > {
> > 	rcu_assign_pointer(*w, y); /* Remove x from list. */

No change when converting this to WRITE_ONCE();

> > 	synchronize_rcu();
> > 	r1 = READ_ONCE(*c);
> > 	if (r1 == x) {
> > 		WRITE_ONCE(*c, 0); /* Invalidate cache. */
> > 		synchronize_rcu();
> > 	}
> > 	smp_store_release(x, 0);  /* Emulate kfree(x). */

Converting this one to WRITE_ONCE() does have an effect:

	Test C-RomanPenyaev-list-rcu-rr Allowed
	States 8
	0:r1=0; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=0; c=0; v=w; w=y; x=0; y=z;
	0:r1=w; 1:r1=w; 1:r2=y; 1:r3=y; 1:r4=z; c=z; v=w; w=y; x=0; y=z;
	0:r1=x; 1:r1=w; 1:r2=x; 1:r3=w; 1:r4=y; c=y; v=w; w=y; x=0; y=z;
	0:r1=x; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=y; c=0; v=w; w=y; x=0; y=z;
	0:r1=x; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=y; c=y; v=w; w=y; x=0; y=z;
	0:r1=y; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=y; c=y; v=w; w=y; x=0; y=z;
	0:r1=y; 1:r1=w; 1:r2=y; 1:r3=y; 1:r4=z; c=z; v=w; w=y; x=0; y=z;
	0:r1=z; 1:r1=w; 1:r2=y; 1:r3=y; 1:r4=z; c=z; v=w; w=y; x=0; y=z;
	Ok
	Witnesses
	Positive: 1 Negative: 7
	Condition exists (1:r1=0 \/ 1:r2=0 \/ 1:r3=0 \/ 1:r4=0)
	Observation C-RomanPenyaev-list-rcu-rr Sometimes 1 7
	Time C-RomanPenyaev-list-rcu-rr 0.40
	Hash=2ec66290a6622117b9877436950e6a08

Maybe reordered with READ_ONCE(*c) when r1 != x?

> > }
> > 
> > P1(int *c, int *v)
> > {
> > 	rcu_read_lock();
> > 	r1 = READ_ONCE(*c); /* Pick up cache. */
> > 	if (r1 == 0) {
> > 		r1 = READ_ONCE(*v); /* Cache empty, start from head. */
> > 	}
> > 	r2 = rcu_dereference(*r1); /* Advance to next element. */
> > 	smp_store_release(c, r2); /* Update cache. */
> > 	rcu_read_unlock();
> > 
> > 	/* And repeat. */
> > 	rcu_read_lock();
> > 	r3 = READ_ONCE(*c);
> > 	if (r3 == 0) {
> > 		r3 = READ_ONCE(*v);
> > 	}
> > 	r4 = rcu_dereference(*r3);
> > 	smp_store_release(c, r4);

Converting this to WRITE_ONCE() has no effect.

> > 	rcu_read_unlock();
> > }
> > 
> > locations [0:r1; 1:r1; 1:r3; c; v; w; x; y]
> > exists (1:r1=0 \/ 1:r2=0 \/ 1:r3=0 \/ 1:r4=0) (* Better not be freed!!! *)
> 

							Thanx, Paul
