From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Date: Sat, 3 Feb 2018 17:10:06 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1802031708380.29515-100000@netrider.rowland.org>
References: <20180203084809.GE3617@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:57161 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1752680AbeBCWKH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Feb 2018 17:10:07 -0500
In-Reply-To: <20180203084809.GE3617@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, 3 Feb 2018, Paul E. McKenney wrote:

> Please see below for an initial patch to this effect.  This activity
> proved to be more productive than expected for these tests, which certainly
> supports our assertion that locking needs more testing...
> 
> MP+polocks.litmus
> MP+porevlocks.litmus
> 
> 	These are allowed by the current model, which surprised me a bit,
> 	given that even powerpc would forbid them.  Is the rationale
> 	that a lock-savvy compiler could pull accesses into the lock's
> 	critical section and then reorder those accesses?  Or does this
> 	constitute a bug in our model of locking?
> 
> 	(And these were allowed when I wrote recipes.txt, embarrassingly
> 	enough...)
> 
> Z6.0+pooncelock+poonceLock+pombonce.litmus
> 
> 	This was forbidden when I wrote recipes.txt, but now is allowed.
> 	The header comment for smp_mb__after_spinlock() makes it pretty
> 	clear that it must be forbidden.  So this one is a bug in our
> 	model of locking.

I just tried testing these under the most recent version of herd, and 
all three were forbidden.

Alan
