From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/4] arch: Introduce smp_load_acquire(),
 smp_store_release()
Date: Tue, 17 Dec 2013 10:14:30 +0100
Message-ID: <20131217091430.GB21999@twins.programming.kicks-ass.net>
References: <20131213145657.265414969@infradead.org>
 <20131213150640.908486364@infradead.org>
 <20131216213720.GA28557@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:36309 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab3LQJO4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Dec 2013 04:14:56 -0500
Content-Disposition: inline
In-Reply-To: <20131216213720.GA28557@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kerne.org, geert@linux-m68k.org, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, mathieu.desnoyers@polymtl.ca, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com, Will Deacon <will.deacon@arm.com>

On Mon, Dec 16, 2013 at 01:37:20PM -0800, Paul E. McKenney wrote:
> rcu: Define rcu_assign_pointer() in terms of smp_store_release()
> 
> The new smp_store_release() function provides better guarantees than did
> rcu_assign_pointer(), and potentially less overhead on some architectures.
> The guarantee that smp_store_release() provides that rcu_assign_pointer()
> does that is obscure, but its lack could cause considerable confusion.
> This guarantee is illustrated by the following code fragment:
>     
>     	struct foo {
>     		int a;
>     		int b;
>     		int c;
>     		struct foo *next;
>     	};
>     	struct foo foo1;
>     	struct foo foo2;
>     	struct foo __rcu *foop;
>     
>     	...
>     
>     	foo2.a = 1;
>     	foo2.b = 2;
>     	BUG_ON(foo2.c);
>     	rcu_assign_pointer(foop, &foo);
>     
>     	...
>     
>     	fp = rcu_dereference(foop);
>     	fp.c = 3;
> 
> The current rcu_assign_pointer() semantics permit the BUG_ON() to
> trigger because rcu_assign_pointer()'s smp_wmb() is not guaranteed to
> order prior reads against later writes.  This commit therefore upgrades
> rcu_assign_pointer() from smp_wmb() to smp_store_release() to avoid this
> counter-intuitive outcome.

This of course raises the obvious question; why doesn't
rcu_dereference() need to be a smp_load_acquire?

And I think I know the answer; which would be that the data dependency
is still sufficient. But the situation does create an unpleasant
asymmetry in things.
