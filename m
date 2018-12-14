Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726997AbeLNFUS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Dec 2018 00:20:18 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBE5JO1D107272
        for <linux-arch@vger.kernel.org>; Fri, 14 Dec 2018 00:20:17 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pc5rwh79d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 14 Dec 2018 00:20:17 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 14 Dec 2018 05:20:15 -0000
Date: Thu, 13 Dec 2018 21:20:08 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] Linux: Implement membarrier function
Reply-To: paulmck@linux.ibm.com
References: <20181214002043.GP4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812132110100.26937-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812132110100.26937-100000@netrider.rowland.org>
Message-ID: <20181214052008.GT4170@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Goldblatt <davidtgoldblatt@gmail.com>, mathieu.desnoyers@efficios.com, Florian Weimer <fweimer@redhat.com>, triegel@redhat.com, libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181214052008.dWt1e0t4d3vqKKo3o7iOMczup4EhHXYtgMJ01r5zB0o@z>

On Thu, Dec 13, 2018 at 09:26:47PM -0500, Alan Stern wrote:
> On Thu, 13 Dec 2018, Paul E. McKenney wrote:
> 
> > > > A good next step would be to automatically generate random tests along
> > > > with an automatically generated prediction, like I did for RCU a few
> > > > years back.  I should be able to generalize my time-based cheat for RCU to
> > > > also cover SRCU, though sys_membarrier() will require a bit more thought.
> > > > (The time-based cheat was to have fixed duration RCU grace periods and
> > > > RCU read-side critical sections, with the grace period duration being
> > > > slightly longer than that of the critical sections.  The number of
> > > > processes is of course limited by the chosen durations, but that limit
> > > > can easily be made insanely large.)
> > > 
> > > Imagine that each sys_membarrier call takes a fixed duration and each 
> > > other instruction takes slightly less (the idea being that each 
> > > instruction is a critical section).  Instructions can be reordered 
> > > (although not across a sys_membarrier call), but no matter how the 
> > > reordering is done, the result is disallowed.
> 
> This turns out not to be right.  Instead, imagine that each 
> sys_membarrier call takes a fixed duration, T.  Other instructions can 
> take arbitrary amounts of time and can be reordered abitrarily, with 
> two restrictions:
> 
> 	Instructions cannot be reordered past a sys_membarrier call;
> 
> 	If instructions A and B are reordered then the time duration
> 	from B to A must be less than T.
> 
> If you prefer, you can replace the second restriction with something a 
> little more liberal:
> 
> 	If A and B are reordered and A ends up executing after a 
> 	sys_membarrier call (on any CPU) then B cannot execute before 
> 	that sys_membarrier call.
> 
> Of course, this form is a consequence of the more restrictive form.

Makes sense.  And the zero-size critical sections are why sys_membarrier()
cannot be directly used for classic deferred reclamation.

> > It gets a bit trickier with interleavings of different combinations
> > of RCU, SRCU, and sys_membarrier().  Yes, your cat code very elegantly
> > sorts this out, but my goal is to be able to explain a given example
> > to someone.
> 
> I don't think you're going to be able to fit different combinations of
> RCU, SRCU, and sys_membarrier into this picture.  How would you allow
> tests with incorrect interleaving, such as GP - memb - RSCS - nothing,
> while forbidding similar tests with correct interleaving?

Well, no, I cannot do a simple linear scan tracking time, which is what
the current scripts do.  I must instead find longest sequence with all
operations of the same type (RCU, SRCU, or memb) and work out their
worst-case timing.  If the overall effect of a given sequence is to
go backwards in time, the result is allowed.  Otherwise eliminate that
sequence from the cycle and repeat.  If everything is eliminated, the
cycle is forbidden.

Which can be thought of as an iterative process similar to something
called "rcu-fence", can't it?  ;-)

							Thanx, Paul
