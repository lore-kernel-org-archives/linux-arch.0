From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] arch: Introduce smp_load_acquire(),
 smp_store_release()
Date: Tue, 17 Dec 2013 05:58:16 -0800
Message-ID: <20131217135815.GD5919@linux.vnet.ibm.com>
References: <20131213145657.265414969@infradead.org>
 <20131213150640.908486364@infradead.org>
 <20131216213720.GA28557@linux.vnet.ibm.com>
 <20131217091430.GB21999@twins.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:44538 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab3LQN62 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Dec 2013 08:58:28 -0500
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 17 Dec 2013 06:58:27 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id EBC1019D8046
	for <linux-arch@vger.kernel.org>; Tue, 17 Dec 2013 06:58:17 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rBHDwNK96816230
	for <linux-arch@vger.kernel.org>; Tue, 17 Dec 2013 14:58:23 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id rBHE1QKR013904
	for <linux-arch@vger.kernel.org>; Tue, 17 Dec 2013 07:01:29 -0700
Content-Disposition: inline
In-Reply-To: <20131217091430.GB21999@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kerne.org, geert@linux-m68k.org, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, mathieu.desnoyers@polymtl.ca, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com, Will Deacon <will.deacon@arm.com>

On Tue, Dec 17, 2013 at 10:14:30AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 16, 2013 at 01:37:20PM -0800, Paul E. McKenney wrote:
> > rcu: Define rcu_assign_pointer() in terms of smp_store_release()
> > 
> > The new smp_store_release() function provides better guarantees than did
> > rcu_assign_pointer(), and potentially less overhead on some architectures.
> > The guarantee that smp_store_release() provides that rcu_assign_pointer()
> > does that is obscure, but its lack could cause considerable confusion.
> > This guarantee is illustrated by the following code fragment:
> >     
> >     	struct foo {
> >     		int a;
> >     		int b;
> >     		int c;
> >     		struct foo *next;
> >     	};
> >     	struct foo foo1;
> >     	struct foo foo2;
> >     	struct foo __rcu *foop;
> >     
> >     	...
> >     
> >     	foo2.a = 1;
> >     	foo2.b = 2;
> >     	BUG_ON(foo2.c);
> >     	rcu_assign_pointer(foop, &foo);
> >     
> >     	...
> >     
> >     	fp = rcu_dereference(foop);
> >     	fp.c = 3;
> > 
> > The current rcu_assign_pointer() semantics permit the BUG_ON() to
> > trigger because rcu_assign_pointer()'s smp_wmb() is not guaranteed to
> > order prior reads against later writes.  This commit therefore upgrades
> > rcu_assign_pointer() from smp_wmb() to smp_store_release() to avoid this
> > counter-intuitive outcome.
> 
> This of course raises the obvious question; why doesn't
> rcu_dereference() need to be a smp_load_acquire?
> 
> And I think I know the answer; which would be that the data dependency
> is still sufficient. But the situation does create an unpleasant
> asymmetry in things.

Yep, rcu_dereference() does rely on data dependency rather than explicit
barriers.  That said, for TSO architectures, the code emitted for
data dependency and for the acquire memory barrier is often identical.
And no, many the C/C++11 guys didn't like this asymmetry much either.  ;-)

							Thanx, Paul
