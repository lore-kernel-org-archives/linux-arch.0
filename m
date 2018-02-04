From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Date: Sun, 4 Feb 2018 01:16:01 -0800
Message-ID: <20180204091601.GO3617@linux.vnet.ibm.com>
References: <20180203084809.GE3617@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802031708380.29515-100000@netrider.rowland.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750798AbeBDJQA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Feb 2018 04:16:00 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w149DoAD083843
        for <linux-arch@vger.kernel.org>; Sun, 4 Feb 2018 04:16:00 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fwu9ux8j3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sun, 04 Feb 2018 04:16:00 -0500
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 4 Feb 2018 04:15:59 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802031708380.29515-100000@netrider.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Feb 03, 2018 at 05:10:06PM -0500, Alan Stern wrote:
> On Sat, 3 Feb 2018, Paul E. McKenney wrote:
> 
> > Please see below for an initial patch to this effect.  This activity
> > proved to be more productive than expected for these tests, which certainly
> > supports our assertion that locking needs more testing...
> > 
> > MP+polocks.litmus
> > MP+porevlocks.litmus
> > 
> > 	These are allowed by the current model, which surprised me a bit,
> > 	given that even powerpc would forbid them.  Is the rationale
> > 	that a lock-savvy compiler could pull accesses into the lock's
> > 	critical section and then reorder those accesses?  Or does this
> > 	constitute a bug in our model of locking?
> > 
> > 	(And these were allowed when I wrote recipes.txt, embarrassingly
> > 	enough...)
> > 
> > Z6.0+pooncelock+poonceLock+pombonce.litmus
> > 
> > 	This was forbidden when I wrote recipes.txt, but now is allowed.
> > 	The header comment for smp_mb__after_spinlock() makes it pretty
> > 	clear that it must be forbidden.  So this one is a bug in our
> > 	model of locking.
> 
> I just tried testing these under the most recent version of herd, and 
> all three were forbidden.

And they do for me as well once I upgraded to the most recent version of
herd.  Whew!!!

Boy, we weren't kidding when we said that you need to us the latest
and greatest herd7, now were we?  ;-)

							Thanx, Paul

	
